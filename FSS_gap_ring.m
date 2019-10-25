clear
clc
close all
% '----------------------------------------------------------------------------
ParaList = load('ParaList.txt');
% '----------------------------------------------------------------------------
SubWidth = [];
SubThickness = [0.1, 0.2];
RingRadius_Outer = [];
RingRadius_Inner = [];
RingHeight = 0.05;
GapLength = [];
Auxiliary = [];
Freq = [8, 22];
% '----------------------------------------------------------------------------
CST = actxserver('CSTStudio.application');
MWS = invoke(CST, 'NewMWS');
APP = invoke(MWS, 'GetApplicationName');
VER = invoke(MWS, 'GetApplicationVersion');
invoke(MWS, 'FileNew');
path = pwd;
filename = ['\tmp\', tmp, '.cst'];
fullname=[path filename];
invoke(MWS, 'SaveAs', fullname, 'True');
invoke(MWS, 'DeleteRessults');
% '----------------------------------------------------------------------------
UNINTS = invoke(MWS, 'Units');
invoke(UNINTS, 'Geometry', 'mm');
invoke(UNINTS, 'Frequency', 'GHz');
invoke(UNINTS, 'Voltage', 'V');
invoke(UNINTS, 'Resistance', 'Ohm');
invoke(UNINTS, 'Inductance', 'NanoH');
invoke(UNINTS, 'TemperatureUnit', 'Kelvin');
invoke(UNINTS, 'Time', 'ns');
invoke(UNINTS, 'Current', 'A');
invoke(UNINTS, 'Conductance', 'Siemens');
invoke(UNINTS, 'Capacitance', 'PikoF');
release(UNINTS);
% '----------------------------------------------------------------------------
PLOT = invoke(MWS, 'Plot');
invoke(PLOT, 'DrawBox', 'True');
invoke(PLOT, 'DrawWorkplane', 'true');
release(PLOT);
% '----------------------------------------------------------------------------
BACKGROUND = invoke(MWS, 'Background');
invoke(BACKGROUND, '', '');
invoke(BACKGROUND, 'Type', 'Normal');
invoke(BACKGROUND, 'Epsilon', '1.0');
invoke(BACKGROUND, 'Mu', '1.0');
invoke(BACKGROUND, 'Rho', '1.204');
invoke(BACKGROUND, 'ThermalType', 'Normal');
invoke(BACKGROUND, 'ThermalConductivity', '0.026');
invoke(BACKGROUND, 'HeatCapacity', '1.005');
invoke(BACKGROUND, 'XminSpace', '0.0');
invoke(BACKGROUND, 'XmaxSpace', '0.0');
invoke(BACKGROUND, 'YminSpace', '0.0');
invoke(BACKGROUND, 'YmaxSpace', '0.0');
invoke(BACKGROUND, 'ZminSpace', '0.0');
invoke(BACKGROUND, 'ZmaxSpace', '0.0');
release(BACKGROUND);
% '----------------------------------------------------------------------------
FLOQUETPORT = invoke(MWS, 'FloquetPort');
invoke(FLOQUETPORT, 'Reset');
invoke(FLOQUETPORT, 'SetDialogTheta', '0');
invoke(FLOQUETPORT, 'SetDialogPhi', '0');
invoke(FLOQUETPORT, 'SetSortCode', '+beta/pw');
invoke(FLOQUETPORT, 'SetCustomizedListFlag', 'False');
invoke(FLOQUETPORT, 'Port', 'Zmin');
invoke(FLOQUETPORT, 'SetNumberOfModesConsidered', '2');
invoke(FLOQUETPORT, 'Port', 'Zmax');
invoke(FLOQUETPORT, 'SetNumberOfModesConsidered', '2');
release(FLOQUETPORT);
% '----------------------------------------------------------------------------
SOLVER = invoke(mws, 'Solver');
invoke(SOLVER, 'FrequencyRange', Freq(1), Freq(2));
release(SOLVER);
% '----------------------------------------------------------------------------
% MakeSureParameterExists "theta", "0"
% SetParameterDescription "theta", "spherical angle of incident plane wave"
% MakeSureParameterExists "phi", "0"
% SetParameterDescription "phi", "spherical angle of incident plane wave"
% '----------------------------------------------------------------------------
BOUNDARY = invoke(MWS, 'Boundary');
invoke(BOUNDARY, 'Xmin', 'unit cell');
invoke(BOUNDARY, 'Xmax', 'unit cell');
invoke(BOUNDARY, 'Ymin', 'unit cell');
invoke(BOUNDARY, 'Ymax', 'unit cell');
invoke(BOUNDARY, 'Zmin', 'expanded open');
invoke(BOUNDARY, 'Zmax', 'expanded open');
invoke(BOUNDARY, 'Xsymmetry', 'none');
invoke(BOUNDARY, 'Ysymmetry', 'none');
invoke(BOUNDARY, 'Zsymmetry', 'none');
invoke(BOUNDARY, 'XPeriodicShift', '0.0');
invoke(BOUNDARY, 'YPeriodicShift', '0.0');
invoke(BOUNDARY, 'ZPeriodicShift', '0.0');
invoke(BOUNDARY, 'PeriodicUseConstantAngles', 'False');
invoke(BOUNDARY, 'SetPeriodicBoundaryAngles', 'theta', 'phi');
invoke(BOUNDARY, 'SetPeriodicBoundaryAnglesDirection', 'inward');
invoke(BOUNDARY, 'UnitCellFitToBoundingBox', 'True');
invoke(BOUNDARY, 'UnitCellDs1', '0.0');
invoke(BOUNDARY, 'UnitCellDs2', '0.0');
invoke(BOUNDARY, 'UnitCellAngle', '90.0');
release(BOUNDARY);
% '----------------------------------------------------------------------------
MESHSETTINGS = invoke(MWS, 'MeshSettings');
invoke(MESHSETTINGS,'SetMeshType','Tet');
invoke(MESHSETTINGS,'Set','version','1%');
release(MESHSETTINGS);
% '----------------------------------------------------------------------------
MESH = invoke(MWS, 'Mesh');
invoke(MESH, 'MeshType', 'Tetrahedral');
release(MESH);
% '----------------------------------------------------------------------------
FDSOLVER = invoke(MWS, 'FDSolver');
invoke(FDSOLVER, 'Reset');
invoke(FDSOLVER, 'Stimulation', 'List', 'List');
invoke(FDSOLVER, 'ResetExcitationList');
invoke(FDSOLVER, 'Zmax', 'TE(0,0);TM(0,0)'); 
invoke(FDSOLVER, 'LowFrequencyStabilization', 'False');
release(FDSOLVER);
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
% Next
% '----------------------------------------------------------------------------
% With MeshSettings
%      .SetMeshType "Tet"
%      .Set "Version", 1%
% End With
% With Mesh
%      .MeshType "Tetrahedral"
% End With
% 'set the solver type
% ChangeSolverType("HF Frequency Domain")
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
release(PARAMETERSWEEP);
% '----------------------------------------------------------------------------
MESH = invoke(MWS, 'Mesh');
invoke(MESH, 'SetCreator', 'High Frequency');
release(MESH);
% '----------------------------------------------------------------------------
FDSOLVER = invoke(MWS, 'FDSolver');
invoke(FDSOLVER, 'Reset');
invoke(FDSOLVER, 'SetMethod', 'Tetrahedral', 'General purpose');
invoke(FDSOLVER, 'OrderTet', 'Second');
invoke(FDSOLVER, 'OrderSrf', 'First');
invoke(FDSOLVER, 'Stimulation', 'List', 'List');
invoke(FDSOLVER, 'ResetExcitationList');
invoke(FDSOLVER, 'AddToExcitationList', 'Zmax', 'TE(0,0);TM(0,0)');
invoke(FDSOLVER, 'AutoNormImpedance', 'False');
invoke(FDSOLVER, 'NormingImpedance', '50');
invoke(FDSOLVER, 'ModesOnly', 'False');
invoke(FDSOLVER, 'ConsiderPortLossesTet', 'True');
invoke(FDSOLVER, 'SetShieldAllPorts', 'False');
invoke(FDSOLVER, 'AccuracyHex', '1e-6');
invoke(FDSOLVER, 'AccuracyTet', '1e-4');
invoke(FDSOLVER, 'AccuracySrf', '1e-3');
invoke(FDSOLVER, 'LimitIterations', 'False');
invoke(FDSOLVER, 'MaxIterations', '0');
invoke(FDSOLVER, 'SetCalcBlockExcitationsInParallel', 'True', 'True', '');
invoke(FDSOLVER, 'StoreAllResults', 'False');
invoke(FDSOLVER, 'StoreResultsInCache', 'False');
invoke(FDSOLVER, 'UseHelmholtzEquation', 'True');
invoke(FDSOLVER, 'LowFrequencyStabilization', 'False');
invoke(FDSOLVER, 'Type', 'Auto');
invoke(FDSOLVER, 'MeshAdaptionHex', 'False');
invoke(FDSOLVER, 'MeshAdaptionTet', 'True');
invoke(FDSOLVER, 'AcceleratedRestart', 'True');
invoke(FDSOLVER, 'FreqDistAdaptMode', 'Distributed');
invoke(FDSOLVER, 'NewIterativeSolver', 'True');
invoke(FDSOLVER, 'TDCompatibleMaterials', 'False');
invoke(FDSOLVER, 'ExtrudeOpenBC', 'False');
invoke(FDSOLVER, 'SetOpenBCTypeHex', 'Default');
invoke(FDSOLVER, 'SetOpenBCTypeTet', 'Default');
invoke(FDSOLVER, 'AddMonitorSamples', 'True');
invoke(FDSOLVER, 'CalcStatBField', 'False');
invoke(FDSOLVER, 'CalcPowerLoss', 'True');
invoke(FDSOLVER, 'CalcPowerLossPerComponent', 'False');
invoke(FDSOLVER, 'StoreSolutionCoefficients', 'True');
invoke(FDSOLVER, 'UseDoublePrecision', 'False');
invoke(FDSOLVER, 'UseDoublePrecision_ML', 'True');
invoke(FDSOLVER, 'MixedOrderSrf', 'False');
invoke(FDSOLVER, 'MixedOrderTet', 'False');
invoke(FDSOLVER, 'PreconditionerAccuracyIntEq', '0.15');
invoke(FDSOLVER, 'MLFMMAccuracy', 'Default');
invoke(FDSOLVER, 'MinMLFMMBoxSize', '0.3');
invoke(FDSOLVER, 'UseCFIEForCPECIntEq', 'True');
invoke(FDSOLVER, 'UseFastRCSSweepIntEq', 'false');
invoke(FDSOLVER, 'UseSensitivityAnalysis', 'False');
invoke(FDSOLVER, 'RemoveAllStopCriteria', 'Hex');
invoke(FDSOLVER, 'AddStopCriterion', 'All S-Parameters', '0.01', '2', 'Hex', 'True');
invoke(FDSOLVER, 'AddStopCriterion', 'Reflection S-Parameters', '0.01', '2', 'Hex', 'False');
invoke(FDSOLVER, 'AddStopCriterion', 'Transmission S-Parameters', '0.01', '2', 'Hex', 'False');
invoke(FDSOLVER, 'RemoveAllStopCriteria', 'Tet');
invoke(FDSOLVER, 'AddStopCriterion', 'All S-Parameters', '0.01', '2', 'Tet', 'True');
invoke(FDSOLVER, 'AddStopCriterion', 'Reflection S-Parameters', '0.01', '2', 'Tet', 'False');
invoke(FDSOLVER, 'AddStopCriterion', 'Transmission S-Parameters', '0.01', '2', 'Tet', 'False');
invoke(FDSOLVER, 'AddStopCriterion', 'All Probes', '0.05', '2', 'Tet', 'True');
invoke(FDSOLVER, 'RemoveAllStopCriteria', 'Srf');
invoke(FDSOLVER, 'AddStopCriterion', 'All S-Parameters', '0.01', '2', 'Srf', 'True');
invoke(FDSOLVER, 'AddStopCriterion', 'Reflection S-Parameters', '0.01', '2', 'Srf', 'False');
invoke(FDSOLVER, 'AddStopCriterion', 'Transmission S-Parameters', '0.01', '2', 'Srf', 'False');
invoke(FDSOLVER, 'SweepMinimumSamples', '3');
invoke(FDSOLVER, 'SetNumberOfResultDataSamples', '1001');
invoke(FDSOLVER, 'SetResultDataSamplingMode', 'Automatic');
invoke(FDSOLVER, 'SweepWeightEvanescent', '1.0');
invoke(FDSOLVER, 'AccuracyROM', '1e-4');
invoke(FDSOLVER, 'AddSampleInterval', '', '', '1', 'Automatic', 'True');
invoke(FDSOLVER, 'AddSampleInterval', '', '', '', 'Automatic', 'False');
invoke(FDSOLVER, 'MPIParallelization', 'False');
invoke(FDSOLVER, 'UseDistributedComputing', 'False');
invoke(FDSOLVER, 'NetworkComputingStrategy', 'RunRemote');
invoke(FDSOLVER, 'NetworkComputingJobCount', '3');
invoke(FDSOLVER, 'UseParallelization', 'True');
invoke(FDSOLVER, 'MaxCPUs', '96');
invoke(FDSOLVER, 'MaximumNumberOfCPUDevices', '2');
release(FDSOLVER);
% '----------------------------------------------------------------------------
IESOLVER = invoke(MWS, 'IESolver');
invoke(IESOLVER, 'Reset');
invoke(IESOLVER, 'UseFastFrequencySweep', 'True');
invoke(IESOLVER, 'UseIEGroundPlane', 'False');
invoke(IESOLVER, 'SetRealGroundMaterialName', '');
invoke(IESOLVER, 'CalcFarFieldInRealGround', 'False');
invoke(IESOLVER, 'RealGroundModelType', 'Auto');
invoke(IESOLVER, 'PreconditionerType', 'Auto');
invoke(IESOLVER, 'ExtendThinWireModelByWireNubs', 'False');
invoke(IESOLVER, 'SetFMMFFCalcStopLevel', '0');
invoke(IESOLVER, 'SetFMMFFCalcNumInterpPoints', '6');
invoke(IESOLVER, 'UseFMMFarfieldCalc', 'True');
invoke(IESOLVER, 'SetCFIEAlpha', '0.500000');
invoke(IESOLVER, 'LowFrequencyStabilization', 'False');
invoke(IESOLVER, 'LowFrequencyStabilizationML', 'True');
invoke(IESOLVER, 'Multilayer', 'False');
invoke(IESOLVER, 'SetiMoMACC_I', '0.0001');
invoke(IESOLVER, 'SetiMoMACC_M', '0.0001');
invoke(IESOLVER, 'DeembedExternalPorts', 'True');
invoke(IESOLVER, 'SetOpenBC_XY', 'True');
invoke(IESOLVER, 'OldRCSSweepDefintion', 'False');
invoke(IESOLVER, 'SetAccuracySetting', 'Custom');
invoke(IESOLVER, 'CalculateSParaforFieldsources', 'True');
invoke(IESOLVER, 'ModeTrackingCMA', 'True');
invoke(IESOLVER, 'NumberOfModesCMA', '3');
invoke(IESOLVER, 'StartFrequencyCMA', '-1.0');
invoke(IESOLVER, 'SetAccuracySettingCMA', 'Default');
invoke(IESOLVER, 'FrequencySamplesCMA', '0');
invoke(IESOLVER, 'SetMemSettingCMA', 'Auto');
release(IESOLVER);
% '----------------------------------------------------------------------------
% Mesh.SetCreator "High Frequency" 
% With FDSolver
%      .Reset 
%      .SetMethod "Tetrahedral", "General purpose" 
%      .OrderTet "Second" 
%      .OrderSrf "First" 
%      .Stimulation "List", "List" 
%      .ResetExcitationList 
%      .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)" 
%      .AutoNormImpedance "False" 
%      .NormingImpedance "50" 
%      .ModesOnly "False" 
%      .ConsiderPortLossesTet "True" 
%      .SetShieldAllPorts "False" 
%      .AccuracyHex "1e-6" 
%      .AccuracyTet "1e-4" 
%      .AccuracySrf "1e-3" 
%      .LimitIterations "False" 
%      .MaxIterations "0" 
%      .SetCalcBlockExcitationsInParallel "True", "True", "" 
%      .StoreAllResults "False" 
%      .StoreResultsInCache "False" 
%      .UseHelmholtzEquation "True" 
%      .LowFrequencyStabilization "False" 
%      .Type "Auto" 
%      .MeshAdaptionHex "False" 
%      .MeshAdaptionTet "True" 
%      .AcceleratedRestart "True" 
%      .FreqDistAdaptMode "Distributed" 
%      .NewIterativeSolver "True" 
%      .TDCompatibleMaterials "False" 
%      .ExtrudeOpenBC "False" 
%      .SetOpenBCTypeHex "Default" 
%      .SetOpenBCTypeTet "Default" 
%      .AddMonitorSamples "True" 
%      .CalcStatBField "False" 
%      .CalcPowerLoss "True" 
%      .CalcPowerLossPerComponent "False" 
%      .StoreSolutionCoefficients "True" 
%      .UseDoublePrecision "False" 
%      .UseDoublePrecision_ML "True" 
%      .MixedOrderSrf "False" 
%      .MixedOrderTet "False" 
%      .PreconditionerAccuracyIntEq "0.15" 
%      .MLFMMAccuracy "Default" 
%      .MinMLFMMBoxSize "0.3" 
%      .UseCFIEForCPECIntEq "True" 
%      .UseFastRCSSweepIntEq "false" 
%      .UseSensitivityAnalysis "False" 
%      .RemoveAllStopCriteria "Hex"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
%      .RemoveAllStopCriteria "Tet"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
%      .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
%      .RemoveAllStopCriteria "Srf"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
%      .SweepMinimumSamples "3" 
%      .SetNumberOfResultDataSamples "1001" 
%      .SetResultDataSamplingMode "Automatic" 
%      .SweepWeightEvanescent "1.0" 
%      .AccuracyROM "1e-4" 
%      .AddSampleInterval "15", "", "1", "Single", "True" 
%      .AddSampleInterval "", "", "", "Automatic", "False" 
%      .MPIParallelization "False"
%      .UseDistributedComputing "False"
%      .NetworkComputingStrategy "RunRemote"
%      .NetworkComputingJobCount "3"
%      .UseParallelization "True"
%      .MaxCPUs "96"
%      .MaximumNumberOfCPUDevices "2"
% End With
% With IESolver
%      .Reset 
%      .UseFastFrequencySweep "True" 
%      .UseIEGroundPlane "False" 
%      .SetRealGroundMaterialName "" 
%      .CalcFarFieldInRealGround "False" 
%      .RealGroundModelType "Auto" 
%      .PreconditionerType "Auto" 
%      .ExtendThinWireModelByWireNubs "False" 
% End With
% With IESolver
%      .SetFMMFFCalcStopLevel "0" 
%      .SetFMMFFCalcNumInterpPoints "6" 
%      .UseFMMFarfieldCalc "True" 
%      .SetCFIEAlpha "0.500000" 
%      .LowFrequencyStabilization "False" 
%      .LowFrequencyStabilizationML "True" 
%      .Multilayer "False" 
%      .SetiMoMACC_I "0.0001" 
%      .SetiMoMACC_M "0.0001" 
%      .DeembedExternalPorts "True" 
%      .SetOpenBC_XY "True" 
%      .OldRCSSweepDefintion "False" 
%      .SetAccuracySetting "Custom" 
%      .CalculateSParaforFieldsources "True" 
%      .ModeTrackingCMA "True" 
%      .NumberOfModesCMA "3" 
%      .StartFrequencyCMA "-1.0" 
%      .SetAccuracySettingCMA "Default" 
%      .FrequencySamplesCMA "0" 
%      .SetMemSettingCMA "Auto" 
% End With
% '----------------------------------------------------------------------------
% With ParameterSweep
%      .AddSequence "Sequence 1" 
% End With
PARAMETERSWEEP = invoke(MWS, 'ParameterSweep');
invoke(PARAMETERSWEEP, AddSequence, 'Sequence 1');
invoke(AddParameter_Linear, 'Sequence 1', 'theta', '0', '50', '6');
release(PARAMETERSWEEP);
% '----------------------------------------------------------------------------
% With ParameterSweep
%      .AddParameter_Linear "Sequence 1", "theta", "0", "50", "6" 
% End With
% '----------------------------------------------------------------------------
% Pick.ClearAllPicks
PICK = invoke(MWS, 'Pick');
invoke(PICK, 'ClearAllPicks');
release(PICK);
% '----------------------------------------------------------------------------
% Mesh.SetCreator "High Frequency" 
% With FDSolver
%      .Reset 
%      .SetMethod "Tetrahedral", "General purpose" 
%      .OrderTet "Second" 
%      .OrderSrf "First" 
%      .Stimulation "List", "List" 
%      .ResetExcitationList 
%      .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)" 
%      .AutoNormImpedance "False" 
%      .NormingImpedance "50" 
%      .ModesOnly "False" 
%      .ConsiderPortLossesTet "True" 
%      .SetShieldAllPorts "False" 
%      .AccuracyHex "1e-6" 
%      .AccuracyTet "1e-4" 
%      .AccuracySrf "1e-3" 
%      .LimitIterations "False" 
%      .MaxIterations "0" 
%      .SetCalcBlockExcitationsInParallel "True", "True", "" 
%      .StoreAllResults "False" 
%      .StoreResultsInCache "False" 
%      .UseHelmholtzEquation "True" 
%      .LowFrequencyStabilization "False" 
%      .Type "Auto" 
%      .MeshAdaptionHex "False" 
%      .MeshAdaptionTet "True" 
%      .AcceleratedRestart "True" 
%      .FreqDistAdaptMode "Distributed" 
%      .NewIterativeSolver "True" 
%      .TDCompatibleMaterials "False" 
%      .ExtrudeOpenBC "False" 
%      .SetOpenBCTypeHex "Default" 
%      .SetOpenBCTypeTet "Default" 
%      .AddMonitorSamples "True" 
%      .CalcStatBField "False" 
%      .CalcPowerLoss "True" 
%      .CalcPowerLossPerComponent "False" 
%      .StoreSolutionCoefficients "True" 
%      .UseDoublePrecision "False" 
%      .UseDoublePrecision_ML "True" 
%      .MixedOrderSrf "False" 
%      .MixedOrderTet "False" 
%      .PreconditionerAccuracyIntEq "0.15" 
%      .MLFMMAccuracy "Default" 
%      .MinMLFMMBoxSize "0.3" 
%      .UseCFIEForCPECIntEq "True" 
%      .UseFastRCSSweepIntEq "false" 
%      .UseSensitivityAnalysis "False" 
%      .RemoveAllStopCriteria "Hex"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
%      .RemoveAllStopCriteria "Tet"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
%      .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
%      .RemoveAllStopCriteria "Srf"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
%      .SweepMinimumSamples "3" 
%      .SetNumberOfResultDataSamples "1001" 
%      .SetResultDataSamplingMode "Automatic" 
%      .SweepWeightEvanescent "1.0" 
%      .AccuracyROM "1e-4" 
%      .AddSampleInterval "15", "", "1", "Single", "True" 
%      .AddSampleInterval "", "", "", "Automatic", "False" 
%      .MPIParallelization "False"
%      .UseDistributedComputing "False"
%      .NetworkComputingStrategy "RunRemote"
%      .NetworkComputingJobCount "3"
%      .UseParallelization "True"
%      .MaxCPUs "96"
%      .MaximumNumberOfCPUDevices "2"
% End With
% With MeshSettings
%      .SetMeshType "Unstr"
%      .Set "UseDC", "0"
% End With
% UseDistributedComputingForParameters "False"
% MaxNumberOfDistributedComputingParameters "2"
% UseDistributedComputingMemorySetting "False"
% MinDistributedComputingMemoryLimit "0"
% UseDistributedComputingSharedDirectory "False"
% With IESolver
%      .Reset 
%      .UseFastFrequencySweep "True" 
%      .UseIEGroundPlane "False" 
%      .SetRealGroundMaterialName "" 
%      .CalcFarFieldInRealGround "False" 
%      .RealGroundModelType "Auto" 
%      .PreconditionerType "Auto" 
%      .ExtendThinWireModelByWireNubs "False" 
% End With
% With IESolver
%      .SetFMMFFCalcStopLevel "0" 
%      .SetFMMFFCalcNumInterpPoints "6" 
%      .UseFMMFarfieldCalc "True" 
%      .SetCFIEAlpha "0.500000" 
%      .LowFrequencyStabilization "False" 
%      .LowFrequencyStabilizationML "True" 
%      .Multilayer "False" 
%      .SetiMoMACC_I "0.0001" 
%      .SetiMoMACC_M "0.0001" 
%      .DeembedExternalPorts "True" 
%      .SetOpenBC_XY "True" 
%      .OldRCSSweepDefintion "False" 
%      .SetAccuracySetting "Custom" 
%      .CalculateSParaforFieldsources "True" 
%      .ModeTrackingCMA "True" 
%      .NumberOfModesCMA "3" 
%      .StartFrequencyCMA "-1.0" 
%      .SetAccuracySettingCMA "Default" 
%      .FrequencySamplesCMA "0" 
%      .SetMemSettingCMA "Auto" 
% End With
% '----------------------------------------------------------------------------
% Pick.PickEndpointFromId "component1:solid1", "2"
PICK = invoke(MWS, 'Pick');
invoke(PICK, 'PickEndpointFromId', 'component1:solid1', '2');
release(PICK);
% '----------------------------------------------------------------------------
% Mesh.SetCreator "High Frequency" 
% With FDSolver
%      .Reset 
%      .SetMethod "Tetrahedral", "General purpose" 
%      .OrderTet "Second" 
%      .OrderSrf "First" 
%      .Stimulation "List", "List" 
%      .ResetExcitationList 
%      .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)" 
%      .AutoNormImpedance "False" 
%      .NormingImpedance "50" 
%      .ModesOnly "False" 
%      .ConsiderPortLossesTet "True" 
%      .SetShieldAllPorts "False" 
%      .AccuracyHex "1e-6" 
%      .AccuracyTet "1e-4" 
%      .AccuracySrf "1e-3" 
%      .LimitIterations "False" 
%      .MaxIterations "0" 
%      .SetCalcBlockExcitationsInParallel "True", "True", "" 
%      .StoreAllResults "False" 
%      .StoreResultsInCache "False" 
%      .UseHelmholtzEquation "True" 
%      .LowFrequencyStabilization "False" 
%      .Type "Auto" 
%      .MeshAdaptionHex "False" 
%      .MeshAdaptionTet "True" 
%      .AcceleratedRestart "True" 
%      .FreqDistAdaptMode "Distributed" 
%      .NewIterativeSolver "True" 
%      .TDCompatibleMaterials "False" 
%      .ExtrudeOpenBC "False" 
%      .SetOpenBCTypeHex "Default" 
%      .SetOpenBCTypeTet "Default" 
%      .AddMonitorSamples "True" 
%      .CalcStatBField "False" 
%      .CalcPowerLoss "True" 
%      .CalcPowerLossPerComponent "False" 
%      .StoreSolutionCoefficients "True" 
%      .UseDoublePrecision "False" 
%      .UseDoublePrecision_ML "True" 
%      .MixedOrderSrf "False" 
%      .MixedOrderTet "False" 
%      .PreconditionerAccuracyIntEq "0.15" 
%      .MLFMMAccuracy "Default" 
%      .MinMLFMMBoxSize "0.3" 
%      .UseCFIEForCPECIntEq "True" 
%      .UseFastRCSSweepIntEq "false" 
%      .UseSensitivityAnalysis "False" 
%      .RemoveAllStopCriteria "Hex"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
%      .RemoveAllStopCriteria "Tet"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
%      .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
%      .RemoveAllStopCriteria "Srf"
%      .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
%      .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
%      .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
%      .SweepMinimumSamples "3" 
%      .SetNumberOfResultDataSamples "1001" 
%      .SetResultDataSamplingMode "Automatic" 
%      .SweepWeightEvanescent "1.0" 
%      .AccuracyROM "1e-4" 
%      .AddSampleInterval "15", "", "1", "Single", "True" 
%      .AddSampleInterval "", "", "", "Automatic", "False" 
%      .MPIParallelization "False"
%      .UseDistributedComputing "False"
%      .NetworkComputingStrategy "RunRemote"
%      .NetworkComputingJobCount "3"
%      .UseParallelization "True"
%      .MaxCPUs "96"
%      .MaximumNumberOfCPUDevices "2"
% End With
% With IESolver
%      .Reset 
%      .UseFastFrequencySweep "True" 
%      .UseIEGroundPlane "False" 
%      .SetRealGroundMaterialName "" 
%      .CalcFarFieldInRealGround "False" 
%      .RealGroundModelType "Auto" 
%      .PreconditionerType "Auto" 
%      .ExtendThinWireModelByWireNubs "False" 
% End With
% With IESolver
%      .SetFMMFFCalcStopLevel "0" 
%      .SetFMMFFCalcNumInterpPoints "6" 
%      .UseFMMFarfieldCalc "True" 
%      .SetCFIEAlpha "0.500000" 
%      .LowFrequencyStabilization "False" 
%      .LowFrequencyStabilizationML "True" 
%      .Multilayer "False" 
%      .SetiMoMACC_I "0.0001" 
%      .SetiMoMACC_M "0.0001" 
%      .DeembedExternalPorts "True" 
%      .SetOpenBC_XY "True" 
%      .OldRCSSweepDefintion "False" 
%      .SetAccuracySetting "Custom" 
%      .CalculateSParaforFieldsources "True" 
%      .ModeTrackingCMA "True" 
%      .NumberOfModesCMA "3" 
%      .StartFrequencyCMA "-1.0" 
%      .SetAccuracySettingCMA "Default" 
%      .FrequencySamplesCMA "0" 
%      .SetMemSettingCMA "Auto" 
% End With
% '----------------------------------------------------------------------------
BRICK = invoke(MWS, 'Brick');
invoke(BRICK, 'Reset');
invoke(BRICK, 'Name', 'solid3');
invoke(BRICK, 'Component', 'component1');
invoke(BRICK, 'Material', 'Vacuum');
invoke(BRICK, 'Xrange', '-GapLength/2', 'GapLength/2');
invoke(BRICK, 'Yrange', '0', 'SubWidth/2');
invoke(BRICK, 'Zrange', '0', 'RingHeight');
invoke(BRICK, 'Create');
release(BRICK);
% '----------------------------------------------------------------------------
SOLID = invoke(MWS, 'Solid');
invoke(SOLID, 'Subtract', 'component1:solid2', 'component1:solid3');
release(SOLID);
% '----------------------------------------------------------------------------
