%This code calculates MPCC for 2 images. The inputs are 4 pixelated image
%matrices; image matrix for red molecules,image matrix for green molecules,
%uniform matrix corresponding to red molecules,and uniform matrix corresponding 
%to green molecules, 
function []=MPCC()
%% Input parameters
INT = 1;
ASK = 1;
if ASK == 1

        prompt = {'Image matrix for red molecules',...
           'Image matrix for green molecules',...
           'Uniform image matrix corresponding to red molecules',...
           'Uniform image matrix corresponding to green molecules'}; 
        u_name = 'Input parameters';
        numlines = 1;
        defaultanswer = {'red_mat','green_mat','uni_red_mat','uni_green_mat'};
        options.Resize = 'on';
        options.WindowStyle = 'normal';
        options.Interpreter = 'tex';
        user_var = inputdlg(prompt,u_name,numlines,defaultanswer,options);
end

red_mat=evalin('base',(user_var{1}));%x localizations of green molecules
green_mat=evalin('base',(user_var{2}));%y localizations of green molecules
uni_red_mat=evalin('base',(user_var{3}));%x localizations of red molecules
uni_green_mat=evalin('base',(user_var{4}));%y localizations of red molecules


%Normalizing reference matrices to have same number of molecules as imaged
%in red and green channels

norm_uni_green_mat = (uni_green_mat/sum(sum(uni_green_mat)))*sum(sum(green_mat));
norm_uni_red_mat = (uni_red_mat/sum(sum(uni_red_mat)))*sum(sum(red_mat));

%Difference matrices
delta_green = (green_mat - norm_uni_green_mat);
delta_red = (red_mat - norm_uni_red_mat);

%Normalizing difference matrices so that the sum of elements in the
%difference matrices is 1

delta_green_norm = sum(sum(delta_green.*delta_green));
delta_red_norm = sum(sum(delta_red.*delta_red));


delta_green_hat = delta_green./sqrt(delta_green_norm);
delta_red_hat = delta_red./sqrt(delta_red_norm);

green_mat_r = reshape(delta_green_hat,numel(delta_green_hat),1);
red_mat_r = reshape(delta_red_hat,numel(delta_red_hat),1);
%Calculating MPCC
MPCC = sum(sum(delta_green_hat.*delta_red_hat))
ff = num2str(MPCC,'%.3f')
scatter(green_mat_r, red_mat_r)
legend(strcat('MPCC = ', num2str(MPCC,' %.3f')))
assignin('base','green_mat_r',green_mat_r)
assignin('base','red_mat_r',red_mat_r)
assignin('base','MPCC',MPCC)


title('Scatter plot of \it{\Delta^G_{ij}} vs. \it{\Delta^R_{ij}}')
xlabel('\it{\Delta^G_{ij}}') % x-axis label
ylabel('\it{\Delta^R_{ij}}') % y-axis label