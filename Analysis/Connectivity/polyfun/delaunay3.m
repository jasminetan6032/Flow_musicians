function t = delaunay3(x,y,z,options)
%DELAUNAY3  3-D Delaunay triangulation.
%
%   DELAUNAY3 will be removed in a future release. Use DelaunayTri instead.
%
%   T = DELAUNAY3(X,Y,Z) returns a set of tetrahedra such that no data
%   points of X are contained in any circumspheres of the tetrahedra. T is
%   a numt-by-4 array. The entries in each row of T are indices of the
%   points in (X,Y,Z) forming a tetrahedron in the triangulation of (X,Y,Z).
%
%   T = DELAUNAY3(X,Y,Z,OPTIONS) specifies a cell array of strings OPTIONS
%   that were previously used by Qhull. Qhull-specific OPTIONS are no longer 
%   required and are currently ignored.
%
%   Example:
%      X = [-0.5 -0.5 -0.5 -0.5 0.5 0.5 0.5 0.5];
%      Y = [-0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5 0.5];
%      Z = [-0.5 0.5 -0.5 0.5 -0.5 0.5 -0.5 0.5];
%      T = delaunay3( X, Y, Z )
%
%   See also DelaunayTri, TriScatteredInterp, DELAUNAY, DELAUNAYN, GRIDDATAN,
%            VORONOIN, TETRAMESH.

%   Copyright 1984-2010 The MathWorks, Inc.
%   $Revision: 1.10.4.14 $ $Date: 2010/11/17 11:29:22 $


% warning('MATLAB:delaunay3:DeprecatedFunction',...
% 'DELAUNAY3 will be removed in a future release. Use DelaunayTri instead.');

if nargin < 3
    error(message('MATLAB:delaunay3:NotEnoughInputs'));
end

if ~isequal(size(x),size(y),size(z))
    error(message('MATLAB:delaunay3:InputSizeMismatch'));
end

if ndims(x) > 3 || ndims(y) > 3 || ndims(z) > 3
    error(message('MATLAB:delaunay3:HigherDimArray'));
end

warning(message('MATLAB:delaunay3:DeprecatedFunction'));
    
X = [x(:) y(:) z(:)];

if( nargin > 3)
  cg_opt = options;
else
    cg_opt = {};
end

cgprechecks(X, nargin-1, cg_opt);

[X, dupesfound, idxmap] = mergeDuplicatePoints(X);
if dupesfound
    warning(message('MATLAB:delaunay3:DuplicateDataPoints'));
end
[m,n] = size(X);

if m < n+1,
  error(message('MATLAB:delaunay3:NotEnoughPtsForTessel'));
end

dt = DelaunayTri(X);
scopedWarnOff = warning('off', 'MATLAB:TriRep:EmptyTri3DWarnId');
restoreWarnOff = onCleanup(@()warning(scopedWarnOff));
t = dt.Triangulation;
if isempty(t)
  error(message('MATLAB:delaunay3:EmptyTriangulation'));
end
% Rewire the triangle indices if points were merged
if (dupesfound)
    t = idxmap(t);
end


