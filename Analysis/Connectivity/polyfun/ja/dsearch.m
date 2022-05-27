%DSEARCH  最近傍を用いた Delaunay 三角形分割の検索
%
%   K = DSEARCH(X,Y,TRI,XI,YI) は、データ点 (xi,yi) の最近傍のデータ点 
%   (x,y) のインデックスを返します。DELAUNAY から得られる点 X, Y の三角形
%   分割 TRI が必要です。
%
%   K = DSEARCH(X,Y,TRI,XI,YI,S) は、毎回計算する代わりに、スパース行列 
%   S を使います。
%
%     S = sparse(tri(:,[1 1 2 2 3 3]),tri(:,[2 3 1 3 1 2]),1,nxy,nxy)
%
%   ここで、nxy = prod(size(x)) です。
%
%   参考 DelaunayTri, TSEARCH, DELAUNAY, VORONOI.


%   Copyright 1984-2009 The MathWorks, Inc.
