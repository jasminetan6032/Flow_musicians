% PPVAL  �敪�������̌v�Z
%
%   V = PPVAL(PP,XX) �́AXX �̗v�f�ŁA PCHIP, SPLINE, INTERP1, �܂��́A
%   �X�v���C�����[�e�B���e�B MKPP �ō\�������APP �œ�����敪������ 
%   f �̒l���o�͂��܂��B
%
%   V �́AXX �̊e�v�f��f �̒l�Œu�������邱�Ƃɂ�蓾���܂��B
%   f ���X�J���l�̏ꍇ�AV �́AXX �Ɠ����T�C�Y�ł��B XX �� ND �ɂȂ�܂��B
%
%   PP �� �X�J���łȂ��֐��l�̎w����g���� PCHIP, SPLINE �܂��� MKPP ��
%   �쐬���ꂽ�ꍇ�A���̂悤�ɂȂ�܂��B
%
%   f �� [D1,..,Dr] �̒l�ŁAXX ������ N �̃x�N�g���̏ꍇ�AV �� XX(J) �ł�
%   f �̒l V(:,...,:,J)  �ŁA�T�C�Y [D1,...,Dr, N] �ɂȂ�܂��B
%   f �� [D1,..,Dr] �̒l�ŁAXX ���T�C�Y [N1,...,Ns] �����ꍇ�AV �� 
%   XX(J1,...,Js) �ł� f �̒l V(:,...,:, J1,...,Js) �ŁA�T�C�Y 
%   [D1,...,Dr, N1,...,Ns] �ɂȂ�܂��B
%
%   PP ���A�X�J���łȂ��֐��l�̎w����g���� INTERP1 �ō쐬���ꂽ�ꍇ�A
%   ���̂悤�ɂȂ�܂��B
%
%   f �� [D1,..,Dr] �̒l�ŁAXX ������ N �̃x�N�g���̏ꍇ�AV �� XX(J) �ł�
%   f �̒l V(J,:,...,:) �ŁA�T�C�Y [N,D1,...,Dr] �ɂȂ�܂��B
%   f �� [D1,..,Dr] �̒l�ŁAXX ���T�C�Y [N1,...,Ns] �����ꍇ�AV �� 
%   XX(J1,...,Js) �ł� f �̒l V(J1,...,Js,:,...,:) �ŁA�T�C�Y 
%   [N1,...,Ns,D1,...,Dr] �ɂȂ�܂��B
%
%   ��:
%   �֐� cos ���g�������̂ƁAspline ��Ԃ��g�������̂̐ϕ����ʂ��r���܂��B
%
%     a = 0; b = 10;
%     int1 = quad(@cos,a,b);
%     x = a:b; y = cos(x); pp = spline(x,y); 
%     int2 = quad(@(x)ppval(pp,x),a,b);
%
%   int1 �͋�� [a,b] �Ŋ֐� cos �̐ϕ����v�Z���A����Aint2 �͌v�Z���� 
%   x,y �̒l����}���邱�ƂŁA������ԂŊ֐� cos ���ߎ����āA�敪������ 
%   pp ��ϕ��v�Z�������̂ł��B
%
%   ���� X �� PP �̃t�B�[���h�ɑ΂���N���X�T�|�[�g:
%      float: double, single
%
%   �Q�l SPLINE, PCHIP, INTERP1, MKPP, UNMKPP.


%   Carl de Boor 7-2-86
%   Copyright 1984-2010 The MathWorks, Inc.
