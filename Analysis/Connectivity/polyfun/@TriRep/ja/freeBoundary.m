%freeBoundary  1 �̃V���v���b�N�X�݂̂ŎQ�Ƃ���鏬�ʂ��o��
%
%   FF = freeBoundary(TR) �́A�O�p�`�����̎��R���E�̏��ʂ�\���s�� FF ��
%   �Ԃ��܂��B1 �̃V���v���b�N�X (�O�p�`/�l�ʑ̂Ȃ�) �݂̂ŎQ�Ƃ����ꍇ�A
%   ���ʂ͎��R���E��ɂ���܂��BFF �� m �s n ��̃T�C�Y�ł��B�����ŁAm ��
%   ���E�̏��ʂ̐��ŁAn �͏��ʂ��Ƃ̒��_�̐��ł��B���ʂ̃C���f�b�N�X�̒��_�́A
%   ���_�̍��W TR.X ��\���_�̔z��ł��B�z�� FF �́A���̂̕\�ʂ�\���O�p�`
%   ���b�V���Ɠ����悤�ɋ�ɂȂ�܂��B
%
%   [FF XF] = freeBoundary(TR) �́A���W XF �̃R���p�N�g�Ȕz��̍��Œ�`�����
%   ���_�������R���E�̏��� FF �̍s���Ԃ��܂��BXF �� m �s ndim ��̃T�C�Y�ł��B
%   �����ŁAm �͎��R���E�̏��ʂ̐��Andim �͎O�p�`���������݂����Ԃ̎����ł��B
%
%   �� 1: 3D �̎O�p�`������ǂݍ��݁ATriRep ���g�p���Ă��ׂĂ̎l�ʑ̂̋ߖT��
%         �v�Z���܂��B
%       load tetmesh
%       % ����͎O�p�`���� tet �ƒ��_�̍��W X ��ǂݍ��݂܂��B
%       trep = TriRep(tet, X)
%       [tri xf] = freeBoundary(trep);
%       %Plot the boundary triangulation
%		    trisurf(tri, xf(:,1),xf(:,2),xf(:,3), 'FaceColor', 'cyan', 'FaceAlpha', 0.8); 
%
%   �� 2: DelaunayTri ���g���č쐬���� 2D �̎O�p�`�����𒼐ڒ��ׂ܂��B
%       % ���b�V�����v���b�g���A���R���E�̃G�b�W��Ԃŕ\�����܂��B
%       x = rand(20,1)
%       y = rand(20,1)
%       dt = DelaunayTri(x,y)
%       fe = freeBoundary(dt)';
%       triplot(dt);
%       hold on ; plot(x(fe), y(fe), '-r', 'LineWidth',2) ; hold off ;
%       % ���̏ꍇ�A���R���E�̃G�b�W�� (x, y) �̓ʕ�ɑΉ����܂��B
%
%
%   �Q�l TriRep QueryTetMesh.


%   Copyright 2008-2009 The MathWorks, Inc.
