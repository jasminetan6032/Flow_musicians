%CONVHULL  �ʕ�
%
%   K = CONVHULL(X,Y) �́A�ʕ��̓_�̃x�N�g�� X �� Y �̃C���f�b�N�X��Ԃ��܂��B
%
%   CONVHULL �́AQhull ���g�p���܂��B
%
%   K = CONVHULL(X,Y,OPTIONS) �́ACONVHULLN �ɂ�� Qhull �̃I�v�V�����Ƃ���
%   �g�p�����悤�ɁA������ OPTIONS �̃Z���z����w�肵�܂��B�f�t�H���g��
%   �I�v�V�����́A{'Qt'} �ł��BOPTIONS �� [] �̏ꍇ�A�f�t�H���g�̃I�v�V������
%   �g���܂��BOPTIONS �� {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���B
%   Qhull �Ƃ��̃I�v�V�����ɂ��Ă̏ڍׂ́Ahttp://www.qhull.org ���Q�Ƃ��Ă��������B
%
%   [K,A] = CONVHULL(...) �́AA �̒��̓ʕ�̕������Ԃ��܂��B
%
%   ��:
%      X = [0 0 0 1];
%      Y = [0 1e-10 0 1];
%      K = convhull(X,Y,{'Qt','Pp'})
%
%   �Q�l DelaunayTri, TriRep, CONVHULLN, DELAUNAY, VORONOI,
%        POLYAREA, QHULL.


%   Copyright 1984-2009 The MathWorks, Inc.
