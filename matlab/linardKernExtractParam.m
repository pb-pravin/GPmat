function params = linardKernExtractParam(kern)

% LINARDKERNEXTRACTPARAM Extract parameters from linear ARD kernel structure.

% KERN


params = [kern.variance kern.inputScales];
