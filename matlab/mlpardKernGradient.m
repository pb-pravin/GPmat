function g = mlpardKernGradient(kern, x, covGrad)

% MLPARDKERNGRADIENT Gradient of multi-layer perceptron ARD kernel's parameters.

% KERN
g = zeros(1, kern.nParams);
[k, innerProd, arg, denom, numer, vecDenom] = mlpardKernCompute(kern, x);
denom3 = denom.*denom.*denom;
vec = diag(innerProd);
base = kern.variance./sqrt(1-arg.*arg);
baseCovGrad = base.*covGrad;
g(1) = sum(sum((innerProd./denom ...
                 -.5*numer./denom3 ...
                 .*((kern.weightVariance.*vec+kern.biasVariance+1)*vec' ...
                    + vec*(kern.weightVariance.*vec+kern.biasVariance+1)')) ...
                .*baseCovGrad));

g(2) = sum(sum((1./denom ...
                 -.5*numer./denom3 ...
                 .*(repmat(vec, 1, size(vec, 1))*kern.weightVariance...
                    + 2*kern.biasVariance + 2 ...
                    +repmat(vec', size(vec, 1), 1)*kern.weightVariance))...
                .*baseCovGrad));
 
g(3) = sum(sum(k.*covGrad))/kern.variance;
for j = 1:kern.inputDimension
  x2 = x(:, j).*x(:, j);
  g(3+j) = sum(sum(((x(:, j)*x(:, j)')./denom ...
                     -.5*numer./denom3 ...
                     .*(x2*vecDenom' + vecDenom*x2'))...
                    .*baseCovGrad))*kern.weightVariance;
end


