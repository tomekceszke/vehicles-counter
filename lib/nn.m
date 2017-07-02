%% Author: Tomasz Ceszke 2017
 
1;

 function g = sigmoid(z)
  g = 1.0 ./ (1.0 + exp(-z));  
end

function h = hypothesis(X, theta)
    h = sigmoid(X*theta);  
end
 
function W = randInitializeWeights(L_in, L_out)
  W = zeros(L_out, 1 + L_in);
  epsilon_init = 0.12;
  W = rand(L_out, 1 + L_in) * 2 * epsilon_init - epsilon_init;
end

function [J grad] = cost(nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda)
  Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                   hidden_layer_size, (input_layer_size + 1));
  Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                   num_labels, (hidden_layer_size + 1));

  m = size(X, 1);
  J = 0;
  Theta1_grad = zeros(size(Theta1));
  Theta2_grad = zeros(size(Theta2));

  for i = 1:m
    a1 = X(i,:)';
    a1 = [ones(1,columns(a1)); a1];
    z2 = Theta1*a1;
    a2 = sigmoid(z2);
    a2 = [ones(1,columns(a2)); a2];
    z3 = Theta2*a2;
    a3 = sigmoid(z3);
    h = a3;
    y_vector = zeros(num_labels,1); 
    if y(i)~=0
      y_vector(y(i))=1;
    end;
    delta_3 = (a3-y_vector);
    delta_2 = Theta2'*delta_3.*a2.*(1-a2);
    delta_2 = delta_2(2:end);
    Theta2_grad = Theta2_grad + delta_3 * a2';
    Theta1_grad = Theta1_grad + delta_2 * a1';
    J = J+ (1/m) *(-y_vector'*log(h)-(1-y_vector')*log(1-h));
  end

  Theta1_grad = (1/m)*Theta1_grad;
  Theta2_grad = (1/m)*Theta2_grad;
  Theta1_reg_sum = sum((Theta1(:,2:end))(:).^2);
  Theta2_reg_sum = sum((Theta2(:,2:end))(:).^2);
  reg = (lambda/(2*m))*(Theta1_reg_sum+Theta2_reg_sum);
  J = J + reg;
  Theta1_reg_ = Theta1;
  Theta1_reg_(:,1)  = zeros();
  Theta2_reg_ = Theta2;
  Theta2_reg_(:,1)  = zeros();
  Theta1_grad = Theta1_grad +(lambda/m)*Theta1_reg_;
  Theta2_grad = Theta2_grad +(lambda/m)*Theta2_reg_;
  grad = [Theta1_grad(:) ; Theta2_grad(:)];
end

function [r h2] = recognize(Theta1,Theta2,X)
  m = size(X, 1);
  h1 = hypothesis([ones(m, 1) X],Theta1');
  h2 = hypothesis([ones(m, 1) h1],Theta2');
  r = round(h2);
end
