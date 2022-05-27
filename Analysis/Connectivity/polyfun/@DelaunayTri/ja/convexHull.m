% convexHull  凸包の出力
%
%    K = convexHull(DT) は、凸包の頂点に対応する点の配列 DT.X のインデックス
%    を返します。点が 2D 空間にある場合は K は長さ numf の列ベクトルで、
%    そうでない場合は K は numf 行 ndim 列のサイズの行列です。
%    ここで、numf は凸包の面数で、ndim は点の存在する空間の次元です。
%
%    例 1: 2D 空間の単位正方形内にある乱数の集合の凸包を計算します。
%        x = rand(10,1)
%        y = rand(10,1)
%        dt = DelaunayTri(x,y)
%        k = convexHull(dt)
%        plot(x,y, '.', 'markersize',10); hold on;
%        plot(x(k), y(k), 'r'); hold off;
%
%    例 2: 3D 空間の単位立方体内にある乱数の集合の凸包を計算します。
%        X = rand(25,3)
%        dt = DelaunayTri(X)
%        ch = convexHull(dt)
%        trisurf(ch, X(:,1),X(:,2),X(:,3), 'FaceColor', 'cyan')
%
% 参考 DelaunayTri, trisurf.
