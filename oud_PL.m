function [PL_res] = oud_PL(variable) 

upto = size(variable,2);

for i=2:upto
    [value,index] = max(variable(:,i));
    PL_res(i-1,1) = variable(index,1);
    PL_res(i-1,2) = value;
    PL_res(i-1,3) = i*0.045;%i/45;%(i*0.005)+1;
end

%limit = upto*0.05;
%PL_res(:,3) = 0:0.05:limit;

%plot(PL_res);

plot(PL_res(:,3),smooth(PL_res(:,2)));
%plotyy(PL_res(:,3),PL_res(:,2),time,vf,'plot');

end