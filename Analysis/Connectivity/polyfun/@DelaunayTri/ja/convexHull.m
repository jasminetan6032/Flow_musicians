% convexHull  �ʕ�̏o��
%
%    K = convexHull(DT) �́A�ʕ�̒��_�ɑΉ�����_�̔z�� DT.X �̃C���f�b�N�X
%    ��Ԃ��܂��B�_�� 2D ��Ԃɂ���ꍇ�� K �͒��� numf �̗�x�N�g���ŁA
%    �����łȂ��ꍇ�� K �� numf �s ndim ��̃T�C�Y�̍s��ł��B
%    �����ŁAnumf �͓ʕ�̖ʐ��ŁAndim �͓_�̑��݂����Ԃ̎����ł��B
%
%    �� 1: 2D ��Ԃ̒P�ʐ����`���ɂ��闐���̏W���̓ʕ���v�Z���܂��B
%        x = rand(10,1)
%        y = rand(10,1)
%        dt = DelaunayTri(x,y)
%        k = convexHull(dt)
%        plot(x,y, '.', 'markersize',10); hold on;
%        plot(x(k), y(k), 'r'); hold off;
%
%    �� 2: 3D ��Ԃ̒P�ʗ����̓��ɂ��闐���̏W���̓ʕ���v�Z���܂��B
%        X = rand(25,3)
%        dt = DelaunayTri(X)
%        ch = convexHull(dt)
%        trisurf(ch, X(:,1),X(:,2),X(:,3), 'FaceColor', 'cyan')
%
% �Q�l DelaunayTri, trisurf.
