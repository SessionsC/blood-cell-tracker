% Sessions, Cullen
% Super Points
% 11/27/2017
clear all
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.


% Create a video object
obj = VideoReader('Cells-in-wells-movie-clip.avi');
cx=zeros;
cy=zeros;
i=1;
while  hasFrame(obj) %while the video has a frame do this
F=readFrame(obj); %read current frame

G = rgb2gray(F); %change the frame to a gray image for processing

I = imcrop(G, [165, 410, 170, 165]); %crop the image to one well

[~, threshold] = edge(I, 'sobel'); %identify the edges of dark objects
fudgeFactor = .4;
BWs = edge(I,'sobel', threshold * fudgeFactor); %create an outline of the edges


se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);

%thicken the edgelines
BWsdil = imdilate(BWs, [se90 se0]); 

%fill in the holes in the edges created by edgelines
BWdfill = imfill(BWsdil, 'holes');

%filter out any object smaller than 50 pixels
BWdfilter = bwareaopen(BWdfill,50);

%display frame number and identify circles on the images with a certain
%radius
disp(strcat('Frame: ' ,num2str(i)))
[centers, radii] = imfindcircles(BWdfilter,[10 18],'ObjectPolarity','bright','Sensitivity',0.9)

cspan=size(centers);
in=1;   
% split the centers in to x and y coordinate for later data analysis
    while in<=cspan(1)
    cx(i,in)=centers(in,1);
    cy(i,in)= centers(in,2);
    in=in+1;
    end
    in=1;
     % limit to four to reduce amount of erronus 0's placed 
     %from miss identifed cells that created a new column full of zeros can
     %use (cspan(1)-1) for variable amount of cells
    while in<= 4 %(cspan(1)-1)
        if i==1 %find the displacemet for the first frame
            dtx(i,in)= cx(i,in)-0;
            dty(i,in)= cy(i,in)-0;
            in = in+1;
        else   %find the displacement for every frame after the first
            dtx(i,in)= cx(i,in)-cx(i-1,in);
            dty(i,in)= cy(i,in)-cy(i-1,in);
            in = in+1;
        end
    end
subplot(2,2,[1 2])
imshow(I);%show the gray image
%place circles around the identified cells on the gray image
G = viscircles(centers,radii,'Color','r'); 
time=(-.5)+.5*(i);
title(strcat('Incircled blood cells, time: ' ,num2str(time), 'secs'));

%create a histogram for the displacement in the x axis
subplot(2,2,3)
histogram(dtx,'Normalization','pdf')
title('x Displacement from previous frame')
xlabel('Displacement in pixels')
ylabel('frequency of occurence')

%create a histogram for the displacement in the y axis
subplot(2,2,4)
histogram(dty,'Normalization','pdf')
title('y Displacement from previous frame')
xlabel('Displacement in pixels')
ylabel('frequency of occurence')

i=i+1;
end
disp('end of superpoints')
