function [del_PL] = oud_del_PL(variable) 

upto = size(variable,2);
stepBack = 25;

for i=2:upto
    [value,index] = max(variable(:,i));
    PL_res(i-1,1) = variable(index,1);
    PL_res(i-1,2) = value;
    PL_res(i-1,3) = (i*0.045);%(i*0.005)+1;
end
x = PL_res(:,3);
y = smooth(PL_res(:,2));
[pk,lk] = findpeaks(y,'MinPeakDistance',x(50), 'MinPeakProminence',10);

x_pk_max = x(lk);
y_pk_max = pk;

x_pk_min = x(lk-stepBack);
y_pk_min = y(lk-stepBack);
del_PL = [];
for i=1:size(pk,1)
    del = 100*((y_pk_max(i)-y_pk_min(i))/y_pk_max(i));
    del_PL = [del_PL, del];
end

plot(x,y,x_pk_max,y_pk_max,'o');
hold on;
plot(x_pk_min,y_pk_min,'x');
end