%INPOLYGON  ���p�`���̓_�̌��o
%
%   IN = INPOLYGON(X�AY�AXV�AYV) �́AX �� Y �Ɠ����T�C�Y�̍s�� IN ��Ԃ��܂��B
%   �x�N�g�� XV �� YV �Ŏw�肳��钸�_�������p�`���ɓ_ (X(p,q)�AY(p,q)) ��
%   ����ꍇ�AIN(p,q) = 1 �ł��B�_�����p�`�̋��E��ɂ���ꍇ�AIN(p,q) �� 
%   0.5 �ł��B�_�����p�`�̊O�ɂ���ꍇ�́AIN(p,q) = 0 �ł��B
%
%   [IN ON] = INPOLYGON(X,Y,XV,YV) �� 2 �ڂ̍s�� ON ��Ԃ��܂��B����́A
%   X �� Y �̃T�C�Y�ł��B�_(X(p,q), Y(p,q)) �����p�`�̈�̒[�ɂ���ꍇ�A
%   ON(p,q) = 1 �ŁA�����łȂ��ꍇ�AON(p,q) = 0 �ł��B
%
%   INPOLYGON �́A�ʂłȂ���_�������p�`���T�|�[�g���܂��B�֐��́A����
%   �ڑ�����Ă���A�܂��́A�ʏ�̌�_�������Ȃ����p�`���T�|�[�g���܂����A
%   �X�̃G�b�W���[�v�́ANaN �ŕ�������Ă���K�v������܂��B�����ڑ�
%   ����Ă��鑽�p�`�̏ꍇ�A�O���Ɠ����̃��[�v�́A���Ε����ł���K�v��
%   ����܂��B���Ƃ��΁A�����v���̊O�����[�v�Ǝ��v���̓������[�v�A
%   �܂��͂��̋t�ɂ���K�v������܂��B
%
%   �� 1:
%       % ��_�������Ȃ����p�`
%       xv = rand(6,1); yv = rand(6,1);
%       xv = [xv ; xv(1)]; yv = [yv ; yv(1)];
%       x = rand(1000,1); y = rand(1000,1);
%       in = inpolygon(x,y,xv,yv);
%       plot(xv,yv,x(in),y(in),'.r',x(~in),y(~in),'.b')
%
%   �� 2:
%       % �����ڑ�����Ă��鑽�p�` - �����`�̌��̂��鐳���`
%       % �����v���̊O�����[�v�A���v���̓������[�v
%       xv = [0 3 3 0 0 NaN 1 1 2 2 1];
%       yv = [0 0 3 3 0 NaN 1 2 2 1 1];
%       x = rand(1000,1)*3; y = rand(1000,1)*3;
%       in = inpolygon(x,y,xv,yv);
%       plot(xv,yv,x(in),y(in),'.r',x(~in),y(~in),'.b')
%
%   ���� X,Y,XV,YV �ɑ΂���N���X�T�|�[�g:
%      float: double, single


%   Copyright 1984-2008 The MathWorks, Inc.
