%GRIDDATA  データのグリッド化と表面近似
%
%   ZI = GRIDDATA(X,Y,Z,XI,YI) は、(通常) 一様間隔でないベクトル (X,Y,Z) の
%   データに、Z = F(X,Y) 形式の表面を近似します。GRIDDATA は、ZI を作成する
%   ために、(XI,YI) で指定される点でこの表面を補間します。表面は、必ずデータ点を
%   通ります。XI と YI は、通常 (MESHGRID で作成されるような) 一様間隔のグリッドで、
%   そのため、GRIDDATA と名付けられています。
%
%   XI は、行ベクトルでも構いません。この場合、列要素が一定の値である行列と
%   考えられます。同様に、YI は列ベクトルでも構わず、行要素が一定の値である
%   行列と考えられます。
%
%   [XI,YI,ZI] = GRIDDATA(X,Y,Z,XI,YI) は、この方法で作成された XI と YI も
%   返します ([XI,YI] = MESHGRID(XI,YI) の結果)。
%
%   [...] = GRIDDATA(X,Y,Z,XI,YI,METHOD) は、METHOD が以下のいずれかの場合、
%       'linear'    - 三角形に基づく線形補間 (デフォルト)
%       'cubic'     - 三角形に基づく三次補間
%       'nearest'   - 最近傍補間
%       'v4'        - MATLAB 4 の griddata メソッド
%   データに近似する表面のタイプを定義します。'cubic' と 'v4' は、滑らかな
%   表面を作成します。一方、'linear' と 'nearest' は、それぞれ、1 次微分と 
%   0 次微分における不連続性を持ちます。'v4' 以外のすべての手法は、データの 
%   Delaunay 三角形分割に基づいています。
%   METHOD が [] の場合、デフォルトの 'linear' メソッドが使用されます。
%
%   [...] = GRIDDATA(X,Y,Z,XI,YI,METHOD,OPTIONS) は、DELAUNAYN により Qhull 
%   のオプションとして使われるように、文字列 OPTIONS のセル配列を指定します。
%   OPTIONS が [] の場合、デフォルトの DELAUNAYN オプションが使用されます。
%   OPTIONS が {''} の場合、デフォルトも含め、オプションは用いられません。
%
%   例:
%      x = rand(100,1)*4-2; y = rand(100,1)*4-2; z = x.*exp(-x.^2-y.^2);
%      ti = -2:.25:2;
%      [xi,yi] = meshgrid(ti,ti);
%      zi = griddata(x,y,z,xi,yi);
%      mesh(xi,yi,zi), hold on, plot3(x,y,z,'o'), hold off
%
%   参考 TriScatteredInterp, DelaunayTri, GRIDDATA3, GRIDDATAN, DELAUNAY, 
%        INTERP2, MESHGRID, DELAUNAYN.


%   Copyright 1984-2009 The MathWorks, Inc. 
