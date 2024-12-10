function [f3, gradf3, Hessf3] = third_function(n,rho)

    h = 1/(n+1);

    fk = cell(n,1);
    fk{1} = @(x) 2*x(1) + rho * h^2 * sinh(rho * x(1)) - x(2);
    for k = 2:1:n-1
        fk{k} = @(x) 2*x(k) + rho * h^2 * sinh(rho * x(k)) - x(k-1) + x(k+1);
    end
    fk{n} = @(x) 2*x(n) + rho * h^2 * sinh(rho * x(n)) - x(n-1) - 1;
    
    f3 = @(x) 0.5*sum(cell2mat(cellfun(@(fk) fk(x), fk, 'UniformOutput', false)).^2);

    % deriv_j = \frac{\partial F}{\partial x_j} = \sum_{k=1}^n \frac{\partial fk}{\partial x_j} *fk                                            

    deriv_j = cell(n,1);
    deriv_j{1} = @(x) dot([2+rho^2*h^2*cosh(rho*x(1)); -1], [fk{1}(x);fk{2}(x)]);
    deriv_j{2} = @(x) dot([-1; 2+rho^2*h^2*cosh(x(2)*rho);-1], [fk{1}(x);fk{2}(x);fk{3}(x)]);
    for k = 3:1:n-2
        deriv_j{k} = @(x) dot([-1; 2+rho^2*h^2*cosh(x(k)*rho);-1], [fk{k-1}(x);fk{k}(x);fk{k+1}(x)]);
    end
    deriv_j{n-1} = @(x) dot([-1; 2+rho^2*h^2*cosh(x(n-1)*rho);-1] , [fk{n-2}(x);fk{n-1}(x);fk{n}(x)]);
    deriv_j{n} = @(x) dot([ -1; 2+rho^2*h^2*cosh(rho*x(n))],[fk{n-1}(x);fk{n}(x)]);

    % I wrote the sum using the dot commando (for inner product) knowing
    % that some derivatives are zero

    gradf3 = @(x) cell2mat(cellfun(@(deriv_j) deriv_j(x), deriv_j, 'UniformOutput', false));


    % \frac{\partial F}{\partial x_i \partial x_j} = \sum_{k=1}^n \frac{\partial fk}{\partial x_i \partial x_j}*fk + \frac{\partial fk}{\partial x_i} \frac{\partial fk}{\partial x_j}

    % correct the hessian !

    A = cell(n,1);
    for k = 1:1:n
        A{k} = @(x) rho^3 * h^2 * sinh(rho*x(k));
    end

    Hessf3 = @(x) spdiags (cell2mat(cellfun(@(A) A(x), A, 'UniformOutput', false)),0, n,n);

end
