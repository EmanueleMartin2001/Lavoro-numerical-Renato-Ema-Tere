

f_Rosenbrock = @(x) 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;

gradf_Rosenbrock = @(x) [400*x(1)^3 - 400*x(1)*x(2) + 2*x(1) - 2 ; 200*( x(2) - x(1)^2 )];

Hessianf_Rosenbrock = @(x) [ 1200*x(1)^2 - 400*x(2) + 2 , -400*x(1); -400*x(1) , 200];

rho = 0.5;

c1 = 1e-4;

x_0_1 = [-1.2 ; 1];

kmax = 100;

btmax = 150;

tolgrad = 1e-5;


%% RUN MODIFIED NEWTON METHOD

disp('**** MODIFIED NEWTON METHOD : START *****')

tic;
[xk_mnm, fk_mnm, gradfk_norm, k_mnm, xseq_mnm ,btseq] = Modified_Newton_method(x_0_1, f_Rosenbrock, gradf_Rosenbrock, Hessianf_Rosenbrock, kmax, tolgrad ,c1, rho, btmax);
t = toc;

disp('**** MODIFIED NEWTON METHOD: FINISHED *****')

disp(['Time: ', num2str(t), ' secondi']);

disp('**** MODIFIED NEWTON METHOD : RESULTS *****')
disp('************************************')
disp(['xk: ', mat2str(xk_mnm)])
disp(['f(xk): ', num2str(fk_mnm)])
disp(['N. of Iterations: ', num2str(k_mnm),'/',num2str(kmax), ';'])
disp('************************************')

%% PLOTS (BACKTRACK)

f_meshgrid = @(X, Y) arrayfun(@(i) f_Rosenbrock([X(i); Y(i)]), 1:numel(X));

% Creation of the meshgrid for the contour-plot
[X, Y] = meshgrid(linspace(-6, 6, 500), linspace(-6, 6, 500));
% Computation of the values of f for each point of the mesh
Z = reshape(f_meshgrid(X, Y), size(X));

fk_mnm_seq = arrayfun(@(i) f_Rosenbrock(xseq_mnm(:, i)), 1:size(xseq_mnm, 2));

% Plots

% Simple Plot
fig1 = figure();
% Contour plot with curve levels for each point in xseq
[C1, ~] = contour(X, Y, Z);
hold on
% plot of the points in xseq
plot(xseq_mnm(1,:), xseq_mnm(2,:), '--*')

hold off

% More interesting Plot
fig2 = figure();
% Contour plot with curve levels for each point in xseq
% ATTENTION: actually, the mesh [X, Y] is too coarse for plotting the last
% level curves corresponding to the last point in xseq (check it zooming
% the image).
[C2, ~] = contour(X, Y, Z, fk_mnm_seq);
hold on
% plot of the points in xseq
plot(xseq_mnm(1, :), xseq_mnm(2, :), '--*')
hold off

% Much more interesting plot
fig4 = figure();
surf(X, Y, Z,'EdgeColor','none')
hold on
plot3(xseq_mnm(1, :), xseq_mnm(2, :), fk_mnm_seq, 'r--*')
hold off
