clear
clc

ParaList = load('ParaList.txt');

Freq = [10, 20];

if ~exist('DataSets', 'dir')
    mkdir('DataSets');
end

for n = 1: 10000
    main(ParaList(n, :), Freq);
    disp('---------------------------------');
    disp(n);
end