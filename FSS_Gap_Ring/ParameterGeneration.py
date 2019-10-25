#!/usr/bin/env python
# -*- coding:utf-8 -*-

import numpy as np

SubWidth = np.linspace(7, 9, 11)
SubThickness = np.array([0.1, 0.2])
RingRadius_Outer = np.linspace(1.4, 4.2, 15)
RingRadius_Inner = np.linspace(1.0, 3.6, 14)
RingHeight = 0.05
GapLength = np.linspace(0.5, 5.5, 26)
Auxiliary = max(SubWidth + 1)

ParaList = []

for SubThickness_tmp in SubThickness:
    for SubWidth_tmp in SubWidth:
        for RingRadius_Outer_tmp in RingRadius_Outer:
            for RingRadius_Inner_tmp in RingRadius_Inner:
                for GapLength_tmp in GapLength:
                    if SubWidth_tmp > 2*(RingRadius_Outer_tmp) and RingRadius_Outer_tmp > RingRadius_Inner_tmp and GapLength_tmp < 2*(RingRadius_Inner_tmp):
                        ParaList_tmp = [SubThickness_tmp, SubWidth_tmp, RingRadius_Outer_tmp, RingRadius_Inner_tmp, GapLength_tmp, RingHeight]
                        ParaList.append(ParaList_tmp)

ParaList = np.array(ParaList)

np.savetxt('ParaList.txt', ParaList, fmt='%.2f')

print('end')
