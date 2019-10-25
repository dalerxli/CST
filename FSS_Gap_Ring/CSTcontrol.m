clear
clc
close all
% '----------------------------------------------------------------------------
ParaList = load('ParaList.txt');
% '----------------------------------------------------------------------------
% SubWidth = np.linspace(7, 9, 11)
% SubThickness = np.array([0.1, 0.2])
% RingRadius_Outer = np.linspace(1.4, 4.2, 15)
% RingRadius_Inner = np.linspace(1.0, 3.6, 14)
% RingHeight = 0.05
% GapLength = np.linspace(0.5, 5.5, 26)
% Auxiliary = max(SubWidth + 1)
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
% 'set the units
% With Units
%     .Geometry "mm"
%     .Frequency "GHz"
%     .Voltage "V"
%     .Resistance "Ohm"
%     .Inductance "NanoH"
%     .TemperatureUnit  "Kelvin"
%     .Time "ns"
%     .Current "A"
%     .Conductance "Siemens"
%     .Capacitance "PikoF"
% End With
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
% Plot.DrawBox True
PLOT = invoke(MWS, 'Plot');
invoke(PLOT, 'DrawBox', 'True');
release(PLOT);
% '----------------------------------------------------------------------------
% With Background
%      .Type "Normal"
%      .Epsilon "1.0"
%      .Mu "1.0"
%      .Rho "1.204"
%      .ThermalType "Normal"
%      .ThermalConductivity "0.026"
%      .HeatCapacity "1.005"
%      .XminSpace "0.0"
%      .XmaxSpace "0.0"
%      .YminSpace "0.0"
%      .YmaxSpace "0.0"
%      .ZminSpace "0.0"
%      .ZmaxSpace "0.0"
% End With
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
% ' define Floquet port boundaries
% With FloquetPort
%      .Reset
%      .SetDialogTheta "0"
%      .SetDialogPhi "0"
%      .SetSortCode "+beta/pw"
%      .SetCustomizedListFlag "False"
%      .Port "Zmin"
%      .SetNumberOfModesConsidered "2"
%      .Port "Zmax"
%      .SetNumberOfModesConsidered "2"
% End With
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
% MakeSureParameterExists "theta", "0"
% SetParameterDescription "theta", "spherical angle of incident plane wave"
% MakeSureParameterExists "phi", "0"
% SetParameterDescription "phi", "spherical angle of incident plane wave"
% '----------------------------------------------------------------------------
% ' define boundaries, the open boundaries define floquet port
% With Boundary
%      .Xmin "unit cell"
%      .Xmax "unit cell"
%      .Ymin "unit cell"
%      .Ymax "unit cell"
%      .Zmin "expanded open"
%      .Zmax "expanded open"
%      .Xsymmetry "none"
%      .Ysymmetry "none"
%      .Zsymmetry "none"
%      .XPeriodicShift "0.0"
%      .YPeriodicShift "0.0"
%      .ZPeriodicShift "0.0"
%      .PeriodicUseConstantAngles "False"
%      .SetPeriodicBoundaryAngles "theta", "phi"
%      .SetPeriodicBoundaryAnglesDirection "inward"
%      .UnitCellFitToBoundingBox "True"
%      .UnitCellDs1 "0.0"
%      .UnitCellDs2 "0.0"
%      .UnitCellAngle "90.0"
% End With
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
% ' set tet mesh as default
% With Mesh
%      .MeshType "Tetrahedral"
% End With
MESH = invoke(MWS, 'Mesh');
invoke(MESH, 'MeshType', 'Tetrahedral');
release(MESH);
% '----------------------------------------------------------------------------
% ' FD solver excitation with incoming plane wave at Zmax
% With FDSolver
%      .Reset
%      .Stimulation "List", "List"
%      .ResetExcitationList
%      .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)"
%      .LowFrequencyStabilization "False"
% End With
% '----------------------------------------------------------------------------
% 'set the frequency range
% Solver.FrequencyRange "10", "20"
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
% With Material
%      .Reset
%      .Name "Arlon AD 300 (lossy)"
%      .Folder ""
%      .FrqType "all"
%      .Type "Normal"
%      .SetMaterialUnit "GHz", "mm"
%      .Epsilon "3"
%      .Mu "1.0"
%      .Kappa "0.0"
%      .TanD "0.003"
%      .TanDFreq "10.0"
%      .TanDGiven "True"
%      .TanDModel "ConstTanD"
%      .KappaM "0.0"
%      .TanDM "0.0"
%      .TanDMFreq "0.0"
%      .TanDMGiven "False"
%      .TanDMModel "ConstKappa"
%      .DispModelEps "None"
%      .DispModelMu "None"
%      .DispersiveFittingSchemeEps "General 1st"
%      .DispersiveFittingSchemeMu "General 1st"
%      .UseGeneralDispersionEps "False"
%      .UseGeneralDispersionMu "False"
%      .Rho "0.0"
%      .ThermalType "Normal"
%      .ThermalConductivity "0.235"
%      .SetActiveMaterial "all"
%      .Colour "0.94", "0.82", "0.76"
%      .Wireframe "False"
%      .Transparency "0"
%      .Create
% End With
% '----------------------------------------------------------------------------
% Component.New "component1"
% '----------------------------------------------------------------------------
% With Brick
%      .Reset 
%      .Name "solid1" 
%      .Component "component1" 
%      .Material "Arlon AD 300 (lossy)" 
%      .Xrange "-SubWidth/2", "SubWidth/2" 
%      .Yrange "-SubWidth/2", "SubWidth/2" 
%      .Zrange "-SubThickness", "0" 
%      .Create
% End With
% '----------------------------------------------------------------------------
% Pick.PickFaceFromId "component1:solid1", "1"
% '----------------------------------------------------------------------------
% With Material
%      .Reset
%      .Name "Copper (annealed)"
%      .Folder ""
%      .FrqType "static"
%      .Type "Normal"
%      .SetMaterialUnit "Hz", "mm"
%      .Epsilon "1"
%      .Mu "1.0"
%      .Kappa "5.8e+007"
%      .TanD "0.0"
%      .TanDFreq "0.0"
%      .TanDGiven "False"
%      .TanDModel "ConstTanD"
%      .KappaM "0"
%      .TanDM "0.0"
%      .TanDMFreq "0.0"
%      .TanDMGiven "False"
%      .TanDMModel "ConstTanD"
%      .DispModelEps "None"
%      .DispModelMu "None"
%      .DispersiveFittingSchemeEps "Nth Order"
%      .DispersiveFittingSchemeMu "Nth Order"
%      .UseGeneralDispersionEps "False"
%      .UseGeneralDispersionMu "False"
%      .FrqType "all"
%      .Type "Lossy metal"
%      .SetMaterialUnit "GHz", "mm"
%      .Mu "1.0"
%      .Kappa "5.8e+007"
%      .Rho "8930.0"
%      .ThermalType "Normal"
%      .ThermalConductivity "401.0"
%      .HeatCapacity "0.39"
%      .MetabolicRate "0"
%      .BloodFlow "0"
%      .VoxelConvection "0"
%      .MechanicsType "Isotropic"
%      .YoungsModulus "120"
%      .PoissonsRatio "0.33"
%      .ThermalExpansionRate "17"
%      .Colour "1", "1", "0"
%      .Wireframe "False"
%      .Reflection "False"
%      .Allowoutline "True"
%      .Transparentoutline "False"
%      .Transparency "0"
%      .Create
% End With
% '----------------------------------------------------------------------------
% With Cylinder 
%      .Reset 
%      .Name "solid2" 
%      .Component "component1" 
%      .Material "Copper (annealed)" 
%      .OuterRadius "RingRadius_Outer" 
%      .InnerRadius "RingRadius_Inner" 
%      .Axis "z" 
%      .Zrange "0", "RingHeight" 
%      .Xcenter "0" 
%      .Ycenter "0" 
%      .Segments "0" 
%      .Create 
% End With
% '----------------------------------------------------------------------------
% Pick.ClearAllPicks
% '----------------------------------------------------------------------------
% With ParameterSweep
%     .SetSimulationType "Frequency" 
% End With
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
%      .AddSampleInterval "", "", "1", "Automatic", "True" 
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
% Plot.DrawWorkplane "false"
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
% '----------------------------------------------------------------------------
% With ParameterSweep
%      .AddParameter_Linear "Sequence 1", "theta", "0", "50", "6" 
% End With
% '----------------------------------------------------------------------------
% Pick.ClearAllPicks
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
% Pick.ClearAllPicks 
% '----------------------------------------------------------------------------
% Plot.DrawWorkplane "true" 
% '----------------------------------------------------------------------------
% With Brick
%      .Reset 
%      .Name "solid3" 
%      .Component "component1" 
%      .Material "Vacuum" 
%      .Xrange "-GapLength/2", "GapLength/2" 
%      .Yrange "0", "SubWidth/2" 
%      .Zrange "0", "RingHeight" 
%      .Create
% End With
% '----------------------------------------------------------------------------
% Solid.Subtract "component1:solid2", "component1:solid3" 
% '----------------------------------------------------------------------------
% Solver.FrequencyRange "8", "22" 
% '----------------------------------------------------------------------------