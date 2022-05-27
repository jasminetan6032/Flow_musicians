function r = roots(c)
%ROOTS  Find polynomial roots.
%   ROOTS(C) computes the roots of the polynomial whose coefficients
%   are the elements of the vector C. If C has N+1 components,
%   the polynomial is C(1)*X^N + ... + C(N)*X + C(N+1).
%
%   Note:  Leading zeros in C are discarded first.  Then, leading relative
%   zeros are removed as well.  That is, if division by the leading
%   coefficient results in overflow, all coefficients up to the first
%   coefficient where overflow occurred are also discarded.  This process is
%   repeated until the leading coefficient is not a relative zero.
%
%   Class support for input c: 
%      float: double, single
%
%   See also POLY, RESIDUE, FZERO.

%   Copyright 1984-2008 The MathWorks, Inc.
%   $Revision: 5.12.4.6 $  $Date: 2010/08/23 23:12:01 $

% ROOTS finds the eigenvalues of the associated companion matrix.

if size(c,1)>1 && size(c,2)>1
    error(message('MATLAB:roots:NonVectorInput'))
end

if ~all(isfinite(c))
    error(message('MATLAB:roots:NonFiniteInput'));
end

c = c(:).';
n = size(c,2);
r = zeros(0,1,class(c));  

inz = find(c);
if isempty(inz),
    % All elements are zero
    return
end

% Strip leading zeros and throw away.  
% Strip trailing zeros, but remember them as roots at zero.
nnz = length(inz);
c = c(inz(1):inz(nnz));
r = zeros(n-inz(nnz),1,class(c));  

% Prevent relatively small leading coefficients from introducing Inf
% by removing them.
d = c(2:end)./c(1);
while any(isinf(d))
    c = c(2:end);
    d = c(2:end)./c(1);
end

% Polynomial roots via a companion matrix
n = length(c);
if n > 1
    a = diag(ones(1,n-2,class(c)),-1);
    a(1,:) = -d;
    r = [r;eig(a)];
end
