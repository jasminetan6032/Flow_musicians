%DSEARCHN  N-�����ŋߖT�_�̌���
%
%   K = DSEARCHN(X,T,XI) �́AXI �̒��̊e�_�ɑ΂��� X �̍ŋߖT�_�̃C���f�b�N�X 
%   K ��Ԃ��܂��BX �́An ������Ԃ� p �_��\�킷 p �s n ��̍s��ł��B
%   XI �́Ap �s n ��s��ŁAN ������Ԃ� p �_��\�킵�܂��BT �́Anumt �s 
%   n+1 ��̍s��ŁADELAUAYN �ō쐬�����f�[�^ X �̕����ł��B�o�� K �́A
%   ���� p �̗�x�N�g���ł��B
%
%   K = DSEARCHN(X,T,XI,OUTVAL) �́A�_���ʕ�̒��ɑ��݂������AXI �̒���
%   �e�_�ɑ΂��āAX �ɍŋߖT�_�̃C���f�b�N�X K ��Ԃ��܂��BXI(J,:) ���ʕ��
%   �O�Ɉʒu����ꍇ�́AK(J) �́A�X�J���� double �l�ł��� OUTVAL �����蓖�Ă܂��B
%   Inf �͂��΂��� OUTVAL �Ŏg���܂��BOUTVAL �� [] �̏ꍇ�AK �́A
%   K = DSEARCHN(X,T,XI) �Ɠ����ł��B
%
%   K = DSEARCHN(X,T,XI,OUTVAL,COPTIONS) �́ACONVHULLN �ɂ�� Qhull ��
%   �I�v�V�����Ƃ��Ďg�p�����悤�ɁA������̃Z���z�� COPTIONS ���w�肵�܂��B
%   OPTIONS �� [] �̏ꍇ�A�f�t�H���g�� CONVHULLN �I�v�V�������g�p����܂��B
%   COPTIONS �� {''} �̏ꍇ�A�I�v�V�����͎g�p����܂���B�f�t�H���g�̂��̂�
%   �g�p����܂���B
%
%   K = DSEARCHN(X,T,XI,OUTVAL,COPTIONS,DOPTIONS) �́ADELAUNAYN �ɂ�� Qhull 
%   �̃I�v�V�����Ƃ��Ďg�p�����悤�ɁA������ DOPTIONS �̃Z���z����w�肵�܂��B
%   DOPTIONS �� [] �̏ꍇ�A�f�t�H���g�� DELAUNAYN �I�v�V�������g�p����܂��B
%   DOPTIONS �� {''} �̏ꍇ�A�I�v�V�����͎g�p����܂���B�f�t�H���g�̂��̂�
%   �g�p����܂���B
%
%   K = DSEARCHN(X,XI) �́A�������g��Ȃ��Ō������s���܂��B�傫�� X �Ə����� 
%   XI ���g���ꍇ�ɁA���̃A�v���[�`�͑����Ȃ�A�������̎g�p�����Ȃ��Ȃ�܂��B
%
%   [K,D] = DSEARCHN(X,...) �́A�ŋߖT�_�܂ł̋��� D �ɕԂ��܂��BD �́A
%   ���� p �̗�x�N�g���ł��B
%
%   �Q�l DelaunayTri, TSEARCH, DSEARCH, TSEARCHN, QHULL, GRIDDATAN, 
%        DELAUNAYN, CONVHULLN.


%   Copyright 1984-2009 The MathWorks, Inc.
