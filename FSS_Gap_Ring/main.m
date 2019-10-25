clear
clc
% '----------------------------------------------------------------------------
ParaList = load('ParaList.txt');
% '----------------------------------------------------------------------------
SubWidth = 7;
SubThickness = 0.1;
RingRadius_Outer = 1.4;
RingRadius_Inner = 1.0;
RingHeight = 0.05;
GapLength = 0.5;
Auxiliary = RingRadius_Outer;
Freq = [8, 22];
% '----------------------------------------------------------------------------
CST = actxserver('CSTStudio.application');
MWS = invoke(CST, 'NewMWS');
APP = invoke(MWS, 'GetApplicationName');
VER = invoke(MWS, 'GetApplicationVersion');
invoke(MWS, 'FileNew');
path = pwd;
filename = ['\', 'temp', '.cst'];
fullname=[path, '\tmp', filename];
invoke(MWS, 'SaveAs', fullname, 'True');
invoke(MWS, 'DeleteResults');
% '----------------------------------------------------------------------------
SetUnints(MWS);
SetPlot(MWS);
SetBackground(MWS);
SetFloquetPort(MWS);
SetFreq(MWS, Freq(1), Freq(2));
% '----------------------------------------------------------------------------
invoke(MWS, 'MakeSureParameterExists', 'theta', '0');
invoke(MWS, 'SetParameterDescription', 'theta', 'spherical angle of incident plane wave');
invoke(MWS, 'MakeSureParameterExists', 'phi', '0');
invoke(MWS, 'SetParameterDescription', 'phi', 'spherical angle of incident plane wave');
invoke(MWS, 'MakeSureParameterExists', 'SubWidth', SubWidth);
invoke(MWS, 'MakeSureParameterExists', 'SubThickness', SubThickness);
invoke(MWS, 'MakeSureParameterExists', 'RingRadius_Outer', RingRadius_Outer);
invoke(MWS, 'MakeSureParameterExists', 'RingRadius_Inner', RingRadius_Inner);
invoke(MWS, 'MakeSureParameterExists', 'RingHeight', RingHeight);
invoke(MWS, 'MakeSureParameterExists', 'GapLength', GapLength);
invoke(MWS, 'MakeSureParameterExists', 'Auxiliary', Auxiliary);
% '----------------------------------------------------------------------------
SetBoundary(MWS);
MeshSettings(MWS);
SetMesh(MWS);
FDsolverSettings(MWS);
IEsolverSettings(MWS);
% '----------------------------------------------------------------------------s
% Dim sDefineAt As String
% sDefineAt = "15"
% Dim sDefineAtName As String
% sDefineAtName = "15"
% Dim sDefineAtToken As String
% sDefineAtToken = "f="
% Dim aFreq() As String
% aFreq = Split(sDefineAt, ";")
% Dim aNames() As String
% aNames = Split(sDefineAtName, ";")
% Dim nIndex As Integer
% For nIndex = LBound(aFreq) To UBound(aFreq)
% Dim zz_val As String
% zz_val = aFreq (nIndex)
% Dim zz_name As String
% zz_name = sDefineAtToken & aNames (nIndex)
% '----------------------------------------------------------------------------
% ' Define E-Field Monitors
% With Monitor
%     .Reset
%     .Name "e-field ("& zz_name &")"
%     .Dimension "Volume"
%     .Domain "Frequency"
%     .FieldType "Efield"
%     .MonitorValue  zz_val
%     .Create
% End With
% '----------------------------------------------------------------------------
% ' Define H-Field Monitors
% With Monitor
%     .Reset
%     .Name "h-field ("& zz_name &")"
%     .Dimension "Volume"
%     .Domain "Frequency"
%     .FieldType "Hfield"
%     .MonitorValue  zz_val
%     .Create
% End With
% '----------------------------------------------------------------------------
Arlon_AD_300_LOSSY = invoke(MWS, 'Material');
invoke(Arlon_AD_300_LOSSY, 'Reset');
invoke(Arlon_AD_300_LOSSY, 'Name', 'Arlon AD 300 (lossy)');
invoke(Arlon_AD_300_LOSSY, 'Folder', '');
invoke(Arlon_AD_300_LOSSY, 'FrqType', 'all');
invoke(Arlon_AD_300_LOSSY, 'Type', 'Normal');
invoke(Arlon_AD_300_LOSSY, 'SetMaterialUnit', 'GHz', 'mm');
invoke(Arlon_AD_300_LOSSY, 'Epsilon', '3');
invoke(Arlon_AD_300_LOSSY, 'Mu', '1.0');
invoke(Arlon_AD_300_LOSSY, 'Kappa', '0.0');
invoke(Arlon_AD_300_LOSSY, 'TanD', '0.003');
invoke(Arlon_AD_300_LOSSY, 'TanDFreq', '10.0');
invoke(Arlon_AD_300_LOSSY, 'TanDGiven', 'True');
invoke(Arlon_AD_300_LOSSY, 'TanDModel', 'ConstTanD');
invoke(Arlon_AD_300_LOSSY, 'KappaM', '0.0');
invoke(Arlon_AD_300_LOSSY, 'TanDM', '0.0');
invoke(Arlon_AD_300_LOSSY, 'TanDMFreq', '0.0');
invoke(Arlon_AD_300_LOSSY, 'TanDMGiven', 'False');
invoke(Arlon_AD_300_LOSSY, 'TanDMModel', 'ConstKappa');
invoke(Arlon_AD_300_LOSSY, 'DispModelEps', 'None');
invoke(Arlon_AD_300_LOSSY, 'DispModelMu', 'None');
invoke(Arlon_AD_300_LOSSY, 'DispersiveFittingSchemeEps', 'General 1st');
invoke(Arlon_AD_300_LOSSY, 'DispersiveFittingSchemeMu', 'General 1st');
invoke(Arlon_AD_300_LOSSY, 'UseGeneralDispersionEps', 'False');
invoke(Arlon_AD_300_LOSSY, 'UseGeneralDispersionMu', 'False');
invoke(Arlon_AD_300_LOSSY, 'Rho', '0.0');
invoke(Arlon_AD_300_LOSSY, 'ThermalType', 'Normal');
invoke(Arlon_AD_300_LOSSY, 'ThermalConductivity', '0.235');
invoke(Arlon_AD_300_LOSSY, 'SetActiveMaterial', 'all');
invoke(Arlon_AD_300_LOSSY, 'Colour', '0.94', '0.82', '0.76');
invoke(Arlon_AD_300_LOSSY, 'Wireframe', 'False');
invoke(Arlon_AD_300_LOSSY, 'Transparency', '0');
invoke(Arlon_AD_300_LOSSY, 'Create');
release(Arlon_AD_300_LOSSY);
% '----------------------------------------------------------------------------
COMPONENT = invoke(MWS, 'Component');
invoke(COMPONENT, 'New', 'component1');
release(COMPONENT);
% '----------------------------------------------------------------------------
BRICK = invoke(MWS, 'Brick');
invoke(BRICK, 'Reset');
invoke(BRICK, 'Name', 'solid1');
invoke(BRICK, 'Component', 'component1');
invoke(BRICK, 'Material', 'Arlon AD 300 (lossy)');
invoke(BRICK, 'Xrange', '-SubWidth/2', 'SubWidth/2');
invoke(BRICK, 'Yrange', '-SubWidth/2', 'SubWidth/2');
invoke(BRICK, 'Zrange', '-SubThickness', '0');
invoke(BRICK, 'Create');
release(BRICK);
% '----------------------------------------------------------------------------
PICK = invoke(MWS, 'Pick');
invoke(PICK, 'PickFaceFromId', 'component1:solid1', '1');
release(PICK);
% '----------------------------------------------------------------------------
Copper_annealed = invoke(MWS, 'Material');
invoke(Copper_annealed, 'Reset');
invoke(Copper_annealed, 'Name', 'Copper (annealed)');
invoke(Copper_annealed, 'Folder', '');
invoke(Copper_annealed, 'FrqType', 'static');
invoke(Copper_annealed, 'Type', 'Normal');
invoke(Copper_annealed, 'SetMaterialUnit', 'Hz', 'mm');
invoke(Copper_annealed, 'Epsilon', '1');
invoke(Copper_annealed, 'Mu', '1.0');
invoke(Copper_annealed, 'Kappa', '5.8e+007');
invoke(Copper_annealed, 'TanD', '0.0');
invoke(Copper_annealed, 'TanDFreq', '0.0');
invoke(Copper_annealed, 'TanDGiven', 'False');
invoke(Copper_annealed, 'TanDModel', 'ConstTanD');
invoke(Copper_annealed, 'KappaM', '0');
invoke(Copper_annealed, 'TanDM', '0.0');
invoke(Copper_annealed, 'TanDMFreq', '0.0');
invoke(Copper_annealed, 'TanDMGiven', 'False');
invoke(Copper_annealed, 'TanDMModel', 'ConstTanD');
invoke(Copper_annealed, 'DispModelEps', 'None');
invoke(Copper_annealed, 'DispModelMu', 'None');
invoke(Copper_annealed, 'DispersiveFittingSchemeEps', 'Nth Order');
invoke(Copper_annealed, 'DispersiveFittingSchemeMu', 'Nth Order');
invoke(Copper_annealed, 'UseGeneralDispersionEps', 'False');
invoke(Copper_annealed, 'UseGeneralDispersionMu', 'False');
invoke(Copper_annealed, 'FrqType', 'all');
invoke(Copper_annealed, 'Type', 'Lossy metal');
invoke(Copper_annealed, 'SetMaterialUnit', 'GHz', 'mm');
invoke(Copper_annealed, 'Mu', '1.0');
invoke(Copper_annealed, 'Kappa', '5.8e+007');
invoke(Copper_annealed, 'Rho', '8930.0');
invoke(Copper_annealed, 'ThermalType', 'Normal');
invoke(Copper_annealed, 'ThermalConductivity', '401.0');
invoke(Copper_annealed, 'HeatCapacity', '0.39');
invoke(Copper_annealed, 'MetabolicRate', '0');
invoke(Copper_annealed, 'BloodFlow', '0');
invoke(Copper_annealed, 'VoxelConvection', '0');
invoke(Copper_annealed, 'MechanicsType', 'Isotropic');
invoke(Copper_annealed, 'YoungsModulus', '120');
invoke(Copper_annealed, 'PoissonsRatio', '0.33');
invoke(Copper_annealed, 'ThermalExpansionRate', '17');
invoke(Copper_annealed, 'Colour', '1', '1', '0');
invoke(Copper_annealed, 'Wireframe', 'False');
invoke(Copper_annealed, 'Reflection', 'False');
invoke(Copper_annealed, 'Allowoutline', 'True');
invoke(Copper_annealed, 'Transparentoutline', 'False');
invoke(Copper_annealed, 'Transparency', '0');
invoke(Copper_annealed, 'Create');
release(Copper_annealed);
% '----------------------------------------------------------------------------
CYLINDER = invoke(MWS, 'Cylinder');
invoke(CYLINDER, 'Reset');
invoke(CYLINDER, 'Name', 'solid2');
invoke(CYLINDER, 'Component', 'component1');
invoke(CYLINDER, 'Material', 'Copper (annealed)');
invoke(CYLINDER, 'OuterRadius', 'RingRadius_Outer');
invoke(CYLINDER, 'InnerRadius', 'RingRadius_Inner');
invoke(CYLINDER, 'Axis', 'z');
invoke(CYLINDER, 'Zrange', '0', 'RingHeight');
invoke(CYLINDER, 'Xcenter', '0');
invoke(CYLINDER, 'Ycenter', '0');
invoke(CYLINDER, 'Segments', '0');
invoke(CYLINDER, 'Create');
release(CYLINDER);
% '----------------------------------------------------------------------------
PICK = invoke(MWS, 'Pick');
invoke(PICK, 'ClearAllPicks');
release(PICK);
% '----------------------------------------------------------------------------
PARAMETERSWEEP = invoke(MWS, 'ParameterSweep');
invoke(PARAMETERSWEEP, 'SetSimulationType', 'Frequency');
invoke(PARAMETERSWEEP, 'AddSequence', 'Sequence 1');
invoke(PARAMETERSWEEP, 'AddParameter_Linear', 'Sequence 1', 'theta', '0', '50', '6');
release(PARAMETERSWEEP);
% '----------------------------------------------------------------------------
PICK = invoke(MWS, 'Pick');
invoke(PICK, 'ClearAllPicks');
invoke(PICK, 'PickEndpointFromId', 'component1:solid1', '2');
release(PICK);
% '----------------------------------------------------------------------------
BRICK = invoke(MWS, 'Brick');
invoke(BRICK, 'Reset');
invoke(BRICK, 'Name', 'solid3');
invoke(BRICK, 'Component', 'component1');
invoke(BRICK, 'Material', 'Vacuum');
invoke(BRICK, 'Xrange', '-GapLength/2', 'GapLength/2');
invoke(BRICK, 'Yrange', '0', 'Auxiliary');
invoke(BRICK, 'Zrange', '0', 'RingHeight');
invoke(BRICK, 'Create');
release(BRICK);
% '----------------------------------------------------------------------------
SOLID = invoke(MWS, 'Solid');
invoke(SOLID, 'Subtract', 'component1:solid2', 'component1:solid3');
release(SOLID);
% '----------------------------------------------------------------------------
FDSOLVER = invoke(MWS, 'fdsolver');
invoke(FDSOLVER, 'Start');
release(FDSOLVER);
