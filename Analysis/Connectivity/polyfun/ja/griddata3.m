%GRIDDATA3  3 次元データ用のデータのグリッド化と超曲面近似
%
%   W = GRIDDATAN(X, Y, Z, V, XI, YI, ZI) は、空間的に不均質に分布する
%   ベクトル (X, Y, Z, V) のデータに W = F(X,Y,Z) の型の超曲面を近似します。
%   GRIDDATA3 は、W を作成するために、(XI,YI,ZI) で指定される点でこの超曲面を
%   
%   (XI,YI,ZI) は、通常 (関数 MESHGRID で作成する) 一様分布グリッドで、
%   そのため GRIDDATA3 と名付けられています。
%
%   [...] = GRIDDATA3(X,Y,Z,V,XI,YI,ZI,METHOD) の METHOD が以下のいずれかで
%   ある場合、
%       'linear'    - テセレーションに基づく線形内挿 (デフォルト)
%       'nearest'   - 最近傍補間
%
%   データに近似する表面のタイプを定義します。
%   すべての方法は、データの Delaunay 三角形分割に基づいています。
%   METHOD が [] の場合、デフォルトの 'linear' メソッドが使用されます。
%
%   [...] = GRIDDATA3(X,Y,Z,V,XI,YI,ZI,METHOD,OPTIONS) は、DELAUNAYN により 
%   Qhull のオプションとして使用されるように、文字列 OPTIONS のセル配列を
%   指定します。OPTIONS が [] の場合、デフォルトのオプションが使われます。
%   OPTIONS が {''} の場合、デフォルトも含め、オプションは用いられません。
%
%   例:
%      x = 2*rand(5000,1)-1; y = 2*rand(5000,1)-1; z = 2*rand(5000,1)-1;
%      v = x.^2 + y.^2 + z.^2;
%      d = -0.8:0.05:0.8;
%      [xi,yi,zi] = meshgrid(d,d,d);
%      w = griddata3(x,y,z,v,xi,yi,zi);
%   4 次元のデータセットを視覚化するのは難しいため、0.8 の等平面を使用します。
%      p = patch(isosurface(xi,yi,zi,w,0.8));
%      isonormals(xi,yi,zi,w,p);
%      set(p,'FaceColor','blue','EdgeColor','none');
%      view(3), axis equal, axis off, camlight, lighting phong
%
%   入力 X,Y,Z,V,XI,YI,ZI に対するクラスサポート: double
%
%   参考 TriScatteredInterp, DelaunayTri, GRIDDATA, GRIDDATAN, QHULL, 
%        DELAUNAYN, MESHGRID.


%   Copyright 1984-2009 The MathWorks, Inc.
