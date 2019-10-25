clc;
clear;
close all;
for epoch = 1: 2
px = 2; %每个周期单元的长度
py = 2;
matrix = rand(px, py);
for i = 1: px
    for j = 1: py
        if matrix(i, j) > 0.5
            matrix(i, j) = 1;
        else
            matrix(i, j) = -1;
        end
    end
end

a=1;   %上层贴片的长
b=1;   %上层贴片的宽
t=1;   %介质基板的厚度；
Frq=[10, 30]; %工作频带的频率

%% CST文件初始化
cst = actxserver('CSTStudio.application');%首先载入CST应用控件
mws = invoke(cst, 'NewMWS');%新建一个MWS项目
app = invoke(mws, 'GetApplicationName');%获取当前应用名称
ver = invoke(mws, 'GetApplicationVersion');%获取当前应用版本号
invoke(mws, 'FileNew');%新建一个CST文件
path=pwd;%获取当前m文件夹路径
% filename='\metamaterialabsorber.cst';%新建的CST文件名字
filename = ['\', num2str(epoch), '.cst'];
fullname=[path filename];
invoke(mws, 'SaveAs', fullname, 'True');%True表示保存到目前为止的结果
invoke(mws, 'DeleteResults');%删除之前的结果。注：在有结果的情况下修改模型会出现弹窗提示是否删除结果，这样运行的程序会停止，需等待手动点击弹窗使之消失
%%CST文件初始化结束

%全局单位初始化
units = invoke(mws, 'Units');
invoke(units, 'Geometry', 'mm');
invoke(units, 'Frequency', 'ghz');
invoke(units, 'Time', 'ns');
invoke(units, 'TemperatureUnit', 'kelvin');
release(units);
%%全局单位初始化结束

%%工作频率设置
solver = invoke(mws, 'Solver');
invoke(solver, 'FrequencyRange', Frq(1), Frq(2));
release(solver);



%背景材料设置
background=invoke(mws,'Background');
invoke(background,'Resetbackground');
invoke(background,'Type','Normal');
release(background);

floquetport=invoke(mws,'FloquetPort');
invoke(floquetport,'Reset');
invoke(floquetport,'SetDialogTheta','0');
invoke(floquetport,'SetDialogPhi','0');
invoke(floquetport,'SetSortcode','+beta/pw');
invoke(floquetport,'SetCustomizedListFlag','False');
invoke(floquetport,'Port','Zmin');
invoke(floquetport,'SetNumberOfModesConsidered','2');
invoke(floquetport,'Port','Zmax');
invoke(floquetport,'SetNumberOfModesConsidered','2');
release(floquetport);

boundary=invoke(mws,'Boundary');
invoke(boundary,'Xmin','unit cell');
invoke(boundary,'Xmax', 'unit cell');
invoke(boundary, 'Ymin', 'unit cell');
invoke(boundary, 'Ymax', 'unit cell');
invoke(boundary, 'Zmin', 'expanded open');
invoke(boundary, 'Zmax', 'expanded open');
invoke(boundary, 'Xsymmetry', 'none');
invoke(boundary, 'Ysymmetry', 'none');
invoke(boundary, 'Zsymmetry', 'none');
invoke(boundary, 'XPeriodicShift', '0.0');
invoke(boundary, 'YPeriodicShift', '0.0');
invoke(boundary, 'ZPeriodicShift', '0.0');
    
invoke(boundary, 'SetPeriodicBoundaryAnglesDirection', 'inward');
invoke(boundary,  'UnitCellFitToBoundingBox', 'True');
invoke(boundary,  'UnitCellDs1', '0.0');
invoke(boundary,  'UnitCellDs2',"0.0");
invoke(boundary,  'UnitCellAngle', '90.0');
release(boundary);

meshsettings=invoke(mws,'MeshSettings');
invoke(meshsettings,'SetMeshType','Tet');
invoke(meshsettings,'Set','version','1%');
release(meshsettings);

mesh=invoke(mws,'Mesh');
invoke(mesh,'MeshType','Tetrahedral');
release(mesh);

%%新建所需介质材料
material = invoke(mws, 'Material');
material1 = 'material265';
er1 = 4.4;
invoke(material, 'Reset');
invoke(material, 'Name', material1);
invoke(material, 'FrqType', 'all');
invoke(material, 'Type', 'Normal');
invoke(material, 'Epsilon', er1);
invoke(material, 'Create');
release(material);

%%建模型
brick=invoke(mws,'Brick');
Str_Name='substate';
Str_Component='sub';
Str_Material=material1;
x=[0,px];
y=[0,py];
z=[-t,0]; 
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');

%上层的贴片
for yy = 1: py
    for xx = 1: px
        if matrix(xx, yy) == double(1)
            Str_Name = num2str((yy - 1) * px + xx);
            Str_Component='toplayer';
            Str_Material='PEC';
            x=[xx - 1, xx];
            y=[yy - 1, yy];
            z=[0,0];
            invoke(brick, 'Reset');
            invoke(brick, 'Name', Str_Name);
            invoke(brick, 'Component', Str_Component);
            invoke(brick, 'Material', Str_Material);
            invoke(brick, 'Xrange', x(1), x(2));
            invoke(brick, 'Yrange', y(1), y(2));
            invoke(brick, 'Zrange', z(1), z(2));
            invoke(brick, 'Create');
        end
    end
end

fdsolver=invoke(mws,'FDsolver');
invoke(fdsolver,'Reset');
invoke(fdsolver,'Stimulation','List','List');
invoke(fdsolver,'ResetExcitationList');
invoke(fdsolver,'AddtoExcitationList','Zmax','TE(0,0);TM(0,0)');
invoke(fdsolver,'LowFrequencyStabilization','False');
invoke(fdsolver,'SetNumberOfResultDataSamples','49'); 

invoke(fdsolver, 'Start');

release(fdsolver);

Res=invoke(mws,'ResultTree'); 
number=invoke(Res,'GetResultIDsFromTreeItem','1D Results\S-Parameters\SZmax(1),Zmax(1)'); 
N=numel(number); 
 
A_Freq=zeros(49,1); 
A_Complex=zeros(49,2); 
 
c=invoke(Res,'GetResultFromTreeItem','1D Results\S-Parameters\SZmax(1),Zmax(1)',number{1}); 
A_Freq(:,1)=invoke(c,'GetArray','x'); 
c=invoke(Res,'GetResultFromTreeItem','1D Results\S-Parameters\SZmax(1),Zmax(1)',number{1}); 
A_Complex(:,1)=invoke(c,'GetArray','yre'); 
A_Complex(:,2)=invoke(c,'GetArray','yim'); 

A=[A_Freq,A_Complex]; 
 
invoke(mws,'Save');

invoke(mws,'Quit'); 
 
release(mws); 
release(cst);
sfilename = ['C:\Users\iamtyz\Desktop\', num2str(epoch), '-s11.txt'];
mfilename = ['C:\Users\iamtyz\Desktop\', num2str(epoch), '-m.txt'];
save(sfilename, 'A', '-ascii');
save(mfilename, 'matrix', '-ascii');
end
% plot(A(:, 1), 20 * log10(abs(A(:, 2) + 1i * A(:, 3))));