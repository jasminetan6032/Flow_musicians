%circumcenters  指定したシンプレックスの外心を出力
%
%   CC = circumcenters(TR, SI) は、指定したシンプレックス SI ごとの外心の
%   座標を返します。シンプレックスは、三角形/四面体、またはより高い次元に
%   相当するものです。SI は、三角形分割の行列 TR.Triangulation への
%   インデックスを示すシンプレックスの列ベクトルです。CC は m 行 n 列の行列です。
%   ここで、m は指定したシンプレックスの数 length(SI) で、n は三角形分割が
%   存在する空間の次元です。各行 CC(i,:) は、シンプレックス SI(i) の外心の
%   座標を表します。SI が指定されない場合、三角形分割全体に対する外心の
%   情報が返されます。ここで、シンプレックス i に関する外心は、CC の 
%   i 番目の行になります。
%
%   例 1: 2D の三角形分割を読み込み、外心を計算するために TriRep を使用します。
%       load trimesh2d
%       % これは三角形分割 tri と頂点の座標 x, y を読み込みます。
%       trep = TriRep(tri, x,y)
%       cc = circumcenters(trep);
%       triplot(trep);
%       axis([-50 350 -50 350]);
%       axis equal;
%       hold on; plot(cc(:,1),cc(:,2),'*r'); hold off;
%       % 外心は、多角形の中間の点を表します。
%
%   例 2: DelaunayTri を使って作成した 3D の三角形分割を直接調べます。
%            最初の 5 つの四面体の外心を計算します。
%       X = rand(10,3);
%       dt = DelaunayTri(X);
%       cc = circumcenters(dt, [1:5]')
%
%   参考 TriRep, TriRep.incenters, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
