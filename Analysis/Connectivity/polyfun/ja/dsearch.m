%DSEARCH  �ŋߖT��p���� Delaunay �O�p�`�����̌���
%
%   K = DSEARCH(X,Y,TRI,XI,YI) �́A�f�[�^�_ (xi,yi) �̍ŋߖT�̃f�[�^�_ 
%   (x,y) �̃C���f�b�N�X��Ԃ��܂��BDELAUNAY ���瓾����_ X, Y �̎O�p�`
%   ���� TRI ���K�v�ł��B
%
%   K = DSEARCH(X,Y,TRI,XI,YI,S) �́A����v�Z�������ɁA�X�p�[�X�s�� 
%   S ���g���܂��B
%
%     S = sparse(tri(:,[1 1 2 2 3 3]),tri(:,[2 3 1 3 1 2]),1,nxy,nxy)
%
%   �����ŁAnxy = prod(size(x)) �ł��B
%
%   �Q�l DelaunayTri, TSEARCH, DELAUNAY, VORONOI.


%   Copyright 1984-2009 The MathWorks, Inc.
