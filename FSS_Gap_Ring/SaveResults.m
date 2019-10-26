function [aaa, bbb] = SaveResults(MWS)
Res = invoke(MWS, 'ResultTree'); 
s11 = invoke(Res, 'GetResultIDsFromTreeItem', '1D Results\S-Parameters\SZmax(1),Zmax(1)');
s21 = invoke(Res, 'GetResultIDsFromTreeItem', '1D Results\S-Parameters\SZmin(1),Zmax(1)');

s11_ = invoke(Res, 'GetResultFromTreeItem', '1D Results\S-Parameters\SZmax(1),Zmax(1)', s11{1}); 
Freq_ = invoke(s11_, 'GetArray', 'x');
s11_re = invoke(s11_, 'GetArray','yre');
s11_im = invoke(s11_, 'GetArray','yim');

s11_1 = invoke(Res, 'GetResultFromTreeItem', '1D Results\S-Parameters\SZmax(1),Zmax(1)', s11{2});
Freq_1 = invoke(s11_1, 'GetArray', 'x');
s11_re_1 = invoke(s11_1, 'GetArray','yre');
s11_im_1 = invoke(s11_1, 'GetArray','yim');

aaa = [Freq_, s11_re, s11_im];
bbb = [Freq_1, s11_re_1, s11_im_1];
end