function [output_array] = arr_to_wave(amp, freq, time, form, track_time, bitrate)
%ARR_TO_WAVE Summary of this function goes here
%   Detailed explanation goes here
output_array=[];
data = [];
stage_time_1 = 0;

freq_max = 20000;
freq_min = 20;

frequencic = freq * (freq_max-freq_min)+freq_min
time_sampl = track_time / sum(time)
time_samples = time*time_sampl;
sum(time_samples)
time_step = 1/bitrate;
omega = 2 * pi * frequencic;
m=1;

while m<size(time,2)+1
    stage_time = time_samples(m);
    new_data = [];
    m
%     form
    for n=stage_time_1:time_step:stage_time
        switch form
            case 'sine'
                data = amp(m)*sin(omega(m)*n);
            case 'square'
                data = amp(m)*square(omega(m)*n);
            case 'triangle'
                data = amp(m)*sawtooth(omega(m)*n,1/2);
            case 'swatooth'
                data = amp(m)*sin(omega(m)*n);
            otherwise
                print("what")
        end
        new_data = [new_data data];
    end
    stage_time_1 = stage_time;
    m=m+1;
    output_array = [output_array new_data];
    size(output_array)
end
end
