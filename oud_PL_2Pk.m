function [PL_res1, PL_res2] = oud_PL_2Pk(variable) 

upto = size(variable,2);

for i=2:upto
    [value,index] = max(variable(1:230,i));
    PL_res1(i-1,1) = variable(index,1);
    PL_res1(i-1,2) = value;
    PL_res1(i-1,3) = (i*0.045);%(i*0.005)+1;
end

for i=2:upto
    [value,index] = max(variable(400:1024,i));
    index = index +400;
    PL_res2(i-1,1) = variable(index,1);
    PL_res2(i-1,2) = value;
    PL_res2(i-1,3) = (i*0.045);%(i*0.005)+1;
end
%limit = upto*0.05;
%PL_res(:,3) = 0:0.05:limit;

%plot(PL_res);

%%plotyy(PL_res(:,3),PL_res(:,2),time,vf,'plot');

figure; plot(PL_res1(:,3),PL_res1(:,2));
figure; plot(PL_res2(:,3),PL_res2(:,2));

end