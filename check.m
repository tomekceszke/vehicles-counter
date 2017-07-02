%% Author: Tomasz Ceszke 2017

%% ----------- init
clear ; close all; 
more off
%pkg load image;

source('conf/settings.m');
source('lib/features.m');
source('lib/nn.m');

%% ----------- load learned factors
load 'Theta1.mat'; 
load 'Theta2.mat'; 

%% ----------- test data
notcars_test_images = getImages(strcat(datasource_path_prefix,'test/notcars/'), extension,resize_scale);
fprintf('Loaded %d not cars test samples\n', columns(notcars_test_images));
cars_test_images = getImages(strcat(datasource_path_prefix,'test/cars/'),extension,resize_scale);
fprintf('Loaded %d cars test samples\n', columns(cars_test_images));

%% ----------- features
X = [prepareFeatures(notcars_test_images); prepareFeatures(cars_test_images)];

%% ----------- labels
Y = [ones(columns(notcars_test_images),1); zeros(columns(cars_test_images),1)];

%% ----------- check accuracy
fprintf('Testing...')
accuracy = recognize(Theta1,Theta2,X);
fprintf('\nAccuracy for test samples: %d%%\n\n',round(mean(double(accuracy == Y)) * 100));