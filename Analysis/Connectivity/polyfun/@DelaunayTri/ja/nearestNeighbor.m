%    nearestNeighbor  �w�肵���ʒu�ɍł��߂��_�̌���
%
%    PI = nearestNeighbor(DT, QX) �́AQX �̏ƍ��_�̈ʒu���Ƃ� DT.X �ɍŋߖT��
%    �_�̃C���f�b�N�X��Ԃ��܂��B�s�� QX �́Ampts �s ndim ��̃T�C�Y�ł��B
%    �����ŁAmpts �͏ƍ��_���ŁAndim �͓_�̂����Ԃ̎����ł��BPI �́A
%    �_ DT.X �̃C���f�b�N�X�������_�̗�x�N�g���ł��B
%    PI �̒����́A�ƍ��_ mpts �̐��Ɠ������Ȃ�܂��B
%
%    PI = nearestNeighbor(DT, QX,QY) �� PI = nearestNeighbor(DT, QX,QY,QZ) 
%    �́A2D �� 3D �ŋ@�\����ꍇ�A�ƍ��_��ʂ̗�x�N�g���̌`���Ŏw�肷�邱�Ƃ�
%    �ł��܂��B
%
%    ����: nearestNeighbor �́A���񂳂ꂽ�G�b�W������ 2D �O�p�`�����ł͎g�p
%          �ł��܂���B
%
%    ��:
%        x = rand(10,1)
%        y = rand(10,1)
%        dt = DelaunayTri(x,y)
%        % �ȉ��̏ƍ��_�̍ŋߖT�̓_�����o
%        qrypts = [0.25 0.25; 0.5 0.5]
%        pid = nearestNeighbor(dt, qrypts)
%
%    �Q�l DelaunayTri, DelaunayTri.pointLocation.
