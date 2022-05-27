%TSEARCH  最近傍の三角形検索
%
%   T = TSEARCH(X,Y,TRI,XI,YI) は、点 (XI(k),YI(k)) に対して囲んだ三角形が 
%   TRI(T(k),:) であるような、XI, YI 内の点に対する囲んだ Delaunay 三角形の
%   インデックスを返します。TSEARCH は、凸包の外部のすべての点に対しては、
%   NaN を返します。DELAUNAY から得られる点 X, Y の三角形分割 TRI が必要です。
%
%   参考 DelaunayTri, DELAUNAY, DSEARCH, QHULL, TSEARCHN, DELAUNAYN.


%   Copyright 1984-2009 The MathWorks, Inc. 
