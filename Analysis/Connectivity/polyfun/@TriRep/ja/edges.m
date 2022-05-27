%edges  三角形分割内のエッジを出力
%
%   E = edges(TR) は、n 行 2 列の行列として三角形分割のエッジを返します。
%   n はエッジ数です。TR.X のエッジのインデックスの頂点は、頂点の座標を
%   表す点の配列です。
%
%   例 1:
%       % 2D の三角形分割を読み込み、エッジの集合を作成するために TriRep を
%       % 使用します。
%       load trimesh2d
%       % これは三角形分割 tri と頂点の座標 x, y を読み込みます。
%       trep = TriRep(tri, x,y)
%       e = edges(trep)
%
%       % DelaunayTri を使って作成した 2D の Delaunay 三角形分割を直接
%       % 調べます。前のケースと同様にエッジの集合を作成します。
%       X = rand(10,2)
%       dt = DelaunayTri(X)
%       e = edges(dt)
%
%
%   参考 TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
