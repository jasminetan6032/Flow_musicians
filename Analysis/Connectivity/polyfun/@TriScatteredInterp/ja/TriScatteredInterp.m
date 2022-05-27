% TriScatteredInterp  �U�z�}�f�[�^�̕��
%
%    �U�z�}�f�[�^�̏W���́AX �̈ʒu�Œ�`����邽�߁A�Ή�����l V �́A
%    X �� Delaunay �O�p�`�������g���Čv�Z���邱�Ƃ��ł��܂��B
%    ����́AV = F(X) �Ƃ����^�̕\�ʂ𐶐����܂��B�\�ʂ́AQV = F(QX) ��
%    �g���ďƍ��ʒu QX �Ŏ��s����܂��B�����ŁAQX �� X �̓ʕ���ɂ���܂��B
%    ��� F �́A��ɕW�{�Ŏw�肳�ꂽ�f�[�^�_��ʂ�܂��B
%
%    F = TriScatteredInterp() �́A��̎U�z�}�f�[�^�̕�Ԃ��쐬���܂��B
%    ���̌�ɁAF.X = Xdata �� F.V = Vdata �ŕW�{�̃f�[�^�_�ƒl 
%    (Xdata, Vdata) �����������܂��B
%
%    F = TriScatteredInterp(X, V) �́AV = F(X) �̌^�̕\�ʂ� (X, V) ���̎U�z�}
%    �f�[�^�ɋߎ������Ԃ��쐬���܂��BX �� mpts �s ndim ��̃T�C�Y�̍s��ł��B
%    �����ŁAmpts �͓_���ŁAndim �͓_�����݂����Ԃ̎����� ndim >= 2 �ł��B
%    V �́AX �ł̒l���`�����x�N�g���ł��B�����ŁAV �̒����� mpts �Ɠ�����
%    �Ȃ�܂��B
%
%    F = TriScatteredInterp(X, Y, V) �� F = TriScatteredInterp(X, Y, Z, V) 
%    �́A2D �� 3D �œ��삷��ꍇ�ɁA����Ƀf�[�^�_�̈ʒu���x�N�g���̌`����
%    �w�肷�邱�Ƃ��ł��܂��B
%
%    F = TriScatteredInterp(DT, V) �́A��Ԃ��v�Z���邽�߂̃x�[�X�Ƃ��āA
%    �w�肵�� DelaunayTri DT ���g�p���܂��BDT �́A�U�z�}�f�[�^�̈ʒu DT.X �� 
%    Delaunay �O�p�`�����ł��B�s�� DT.X �́Ampts �s ndim ��̃T�C�Y�ł��B
%    �����ŁAmpts �͓_���ŁAndim �͓_�����݂����Ԃ̎����� ndim >= 2 �ł��B
%    V �́ADT.X �ł̒l���`�����x�N�g���ł��B�����ŁAV �̒����� mpts ��
%    �������Ȃ�܂��B
%
%    F = TriScatteredInterp(..., METHOD) �́A�f�[�^���Ԃ��邽�߂Ɏg�p����
%    ��@��I�����邱�Ƃ��ł��܂��B
%           'natural'   ���R�ȋߖT���
%           'linear'    ���`��� �i�f�t�H���g�j
%           'nearest'   �ŋߖT���
%    'natural' �̎�@�́A�U�z�}�f�[�^�̈ʒu�������� C1 �A���ł��B
%    'linear' �� C0 �A���ŁA'nearest' �͕s�A���ɂȂ�܂��B
%
%    �� 1:
%        x = rand(100,1)*4-2;
%        y = rand(100,1)*4-2;
%        z = x.*exp(-x.^2-y.^2);
%
%   % ��Ԃ��쐬
%        F = TriScatteredInterp(x,y,z);
%
%   % �ʒu (qx, qy) �ŕ�Ԃ����s���܂��Bqz �͂����̈ʒu�ɑΉ�����l�ł��B
%        ti = -2:.25:2;
%        [qx,qy] = meshgrid(ti,ti);
%        qz = F(qx,qy);
%        mesh(qx,qy,qz); hold on; plot3(x,y,z,'o'); hold off
%
%
%    �� 2: �� 1 �ō쐬������Ԃ�ҏW���ē_��ǉ�/�폜�A�܂��͒l��u�������܂��B
%
%        % ����� 5 �̕W�{�_��}�����܂��BF.V �� F.X �̗������X�V����K�v��
%          ����܂��B
%        close(gcf)
%        x = rand(5,1)*4-2;
%        y = rand(5,1)*4-2;
%        v = x.*exp(-x.^2-y.^2);
%        F.V(end+(1:5)) = v;
%        F.X(end+(1:5), :) = [x, y];
%
%        % 5 �Ԗڂ̓_�̈ʒu�ƒl��u�������܂��B
%        F.X(5,:) = [0.1, 0.1];
%        F.V(5) = 0.098;
%
%        % 4 �Ԗڂ̓_���폜���܂��B
%        F.X(4,:) = [];
%        F.V(4) = [];
%
%        % ���ׂĂ̕W�{�_�̒l��u�������܂��B
%        vnew = 1.2*(F.V);
%        F.V(1:length(vnew)) = vnew;
%
%    TriScatteredInterp ���\�b�h:
%        TriScatteredInterp �́A��Ԃ̓Y���ɂ����s���\�ł��B
%        �����W���̌`���ŕ\�����֐��̎��s�Ɠ������@�Ŏ��s���܂��B
%
%        QV = F(QX) �́A�ƍ��l QV �𐶐����邽�߂Ɏw�肵���ƍ��ʒu QX ��
%        ��Ԃ����s���܂��B
%
%        QV = F(QX, QY, ...) �� QV = F(QX, QY, QZ, ...) �́A2D �� 3D ��
%        �@�\����ꍇ�ɁA�ƍ��_�����̗�x�N�g���̌`���Ŏw�肷�邱�Ƃ�
%        �ł��܂��B
%
%
%    TriScatteredInterp �v���p�e�B:
%        X      - �U�z�}�f�[�^�_�̈ʒu���`
%        V      - �e�f�[�^�_�Ɋւ���l���`
%        Method - �f�[�^���Ԃ��邽�߂Ɏg������@���`
%
%    �Q�l  DelaunayTri, interp1, interp2, interp3, meshgrid.


%   Copyright 2008-2009 The MathWorks, Inc.
