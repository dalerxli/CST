function []=SetBoundary(MWS)
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
end