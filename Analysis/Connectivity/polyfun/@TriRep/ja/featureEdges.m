%featureEdges  表面の三角形分割の鋭いエッジを出力
%
%   このクエリーは、三角形の表面メッシュにのみ適用可能です。
%   FE = featureEdges(TR, FILTERANGLE) は、隣接する三角形が FILTERANGLE 
%   以上の角度で PI から派生する二面角を持つ三角形分割のエッジを表す行列 
%   FE を返します。この方法は、一般的に表示目的で表面メッシュ内の鋭い
%   エッジを抽出するために使われます。1 つの三角形でのみ共有されるエッジと 
%   2 つ以上の三角形で共有されるエッジは、デフォルトで feature エッジに
%   なると考えられます。
%   FE は m 行 2 列のサイズです。ここで、m はメッシュ内の自由エッジの数です。
%   エッジのインデックスの頂点は、頂点の座標 TR.X を表す点の配列です。
%
%   例:
%       % 表面の三角形分割を作成し、feature エッジを抽出します。
%       x = [0 0 0 0 0 3 3 3 3 3 3 6 6 6 6 6 9 9 9 9 9 9]';
%       y = [0 2 4 6 8 0 1 3 5 7 8 0 2 4 6 8 0 1 3 5 7 8]';
%       dt = DelaunayTri(x,y);
%       tri = dt(:,:);
%       % 表面を作成するために 2D メッシュを強化します。
%       z = [0 0 0 0 0 2 2 2 2 2 2 0 0 0 0 0 0 0 0 0 0 0]';
%       subplot(1,2,1);
%       trisurf(tri,x,y,z, 'FaceColor', 'cyan'); axis equal;
%       title(sprintf('TRISURF display of surface mesh\n showing mesh edges\n'));
%       % pi/4 のフィルタの角度を使って feature エッジを計算します。
%       tr = TriRep(tri, x,y,z);
%       fe = featureEdges(tr,pi/6)';
%       subplot(1,2,2);
%	      trisurf(tr, 'FaceColor', 'cyan', 'EdgeColor','none', ...
%          'FaceAlpha', 0.8); axis equal;
%       % feature エッジを追加
%	      hold on; plot3(x(fe), y(fe), z(fe), 'k', 'LineWidth',1.5); hold off;
%       title(sprintf('TRISURF display of surface mesh\n suppressing mesh edges\nand showing feature edges'));
%
%   参考 TriRep, DelaunayTri.


%   Copyright 2007-2009 The MathWorks, Inc.
