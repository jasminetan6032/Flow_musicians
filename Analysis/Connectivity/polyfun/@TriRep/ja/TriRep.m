%TriRep     �O�p�`�����\��
%
%   ����́A2D �� 3D ��ԓ��̎O�p�`�����ɑ΂��Ĉʑ��􉽊w�I�ȏƍ����s���܂��B
%   ���Ƃ��΁A�O�p�`���b�V���̏ꍇ�A���_��ǉ������O�p�`��A�G�b�W�����L����
%   ����O�p�`�A�ߖT���A�O�S�Ȃǂ𒲂ׂ邱�Ƃ��ł��܂��B�����̎O�p�`����
%   �f�[�^���g���āA���� TriRep ���쐬���邱�Ƃ��ł��܂��B���邢�́ATriRep �ւ�
%   �@�\�I�ȃA�N�Z�X���@�ł��� DelaunayTri �ɂ��ADelaunay �O�p�`�������쐬����
%   ���Ƃ��\�ł��B
%
%   TR = TriRep(TRI, X, Y) �́A�O�p�`�����̍s�� TRI �ƒ��_�̍��W (X, Y) ���� 
%   2D �� TriRep ���쐬���܂��BTRI �́A�O�p�`�������-���_�̌`���Œ�`���� 
%   m �s 3 ��̍s��ł��B�����ŁAm �͎O�p�`�̐��ł��BTRI �̊e�s�́A���_�̍��W 
%   (X, Y) �̗�x�N�g���̃C���f�b�N�X�Œ�`�����O�p�`�ł��B
%
%   TR = TriRep(TRI, X, Y, Z) �́A�O�p�`�����̍s�� TRI �ƒ��_�̍��W (X, Y, Z) 
%   ���� 3D �� TriRep ���쐬���܂��BTRI �́A�O�p�`�������V���v���b�N�X-���_��
%   �`���Œ�`���� m �s 3 ��A�܂��� m �s 4 ��̍s��ł��B�����ŁAm ��
%   �V���v���b�N�X (���̏ꍇ�A�O�p�`�܂��͎l�ʑ�) �̐��ł��BTRI �̊e�s�́A
%   ���_�̍��W (X, Y, Z) �̗�x�N�g���̃C���f�b�N�X�Œ�`�����V���v���b�N�X�ł��B
%
%   TR = TriRep(TRI, X) �́A�O�p�`�����̍s�� TRI �ƒ��_�̍��W X ���� TriRep 
%   ���쐬���܂��BTRI �́A�O�p�`�������V���v���b�N�X-���_�̌`���Œ�`���� m �s 
%   n ��̍s��ł��B�����ŁAm �̓V���v���b�N�X�̐��ŁAn �̓V���v���b�N�X���Ƃ�
%   ���_�̐��ł��BTRI �̊e�s�́A���_�̍��W X �̔z��̃C���f�b�N�X�Œ�`�����
%   �V���v���b�N�X�ł��BX �� mpts �s ndim ��̍s��ł��B�����ŁAmpts �͓_���ŁA
%   ndim �͓_�����݂����Ԃ̎����� 2 <= ndim <= 3 �ł��B
%
%
%   �� 1:
%       % 2D �̎O�p�`������ǂݍ��݁ATriRep ���g�p���Ď��R���E�̃G�b�W��
%       % �z����쐬���܂��B
%       load trimesh2d
%       % ����͎O�p�`���� tri �ƒ��_�̍��W x, y ��ǂݍ��݂܂��B
%       trep = TriRep(tri, x,y);
%       fe = freeBoundary(trep)';
%       triplot(trep);
%       % ���R���E�̃G�b�W��ԂŒǉ����܂��B
%       hold on; plot(x(fe), y(fe), 'r','LineWidth',2); hold off;
%       axis([-50 350 -50 350]);
%       axis equal;
%
%   �� 2:
%       % 3D �̎l�ʑ̂̎O�p�`������ǂݍ��݁ATriRep ���g�p���Ď��R���E 
%       % (�O�p�`�����̕\��) ���v�Z���܂��B
%       load tetmesh
%       % ����͎O�p�`���� tet �ƒ��_�̍��W X ��ǂݍ��݂܂��B
%       trep = TriRep(tet, X);
%       [tri, Xb] = freeBoundary(trep);
%       % �\�ʃ��b�V�����v���b�g
%       trisurf(tri, Xb(:,1), Xb(:,2), Xb(:,3), 'FaceColor', 'cyan', 'FaceAlpha', 0.8);
%
%   �� 3:
%       % DelaunayTri ���g���č쐬���� 3D �� Delaunay �O�p�`�����𒼐�
%       % ���ׂ܂��B�� 2 �Ɠ��l�Ɏ��R���E���v�Z���܂��B
%       X = rand(50,3);
%       dt = DelaunayTri(X);
%       [tri, Xb] = freeBoundary(dt);
%       % �\�ʃ��b�V�����v���b�g
%       trisurf(tri, Xb(:,1), Xb(:,2), Xb(:,3), 'FaceColor', 'cyan','FaceAlpha', 0.8);
%
%
%   TriRep ���\�b�h:
%        baryToCart     - �_�̍��W���d�S���W���璼�����W�ɕϊ�
%        cartToBary     - �_�̍��W�𒼌����W����d�S���W�ɕϊ�
%        circumcenters  - �w�肵���V���v���b�N�X�̊O�S���o��
%        edgeAttachments  - �w�肵���G�b�W�ɒǉ�����V���v���b�N�X���o��
%        edges          - �O�p�`�������̃G�b�W���o��
%        faceNormals    - �w�肵���O�p�`�̒P�ʖ@�����o��
%        featureEdges   - �\�ʂ̎O�p�`�����̉s���G�b�W���o��
%        freeBoundary   - 1 �̃V���v���b�N�X�݂̂ŎQ�Ƃ���鏬�ʂ��o��
%        incenters      - �w�肵���V���v���b�N�X�̓��_���o��
%        isEdge         - ���_�̑g���G�b�W�ŘA�����Ă��邩�ǂ������e�X�g
%        neighbors      - �V���v���b�N�X�̋ߖT�����o��
%        vertexAttachments  - �w�肵�����_�ɒǉ�����V���v���b�N�X���o��
%        size               - �O�p�`�����̍s��̃T�C�Y���o��
%
%    TriRep �v���p�e�B:
%        X              - �O�p�`�������̓_�̍��W
%        Triangulation  - �O�p�`�����f�[�^�̍\����
%
%   �Q�l DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
