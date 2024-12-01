



%%%%%%%% FIRST POINT %%%%%%%%

seed = min([341965, 343316, 284817]);

rng(seed);

%%%%%%%% END FIRST POINT %%%%%%%% 





%%%%%%%% SECOND POINT %%%%%%%%

d = 3;    % alternative: 3,4,5

n = 10^d;

[f1,gradf1,Hessf1] = first_function(n); % Problem 1

[f2,gradf2, Hessf2] = second_function(n); % Problem 27

[f3, gradf3, Hessf3] = third_function(n,10); %Problem 64

%%%%%%%% END SECOND POINT





%%%%%%%% THIRD POINT %%%%%%%%

% construction of the test point x0 for f1:

x_f1 = zeros(n,1);
for i= 1:1:n
    if mod(i,2) == 1
        x_f1(i) = -1.2;
    else
        x_f1(i) = 1.0;
    end
end

% construction of the test point for f2

x_f2 = zeros(n,1);
for l = 1:1:n
    x_f2(l) = l;
end


% construction of the 10 points for f1

X_f1 = (x_f1*(ones(n,1))')';       % matrix that copy for each column the vector x_f1
X_f1 = X_f1(:,1:1:10);             % rescale of the matrix

error = rand(n,10);     % matrix of random variable to add to the starting point 
X_f1 = X_f1 + error;    % each column of this vector represent a starting point

% construction of the 10 points for f2 

X_f2 = (x_f2*(ones(n,1))')';
X_f2 = X_f2(:,1:1:10);

error = rand(n,10);
X_f2 = X_f2 + error;

%%%%%%%% END THIRD POINT %%%%%%%%



%%%%%%% START FOURTH POINT %%%%%%%%

%% MODIFIED NEWTON METHOD

rho = 0.5;
c = 1e-4;

kmax = 1000;
tolgrad = 1e-6;
btmax = 40;


% calling the method:


[x1k, f1k, gradf1k_norm, k1, x1seq, bt1seq] = ...
    Modified_Newton_method(X_f1(:,2), f1, gradf1, Hessf1, ...
    kmax, tolgrad, c, rho, btmax);


[x2k, f2k, gradf2k_norm, k2, x2seq, b2tseq] = ...
    Modified_Newton_method(X_f2(:,2), f2, gradf2, Hessf2, ...
    kmax, tolgrad, c, rho, btmax);

[x3k, f3k, gradf3k_norm, k3, x3seq, b3tseq] = ...
    Modified_Newton_method(X_f2(:,10), f3, gradf3, Hessf3, ...
    kmax, tolgrad, c, rho, btmax);


