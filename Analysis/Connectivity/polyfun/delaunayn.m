function t = delaunayn(x,options)
%DELAUNAYN  N-D Delaunay triangulation.
%   T = DELAUNAYN(X) returns a set of simplices such that no data points of
%   X are contained in any circumspheres of the simplices. The set of
%   simplices forms the Delaunay triangulation. X is an m-by-n array
%   representing m points in n-D space. T is a numt-by-(n+1) array where
%   each row is the indices into X of the vertices of the corresponding
%   simplex. 
%
%   DELAUNAYN uses Qhull. 
%
%   T = DELAUNAYN(X,OPTIONS) specifies a cell array of strings OPTIONS to
%   be used as options in Qhull. The default options are:
%                                 {'Qt','Qbb','Qc'} for 2D and 3D input,
%                                 {'Qt','Qbb','Qc','Qx'} for 4D and higher.  
%   If OPTIONS is [], the default options will be used.
%   If OPTIONS is {''}, no options will be used, not even the default.
%   For more information on Qhull options, see http://www.qhull.org.
%
%   Example:
%      X = [-0.5 -0.5  -0.5;
%           -0.5 -0.5   0.5;
%           -0.5  0.5  -0.5;
%           -0.5  0.5   0.5;
%            0.5 -0.5  -0.5;
%            0.5 -0.5   0.5;
%            0.5  0.5  -0.5;
%            0.5  0.5   0.5];
%      T = delaunayn(X);
%   errors, but hints that adding 'Qz' to the default options might help.
%      T = delaunayn(X,{'Qt','Qbb','Qc','Qz'});
%   To visualize this answer you can use the TETRAMESH function:
%      tetramesh(T,X)
%
%   See also DelaunayTri, QHULL, VORONOIN, CONVHULLN, DELAUNAY, TETRAMESH.

%   Copyright 1984-2010 The MathWorks, Inc.
%   $Revision: 1.20.4.14 $ $Date: 2010/11/22 02:46:35 $

if nargin < 1
    error(message('MATLAB:delaunayn:NotEnoughInputs'));
end
if( nargin > 1)
  cg_opt = options;
else
    cg_opt = {};
end
cgprechecks(x, nargin, cg_opt);

if ndims(x) > 2
    error(message('MATLAB:delaunayn:HigherDimArray'));
end

n = size(x,2);
if n < 1
  error(message('MATLAB:delaunayn:XLowColNum'));
end

   
[x, dupesfound, idxmap] = mergeDuplicatePoints(x);
if dupesfound
   warning(message('MATLAB:delaunayn:DuplicateDataPoints'));
end
[m,n] = size(x);

if m < n+1,
  error(message('MATLAB:delaunayn:NotEnoughPtsForTessel'));
end

if m == n+1
    t = 1:n+1;
    % Enforce the orientation convention
    if n == 2 || n == 3
        PredicateMat = ones(m,m);        
        PredicateMat(:,(1:n)) = x(t,(1:n));      
        orient = det(PredicateMat);
        if n == 3
            orient = orient *-1;
        end;
        if orient < 0
               tmp_int = t(2);
               t(2) = t(3);
               t(3) = tmp_int;    
        end
    end
    if (dupesfound)
        t = idxmap(t);
    end
  return;
end

%default options
if n >= 4
    opt = 'Qt Qbb Qc Qx';
else 
    opt = 'Qt Qbb Qc';
end

if ( nargin > 1 && ~isempty(options) )
    sp = {' '};
    c = strcat(options,sp);
    opt = cat(2,c{:});   
end

t = qhullmx(x', 'd ', opt);

% try to get rid of zero volume simplices. They are generated
% because of the fuzzy jiggling.

[mt, nt] = size(t);
v = true(mt,1);

seps = eps^(4/5)*max(abs(x(:)));
try
    for i=1:mt
        val = abs(det(x(t(i,1:nt-1),:)-x(t(i,nt)*ones([nt-1, 1]),:))); 
        if val < seps
           v(i) = false;
        end
    end
catch 
    error(message('MATLAB:delaunayn:InvalidOpts'));
end

t = t(v,:);
% Rewire the triangle indices if points were merged
if (dupesfound)
    t = idxmap(t);
end

