% INTERP1  1�������(table lookup)
%
%   YI = INTERP1(X,Y,XI) �́A�z�� XI �̓_�Ō��ƂȂ�֐� Y �̒l YI �����߂�
%   ���߂ɕ�Ԃ��s���܂��B X �͒��� N �̃x�N�g���łȂ���΂Ȃ�܂���B
%   Y ���x�N�g���̏ꍇ�A������ N �ŁAYI �� XI�Ɠ����T�C�Y�łȂ���΂Ȃ�
%   �܂���B Y �� �T�C�Y [N,D1,D2,...,Dk] �̔z��̏ꍇ�A��Ԃ� Y(i,:,:,...,:) 
%   �� D1�~D2�~...Dk �̂��ꂼ��̒l�Ŏ��s����܂��B
%   XI ������ M �̃x�N�g���̏ꍇ�AYI �̓T�C�Y [M,D1,D2,...,Dk] �ɂȂ�܂��B
%   XI ���T�C�Y [M1,M2,...,Mj] �̔z��̏ꍇ�AYI �� [M1,M2,...,Mj,D1,D2,...,Dk] 
%   �̃T�C�Y�ɂȂ�܂��B
%
%   YI = INTERP1(Y,XI) �́AX = 1:N �Ɖ��肵�܂��B ������ N �́A�x�N�g��
%   Y �ɑ΂��� LENGTH(Y) �ŁA�z�� Y �ɑ΂��� SIZE(Y,1) �ł��B
%
%   ��Ԃ́A"table lookup" �Ɠ������Z���s���܂��B "table lookup" �̗p���
%   ��������ƁA"table" �� [X,Y] �ŁAINTERP1 �� X �� XI �̗v�f�� "looks-up"���A
%   �����̈ʒu�Ɋ�Â��� Y �̗v�f���ŕ�Ԃ��ꂽ�l YI ���o�͂��܂��B
%
%   YI = INTERP1(X,Y,XI,METHOD) �́A��Ԏ�@���w�肵�܂��B
%   �f�t�H���g�́A���`��Ԃł��B �f�t�H���g���w�肷��ɂ́A��s�� [] ��
%   �g�p���Ă��������B ���p�\�Ȏ�@�͂��̒ʂ�ł��B
%
%     'nearest'  - �ŋߖT�_�ɂ����
%     'linear'   - ���`���
%     'spline'   - �L���[�r�b�N�X�v���C����� (SPLINE)
%     'pchip'    - �`��ێ��̋敪�I�L���[�r�b�N���
%     'cubic'    - 'pchip' �Ɠ��l
%     'v5cubic'  - MATLAB 5 �̃L���[�r�b�N��ԁA����́AX �����Ԋu�łȂ�
%                  �ꍇ�͊O�}�����A 'spline'�𗘗p���܂��B
%
%   YI = INTERP1(X,Y,XI,METHOD,'extrap') �́AX �ō쐬���ꂽ��ԊO�� XI ��
%   �v�f�ɑ΂��Ďg�p����O�}�@���w�肷��̂Ɏg���܂��B
%   �܂��AYI = INTERP1(X,Y,XI,METHOD,EXTRAPVAL) �́AEXTRAPVAL ���g���āA
%   X �ō쐬���ꂽ��ԊO�̒l��u�������܂��B
%   EXTRAPVAL �ɑ΂��ẮANaN �� 0 �����΂��Ύg�p����܂��B4�̓��͈�����
%   ���f�t�H���g�̊O�}�@�́A'spline' �� 'pchip' �ɑ΂��Ă� 'extrap' �ŁA
%   ���̕��@�ɑ΂��Ă� EXTRAPVAL = NaN �ł��B
%
%   PP = INTERP1(X,Y,METHOD,'pp') �́AY �� ppform (�敪�������̌`��) ��
%   �쐬���邽�߂ɁA�w�肵����@���g�p���܂��B ��@�́A'v5cubic' �ȊO�ł�
%   ��L�̂����ꂩ�ɂȂ�܂��B PP �́A���̂Ƃ� PPVAL �Ŏ��s����܂��B 
%   PPVAL(PP,XI) �́AINTERP1(X,Y,XI,METHOD,'extrap') �Ɠ����ł��B
%
%   ���Ƃ��΁A�e�������g���쐬���A�ׂ���������œ��}���܂��B
%       x = 0:10; y = sin(x); xi = 0:.25:10;
%       yi = interp1(x,y,xi); plot(x,y,'o',xi,yi)
%
%   �������̗�Ƃ��āAfunctional values �̕\���쐬���܂��B
%       x = [1:10]'; y = [ x.^2, x.^3, x.^4 ];
%       xi = [ 1.5, 1.75; 7.5, 7.75]; yi = interp1(x,y,xi);
%
%   �́A3 �̊֐��e�X�ɂ���1���A��Ԃ����֐��l�� 2�~2 �̍s���
%   �쐬���܂��B yi �́A�T�C�Y 2�~2�~3 �ƂȂ�܂��B
%
%   ���� X, Y, XI, EXTRAPVAL �ɑ΂���N���X�T�|�[�g:
%      float: double, single
%
%   �Q�l INTERP1Q, INTERPFT, SPLINE, PCHIP, INTERP2, INTERP3, INTERPN, PPVAL.


%   Copyright 1984-2005 The MathWorks, Inc.
