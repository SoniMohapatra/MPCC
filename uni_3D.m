%The code generates a random 3D distribution in a speherocylinder of chosen 
%length and radius. The localization error for the red and green molecules
%can be chosen as well. The user can chose whether or not to convert the x
%and y localizations into 2D heat maps
function []=uni_3D()

INT = 1;
%  sptint = 0;
ASK = 1;
if ASK == 1

        prompt = {'Number of red particles',...
            'Number of green particles',...
            'Cell length (in \mum)',...
            'R (in \mum)',...
            'Loc err for red molecules(in \mum)'...
          'Loc err for green molecules(in \mum)',}; 
        u_name = 'Input Parameters ';
        numlines = 1;
        defaultanswer = {'100000','100000','3.5','0.412','0.05','0.05'};                                                                                                                                                                                                                                                                                                                                                                                  
        options.Resize = 'on';
        options.WindowStyle = 'normal';
        options.Interpreter = 'tex';
        user_var = inputdlg(prompt,u_name,numlines,defaultanswer,options);
end

N1 =str2double(user_var{1});%Number of red molecules
N2 =str2double(user_var{2});%Number of green molecules

Loc_err_red = str2double(user_var{5});%Localization error for red molecules
Loc_err_green = str2double(user_var{6});%Localization error for green molecules

length =str2double(user_var{3}); %Tip to tip cell length
R =str2double(user_var{4});%Cell radius
Cyl_len = (length - 2*R)/2; %Half of cylinder length; 
for ii = 1:2
    num_particle = 1;
    if ii == 1
        N = N1;
    else
        N = N2;
    end
X=nan(1,N); 
Y=nan(1,N); 
Z=nan(1,N);
X_final=nan(1,N); 
Y_final=nan(1,N); 
Z_final=nan(1,N);
 while num_particle <=N
    start=2*(rand(1,3)-0.5);
    x_start = (Cyl_len+R)*2*start(1);
    y_start = R*2*start(2);
    z_start = R*2*start(3);
    
    % Checking each molecule lies within the spherocylinder
    if abs(x_start)<=Cyl_len && (y_start)^2+(z_start)^2 <(R^2)
        X(num_particle)= x_start;
        Y(num_particle)=y_start;
        Z(num_particle)=z_start;
        num_particle = num_particle+1;
       
    elseif abs(x_start)>=Cyl_len &&abs(x_start)<Cyl_len+R&& +(abs(x_start)-Cyl_len)^2+(y_start)^2+(z_start)^2 <(R^2)
        X(num_particle)= x_start;
        Y(num_particle)=y_start;
        Z(num_particle)=z_start;
        num_particle = num_particle+1;
    
    end     
    

     
 end 
 if ii == 1
      % Adding localization errors
     for kk = 1:N
     X_final(1,kk) =X(1,kk)+randn(1,1)*Loc_err_red;
       Y_final(1,kk) =Y(1,kk)+randn(1,1)*Loc_err_red;
       Z_final(1,kk)=Z(1,kk)+randn(1,1)*Loc_err_red; 
     end
     % Normalizing the x and y localizations wrt. to cell length and radius
     % respectively
        x_uni_red = X_final/length;
      y_uni_red = Y_final/(2*R);
      
 else
      % Adding localization errors
  for kk = 1:N
     X_final(1,kk) =X(1,kk)+randn(1,1)*Loc_err_green;
       Y_final(1,kk) =Y(1,kk)+randn(1,1)*Loc_err_green;
       Z_final(1,kk)=Z(1,kk)+randn(1,1)*Loc_err_green; 
  end
      % Normalizing the x and y localizations wrt. to cell length and radius
     % respectively
        x_uni_green = X_final/length;
      y_uni_green = Y_final/(2*R);
     
 end

end
% Would you like a 2D heat map
choice = questdlg('Would you like a 2D localization probability density map', ...
	'Pixelate image matrix', ...
	'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
       INT = 2;
ASK = 2;
if ASK == 2

        prompt = {'Choice of pixel size (nm)'}; 
        u_name = 'Input Parameters ';
        numlines = 1;
        defaultanswer = {'50'};                                                                                                                                                                                                                                                                                                                                                                                  
        options.Resize = 'on';
        options.WindowStyle = 'normal';
        options.Interpreter = 'tex';
        user_var = inputdlg(prompt,u_name,numlines,defaultanswer,options);
end

px =str2double(user_var{1}); 
pixelate_image(x_uni_red, y_uni_red, x_uni_green, y_uni_green,length,R,px)
    case 'No'
       assignin('base','x_uni_green',x_uni_green)
     assignin('base','y_uni_green',y_uni_green)
     assignin('base','x_uni_red',x_uni_red)
     assignin('base','y_uni_red',y_uni_red)
end

end


