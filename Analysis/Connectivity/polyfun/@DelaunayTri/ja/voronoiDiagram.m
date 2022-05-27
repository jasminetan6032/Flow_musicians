% voronoiDiagram  Voronoi ���}�̏o��
%
%    �_ X �̗��U�W���� Voronoi ���}�́A�e�_ X(i) �̎���̋�Ԃ��e���͈� R{i} 
%    �ɕ������܂��B�͈� R{i} �̈ʒu�́AX ���̑��̓_���_ i �ɋ߂��Ȃ�܂��B
%    �e���͈͂́AVoronoi �̈���Ăяo���܂��BVoronoi �̈�̂��ׂĂ̏W���� 
%    Voronoi ���}�ł��B
%
%    [V, R] = voronoiDiagram(DT) �́A�_ DT.X �� Voronoi ���}�̒��_ V ��
%    �̈� R ��Ԃ��܂��B�̈� R{i} �́A�̈���͂� Voronoi �̒��_��\�� 
%    V �̃C���f�b�N�X�̃Z���z��ł��BV �́AVoronoi �̒��_�̍��W��\�� 
%    numv �s ndim ��̍s��ł��B�����ŁAnumv �͒��_�̐��ŁAndim �͓_��
%    ���݂����Ԃ̎����ł��BR �́A�e�_�Ɋ֘A���� Voronoi �̃Z����\�� 
%    length(DR.X) �̃x�N�g���̃Z���z��ł��B���������āAVoronoi �̈�́A
%    DT.X(i) �� R{i} �ƂȂ�悤�ɁAi �Ԗڂ̓_�Ɋ֘A���܂��B
%
%    2 �����̏ꍇ�AR{i} �̒��̒��_�ׂ͗荇�������Ƀ��X�g����A���Ȃ킿�A
%    �������������邱�Ƃɂ��A���p�` (voronoi ���}) ���쐬����܂��B
%    3 �����̏ꍇ�AR{i} �̒��_�͏����Ƀ��X�g����܂��B
%
%    �������_
%    DT.X �̓ʕ�ɂ���_�Ɋ֘A���� Voronoi �̈�ɂ͋��E������܂���B
%    �����̗̈�̃G�b�W���͂ނƖ����ɍL����܂��B������̒��_�́A
%    V �� 1 �Ԗڂ̒��_�ŕ\����܂��B
%
%    ��: �_�W���� Voronoi ���}���v�Z���܂��B
%        X = [ 0.5    0
%              0      0.5
%             -0.5   -0.5
%             -0.2   -0.1
%             -0.1    0.1
%              0.1   -0.1
%              0.1    0.1 ]
%        dt = DelaunayTri(X)
%        [V,R] = voronoiDiagram(dt)
%
%    �Q�l DelaunayTri, voronoi
