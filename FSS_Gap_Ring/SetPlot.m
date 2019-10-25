function []=SetPlot(MWS)
PLOT = invoke(MWS, 'Plot');
invoke(PLOT, 'DrawBox', 'True');
invoke(PLOT, 'DrawWorkplane', 'true');
release(PLOT);
end