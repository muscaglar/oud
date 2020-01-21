function [summary] = oud_PL_change(V,V_T,PL,PL_T)%PL,PL_T,V,V_T)

grad = abs(gradient(gradient(smooth(V))));
grad = grad*100;
grad(grad>50)=0;
[pks,locs,widths,proms] = findpeaks(smooth(grad),V_T,'MinPeakProminence',1,'MinPeakDistance',5,'Annotate','extents');
peak_times = locs;

PL_locs = [];

for i = 1:1:length(locs)
    curentValue = find(abs(PL_T-peak_times(i))<0.02);
    if isempty(curentValue)
        curentValue = find(abs(PL_T-peak_times(i))<0.25);
        if isempty(curentValue)
            curentValue = find(abs(PL_T-peak_times(i))<0.5);
        end
        if isempty(curentValue)
        else
            curentValue = curentValue(1);
        end
    end
    PL_locs = [curentValue, PL_locs];
end

x = 1;
summary = zeros(length(PL_locs),2);

[pks,locs,widths,proms] = findpeaks(smooth(grad),'MinPeakProminence',1,'MinPeakDistance',5,'Annotate','extents');

for i = 1:2:length(PL_locs)
    summary(x,1) = V(round(locs(i)*1.1));
    summary(x,2) = mean(PL(i:i+1));
    x=x+1;
end

end