%freeBoundary  1 つのシンプレックスのみで参照される小面を出力
%
%   FF = freeBoundary(TR) は、三角形分割の自由境界の小面を表す行列 FF を
%   返します。1 つのシンプレックス (三角形/四面体など) のみで参照される場合、
%   小面は自由境界上にあります。FF は m 行 n 列のサイズです。ここで、m は
%   境界の小面の数で、n は小面ごとの頂点の数です。小面のインデックスの頂点は、
%   頂点の座標 TR.X を表す点の配列です。配列 FF は、球体の表面を表す三角形
%   メッシュと同じように空になります。
%
%   [FF XF] = freeBoundary(TR) は、座標 XF のコンパクトな配列の項で定義される
%   頂点を持つ自由境界の小面 FF の行列を返します。XF は m 行 ndim 列のサイズです。
%   ここで、m は自由境界の小面の数、ndim は三角形分割が存在する空間の次元です。
%
%   例 1: 3D の三角形分割を読み込み、TriRep を使用してすべての四面体の近傍を
%         計算します。
%       load tetmesh
%       % これは三角形分割 tet と頂点の座標 X を読み込みます。
%       trep = TriRep(tet, X)
%       [tri xf] = freeBoundary(trep);
%       %Plot the boundary triangulation
%		    trisurf(tri, xf(:,1),xf(:,2),xf(:,3), 'FaceColor', 'cyan', 'FaceAlpha', 0.8); 
%
%   例 2: DelaunayTri を使って作成した 2D の三角形分割を直接調べます。
%       % メッシュをプロットし、自由境界のエッジを赤で表示します。
%       x = rand(20,1)
%       y = rand(20,1)
%       dt = DelaunayTri(x,y)
%       fe = freeBoundary(dt)';
%       triplot(dt);
%       hold on ; plot(x(fe), y(fe), '-r', 'LineWidth',2) ; hold off ;
%       % この場合、自由境界のエッジは (x, y) の凸包に対応します。
%
%
%   参考 TriRep QueryTetMesh.


%   Copyright 2008-2009 The MathWorks, Inc.
