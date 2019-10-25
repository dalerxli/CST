function []=SetFloquetPort(MWS)
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
end