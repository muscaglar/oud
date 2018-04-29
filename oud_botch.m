function [] = oud_botch(PL_Spectra, result, name)

PL_res = oud_PL(PL_Spectra);
PL_volt = [result(:,1),result(:,2)];

save(name, 'PL_volt','PL_res');

close all;

end