% INTERP1  1次元補間(table lookup)
%
%   YI = INTERP1(X,Y,XI) は、配列 XI の点で元となる関数 Y の値 YI を求める
%   ために補間を行います。 X は長さ N のベクトルでなければなりません。
%   Y がベクトルの場合、長さは N で、YI は XIと同じサイズでなければなり
%   ません。 Y が サイズ [N,D1,D2,...,Dk] の配列の場合、補間は Y(i,:,:,...,:) 
%   の D1×D2×...Dk のそれぞれの値で実行されます。
%   XI が長さ M のベクトルの場合、YI はサイズ [M,D1,D2,...,Dk] になります。
%   XI がサイズ [M1,M2,...,Mj] の配列の場合、YI は [M1,M2,...,Mj,D1,D2,...,Dk] 
%   のサイズになります。
%
%   YI = INTERP1(Y,XI) は、X = 1:N と仮定します。 ここで N は、ベクトル
%   Y に対して LENGTH(Y) で、配列 Y に対して SIZE(Y,1) です。
%
%   補間は、"table lookup" と同じ演算を行います。 "table lookup" の用語で
%   説明すると、"table" は [X,Y] で、INTERP1 は X の XI の要素を "looks-up"し、
%   それらの位置に基づいて Y の要素内で補間された値 YI を出力します。
%
%   YI = INTERP1(X,Y,XI,METHOD) は、補間手法を指定します。
%   デフォルトは、線形補間です。 デフォルトを指定するには、空行列 [] を
%   使用してください。 利用可能な手法はつぎの通りです。
%
%     'nearest'  - 最近傍点による補間
%     'linear'   - 線形補間
%     'spline'   - キュービックスプライン補間 (SPLINE)
%     'pchip'    - 形状保持の区分的キュービック補間
%     'cubic'    - 'pchip' と同様
%     'v5cubic'  - MATLAB 5 のキュービック補間、これは、X が等間隔でない
%                  場合は外挿せず、 'spline'を利用します。
%
%   YI = INTERP1(X,Y,XI,METHOD,'extrap') は、X で作成された区間外の XI の
%   要素に対して使用する外挿法を指定するのに使います。
%   また、YI = INTERP1(X,Y,XI,METHOD,EXTRAPVAL) は、EXTRAPVAL を使って、
%   X で作成された区間外の値を置き換えます。
%   EXTRAPVAL に対しては、NaN と 0 がしばしば使用されます。4つの入力引数を
%   もつデフォルトの外挿法は、'spline' と 'pchip' に対しては 'extrap' で、
%   他の方法に対しては EXTRAPVAL = NaN です。
%
%   PP = INTERP1(X,Y,METHOD,'pp') は、Y の ppform (区分多項式の形式) を
%   作成するために、指定した手法を使用します。 手法は、'v5cubic' 以外では
%   上記のいずれかになります。 PP は、そのとき PPVAL で実行されます。 
%   PPVAL(PP,XI) は、INTERP1(X,Y,XI,METHOD,'extrap') と同じです。
%
%   たとえば、粗い正弦波を作成し、細かい横軸上で内挿します。
%       x = 0:10; y = sin(x); xi = 0:.25:10;
%       yi = interp1(x,y,xi); plot(x,y,'o',xi,yi)
%
%   多次元の例として、functional values の表を作成します。
%       x = [1:10]'; y = [ x.^2, x.^3, x.^4 ];
%       xi = [ 1.5, 1.75; 7.5, 7.75]; yi = interp1(x,y,xi);
%
%   は、3 つの関数各々について1つずつ、補間した関数値の 2×2 の行列を
%   作成します。 yi は、サイズ 2×2×3 となります。
%
%   入力 X, Y, XI, EXTRAPVAL に対するクラスサポート:
%      float: double, single
%
%   参考 INTERP1Q, INTERPFT, SPLINE, PCHIP, INTERP2, INTERP3, INTERPN, PPVAL.


%   Copyright 1984-2005 The MathWorks, Inc.
