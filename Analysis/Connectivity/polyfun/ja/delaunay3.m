%DELAUNAY3  3 ������ Delaunay ����
%
%   T = DELAUNAY3(X,Y,Z) �́A�l�ʑ̂̎���̋��ʂɊ܂܂�Ȃ� X �̃f�[�^�_����
%   �Ȃ�l�ʑ̂̏W����Ԃ��܂��BT �́Anum �s 4 ��̔z��ł��BT �̊e�s�̗v�f�́A
%   (X,Y,Z) �̃��U�C�N���Ŏl�ʑ̂��`������ (X,Y,Z) �̓_�̃C���f�b�N�X�ł��B
%
%   DELAUNAY3 �́AQhull ���g�p���܂��B
%
%   T = DELAUNAY3(X,Y,Z,OPTIONS) �́ADELAUNAY3 �ɂ�� Qhull �̃I�v�V������
%   ���Ďg����悤�ɁA������ OPTIONS �̃Z���z����w�肵�܂��B�f�t�H���g��
%   �I�v�V�����́A{'Qt','Qbb','Qc'} �ł��B
%   OPTIONS �� [] �̏ꍇ�A�f�t�H���g�̃I�v�V�������g���܂��BOPTIONS �� 
%   {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���B
%   Qhull �I�v�V�����̏ڍׂ́Ahttp://www.qhull.org ���Q�Ƃ��Ă��������B
%
%   ��:
%      X = [-0.5 -0.5 -0.5 -0.5 0.5 0.5 0.5 0.5];
%      Y = [-0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5 0.5];
%      Z = [-0.5 0.5 -0.5 0.5 -0.5 0.5 -0.5 0.5];
%      T = delaunay3( X, Y, Z, {'Qt', 'Qbb', 'Qc', 'Qz'} )
%
%   �Q�l DelaunayTri, QHULL, DELAUNAY, DELAUNAYN, GRIDDATA3, GRIDDATAN,
%        VORONOIN, TETRAMESH.


%   Copyright 1984-2009 The MathWorks, Inc.
