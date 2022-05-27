%neighbors  シンプレックスの近傍情報を出力
%
%   SN = neighbors(TR, SI) は、指定したシンプレックス SI に対するシンプレックス
%   の近傍情報を返します。シンプレックスは、三角形/四面体、またはより高い次元に
%   相当するものです。SI は、三角形分割の行列 TR.Triangulation へのインデックス
%   を示すシンプレックスの列ベクトルです。SN は m 行 n 列の行列です。ここで、
%   m は指定したシンプレックスの数 length(SI) で、n はシンプレックスごとの近傍の
%   数です。各行 SN(i,:) は、シンプレックス SI(i) の近傍を表します。SI が指定
%   されない場合、三角形分割全体に対する近傍の情報が返されます。
%   ここで、シンプレックス i に関する近傍は、SN の i 番目の行で定義されます。
%
%   便宜上、シンプレックス SI(i) のシンプレックスの反対の頂点 (j) は SN(i,j) 
%   です。シンプレックスに複数の境界の小面がある場合、存在しない近傍は NaN で
%   現されます。
%
%   例 1: 2D の三角形分割を読み込み、TriRep を使用して三角形の近傍を計算します。
%       load trimesh2d
%       % これは三角形分割 tet と頂点の座標 X を読み込みます。
%       trep = TriRep(tri,x,y)
%       triplot(trep);
%       nbrs = neighbors(trep,119)
%       trigroup = [119, 2 29 108]';
%       ic = incenters(trep, trigroup);
%       hold on
%       axis([-50 350 -50 350]);
%       axis equal;
%       trilabels = arrayfun(@(x) {sprintf('T%d', x)}, trigroup);
%       Htl = text(ic(:,1), ic(:,2), trilabels, 'FontWeight', 'bold', ...
%               'HorizontalAlignment', 'center', 'Color', 'red');
%       hold off
%
%   例 2: DelaunayTri を使って作成した 2D の三角形分割を直接調べます。
%       % 単位正方形内の乱数から 2D の Delaunay 三角形分割を計算します。
%       x = rand(10,1)
%       y = rand(10,1)
%       dt = DelaunayTri(x,y)
%       % 1 番目の三角形の近傍を求めます。
%       n1 = neighbors(dt, 1)
%
%
%   参考 TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
