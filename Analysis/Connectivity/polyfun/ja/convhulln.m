%CONVHULLN  N-�����̓ʕ�
%
%   K = CONVHULLN(X) �́AX �̓ʕ�̖ʂ��\������ X �̒��̓_�̃C���f�b�N�X K ��
%   �Ԃ��܂��B
%   X �́An-�����̋�ԂɈʒu���� m �_��\�킷m �s n ��̔z��ł��B�ʕ p ��
%   �����ꍇ�AK �� p �s n ��ɂȂ�܂��B
%
%   CONVHULLN �́AQhull ���g�p���܂��B
%
%   K = CONVHULLN(X,OPTIONS) �́AQhull �̃I�v�V�����Ƃ��Ďg�p�����悤�ɁA
%   ������ OPTIONS �̃Z���z����w�肵�܂��B�f�t�H���g�̃I�v�V�����́A
%   �ȉ��̂Ƃ���ł��B
%                                 2D, 3D ����� 4D ���͂̏ꍇ�A{'Qt'}
%                                 5D �ȏ�̓��͂̏ꍇ�A{'Qt','Qx'}
%   OPTIONS �� [] �̏ꍇ�A�f�t�H���g�̃I�v�V�������g���܂��BOPTIONS �� 
%   {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���BQhull ��
%   ���̃I�v�V�����ɂ��Ă̏ڍׂ́Ahttp://www.qhull.org ���Q�Ƃ��Ă��������B
%
%   [K,V] = CONVHULLN(...) �́AV �ɓʕ�̑̐ς�Ԃ��܂��B
%
%   ��:
%      X = [0 0; 0 1e-10; 0 0; 1 1];
%      K = convhulln(X)
%   �́A�ǉ��I�v�V���� 'Pp' �Ōx�����\���ɂ��܂��B
%      K = convhulln(X,{'Qt','Pp'})
%
%   �Q�l DelaunayTri, TriRep, CONVHULL, QHULL, DELAUNAYN, VORONOIN,
%        TSEARCHN, DSEARCHN.


%   Copyright 1984-2009 The MathWorks, Inc. 
