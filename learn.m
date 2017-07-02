%% Author: Tomasz Ceszke 2017

clear ; close all; 
more off
pkg load image;

source('conf/settings.m');
source('lib/features.m');
source('lib/nn.m');
source('lib/fmincg.m');

%% ----------- settings
iterations = 60;
lambda = 0.01;
input_layer_size = NaN; % will be defined later
hidden_layer_size = 25;
output_layer_size = 1;
num_labels = output_layer_size;
samples_to_show = 5;
 

%% ----------- datasource
fprintf('Loading data...\n')
notcars_images = getImages(strcat(datasource_path_prefix,'train/notcars/'), extension,resize_scale);
fprintf('Loaded %d not cars samples\n', columns(notcars_images));
%imshow(green_images{1});
cars_images = getImages(strcat(datasource_path_prefix,'train/cars/'), extension,resize_scale);
fprintf('Loaded %d cars samples\n', columns(cars_images));
%imshow(red_images{1})
%fprintf('Press any key...\n');
%pause;

%% ----------- features
fprintf('Preparing features...\n')
X = [prepareFeatures(notcars_images); prepareFeatures(cars_images)];
displaySamples(notcars_images, cars_images, samples_to_show);
fprintf('Sample features: %d  %d  %d\n', X(1), X(2), X(3));
input_layer_size = columns(X);

%% ----------- label
fprintf('Preparing label...\n')
y = [ones(columns(notcars_images),1); zeros(columns(cars_images),1)];

%% ----------- pre-training operations
fprintf('\nInitializing Neural Network Parameters ...\n')
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, output_layer_size);
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
% check initial cost
J = cost(initial_nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);
fprintf('\nCost for initial parameters: %d\n',J);
                   
%% ----------- train
fprintf('\nTraining Neural Network... \n')
options = optimset('MaxIter', iterations);
costFunction = @(p) cost(p, input_layer_size, hidden_layer_size, output_layer_size, X, y, lambda);
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
save Theta1.mat Theta1;
save Theta2.mat Theta2;
                 
accuracy = recognize(Theta1, Theta2, X);
%disp([accuracy y]);
fprintf('\nDone.\n Final cost: %.3f \t Accuracy: %d%%\n\n', cost(end),round(mean(double(accuracy == y)) * 100));
