clear
clc

ParaList = load('ParaList.txt');

Freq = [10, 20];

[aaa, bbb] = main(ParaList(2224, :), Freq);
