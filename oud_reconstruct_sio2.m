function[output] = oud_reconstruct_sio2(data)

time = 0:0.2:((size(data,2) -1)*0.2);
time(255) = [];

output = zeros((size(data,2) -1),2);
output(:,1) = time;

for i=2:(size(data,2) -1)
    output(i-1,2) = max(data(:,i));
end

end