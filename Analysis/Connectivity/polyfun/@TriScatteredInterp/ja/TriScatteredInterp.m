% TriScatteredInterp  散布図データの補間
%
%    散布図データの集合は、X の位置で定義されるため、対応する値 V は、
%    X の Delaunay 三角形分割を使って計算することができます。
%    これは、V = F(X) という型の表面を生成します。表面は、QV = F(QX) を
%    使って照合位置 QX で実行されます。ここで、QX は X の凸包内にあります。
%    補間 F は、常に標本で指定されたデータ点を通ります。
%
%    F = TriScatteredInterp() は、空の散布図データの補間を作成します。
%    その後に、F.X = Xdata と F.V = Vdata で標本のデータ点と値 
%    (Xdata, Vdata) を初期化します。
%
%    F = TriScatteredInterp(X, V) は、V = F(X) の型の表面を (X, V) 内の散布図
%    データに近似する補間を作成します。X は mpts 行 ndim 列のサイズの行列です。
%    ここで、mpts は点数で、ndim は点が存在する空間の次元で ndim >= 2 です。
%    V は、X での値を定義する列ベクトルです。ここで、V の長さは mpts と等しく
%    なります。
%
%    F = TriScatteredInterp(X, Y, V) と F = TriScatteredInterp(X, Y, Z, V) 
%    は、2D と 3D で動作する場合に、代わりにデータ点の位置を列ベクトルの形式で
%    指定することができます。
%
%    F = TriScatteredInterp(DT, V) は、補間を計算するためのベースとして、
%    指定した DelaunayTri DT を使用します。DT は、散布図データの位置 DT.X の 
%    Delaunay 三角形分割です。行列 DT.X は、mpts 行 ndim 列のサイズです。
%    ここで、mpts は点数で、ndim は点が存在する空間の次元で ndim >= 2 です。
%    V は、DT.X での値を定義する列ベクトルです。ここで、V の長さは mpts と
%    等しくなります。
%
%    F = TriScatteredInterp(..., METHOD) は、データを補間するために使用する
%    手法を選択することができます。
%           'natural'   自然な近傍補間
%           'linear'    線形補間 （デフォルト）
%           'nearest'   最近傍補間
%    'natural' の手法は、散布図データの位置を除いて C1 連続です。
%    'linear' は C0 連続で、'nearest' は不連続になります。
%
%    例 1:
%        x = rand(100,1)*4-2;
%        y = rand(100,1)*4-2;
%        z = x.*exp(-x.^2-y.^2);
%
%   % 補間を作成
%        F = TriScatteredInterp(x,y,z);
%
%   % 位置 (qx, qy) で補間を実行します。qz はこれらの位置に対応する値です。
%        ti = -2:.25:2;
%        [qx,qy] = meshgrid(ti,ti);
%        qz = F(qx,qy);
%        mesh(qx,qy,qz); hold on; plot3(x,y,z,'o'); hold off
%
%
%    例 2: 例 1 で作成した補間を編集して点を追加/削除、または値を置き換えます。
%
%        % さらに 5 つの標本点を挿入します。F.V と F.X の両方を更新する必要が
%          あります。
%        close(gcf)
%        x = rand(5,1)*4-2;
%        y = rand(5,1)*4-2;
%        v = x.*exp(-x.^2-y.^2);
%        F.V(end+(1:5)) = v;
%        F.X(end+(1:5), :) = [x, y];
%
%        % 5 番目の点の位置と値を置き換えます。
%        F.X(5,:) = [0.1, 0.1];
%        F.V(5) = 0.098;
%
%        % 4 番目の点を削除します。
%        F.X(4,:) = [];
%        F.V(4) = [];
%
%        % すべての標本点の値を置き換えます。
%        vnew = 1.2*(F.V);
%        F.V(1:length(vnew)) = vnew;
%
%    TriScatteredInterp メソッド:
%        TriScatteredInterp は、補間の添字による実行が可能です。
%        モンジュの形式で表される関数の実行と同じ方法で実行します。
%
%        QV = F(QX) は、照合値 QV を生成するために指定した照合位置 QX で
%        補間を実行します。
%
%        QV = F(QX, QY, ...) と QV = F(QX, QY, QZ, ...) は、2D と 3D で
%        機能する場合に、照合点を代わりの列ベクトルの形式で指定することが
%        できます。
%
%
%    TriScatteredInterp プロパティ:
%        X      - 散布図データ点の位置を定義
%        V      - 各データ点に関する値を定義
%        Method - データを補間するために使われる方法を定義
%
%    参考  DelaunayTri, interp1, interp2, interp3, meshgrid.


%   Copyright 2008-2009 The MathWorks, Inc.
