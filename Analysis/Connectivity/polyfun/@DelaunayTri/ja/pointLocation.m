% pointLocation  指定した位置を含むシンプレックスの位置
%
%    SI = pointLocation(DT, QX) は、QX の照合点の位置ごとに囲まれている
%    シンプレックス (三角形/四面体など) のインデックス SI を返します。
%    点 QX(k,:) に対して囲まれているシンプレックスは、 SI(k) です。
%    行列 QX は、mptx 行 ndim のサイズです。ここで、mpts は照合点数です。
%    SI は、長さ mpts の列ベクトルです。pointLocation は、凸包の外部の
%    すべての点に対しては NaN を返します。
%
%    SI = pointLocation(DT, QX,QY) と SI = pointLocation (DT, QX,QY,QZ) は、
%    2D と 3D で機能する場合、照合点の位置を別の列ベクトルの形式で指定する
%    ことができます。
%
%    [SI, BC] = pointLocation(DT,...) は、さらに重心座標 BC を返します。
%    BC は mpts 行 ndim 列の行列です。各行 BC(i,:) は、囲まれている
%    シンプレックス SI(i) に対する QX(i,:) の重心座標を表します。
%
%    例 1:
%        % 2D の点の位置
%        X = rand(10,2)
%        dt = DelaunayTri(X)
%        % 以下の照合点を含む三角形を検出
%        qrypts = [0.25 0.25; 0.5 0.5]
%        triids = pointLocation(dt, qrypts)
%
%    例 2:
%        % 3D の重心座標の評価における点の位置
%        x = rand(10,1); y = rand(10,1); z = rand(10,1);
%        dt = DelaunayTri(x,y,z)
%        % 以下の照合点を含む三角形を検出
%        qrypts = [0.25 0.25 0.25; 0.5 0.5 0.5]
%        [tetids, bcs] = pointLocation(dt, qrypts)
%
%    参考 DelaunayTri, DelaunayTri.nearestNeighbor.
