%isEdge  ���_�̑g���G�b�W�ŘA�����Ă��邩�ǂ������e�X�g
%
%   TF = isEdge(TR, V1, V2) �́AV1(i), V2(i) ���O�p�`�����̃G�b�W�̏ꍇ��
%   �e�v�f TF(i) �� true �ƂȂ� 1/0 (true/false) �t���O�̔z���Ԃ��܂��B
%   V1, V2 �́A���b�V�����̒��_�̃C���f�b�N�X�A���Ȃ킿�A���_�̍��W���̔z���
%   �C���f�b�N�X��\����x�N�g���ł��BTF = isEdge(TR, EDGE) �́A�G�b�W��
%   �J�n�ƏI���C���f�b�N�X���s��`���Ŏw�肵�܂��B�����ŁAEDGE �� n �s 2 ��ŁA
%   n �͏ƍ�����G�b�W�̐��ł��B
%
%   �� 1:
%       % 2D �̎O�p�`������ǂݍ��݁ATriRep ���g�p���ē_�̑g�Ԃ̃G�b�W���݂�
%       % ���ׂ܂��B
%       load trimesh2d
%       % ����͎O�p�`���� tri �ƒ��_�̍��W x, y ��ǂݍ��݂܂��B
%       trep = TriRep(tri, x,y);
%       triplot(trep);
%       vxlabels = arrayfun(@(n) {sprintf('P%d', n)}, [2 25 36]');
%         Hpl = text(x([2 25 36]), y([2 25 36]), vxlabels, 'FontWeight', ...
%                    'bold', 'HorizontalAlignment',...
%                   'center', 'BackgroundColor', 'none');
%       axis([-50 350 -50 350]);
%       axis equal;
%       % ���_ 1 �� 5 �̓G�b�W�ɐڑ����Ă��܂��� ?
%       % (�E���̋�)
%       isEdge(trep, 2, 25)
%       isEdge(trep, 2, 36)
%
%   �� 2:
%       % DelaunayTri ���g���č쐬���� 3D �� Delaunay �O�p�`�����𒼐�
%       % ���ׂ܂��B
%       X = rand(10,3)
%       dt = DelaunayTri(X)
%       % ���_ 2 �� 7 �̓G�b�W�ɐڑ����Ă��܂��� ?
%       isEdge(dt, 2, 7)
%
%   �Q�l TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
