  %This code is used to generate 2D localization probability density maps of 
%red and green molecules using their localizations. The pixel size of the density maps 
% is chosen by the user. The names of the final mat files can be chosen by
% the user
function []=pixelate_image(x_red, y_red, x_green, y_green,l,r,px)
%% Input parameters
INT = 1;
ASK = 1;
if ASK == 1

        prompt = {
           'Name of pixelated image of green molecules',...
           'Name of pixelated image of red molecules',...
           }; 
        u_name = 'Input parameters';
        numlines = 1;
        defaultanswer = {'green_mat','red_mat'};
        options.Resize = 'on';
        options.WindowStyle = 'normal';
        options.Interpreter = 'tex';
        user_var = inputdlg(prompt,u_name,numlines,defaultanswer,options);
end



% Pixel position of x and y localizations
x_green = (x_green*1000*l/px) + ((1000*l)/px) +1;
y_green = (y_green*1000*2*r/px) + ((1000*2*r)/px)+1;
x_red = (x_red*1000*l/px) + ((1000*l)/px)+1 ;
y_red = (y_red*1000*2*r/px) + ((1000*2*r)/px)+1;

allx_green = round(x_green,0);
ally_green = round(y_green,0); 
allx_red = round(x_red,0);
ally_red = round(y_red,0);


green = zeros(round((2*1000*2*r/px),0)+1, round((2*1000*l/px),0)+1); %% want to ensure same size of images through out
red = zeros(round((2*1000*2*r/px),0)+1, round((2*1000*l/px),0)+1);

%Molecules with same pixel positions are added up to give the total
%molecule count of the pixel
for xx =1: size(ally_green, 2)
green(ally_green(xx),allx_green(xx)) =green(ally_green(xx),allx_green(xx))+1;

end
for xxx =1: size(ally_red, 2)
red(ally_red(xxx),allx_red(xxx)) = red(ally_red(xxx),allx_red(xxx))+1;

end
% Plotting pixelated images
figure(12);
colormap('jet')
imagesc(green); axis image
figure(11);
colormap('jet')
imagesc(red); axis image

assignin('base',(user_var{1}),green)
assignin('base',(user_var{2}),red)
