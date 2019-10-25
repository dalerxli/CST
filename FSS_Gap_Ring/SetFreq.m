function []=SetFreq(MWS, freq1, freq2)
SOLVER = invoke(MWS, 'Solver');
invoke(SOLVER, 'FrequencyRange', freq1, freq2);
release(SOLVER);
end