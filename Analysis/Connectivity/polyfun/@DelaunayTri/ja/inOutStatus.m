%    inOutStatus  2D ����t�� Delaunay ���̎O�p�`�̓�/�O�̏�Ԃ��o��
%
%    IN = inOutStatus(DT) �́A�􉽊w�I�̈�� 2D ����t�� Delaunay �O�p�`����
%    �ɂ����āA�O�p�`�̓�/�O�̏�Ԃ�Ԃ��܂��B
%    IN �́A�O�p�`�����̎O�p�`�̐��Ɠ����������̘_���z��ł��B�O�p�`������
%    ���񂳂ꂽ�G�b�W�́A�L���Ȋ􉽊w�I�̈�͈̔͂��`���܂��B
%
%    �^����ꂽ Delaunay �O�p�`�����ɂ́A�͂܂ꂽ�􉽊w�I�̈���`���鐧��
%    ���ꂽ�G�b�W�̏W��������܂��B�O�p�`�������� i �Ԗڂ̎O�p�`�́AIN(i) �� 
%    1 �Ɠ������ꍇ�͗̈�����Ƃ��āA�����łȂ��ꍇ�͎O�p�`�̊O���Ƃ��ĕ��ނ���܂��B
%
%    ����: inOutStatus �́A2D �̐���t�� Delaunay �O�p�`�����ɑ΂��Ă̂�
%          �L���ł��B����́A�ۂ���ꂽ�G�b�W�̐��񂪕����􉽊w�I�̈��
%          �͂ނ��Ƃ�\���܂��B
%
%    ��:
%            % �����`�̌����������`����Ȃ�􉽊w�I�ȗ̈���쐬���܂��B
%            outerprofile = [-5 -5; -3 -5; -1 -5; 1 -5; 3 -5; 5 -5;...
%                                 5 -3; 5 -1; 5  1; 5  3;...
%                             5  5;  3  5;  1  5; -1  5; -3  5; -5  5;...
%                                   -5  3; -5  1; -5 -1; -5 -3; ];
%            innerprofile = outerprofile.*0.5;
%            profile = [outerprofile; innerprofile];
%            outercons = [(1:19)' (2:20)'; 20 1;];
%            innercons = [(21:39)' (22:40)'; 40 21];
%            edgeconstraints = [outercons; innercons];
%            % �̈�̐���t�� Delaunay �O�p�`�������쐬���܂��B
%            dt = DelaunayTri(profile, edgeconstraints)
%            subplot(1,2,1);
%            triplot(dt);
%            hold on; 
%            plot(dt.X(outercons',1), dt.X(outercons',2), '-r', 'LineWidth', 2); 
%            plot(dt.X(innercons',1), dt.X(innercons',2), '-r', 'LineWidth', 2);
%            axis equal;
%            title(sprintf('Plot showing interior and exterior\n triangles with respect to the domain.'));
%            hold off;
%            subplot(1,2,2);
%            inside = inOutStatus(dt);
%            triplot(dt(inside, :), dt.X(:,1), dt.X(:,2));
%            hold on;
%            plot(dt.X(outercons',1), dt.X(outercons',2), '-r', 'LineWidth', 2); 
%            plot(dt.X(innercons',1), dt.X(innercons',2), '-r', 'LineWidth', 2);
%            axis equal;
%            title(sprintf('Plot showing interior triangles only\n'));
%            hold off;
