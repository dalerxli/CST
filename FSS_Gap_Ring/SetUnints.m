function []=SetUnints(MWS)
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
end