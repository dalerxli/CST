function []=SetBackground(MWS)
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
end