% PPVAL  区分多項式の計算
%
%   V = PPVAL(PP,XX) は、XX の要素で、 PCHIP, SPLINE, INTERP1, または、
%   スプラインユーティリティ MKPP で構成される、PP で得られる区分多項式 
%   f の値を出力します。
%
%   V は、XX の各要素をf の値で置き換えることにより得られます。
%   f がスカラ値の場合、V は、XX と同じサイズです。 XX は ND になります。
%
%   PP が スカラでない関数値の指定を使って PCHIP, SPLINE または MKPP で
%   作成された場合、つぎのようになります。
%
%   f が [D1,..,Dr] の値で、XX が長さ N のベクトルの場合、V は XX(J) での
%   f の値 V(:,...,:,J)  で、サイズ [D1,...,Dr, N] になります。
%   f が [D1,..,Dr] の値で、XX がサイズ [N1,...,Ns] をもつ場合、V は 
%   XX(J1,...,Js) での f の値 V(:,...,:, J1,...,Js) で、サイズ 
%   [D1,...,Dr, N1,...,Ns] になります。
%
%   PP が、スカラでない関数値の指定を使って INTERP1 で作成された場合、
%   つぎのようになります。
%
%   f が [D1,..,Dr] の値で、XX が長さ N のベクトルの場合、V は XX(J) での
%   f の値 V(J,:,...,:) で、サイズ [N,D1,...,Dr] になります。
%   f が [D1,..,Dr] の値で、XX がサイズ [N1,...,Ns] をもつ場合、V は 
%   XX(J1,...,Js) での f の値 V(J1,...,Js,:,...,:) で、サイズ 
%   [N1,...,Ns,D1,...,Dr] になります。
%
%   例:
%   関数 cos を使ったものと、spline 補間を使ったものの積分結果を比較します。
%
%     a = 0; b = 10;
%     int1 = quad(@cos,a,b);
%     x = a:b; y = cos(x); pp = spline(x,y); 
%     int2 = quad(@(x)ppval(pp,x),a,b);
%
%   int1 は区間 [a,b] で関数 cos の積分を計算し、一方、int2 は計算した 
%   x,y の値を内挿することで、同じ区間で関数 cos を近似して、区分多項式 
%   pp を積分計算したものです。
%
%   入力 X と PP のフィールドに対するクラスサポート:
%      float: double, single
%
%   参考 SPLINE, PCHIP, INTERP1, MKPP, UNMKPP.


%   Carl de Boor 7-2-86
%   Copyright 1984-2010 The MathWorks, Inc.
