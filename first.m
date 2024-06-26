close all
clear 

fig = figure;

%%
clf

track_time = 600 %s
track_bitrate = 192000 % Hz

filename = 'altimeter_gpx_260624.gpx';
trk = gpxread(filename,'FeatureType','track');

P = gpxread(filename);
% [latlim, lonlim] = geoquadline(P.Latitude, P.Longitude);
% [latlim, lonlim] = bufgeoquad(latlim, lonlim, .005, .005);

timeStr = strrep(trk.Time,'.000Z','')
% t = datetime(timeStr);



% fig = figure;
% pos = fig.Position;
% fig.Position = [300 300 1.25*pos(3) 1.25*pos(4)];
% ax = usamap(latlim, lonlim);
% setm(ax, 'MLabelParallel', 43.5);
% geoshow(P.Latitude, P.Longitude);
coef = 100;
coef_ceil = 100000;
% ind = 15:24
% ind = 5:10
% Lat = (P.Latitude(ind)*coef_ceil-ceil(P.Latitude(ind)*coef_ceil))*coef;
% Long = (P.Longitude(ind)*coef_ceil-ceil(P.Longitude(ind)*coef_ceil))*coef;
Lat = random_norm(P.Latitude, coef_ceil, coef);
Long = random_norm(P.Longitude, coef_ceil, coef);

elev = random_norm(P.Elevation, 0.1, 10);

% frequencic_lat

% plot(Lat,Long);
% plot(frequencic_lat);
% plot(elev);

%%
% t = 0.001:0.001:1;
% omega = 2 * pi * 1
% m = sin(omega*t);
% plot(t,m)

% form_array = ['sine','square','triangle','swatooth'];
% [amp, freq, time, form, track_time, bitrate] = 
% [Long, Lat, elev, form_array(1), track_time, track_bitrate]
% amp = Long;
% freq = Lat;
% time = elev;
% form = form_array(1)
% bitrate = track_bitrate;

% output_array=[];
% data = [];
% 
% freq_max = 20000;
% freq_min = 20;
% 
% frequencic = freq * (freq_max-freq_min)+freq_min
% time_sampl = track_time / sum(time)
% time_samples = time*time_sampl;
% sum(time_samples)
% time_step = 1/bitrate;
% stage_time_1 = 0;
% omega = 2 * pi * frequencic;
% m=1;
% 
% while m<size(time,2)+1
%     stage_time = time_samples(m);
%     new_data = [];
%     m
%     for n=stage_time_1:time_step:stage_time
%         data = amp(m)*sin(omega(m)*n);
%         new_data = [new_data data];
%     end
%     stage_time_1 = stage_time;
%     m=m+1;
%     output_array = [output_array new_data];
% end
% plot(output_array)


%%

form_array = {'sine' 'square' 'triangle' 'swatooth'};
% random - amplitude, frequency, timings, form
% data - longitude, latitude, elevation, seconds
% 4 instruments with 4 forms - sine, 
% square, triangle, sawtooth
% 1 - amp-long, freq-lat, elev-time; sine
% 2 - amp-lat, freq-elev, tim-long; square
% 3 - amp-elev, freq-long, tim-lat; triangle
% 4 - amp-long, freq-long, tim-long; sawtooth

track = {}

track{1} = arr_to_wave(Long, Lat, elev, form_array{1}, track_time,track_bitrate);
track{2} = arr_to_wave(Lat, elev, Long, form_array{2}, track_time,track_bitrate);
track{3} = arr_to_wave(elev, Long, Lat, form_array{3}, track_time,track_bitrate);
track{4} = arr_to_wave(Long, Long, Long, form_array{4}, track_time,track_bitrate);
% plot(track{4})

%%
clf

max_val = max([size(track{1}),size(track{2}),size(track{3}),size(track{4})]);
track{1} =[track{1} zeros(max_val - size(track{1},2),1)'];
track{2} =[track{2} zeros(max_val - size(track{2},2),1)'];
track{3} =[zeros(max_val - size(track{3},2),1)' track{3}];
track{4} =[track{4} zeros(max_val - size(track{4},2),1)'];

myrec = normalize(track{1}+track{2}+track{3}+track{4});
size(track{4})
plot(myrec)
%%
audiowrite('NameOfFile2.wav', myrec, track_bitrate)

