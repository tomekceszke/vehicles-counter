%% Author: Tomasz Ceszke 2017
 
clear ; close all; 
more off
pkg load image;

source('conf/settings.m');
source('lib/features.m');
source('lib/nn.m');

%% ----------- settings
refresh_interval = 0.1 % seconds

car_counter = 0;
not_car_counter = 0;

%% ----------- load learned patameters
load 'Theta1.mat'; 
load 'Theta2.mat'; 

%% ----------- settings
live_image_path = strcat(datasource_path_prefix,strcat('live/scene.','jpg'));

%% 
fprintf('Path to detect: %s \n\n',live_image_path);
while 1
  pause(refresh_interval);
  %tic;
  try
    live_image = imread(live_image_path); 
    live_image = imresize(live_image, resize_scale);
  catch
    %disp('No image');
    continue;
  end
  
  X = zeros(1,numel(live_image));
  X = reshape(double(rgb2gray(live_image)),1,[]);
 
  [r h] = recognize(Theta1,Theta2,X);
  %toc
  if r==1 
    not_car_counter++;
  else
    if not_car_counter > 0
      car_counter++;
      not_car_counter=0;    
    end
  end
  %fprintf('%s h(x)=%.2f\n',color,h)
  fprintf('Counter: %d (h=%.2f) \r', car_counter, h);
end