%% Author: Tomasz Ceszke 2017
 
1;

function g = sigmoid(z)
  g = 1.0 ./ (1.0 + exp(-z));  
end

function h = hypothesis(X, theta)
    h = sigmoid(X*theta);  
end

function plotCost(cost)
  figure;
  plot(1:numel(cost), cost, '-b', 'LineWidth', 3);
  xlabel('Number of iterations');
  ylabel('Cost J');
  drawnow;
end;
  