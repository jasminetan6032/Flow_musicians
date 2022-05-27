%POLYVALM  引数を行列として多項式を計算
%
%   Y = POLYVALM(P,X) は、P が多項式の係数を要素に持つ N+1 の長さのベクトルの
%   とき、行列引数 X を使って計算された多項式の値です。X は、正方行列でなければ
%   なりません。
%
%       Y = P(1)*X^N + P(2)*X^(N-1) + ... + P(N)*X + P(N+1)*I
%
%   入力 p, X に対するクラスサポート:
%      float: double, single
%
%   参考 POLYVAL, POLYFIT.


%   Copyright 1984-2008 The MathWorks, Inc.
