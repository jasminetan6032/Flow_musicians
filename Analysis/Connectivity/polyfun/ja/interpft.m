% INTERPFT   FFT(�����t�[���G�ϊ�)�@���g����1�������
% 
% Y = INTERPFT(X,N) �́AX �̃t�[���G�ϊ��ŕ�Ԃɂ���ē����钷�� N ��
% �x�N�g�� Y ���o�͂��܂��B 
%
% X ���s��̏ꍇ�A��Ԃ͊e��ɑ΂��čs���܂��B
% X ���z��̏ꍇ�A��Ԃ͍ŏ���1�łȂ������ɑ΂��čs���܂��B
%
% INTERPFT(X,N,DIM) �́A���� DIM �ɂ��ĕ�Ԃ��s���܂��B
%
% x(t) ���A���Ԋu�̓_�ŃT���v�����O���ꂽ��� p ������ t �̎����֐���
% ���肷��ƁAT(i) = (i-1)*p/M�Ai = 1:M�AM = length(X) �̂Ƃ��A
% X(i) = x(T(i)) �ƂȂ�܂��By(t) �́A������Ԃ������̎����֐��ŁA
% T(j) = (j-1)*p/N�Aj = 1:N�AN = length(Y) �̂Ƃ��AY(j) = y(T(j)) ��
% �Ȃ�܂��BN �� M �̐����{�̏ꍇ�AY(1:N/M:N) = X�ɂȂ�܂��B
%
% �� : 
%      % �O�p�`�̂悤�ȐM�����Ԃ��邽�߂̐ݒ���s���܂��B
%      y  = [0:.5:2 1.5:-.5:-2 -1.5:.5:0]; % ���Ԋu
%      factor = 5; % 5 �̌W���ŕ��
%      m  = length(y)*factor;
%      x  = 1:factor:m;
%      xi = 1:m;
%      yi = interpft(y,m);
%      plot(x,y,'o',xi,yi,'*')
%      legend('Original data','Interpolated data')
%
% �f�[�^���� x �̃T�|�[�g�N���X
%      float: double, single
%  
% �Q�l INTERP1.


%   Copyright 1984-2006 The MathWorks, Inc. 
