clear
clc

p = 3.6;
% p = 3.75;
% p = 3.68;
% p = 12;

matrix = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0
           0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
           0 0 0 0 1 0 1 1 1 1 1 1 0 1 1 1 0 0 0 0
           0 0 0 0 1 0 1 0 0 0 0 1 0 0 0 1 0 0 0 0
           0 0 0 0 1 0 1 0 1 1 0 1 1 1 0 1 0 0 0 0
           0 0 0 0 1 0 1 0 1 1 0 0 0 1 0 1 0 0 0 0
           0 0 0 0 1 0 1 0 0 0 1 1 0 1 0 1 0 0 0 0
           0 0 0 0 1 0 1 1 1 0 1 1 0 1 0 1 0 0 0 0
           0 0 0 0 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 0
           0 0 0 0 1 1 1 0 1 1 1 1 1 1 0 1 0 0 0 0
           0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0
           0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0
           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
% matrix = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0
%            0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 0 0 1 1 1 1 1 1 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 1 1 1 0 0 0 0 1 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 1 0 0 0 0 1 1 1 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 1 1 1 1 1 1 0 0 0 0 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0
%            0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
%            0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
[px, py] = size(matrix);
a = p / px;
b = p / py;
c = 185e-6;
% c = 0.01;
% c = 0;
t = 1.05;
% t = 3;
Frq = [5, 50];
cst = actxserver('CSTStudio.application');
mws = invoke(cst, 'NewMWS');
app = invoke(mws, 'GetApplicationName');
ver = invoke(mws, 'GetApplicationVersion');
invoke(mws, 'FileNew');
path = pwd;
filename='\metamaterialabsorber.cst';
fullname=[path filename];
invoke(mws, 'SaveAs', fullname, 'True');
invoke(mws, 'DeleteResults');

units = invoke(mws, 'Units');
invoke(units, 'Geometry', 'mm');
invoke(units, 'Frequency', 'ghz');
invoke(units, 'Time', 'ns');
invoke(units, 'TemperatureUnit', 'kelvin');
release(units);

solver = invoke(mws, 'Solver');
invoke(solver, 'FrequencyRange', Frq(1), Frq(2));
release(solver);

background = invoke(mws, 'Background');
invoke(background, 'Resetbackground');
invoke(background, 'Type','Normal');
release(background);

floquetport = invoke(mws, 'FloquetPort');
invoke(floquetport, 'Reset');
invoke(floquetport, 'SetDialogTheta', '0');
invoke(floquetport, 'SetDialogPhi', '0');
invoke(floquetport, 'SetSortcode', '+beta/pw');
invoke(floquetport, 'SetCustomizedListFlag', 'False');
invoke(floquetport, 'Port', 'Zmin');
invoke(floquetport, 'SetNumberOfModesConsidered', '2');
invoke(floquetport, 'Port', 'Zmax');
invoke(floquetport, 'SetNumberOfModesConsidered', '2');
release(floquetport);

boundary = invoke(mws, 'Boundary');
invoke(boundary, 'Xmin', 'unit cell');
invoke(boundary, 'Xmax', 'unit cell');
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
invoke(boundary, 'UnitCellFitToBoundingBox', 'True');
invoke(boundary, 'UnitCellDs1', '0.0');
invoke(boundary, 'UnitCellDs2', '0.0');
invoke(boundary, 'UnitCellAngle', '90.0');
release(boundary);

meshsettings = invoke(mws, 'MeshSettings');
invoke(meshsettings, 'SetMeshType', 'Tet');
invoke(meshsettings, 'Set', 'version', '1%');
release(meshsettings);

mesh = invoke(mws, 'Mesh');
invoke(mesh, 'MeshType', 'Tetrahedral');
release(mesh);

material_glass = invoke(mws, 'Material');
substate = 'material_glass';
invoke(material_glass, 'Reset');
invoke(material_glass, 'Name', substate);
invoke(material_glass, 'FrqType', 'all');
invoke(material_glass, 'Type', 'Normal');
invoke(material_glass, 'Epsilon', 4.7);
invoke(material_glass, 'Colour', 0.8, 0.0, 0.9);
invoke(material_glass, 'Create');
release(material_glass);

brick = invoke(mws, 'Brick');
Str_Name = 'substate';
Str_Component = 'substate';
Str_Material = substate;
x = [0, px * a];
y = [0, py * b];
z = [0, t]; 
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');

material_ITO = invoke(mws, 'Material');
ITO = 'material_ITO';
invoke(material_ITO, 'Reset');
invoke(material_ITO, 'Name', ITO);
invoke(material_ITO, 'Rho', 0.0);
invoke(material_ITO, 'ThermalType', 'Normal');
invoke(material_ITO, 'FrqType', 'all');
invoke(material_ITO, 'Type', 'Lossy metal');
invoke(material_ITO, 'OhmicSheetImpedance', 30, 0);%ITOµÄ·½×è
invoke(material_ITO, 'OhmicSheetFreq', 0);
invoke(material_ITO, 'Colour', 0.0, 0.8, 0.9);
invoke(material_ITO, 'Create');
release(material_ITO);

brick = invoke(mws, 'Brick');
Str_Name = 'mirror';
Str_Component = 'mirror';
Str_Material = ITO;
x = [0, px * a];
y = [0, py * b];
z=[-c, 0]; 
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');

% brick = invoke(mws, 'Brick');
% Str_Name = 'mirror';
% Str_Component = 'mirror';
% Str_Material = 'PEC';
% x = [0, px * a];
% y = [0, py * b];
% z=[-c, 0]; 
% invoke(brick, 'Reset');
% invoke(brick, 'Name', Str_Name);
% invoke(brick, 'Component', Str_Component);
% invoke(brick, 'Material', Str_Material);
% invoke(brick, 'Xrange', x(1), x(2));
% invoke(brick, 'Yrange', y(1), y(2));
% invoke(brick, 'Zrange', z(1), z(2));
% invoke(brick, 'Create');

count = 0;
for yy = 1: py
    for xx = 1: px
        if matrix(xx, yy) == double(1)
            count = count + 1;
            Str_Name = num2str(count);
            Str_Component = 'toplayer';
            Str_Material = ITO;
            x=[(xx - 1) * a, xx * a];
            y=[(yy - 1) * b, yy * b];
            z=[t, t + c];
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

solid = invoke(mws, 'Solid');
for n = 1: count - 1
    tmp = ['toplayer:', num2str(n + 1)];
    invoke(solid, 'Add', 'toplayer:1', tmp);
end
invoke(solid, 'Rename', 'toplayer:1', 'toplayer')
release(solid);
