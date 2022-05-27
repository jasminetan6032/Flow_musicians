%GRIDDATAN  3 次元以上のデータに対するグリッド化と超曲面近似
%
%   YI = GRIDDATAN(X,Y,XI) は、空間的に不均質に分布するベクトル (X, Y) の
%   データに、Y = F(X) の型の超曲面を近似します。GRIDDATAN は、Z を作成するために、
%   XI で設定された点でこの超曲面を補間します。XI は、非一様になります。
%
%   X は次元 m 行 n 列で、n-次元空間での m 点を表わします。Y は m 行 1 列の
%   次元で、超曲面 F(X) の m 個の値を表します。XI は、p 行 n 列のベクトルで、
%   近似する n-次元空間の表面の値を p 個の点で表します。YI は、値 F(XI) を
%   近似する長さ p のベクトルです。超曲面は、常にデータ点 (X,Y) を通ります。
%   XI は、通常は (MESHGRID で作成するような) 一様なグリッドです。
%
%   YI = GRIDDATAN(X,Y,XI,METHOD) は、METHOD が以下のいずれかの場合、
%       'linear'    - テセレーションに基づく線形内挿 (デフォルト)
%       'nearest'   - 最近傍補間
%   データに近似する表面のタイプを定義します。
%   すべての手法は、データの Delaunay 三角分割に基づきます。METHOD が [] の
%   場合、デフォルトの 'linear' メソッドが使用されます。
%
%   YI = GRIDDATAN(X,Y,XI,METHOD,OPTIONS) は、DELAUNAYN により Qhull の
%   オプションとして使用されるように、文字列 OPTIONS のセル配列を指定します。
%   OPTIONS が [] の場合、デフォルトのオプションが使われます。OPTIONS が 
%   {''} の場合、デフォルトも含め、オプションは用いられません。
%
%   例:
%      X = 2*rand(5000,3)-1; Y = sum(X.^2,2);
%      d = -0.8:0.05:0.8; [x0,y0,z0] = meshgrid(d,d,d);
%      XI = [x0(:) y0(:) z0(:)];
%      YI = griddatan(X,Y,XI);
%   4 次元のデータセットを視覚化するのは難しいため、0.8 の等平面を使用します。
%      YI = reshape(YI, size(x0));
%      p = patch(isosurface(x0,y0,z0,YI,0.8));
%      isonormals(x0,y0,z0,YI,p);
%      set(p,'FaceColor','blue','EdgeColor','none');
%      view(3), axis equal, axis off, camlight, lighting phong
%
%   参考 TriScatteredInterp, DelaunayTri, GRIDDATA, GRIDDATA3, QHULL, 
%        DELAUNAYN, MESHGRID.


%   Copyright 1984-2009 The MathWorks, Inc.
