% pointLocation  �w�肵���ʒu���܂ރV���v���b�N�X�̈ʒu
%
%    SI = pointLocation(DT, QX) �́AQX �̏ƍ��_�̈ʒu���ƂɈ͂܂�Ă���
%    �V���v���b�N�X (�O�p�`/�l�ʑ̂Ȃ�) �̃C���f�b�N�X SI ��Ԃ��܂��B
%    �_ QX(k,:) �ɑ΂��Ĉ͂܂�Ă���V���v���b�N�X�́A SI(k) �ł��B
%    �s�� QX �́Amptx �s ndim �̃T�C�Y�ł��B�����ŁAmpts �͏ƍ��_���ł��B
%    SI �́A���� mpts �̗�x�N�g���ł��BpointLocation �́A�ʕ�̊O����
%    ���ׂĂ̓_�ɑ΂��Ă� NaN ��Ԃ��܂��B
%
%    SI = pointLocation(DT, QX,QY) �� SI = pointLocation (DT, QX,QY,QZ) �́A
%    2D �� 3D �ŋ@�\����ꍇ�A�ƍ��_�̈ʒu��ʂ̗�x�N�g���̌`���Ŏw�肷��
%    ���Ƃ��ł��܂��B
%
%    [SI, BC] = pointLocation(DT,...) �́A����ɏd�S���W BC ��Ԃ��܂��B
%    BC �� mpts �s ndim ��̍s��ł��B�e�s BC(i,:) �́A�͂܂�Ă���
%    �V���v���b�N�X SI(i) �ɑ΂��� QX(i,:) �̏d�S���W��\���܂��B
%
%    �� 1:
%        % 2D �̓_�̈ʒu
%        X = rand(10,2)
%        dt = DelaunayTri(X)
%        % �ȉ��̏ƍ��_���܂ގO�p�`�����o
%        qrypts = [0.25 0.25; 0.5 0.5]
%        triids = pointLocation(dt, qrypts)
%
%    �� 2:
%        % 3D �̏d�S���W�̕]���ɂ�����_�̈ʒu
%        x = rand(10,1); y = rand(10,1); z = rand(10,1);
%        dt = DelaunayTri(x,y,z)
%        % �ȉ��̏ƍ��_���܂ގO�p�`�����o
%        qrypts = [0.25 0.25 0.25; 0.5 0.5 0.5]
%        [tetids, bcs] = pointLocation(dt, qrypts)
%
%    �Q�l DelaunayTri, DelaunayTri.nearestNeighbor.
