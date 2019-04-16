mtmrdata = csvread('/mnt/ramdisk/StateDataCollection-MTMR-StateTable-2019-04-16-16-13-36.csv');
duration_arr = [];
mtm_vel_linear_mat = [];
time_arr = [];
for i = 1:size(mtmrdata,1)
    if i== 1
        duration_arr = 0;
        mtm_vel_linear_mat = mtmrdata(1,5:7);
        time_arr = 0;
    else
        duration_arr = [duration_arr,mtmrdata(i,2)-mtmrdata(i-1,2)];
        mtm_vel_linear_mat = cat(1,mtm_vel_linear_mat,mtmrdata(i,5:7));
        time_arr = [time_arr, mtmrdata(i,2)-mtmrdata(1,2)];
    end  
end
duration_mean = mean(duration_arr)
x = mtm_vel_linear_mat(:,1).';
fft_n = 10000;
x_fft = fft(x);
Px_fft = x_fft.*conj(x_fft)/size(x_fft,2);
f = 1/duration_mean/size(x_fft,2)*(1:size(mtmrdata,1));

%x_filtered = lowpass(x,1000,1/duration_mean);
figure(1)
hold on
plot(time_arr, x)
%plot(time_arr, x_filtered)
hold off



figure(2)
plot(1:size(Px_fft,2),Px_fft)
