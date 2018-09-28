function  theta = subspaceAnglesAR(sys1, sys2)
% Calculates the subspace angles between two AR systems
%
% INPUTS
%   sys1:     System 1
%   sys2:     System 2
%
% OUTPUTS
%   angles:   The subspace angles sorted in ascending order in rad
%
% EXAMPLE
% 
%
%% Written by : Avinash Ravichandran, Rizwan Chaudhry
%% $DATE      : 09-Sep-2011 17:57:43 $
%% $REVISION  : 0.5.0 $

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sys1 and sys2 must have .A and .C fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A1 = sys1.A;
C1 = sys1.C;
A2 = sys2.A;
C2 = sys2.C;

n = size(A1,1);
m = size(C1,1);
Z = [A1 zeros(n); zeros(n) A2];
C = [C1 C2];
X = dlyap(Z',C'*C);%X = DLYAP(A,Q) A*X*A' - X + Q = 0
E = eig([zeros(n) pinv(X(1:n,1:n))*X(1:n,n+1:2*n);...%eigenvalues
    pinv(X(n+1:2*n,n+1:2*n))*X(n+1:2*n,1:n) zeros(n)]);
E = real(E);
E = max(-ones(size(E)),E);%保证cos(theta)的值域是[-1,1],
E = min(ones(size(E)),E);
E = sort(E,'descend');
theta = acos(E(1:n));
