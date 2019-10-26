function [Freq_, s11_re, s11_im, s21_re, s21_im] = SaveResults(MWS)
Res = invoke(MWS, 'ResultTree'); 
s11 = invoke(Res, 'GetResultIDsFromTreeItem', '1D Results\S-Parameters\SZmax(1),Zmax(1)');
s11_ = invoke(Res, 'GetResultFromTreeItem', '1D Results\S-Parameters\SZmax(1),Zmax(1)', s11{1}); 
Freq_= invoke(s11_, 'GetArray', 'x');
s11_re = invoke(s11_, 'GetArray','yre');
s11_im = invoke(s11_, 'GetArray','yim');

s21 = invoke(Res, 'GetResultIDsFromTreeItem', '1D Results\S-Parameters\SZmin(1),Zmax(1)');
s21_ = invoke(Res, 'GetResultFromTreeItem', '1D Results\S-Parameters\SZmin(1),Zmax(1)', s21{1});
s21_re = invoke(s21_, 'GetArray','yre');
s21_im = invoke(s21_, 'GetArray','yim');
end