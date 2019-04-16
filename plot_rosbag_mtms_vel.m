data_file = 'data/MTML-MTMR-twist.bag';
bagselect = rosbag(data_file);
bSel_current_mtm = select(bagselect,'Topic','/dvrk/MTMR/twist_body_current');
current_mtm_struct = readMessages(bSel_current_mtm);

velocity_arr = [];
time_arr = [];
duration_arr = [];
start_time = current_mtm_struct{1}.Header.Stamp.Sec + current_mtm_struct{1}.Header.Stamp.Nsec*10^-9;
for i = 1:size(current_mtm_struct,1)
    vel = [current_mtm_struct{i}.Twist.Linear.X;current_mtm_struct{i}.Twist.Linear.Y;current_mtm_struct{i}.Twist.Linear.Z];
    velocity_arr = cat(2,velocity_arr,vel);
    time_arr = cat(2,time_arr, (current_mtm_struct{i}.Header.Stamp.Sec + current_mtm_struct{i}.Header.Stamp.Nsec*10^-9)   ...
                                - start_time);
    if i ~ =1
        duration_arr = cat(2, duration_arr, time_arr(end) - time_arr(end-1));
    else
        duration_arr = [0];
    end
end

plot(time_arr, velocity_arr(1,:))
duration_mean = mean(duration_arr);