clc
%read the data
data = csvread('data.csv',1,0);

%convert to absolute time
for i = 2:size(data,1)
    data(i,4) = data(i-1,4)+data(i,4);
end

%plot the raw data
figure; plot(data(:,4),data(:,1),data(:,4),data(:,2),data(:,4),data(:,3)); title('raw data');

%low-pass filter
columnToFilter = 3; %let's try the filter on the Z-axis
bandwidth = 20; % adjust this
lowPass = mylowpassfilter(data(:,columnToFilter),bandwidth);
figure; plot(data(:,4),data(:,columnToFilter),data(:,4),lowPass); title('Low-Pass Filter');

%high-pass filter
columnToFilter = 3; %let's try the filter on the Z-axis
bandwidth = 20; % adjust this
highPass = myhighpassfilter(data(:,columnToFilter),bandwidth);
figure; plot(data(:,4),data(:,columnToFilter),data(:,4),highPass); title('High-Pass Filter');

%detect potholes
pothole_locations = detectpotholes(data);
%TODO: visualize the results yourself

