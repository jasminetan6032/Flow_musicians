%INTERPN  N 次元補間 (table lookup)
%
%   VI = INTERPN(X1,X2,X3,...,V,Y1,Y2,Y3,...) は、配列 Y1, Y2, Y3...の点で 
%   N 次元関数 V の値 VI を求めるために補間します。N 次元配列 V に対して、
%   INTERPN は 2*N+1 個の引数を使って呼び出される必要があります。
%   配列 X1, X2, X3...は、データ V が与えられる点を指定します。範囲外の値は、
%   NaN として返されます。Y1, Y2, Y3... は、同じサイズの配列またはベクトルで
%   なければなりません。ベクトル引数が同じサイズでなく、方向が混在する 
%   (すなわち、行と列ベクトルの両方を持つ) 場合、MESHGRID に渡され、配列 
%   Y1, Y2, Y3 を作成します。INTERPN は、2 次元以上の N 次元配列に対して機能します。
%
%   VI = INTERPN(V,Y1,Y2,Y3,...) は、X1 = 1:SIZE(V,1), X2 = 1:SIZE(V,2)... と
%   仮定します。VI = INTERPN(V,NTIMES) は、再帰的に NTIMES 回、要素間の補間を
%   繰り返すことにより、V を拡張します。
%   VI = INTERPN(V) は、INTERPN(V,1) と同じです。
%
%   VI = INTERPN(...,METHOD) は、補間手法を指定します。デフォルトは、
%   線形補間です。使用可能な手法は以下のとおりです。
%
%     'nearest' - 最近傍補間
%     'linear'  - 線形補間
%     'spline'  - スプライン補間
%     'cubic'   - データが等間隔の場合、双三次補間、そうでない場合は 
%                 'spline' と同じ
%
%   VI = INTERPN(...,METHOD,EXTRAPVAL) は、X1,X2,... で作成された領域の外側
%   の VI の要素に対して使用する外挿法と値を指定するのに使います。こうして、
%   VI は X1,X2,... のそれぞれにより作成されていない、Y1,Y2,.. のいずれかの
%   値について EXTRAPVAL に等しくなります。使用される EXTRAPVAL に対して、
%   メソッドが指定されなければなりません。デフォルトのメソッドは 'linear' です。
%
%   INTERPN は、X1, X2, X3... が単調関数で、(NDGRID で作成されるものと同様) 
%   格子形でなければなりません。X1, X2, X3... は、等間隔でない場合があります。
%
%   たとえば、interpn は、以下の関数を補間するために使われます。
%      f = @(x,y,z,t) t.*exp(-x.^2 - y.^2 - z.^2);
%
%   ndgrid で作られたグリッド上の関数 f を評価することで、ルックアップ
%   テーブルを作成します。
%      [x,y,z,t] = ndgrid(-1:0.2:1,-1:0.2:1,-1:0.2:1,0:2:10);
%      v = f(x,y,z,t);
%
%   より細かいグリッドを作成します。
%      [xi,yi,zi,ti] = ndgrid(-1:0.05:1,-1:0.08:1,-1:0.05:1,0:0.5:10);
%
%   スプラインを使うことにより、細かいグリッドで f を補間します。
%      vi = interpn(x,y,z,t,v,xi,yi,zi,ti,'spline');
%
%   最後に、関数を表示します。
%      nframes = size(ti, 4);
%      for j = 1:nframes
%         slice(yi(:,:,:,j), xi(:,:,:,j), zi(:,:,:,j), vi(:,:,:,j),0,0,0);
%         caxis([0 10]);
%         M(j) = getframe;
%      end
%      movie(M);
%
%   データ入力に対するクラスサポート:
%      float: double, single
%
%   参考 INTERP1, INTERP2, INTERP3, NDGRID.


%   Copyright 1984-2007 The MathWorks, Inc.
