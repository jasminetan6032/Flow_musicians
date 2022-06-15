classdef PPT2007
    %Matlab class creating PowerPoint 2007 Presentations
    % Always make sure to have opened PowerPoint before using this class.
    % 
    % Example:
    % ppt = PPT2007(); %create a powerpoint presentation
    % ppt = ppt.addTitleSlide('10 Plots of Random Data'); %adds a title slide
    %
    % for i = 1:10
    %   a = rand(1,10); %a is some data
    %   f = figure; %create a figure
    %   plot(a); %plot your data
    %   xlabel('Some x axis label'); %apply some formatting and decoration
    %   ylabel('Some y axis label');
    %   image_file_name = fullfile(pwd, ['image_' num2str(i) '.png']); 
    %   saveas(f, image_file_name); %save the figure
    %   close(f);
    %   %add the figure to the powerpoint
    %   ppt = ppt.addImageSlide(['Figure ' num2str(i)], image_file_name);
    % end
    % ppt.saveAs(fullfile(pwd,'presentation.ppt')); %save the presentation.
    % 
    
    
    
    % Created by Alan Meeson. 
    % Edited: 3rd December 2010 - AM
    % Edited: 18/11/2011 - supressed irrelevent warnings re: unused variables. - AM
    % Edited: 05/12/2011 - added function to make ppt visible if powerpoint
    %       wasn't open to start with - AM, with thanks to Yang Zhang.
    
    %layout types:
    % 1 - title
    % 2 - title and content
    % 3 - section header
    % 4 - Two Content
    % 5 - Comparison
    % 6 - Title only
    % 7 - blank
    % 8 - content with caption
    % 9 - picture with caption
    % 10 -title and vertical text
    % 11 - vertical title and text
    
    properties
        app_handle
        presentation
        pt = 0.0352; %point size in cm.
        newline = char(13); %the new line character.
    end
    
    methods
        function obj = PPT2007()
            %creates a new presentation. 
            obj.app_handle = actxserver('PowerPoint.Application'); %open powerpoint
            obj.presentation = obj.app_handle.Presentation.Add; %create presentation
        end
        
        function obj = show(obj)
            %show Makes the presentation visible if you did not have
            %powerpoint open.
            % Thanks for this one go to Yang.
            set(obj.app_handle,'Visible','msoTrue');
        end
        
        function obj = addTitleSlide(obj, title_text, sub_title_text)
            %creates a title slide
            %   ppt = ppt.addTitleSlide(title_text, sub_title_text)
            %       title_text - the text to put in the title section.
            %       sub_title_text - the text to put in the sub title
            %       section.
            %
            % If you need to use a line break (start a new line) use the
            % ppt.newline field of this object. (aka char(13)).
            
            %create slide
            layout = obj.presentation.SlideMaster.CustomLayouts.Item(1); %title slide layout
            Slide = obj.presentation.Slides.AddSlide(obj.presentation.Slides.Count + 1,layout);
            
            %do title
            if exist('title_text', 'var') && ~isempty(title_text)
                Slide.Shapes.Item(1).TextFrame.TextRange.Text = title_text;
            end
            
            %do sub-title
            if exist('sub_title_text', 'var') && ~isempty(sub_title_text)
                Slide.Shapes.Item(2).TextFrame.TextRange.Text = sub_title_text;
            end
        end
        
        function obj = addSectionSlide(obj, title_text, main_text)
            %creates a section title slide
            %   ppt = ppt.addTitleSlide(title_text, main_text)
            %       title_text - the text to put in the title section.
            %       main_text - the text to put in the sub title
            %       section.
            %
            % If you need to use a line break (start a new line) use the
            % ppt.newline field of this object. (aka char(13)).
            
            %create slide
            layout = obj.presentation.SlideMaster.CustomLayouts.Item(3); %section header
            Slide = obj.presentation.Slides.AddSlide(obj.presentation.Slides.Count + 1,layout);
            
            %do title
            if exist('title_text', 'var') && ~isempty(title_text)
                tb = Slide.Shapes.Item(1);
                tb.TextFrame.TextRange.Text = title_text;
            end
            
            %do footer
            if exist('main_text', 'var') && ~isempty(main_text)
                tb2 = Slide.Shapes.Item(2);
                tb2.TextFrame.TextRange.Text = main_text;
            end
        end
        
%         function obj = addImageOnlySlide(obj, title_text, image_file)
%             %addImageOnlySlide - synonymous with addImageSlide. 
%             %   This function is deprecated, and only included to avoid
%             %   breaking some of my old scripts. I may remove it in future versions.
%             %   Use addImageSlide instead.
%             
%             obj = obj.addImageSlide(title_text, image_file);
%         end
        
        function obj = addImageSlide(obj, title_text, image_file)
            %creates a slide consisting of only a title and an image
            %   ppt = ppt.addImageOnlySlide(title_text, image_file)
            %       title_text - the text to put in the title section.
            %       image_file - the filename and path of the image to use
            
            %create slide
            layout = obj.presentation.SlideMaster.CustomLayouts.Item(2); %title and content
            Slide = obj.presentation.Slides.AddSlide(obj.presentation.Slides.Count + 1,layout);
            
            %do image
            if exist('image_file', 'var') && ~isempty(image_file)
                li = Slide.Shapes.Item(2);
                Image1 = Slide.Shapes.AddPicture(image_file,'msoFalse','msoTrue',li.left, li.top, li.width, li.height); %#ok<NASGU>
            end
            
            %do title
            if exist('title_text', 'var') && ~isempty(title_text)
                Slide.Shapes.Item(1).TextFrame.TextRange.Text = title_text;
            end
        end
        
%         function obj = addSlide(obj, title_text, image_file, caption_text)
%             %addSlide - synonymous with addCaptionedPictureSlide.
%             %   This function is deprecated, and only included to avoid
%             %   breaking some of my old scripts. I may remove it in future versions.
%             %   Use addCaptionedPictureSlide instead.
%             obj = obj.addCaptionedPictureSlide(obj, title_text, image_file, caption_text);
%         end
        
        function obj = addCaptionedPictureSlide(obj, title_text, image_file, footer_text)
            %creates a slide of title, image, and caption
            %   ppt = ppt.addTitleSlide(title_text, image_file, footer_text)
            %       title_text - the text to put in the title section.
            %       image_file - the filename and path of the image to use.
            %       footer_text - the text to put in the footer.
            %
            % If you need to use a line break (start a new line) use the
            % ppt.newline field of this object. (aka char(13)).
            
            %create slide
            layout = obj.presentation.SlideMaster.CustomLayouts.Item(9); %Picture with Caption
            Slide = obj.presentation.Slides.AddSlide(obj.presentation.Slides.Count + 1,layout);
            
            %do title
            if exist('title_text', 'var') && ~isempty(title_text)
                Slide.Shapes.Item(1).TextFrame.TextRange.Text = title_text;
            end
            
            %do image
            if exist('image_file', 'var') && ~isempty(image_file)
                li = Slide.Shapes.Item(2);
                Image1 = Slide.Shapes.AddPicture(image_file,'msoFalse','msoTrue',li.left, li.top, li.width, li.height); %#ok<NASGU>
            end
            
            %do footer
            if exist('footer_text', 'var') && ~isempty(footer_text)
                Slide.Shapes.Item(3).TextFrame.TextRange.Text = footer_text;
            end
        end
        
        function obj = addTwoImageSlide(obj, title_text, left_image, right_image)
            %creates a slide of title and two images
            %   ppt = ppt.addTitleSlide(title_text, left_image, right_image)
            %       title_text - the text to put in the title section.
            %       left_image - the filename and path of the left image to use.
            %       right_image - the filename and path of the right image to use.
            %
            % If you need to use a line break (start a new line) use the
            % ppt.newline field of this object. (aka char(13)).
            
            %create slide
            layout = obj.presentation.SlideMaster.CustomLayouts.Item(4); %Two Content
            Slide = obj.presentation.Slides.AddSlide(obj.presentation.Slides.Count + 1,layout);
           
            %do title
            if exist('title_text', 'var') && ~isempty(title_text)
                Slide.Shapes.Item(1).TextFrame.TextRange.Text = title_text;
            end
            
            %do images
            if exist('left_image', 'var') && ~isempty(left_image)
                li = Slide.Shapes.Item(2);
                Image1 = Slide.Shapes.AddPicture(left_image,'msoFalse','msoTrue',li.left, li.top, li.width, li.height); %#ok<NASGU>
            else
                Slide.Shapes.Item(2).TextFrame.TextRange.Text = ' ';
            end
            if exist('right_image', 'var') && ~isempty(right_image)
                li = Slide.Shapes.Item(3);
                Image1 = Slide.Shapes.AddPicture(right_image,'msoFalse','msoTrue',li.left, li.top, li.width, li.height); %#ok<NASGU>
            end
        end
        
        function obj = addTwoImageComparisonSlide(obj, title_text, left_image, right_image, left_text, right_text)
            %creates a slide of title, two images and captions for each image
            %   ppt = ppt.addTwoImageComparisonSlide(title_text, left_image, right_image, left_text, right_text)
            %       title_text - the text to put in the title section.
            %       left_image - the filename and path of the left image to use.
            %       right_image - the filename and path of the right image to use.
            %       left_text - text for the left image.
            %       right_text - text for the right image.
            %
            % If you need to use a line break (start a new line) use the
            % ppt.newline field of this object. (aka char(13)).
            
            %create slide
            layout = obj.presentation.SlideMaster.CustomLayouts.Item(5); %Comparison
            Slide = obj.presentation.Slides.AddSlide(obj.presentation.Slides.Count + 1,layout);
           
            %do title
            if exist('title_text', 'var') && ~isempty(title_text)
                Slide.Shapes.Item(1).TextFrame.TextRange.Text = title_text;
            end
            
            %do images
            if exist('left_image', 'var') && ~isempty(left_image)
                li = Slide.Shapes.Item(3);
                Image1 = Slide.Shapes.AddPicture(left_image,'msoFalse','msoTrue',li.left, li.top, li.width, li.height); %#ok<NASGU>
            end
            if exist('right_image', 'var') && ~isempty(right_image)
                li = Slide.Shapes.Item(5);
                Image1 = Slide.Shapes.AddPicture(right_image,'msoFalse','msoTrue',li.left, li.top, li.width, li.height); %#ok<NASGU>
            end
            
            %do text
            if exist('left_text', 'var') && ~isempty(left_text)
                Slide.Shapes.Item(2).TextFrame.TextRange.Text = left_text;
            end
            if exist('right_text', 'var') && ~isempty(right_text)
                Slide.Shapes.Item(4).TextFrame.TextRange.Text = right_text;
            end
        end
        
        function obj = addTwoImagePlusFooterSlide(obj, title_text, left_image, right_image, footer_text)
            %creates a slide of title, two images and a footer
            %   ppt = ppt.addTwoImagePlusFooterSlide(title_text, left_image, right_image, footer_text)
            %       title_text - the text to put in the title section.
            %       left_image - the filename and path of the left image to use.
            %       right_image - the filename and path of the right image to use.
            %       footer_text - the text to put in the footer.
            %
            % If you need to use a line break (start a new line) use the
            % ppt.newline field of this object. (aka char(13)).
            
            %create slide
            layout = obj.presentation.SlideMaster.CustomLayouts.Item(4); %Two Content
            Slide = obj.presentation.Slides.AddSlide(obj.presentation.Slides.Count + 1,layout);
           
            %do title
            if exist('title_text', 'var') && ~isempty(title_text)
                Slide.Shapes.Item(1).TextFrame.TextRange.Text = title_text;
            end
            
            %do images
            if exist('left_image', 'var') && ~isempty(left_image)
                li = Slide.Shapes.Item(2);
                Image1 = Slide.Shapes.AddPicture(left_image,'msoFalse','msoTrue',li.left, li.top, li.width, li.height * 0.7); %#ok<NASGU>
            end
            if exist('right_image', 'var') && ~isempty(right_image)
                li = Slide.Shapes.Item(3);
                Image1 = Slide.Shapes.AddPicture(right_image,'msoFalse','msoTrue',li.left, li.top, li.width, li.height * 0.7); %#ok<NASGU>
            end
            
            %do footer
            if exist('footer_text', 'var') && ~isempty(footer_text)
                li1 = Slide.Shapes.Item(2);
                li2 = Slide.Shapes.Item(3);
                tb = Slide.Shapes.AddTextbox('msoTextOrientationHorizontal', li1.left, li1.top + li1.height, li1.width + li2.width, (li1.height / 0.7) * 0.3);
                tb.TextFrame.TextRange.Text = footer_text;
            end
            
        end
        
        function obj = saveAs(obj, filename)
            %saves the presentation to the specified file
            obj.presentation.SaveAs(filename);
        end
        
        function obj = close(obj, noQuit)
            %closes the presentation. 
            %   close(noQuit)
            %       noQuit - if false function will attempt 
            %       to close powerpoint if no presentations remain open.
            
            if ~exist('noQuit', 'var') || (exist('noQuit', 'var') && isempty(noQuit))
                noQuit = true;
            end
                
            obj.presentation.Close;
            if ~noQuit && obj.app_handle.Presentations.Count <= 0
                obj.app_handle.Quit;
            end
            obj.app_handle.delete;
        end
    end
    
end

%Notes:
% Page size can be found using obj.presentation.PageSetup.SlideHeight ,etc.

