%edgeAttachments  �w�肵���G�b�W�ɒǉ�����V���v���b�N�X���o��
%
%   SI = edgeAttachments(TR, V1, V2) �́A(V1, V2) �Ŏw�肵���G�b�W�ɒǉ�
%   ����V���v���b�N�X SI ��Ԃ��܂��B�V���v���b�N�X�́A�O�p�`/�l�ʑ́A
%   �܂��͂�荂�������ɑ���������̂ł��BSI �̓x�N�g���̃Z���z��ł��B
%   �����ŁA�e�Z���͎O�p�`�����̍s�� TR.Triangulation �ւ̃C���f�b�N�X��
%   �܂�ł��܂��B(V1, V2) �́A���_�̍��W TR.X ��\���_�̔z��ւ̒��_��
%   �C���f�b�N�X�̗�x�N�g���ł��B(V1, V2) �́A�ƍ�����G�b�W�̍ŏ���
%   �Ō�̒��_��\���܂��BSI �́A�e�G�b�W�Ɋւ���V���v���b�N�X�̐���
%   �ω����邽�߁A�Z���z��ɂȂ�܂��B
%
%   SI = edgeAttachments(TR, EDGE) �́A�G�b�W�̊J�n�ƏI���_���s��`����
%   �w�肵�܂��B�����ŁAEDGE �� m �s 2 ��ŁAm �͏ƍ�����G�b�W�̐��ł��B
%
%   �� 1: 3D �̎O�p�`������ǂݍ��݁A�G�b�W�ɒǉ�����l�ʑ̂��v�Z���邽�߂� 
%         TriRep ���g�p���܂��B
%       load tetmesh
%       % ����͎O�p�`���� tet �ƒ��_�̍��W X ��ǂݍ��݂܂��B
%       trep = TriRep(tet, X)
%       v1 = [15 21]'
%       v2 = [936 716]'
%       t = edgeAttachments(trep, v1, v2)
%       t{:}
%       % ����ɁA�G�b�W���w�肵�܂��B
%       e = [v1 v2]
%       t = edgeAttachments(trep, e)
%       t{:}
%
%   �� 2: DelaunayTri ���g���č쐬�����O�p�`�����𒼐ڒ��ׂ܂��B 
%   % 2D �� Delaunay �O�p�`�������쐬���Aedge(1,5) �ɒǉ�����O�p�`�𒲂ׂ܂��B
%     x = [0 1 1 0 0.5]'
%     y = [0 0 1 1 0.5]'
%     dt = DelaunayTri(x,y)
%     t = edgeAttachments(dt, 1,5)
%     t{:}
%
%
%   �Q�l TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
