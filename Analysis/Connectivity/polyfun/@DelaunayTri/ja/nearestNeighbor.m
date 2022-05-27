%    nearestNeighbor  指定した位置に最も近い点の検索
%
%    PI = nearestNeighbor(DT, QX) は、QX の照合点の位置ごとに DT.X に最近傍の
%    点のインデックスを返します。行列 QX は、mpts 行 ndim 列のサイズです。
%    ここで、mpts は照合点数で、ndim は点のある空間の次元です。PI は、
%    点 DT.X のインデックスを示す点の列ベクトルです。
%    PI の長さは、照合点 mpts の数と等しくなります。
%
%    PI = nearestNeighbor(DT, QX,QY) と PI = nearestNeighbor(DT, QX,QY,QZ) 
%    は、2D と 3D で機能する場合、照合点を別の列ベクトルの形式で指定することが
%    できます。
%
%    注意: nearestNeighbor は、制約されたエッジを持つ 2D 三角形分割では使用
%          できません。
%
%    例:
%        x = rand(10,1)
%        y = rand(10,1)
%        dt = DelaunayTri(x,y)
%        % 以下の照合点の最近傍の点を検出
%        qrypts = [0.25 0.25; 0.5 0.5]
%        pid = nearestNeighbor(dt, qrypts)
%
%    参考 DelaunayTri, DelaunayTri.pointLocation.
