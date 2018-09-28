function sysParam = suboptimalSystemID(dataMatrix,order,params)
% Caclculates system parameters of LDS using suboptimalsysid  
%
% This function calculates the system parameters of a LDS that represents a video 
% sequence. This is the suboptimal approach proposed by Doretto et. al IJCV 2003.
%
% INPUTS
%   dataMatrix - p x F vector matrix or r x c x F sequence matrix
%   order      - [n nv] vector, [Default: nv=1]
%   params     - parameter structure containing the various parameters
%   .class     - determines the different subset of parameters that need
%              - to be identified [Default: 1]
%              - 1: Basic parameters,
%              - 2: Basic + noise parameters
%
% OUTPUTS
%   sysParam   - output structure containing all the system parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial Parameter Checks and Preprocessing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Checking the Data Matrix
F = size(dataMatrix,3);

if (size(dataMatrix,3)~=1)
    I = double(reshape(dataMatrix,[],F));
else
    F = size(dataMatrix,2);
    I = double(dataMatrix);
end

% Checking if we have noise order 
if length(order)==1
    n    = order(1);
    nv   = 1;
else
    n    = order(1);
    nv   = order(2);
end

% Parsing the parameter structure
dParams.class = 1;
if nargin<3
    params = dParams
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Basic Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Creating Mean Subtracted sequence
C0         = mean(I,2);
Y          = I - repmat(C0,1,F);

% Perform SVD for the paramters
[U,S,V]    = svd(Y,0);
C          = U(:,1:n);
X          = S(1:n,1:n)*V(:,1:n)';
A          = X(:,2:F)*pinv(X(:,1:(F-1)));
X0         = X(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regularizing A Matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e = eig(A);
e = abs(e);
target = 0.9999;
if any(e>=target)
    spectral_radius = max(e);
    A = A*target/spectral_radius;
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Noise Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (params.class~=1)
    S          = X(:,2:F) - A*X(:,1:(F-1));
    [Uv,Sv,Vv] = svd(S,0);
    B          = Uv(:,1:nv)*Sv(1:nv,1:nv)./sqrt(F-1);
    Q          = B*B';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assigning Output Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sysParam.X0    = X0;
sysParam.A     = A;
sysParam.C     = C;
sysParam.X     = X;
sysParam.C0    = C0; %Ymean
sysParam.class = params.class;

if (params.class~=1)
    sysParam.B    = B;
    sysParam.Q    = Q;    % Process Noise
end

