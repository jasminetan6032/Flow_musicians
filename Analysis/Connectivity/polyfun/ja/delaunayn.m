%DELAUNAYN  N-������ Delaunay ����
%
%   T = DELAUNAYN(X) �́A�V���v���b�N�X�̎���̋��ʂɊ܂܂�Ȃ� X �̃f�[�^�_
%   ����Ȃ�V���v���b�N�X�̏W����Ԃ��܂��B�V���v���b�N�X�̏W���́ADelaunay 
%   �������`�����܂��BX �́An-�����̋�ԂɈʒu���� m �_��\�킷m �s n ���
%   �z��ł��BX �� numt �s (n+1) ��̔z��ŁA���̍s���Ή�����V���v���b�N�X��
%   ���_�� X �̃C���f�b�N�X�ɂȂ�܂��B
%
%   DELAUNAYN �́AQhull ���g�p���܂��B
%
%   T = DELAUNAYN(X,OPTIONS) �́AQhull �̃I�v�V�����Ƃ��Ďg�p�����悤�ɁA
%   ������ OPTIONS �̃Z���z����w�肵�܂��B�f�t�H���g�̃I�v�V�����́A
%   �ȉ��̂Ƃ���ł��B
%           2D ����� 3D �̓��͂̏ꍇ�A{'Qt','Qbb','Qc'}
%           4D �ȏ�̓��͂̏ꍇ�A{'Qt','Qbb','Qc','Qx'}
%   OPTIONS �� [] �̏ꍇ�A�f�t�H���g�̃I�v�V�������g���܂��BOPTIONS �� 
%   {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���B
%   Qhull �I�v�V�����̏ڍׂ́Ahttp://www.qhull.org ���Q�Ƃ��Ă��������B
%
%   ��:
%      X = [-0.5 -0.5  -0.5;
%           -0.5 -0.5   0.5;
%           -0.5  0.5  -0.5;
%           -0.5  0.5   0.5;
%            0.5 -0.5  -0.5;
%            0.5 -0.5   0.5;
%            0.5  0.5  -0.5;
%            0.5  0.5   0.5];
%      T = delaunayn(X);
%   �́A�G���[�ƂȂ�܂����A�f�t�H���g�I�v�V������ 'Qz' ��ǉ������
%   �𗧂��Ƃ������܂��B
%      T = delaunayn(X,{'Qt','Qbb','Qc','Qz'});
%   ���̉𓚂�\�����邽�߂ɁATETRAMESH �֐����g�p���邱�Ƃ��ł��܂��B
%      tetramesh(T,X)
%
%   �Q�l DelaunayTri, QHULL, VORONOIN, CONVHULLN, DELAUNAY, DELAUNAY3, 
%        TETRAMESH.


%   Copyright 1984-2009 The MathWorks, Inc.
