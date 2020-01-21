function [] = oud_segmentF_PL(F_V,PL,PL_s,fName)

% Take the time values from Hz_1
time_low = duration2double(min(F_V.Time));
time_high = duration2double(max(F_V.Time));
% Find the index of the equiv in PL_s
low = isalmost(PL_s,time_low,0.025);
high = isalmost(PL_s,time_high,0.025);
%
index = low | high;
index(find(low==1):find(high==1),1) = 1;

V = F_V.Var1;
V_s = duration2double(F_V.Time);

PL = PL(index);
PL_s = PL_s(index);

save(fName,'V','V_s','PL','PL_s');

function out = duration2double(input)
    z = 1;
    out = [];
    for i = input'
        output = strsplit(char(i),' sec');
        output = output{1};
        out(z) = str2double(output);
        z = z +1;
    end
end

end