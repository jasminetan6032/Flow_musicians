%POLYFIT  多項式近似
%
%   P = POLYFIT(X,Y,N) は、データ Y を最小二乗的に最適近似する N 次の多項式 
%   P(X) の係数を算出します。P は降順のべき乗の多項式係数  
%   P(1)*X^N + P(2)*X^(N-1) +...+ P(N)*X + P(N+1) 
%   を含む長さ N+1 の行ベクトルです。
%
%   [P,S] = POLYFIT(X,Y,N) は、予測の推定誤差を得るために POLYVAL で使用する
%   多項式の係数 P と構造体 S を返します。S は、X の Vandermonde 行列の QR 分解
%   からの三角因子 (R)、自由度 (df)、残差のノルム (normr) に対するフィールドを
%   含んでいます。データ Y が乱数の場合、P の共分散行列の推定は 
%   (Rinv*Rinv')*normr^2/df です。ここで Rinv は R の逆行列です。
%
%   [P,S,MU] = POLYFIT(X,Y,N) は、XHAT = (X-MU(1))/MU(2) の多項式の係数を求め
%   ます。ここで、MU(1) = MEAN(X) と MU(2) = STD(X) です。このセンタリングと
%   スケーリングの変換は、多項式と近似アルゴリズムの両方の数値的なプロパティを
%   改良します。
%
%   N が >= length(X)、X が重複している、または重複に近い点である、X に
%   センタリングやスケーリングが必要であるかのいずれかの場合、警告メッセージが
%   現れます。
%
%   入力 X,Y のクラスサポート:
%      float: double, single
%
%   参考 POLY, POLYVAL, ROOTS, LSCOV.


%   Copyright 1984-2010 The MathWorks, Inc.
