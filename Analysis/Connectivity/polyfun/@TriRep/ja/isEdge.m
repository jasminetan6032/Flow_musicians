%isEdge  頂点の組がエッジで連結しているかどうかをテスト
%
%   TF = isEdge(TR, V1, V2) は、V1(i), V2(i) が三角形分割のエッジの場合に
%   各要素 TF(i) が true となる 1/0 (true/false) フラグの配列を返します。
%   V1, V2 は、メッシュ内の頂点のインデックス、すなわち、頂点の座標軸の配列の
%   インデックスを表す列ベクトルです。TF = isEdge(TR, EDGE) は、エッジの
%   開始と終了インデックスを行列形式で指定します。ここで、EDGE は n 行 2 列で、
%   n は照合するエッジの数です。
%
%   例 1:
%       % 2D の三角形分割を読み込み、TriRep を使用して点の組間のエッジ存在を
%       % 調べます。
%       load trimesh2d
%       % これは三角形分割 tri と頂点の座標 x, y を読み込みます。
%       trep = TriRep(tri, x,y);
%       triplot(trep);
%       vxlabels = arrayfun(@(n) {sprintf('P%d', n)}, [2 25 36]');
%         Hpl = text(x([2 25 36]), y([2 25 36]), vxlabels, 'FontWeight', ...
%                    'bold', 'HorizontalAlignment',...
%                   'center', 'BackgroundColor', 'none');
%       axis([-50 350 -50 350]);
%       axis equal;
%       % 頂点 1 と 5 はエッジに接続していますか ?
%       % (右下の隅)
%       isEdge(trep, 2, 25)
%       isEdge(trep, 2, 36)
%
%   例 2:
%       % DelaunayTri を使って作成した 3D の Delaunay 三角形分割を直接
%       % 調べます。
%       X = rand(10,3)
%       dt = DelaunayTri(X)
%       % 頂点 2 と 7 はエッジに接続していますか ?
%       isEdge(dt, 2, 7)
%
%   参考 TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
