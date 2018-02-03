 function []=uni_3D()

INT = 1;
ASK = 1;
if ASK == 1

        prompt = {'Number of particles',...
            'Cell length (in \mum)',...
            'R (in \mum)',...
          'Loc err (in \mum)',}; 
        u_name = 'Input Parameters ';
        numlines = 1;
        defaultanswer = {'5000','3.5','0.412','0.055'};                                                                                                                                                                                                                                                                                                                                                                                  
        options.Resize = 'on';
        options.WindowStyle = 'normal';
        options.Interpreter = 'tex';
        user_var = inputdlg(prompt,u_name,numlines,defaultanswer,options);
end

N =str2double(user_var{1});
Loc_err = str2double(user_var{4});
length =str2double(user_var{2}); 
R =str2double(user_var{3});
Cyl_len = (length - 2*R)/2; %Half of cylinder length; 
for ii = 1:2
num_particle = 1;
X=nan(1,N); 
Y=nan(1,N); 
Z=nan(1,N);
X_final = [];
Y_final = [];
Z_final = [];


 while num_particle <=N
x_start = [];
y_start = [];
z_start = [];
start = [];
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
       
    elseif abs(x_start)>Cyl_len &&abs(x_start)<=Cyl_len+R&& +(abs(x_start)-Cyl_len)^2+(y_start)^2+(z_start)^2 <(R^2)
        X(num_particle)= x_start;
        Y(num_particle)=y_start;
        Z(num_particle)=z_start;
        num_particle = num_particle+1;
    
    end     
    
     % Add localization errors
       X_final(1,1:N) =X(1,1:N)+randn(1,N)*Loc_err;
       Y_final(1,1:N) =Y(1,1:N)+randn(1,N)*Loc_err;
       Z_final(1,1:N)=Z(1,1:N)+randn(1,N)*Loc_err;

 end 
X_final = (X_final/length);
Y_final =(Y_final/(2*R));
hold on


if ii == 1
     assignin('base','x_green',X_final')
     assignin('base','y_green',Y_final')
     
elseif ii ==2
     assignin('base','x_red',X_final')
     assignin('base','y_red',Y_final')
end  
end    


 end


