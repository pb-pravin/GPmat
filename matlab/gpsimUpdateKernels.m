function model = gpsimUpdateKernels(model)

% GPSIMUPDATEKERNELS Updates the kernel representations in the GPSIM structure.
% FORMAT
% DESC updates any representations of the kernel in the model
% structure, such as invK, logDetK or K.
% ARG model : the model structure for which kernels are being
% updated.
% RETURN model : the model structure with the kernels updated.
%
% SEEALSO gpsimExpandParam, gpsimCreate
%
% COPYRIGHT Neil D. Lawrence, 2006

% GPSIM

model.K = real(kernCompute(model.kern, model.t)+diag(model.yvar));
[model.invK, U] = pdinv(model.K);
model.logDetK = logdet(model.K, U);