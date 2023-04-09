clear all;
clc;
close all

M=100;   %ct img resolution is MxM

x_coord=linspace(-10,10,101);    %take M+1 point for matching
y_coord=linspace(-10,10,101);
[xx,yy] = meshgrid(x_coord,y_coord);

num_samp = 2000;  %total number of sample

%background(white matter) parameter
bg_eps = 0.564 + 0.564*0.15*[-1 + 2*rand(num_samp,1)]';
bg_cond = 0.253 + 0.253*0.15*[-1 + 2*rand(num_samp,1)]';  %conductivity mean 0.533*2.46 and sd 0.1 (10%)


% stroke(blood) parameter %
% stroke_rad = 0.8+0.8*0.15*[-1 + 2*rand(num_samp,1)]';  %mean 0.8 and sd 0.15 (15%) 
% stroke_eps = 0.893 + 0.893*0.1*[-1 + 2*rand(num_samp,1)]';  %permittivity between 0.1 - 1
% stroke_cond = 0.642 + 0.642*0.1*[-1 + 2*rand(num_samp,1)]';  %conductivity mean 0.533*2.46 and sd 0.1 (10%)


% big circle parameters %
centring_x = 0.5+0.5*0.15*[-1 + 2*rand(num_samp,1)]';    %mean 0.5 and sd 0.05 (5%)  [SO, pi*theta is RANGED FROM 0 TO 180 DEGREES]
centring_y = -5.5-5.5*0.15*[-1 + 2*rand(num_samp,1)]';
cir_rad = 2.8+2.8*0.15*[-1 + 2*rand(num_samp,1)]'; %mean 2.3 and sd 0.1 (10%)
cir_eps = 0.715 + 0.715*0.15*[-1 + 2*rand(num_samp,1)]';  %permittivity mean 0.715*68.4  
cir_cond = 0.533 + 0.533*0.15*[-1 + 2*rand(num_samp,1)]';  %conductivity mean 0.533*2.46 and sd 0.1 (10%)


% ellipse (left) parameters %
ellipse1_theta = -0.1*pi-0.15*0.2*pi*[-1 + 2*rand(num_samp,1)]';    %mean -0.1*pi and sd 0.1 (10%)  [SO, pi*theta is RANGED FROM 0 TO 180 DEGREES]
ellipse1_a = 1.4+1.4*0.15*[-1 + 2*rand(num_samp,1)]';    %mean 1.5 and sd 0.10 (10%) 
ellipse1_b = 3.5+3.5*0.15*[-1 + 2*rand(num_samp,1)]';
center1_x = -2.5-2.5*0.15*[-1 + 2*rand(num_samp,1)]';  %mean -2.5 and sd 0.1 (10%)
center1_y = 0.01+0.01*0.15*[-1 + 2*rand(num_samp,1)]'; %mean 0.01 and sd 0.1 (10%)
rad1 = 2.3+2.3*0.15*[-1 + 2*rand(num_samp,1)]'; %mean 0.01 and sd 0.1 (10%)
elli1_eps = 1 + 1*0.15*[-1 + 2*rand(num_samp,1)]';  %permittivity between 0.1 - 1
elli1_cond = 1 + 1*0.15*[-1 + 2*rand(num_samp,1)]';  %conductivity mean 1*2.46 and sd 0.1 (10%)


% ellipse (right) parameters %
ellipse2_theta = 0.1*pi+0.15*0.2*pi*[-1 + 2*rand(num_samp,1)]';    %mean 0.1*pi and sd 0.1 (10%)  [SO, pi*theta is RANGED FROM 0 TO 180 DEGREES]
ellipse2_a = 0.8+0.8*0.15*[-1 + 2*rand(num_samp,1)]';    %mean 1.5 and sd 0.10 (10%) 
ellipse2_b = 3+3*0.15*[-1 + 2*rand(num_samp,1)]';
center2_x = 4+4*0.15*[-1 + 2*rand(num_samp,1)]';  %mean -2.5 and sd 0.10 (10%)
center2_y = 0.01+0.01*0.15*[-1 + 2*rand(num_samp,1)]'; %mean 0.01 and sd 0.1 (10%)
rad2 = 2.3+2.3*0.15*[-1 + 2*rand(num_samp,1)]'; %mean 0.01 and sd 0.1 (10%)

% border eps
bone_eps = 0.181 + 0.181*0.15*[-1 + 2*rand(num_samp,1)]';  %permittivity mean 0.715*68.4
bone_cond = 0.0634 + 0.0634*0.15*[-1 + 2*rand(num_samp,1)]';  %conductivity mean 0.0634*2.46 and sd 0.1 (10%)


x1 = [];
y1 = [];
final_epsr = [];
final_cond = [];

final_epsr_heal = [];
final_cond_heal = [];


% for storing sinogram
start=0;
step=5;
stop=359; %179
N=60; % how many points for computing projections (=no of meas in MW imaging context)

Data_sinograms=zeros(num_samp,N,length(start:step:stop));  %store sinograms' data of each case

%%
for iter = 1:num_samp

f_x_y=zeros(M,M);   %CT image will be of M*M dimension
f_x_y_cond = zeros(M,M);
epsr_array = [];
cond_array = [];

epsr_array_heal = [];
cond_array_heal = [];

%epsr_array_bg = [];
%cond_array_bg = [];

x1 = [];
y1 = [];
    
%% for circle
xc = centring_x(iter);
yc = centring_y(iter);
for abscissa=1:M
    for ordinate=1:M
    val = ((xx(abscissa,ordinate)-xc)^2)+((yy(abscissa,ordinate)-yc)^2);
    if (val) < cir_rad
        f_x_y(abscissa,ordinate)=cir_eps(iter);
        f_x_y_cond(abscissa,ordinate) = cir_cond(iter);      
    end
    
    val1 = ((xx(abscissa,ordinate))^2)+((yy(abscissa,ordinate))^2);
    
    % for border
    if (val1>=92.5)&(val1<=99.5)            
        f_x_y(abscissa,ordinate)=bone_eps(iter);   %bone(border) permittivity
        f_x_y_cond(abscissa,ordinate) = bone_cond(iter);
        
        f_x_y_heal(abscissa,ordinate)=bone_eps(iter);   %bone(border) permittivity
        f_x_y_cond_heal(abscissa,ordinate) = bone_cond(iter);
    end

    %only for BG image
%     if (val1<93.5)            
%         f_x_y_bg(abscissa,ordinate)=bg_eps(iter);   %bone(border) permittivity
%         f_x_y_cond_bg(abscissa,ordinate) = bg_cond(iter);
%     end
    
    %get all x,y value inside radius 100
    end   
    
end


%% ellipse 1(left)
a = ellipse1_a(iter);
b = ellipse1_b(iter);   % if b>a then major axis will be y axis

alpha21 = ellipse1_theta(iter);  %in radian (angular orientation of first ellipse) 
centx1 = center1_x(iter);
centy1 = center1_y(iter);
rad = rad2(iter);

for abscissa=1:M
    for ordinate=1:M
    
    if ((((xx(abscissa,ordinate)-centx1)*cos(alpha21)+(yy(abscissa,ordinate)-centy1)*sin(alpha21))^2)/a^2....
        +(((xx(abscissa,ordinate)-centx1)*sin(alpha21)-(yy(abscissa,ordinate)-centy1)*cos(alpha21))^2)/b^2) < rad

        f_x_y(abscissa,ordinate)=elli1_eps(iter);
        f_x_y_cond(abscissa,ordinate) = elli1_cond(iter);
        
        f_x_y_heal(abscissa,ordinate)=elli1_eps(iter);
        f_x_y_cond_heal(abscissa,ordinate) = elli1_cond(iter);
    end
    end

end

%% ellipse 2(right)
a = ellipse2_a(iter);
b = ellipse2_b(iter);   % if b>a then major axis will be y axis
alpha22 = ellipse2_theta(iter);  %in radian (angular orientation of first ellipse) 
centx2 = center2_x(iter);
centy2 = center2_y(iter);
rad = rad2(iter);

for abscissa=1:M
    for ordinate=1:M
    
    if ((((xx(abscissa,ordinate)-centx2)*cos(alpha22)+(yy(abscissa,ordinate)-centy2)*sin(alpha22))^2)/a^2....
        +(((xx(abscissa,ordinate)-centx2)*sin(alpha22)-(yy(abscissa,ordinate)-centy2)*cos(alpha22))^2)/b^2) < rad
    
        f_x_y(abscissa,ordinate)=elli1_eps(iter);
        f_x_y_cond(abscissa,ordinate) = elli1_cond(iter);
    end
    
    end

end

% figure(1) 
% imshow(f_x_y)


% figure(6)
% imshow(f_x_y_bg)

%% to assign background's permittivity and conductivity
for ordinate=1:M    
    for abscissa=1:M
        val1 = ((xx(abscissa,ordinate))^2)+((yy(abscissa,ordinate))^2);
        if (val1<=99.9)   %take only circular region value into epsr_array
            if(f_x_y(abscissa,ordinate) == 0)
            f_x_y(abscissa,ordinate) = bg_eps(iter);
            f_x_y_cond(abscissa,ordinate) = bg_cond(iter);
            
            end
        end
    end
end

% figure(10)
% imshow(f_x_y)
% figure(6)
% imshow(f_x_y_bg)

for ordinate=1:2:M    %% WE CAN USE 1:3:M TO DOWNSAMPLE
    for abscissa=1:2:M
        val1 = ((xx(abscissa,ordinate))^2)+((yy(abscissa,ordinate))^2);
        if (val1<=99.9)   %take only circular region value into epsr_array
            x1(end+1) = abscissa-(M/2)-1;
            y1(end+1) = ordinate-(M/2)-1;   %to make it between [-25,25] thus origin is the middle pixel of the CT image
            epsr_array(end+1) = f_x_y(abscissa,ordinate);
            cond_array(end+1) = f_x_y_cond(abscissa,ordinate);
            
            epsr_array_heal(end+1) = f_x_y_heal(abscissa,ordinate);
            cond_array_heal(end+1) = f_x_y_cond_heal(abscissa,ordinate);
        end
    end
end


x1 = x1/(10*(M/2));     %without this 10 factor we will get between [-1,1] with 10 this 10 factor we get between [-0.1,0.1] which is our object domain range in MW
y1 = y1/(10*(M/2));      %%%to reverse it(microwave domain (x1(i)) to CT) we have to --> x1(i)*(10*(M/2)) + (M/2) to get CT domained x1

epsr_array = epsr_array * 68.4;  %highest permittivity is ... (cerebellum)  [mapped from 1 to 52.282 for mw data]
cond_array = cond_array * 2.46;     %highest conductivity is 0.25

epsr_array_bg = epsr_array_heal * 68.4;  %highest permittivity is ... (cerebellum)  [mapped from 1 to 52.282 for mw data]
cond_array_bg = cond_array_heal * 2.46;     %highest conductivity is 0.25

%assigning all 0 values to the lowest permittivity
% ind = find(epsr_array >= 0.169 & epsr_array <= 0.191 );
% epsr_array(ind) = 12.4;   %lowest permittivity Brain Bone border (what black (0 value) pixel will get) [mapped from 0 to 38.577 for mw data]
%cond_array(ind) = 0.0;     %lowest conductivity is 0


final_epsr(iter,:) = epsr_array;  %all epsr arrays storing (for comsol function)
final_cond(iter,:) = cond_array;

final_epsr_heal(iter,:) = epsr_array_heal;  %all epsr arrays storing (for comsol function)
final_cond_heal(iter,:) = cond_array_heal;


R = radon(f_x_y,start:step:stop, N);  %here 50*50 is transformed into 36(rotation)*60(projection)
Data_sinograms(iter,:,:)=R;    %here we have Radon transformed image as sinogram, we will save it for GT

%to see sinogram, ct image enable this otherwise comment out plotting
figure(1) 
imshow(f_x_y)   %CT image
% 
% figure(10) 
% imshow(f_x_y_heal)   %CT image of BG

% % % 
figure(2)
pcolor(R)
hold on
shading interp;
colorbar
colormap('Jet')
I1 = iradon(R,start:step:stop, N);    %reconstructed image
figure(3)
imshow(I1)

end

%% saving data

del = abs(x1(2)-x1(3))

savename='coord_healcases.mat';
save(savename,'x1','y1')

savename='epsr_healcases.mat';
save(savename,'final_epsr','del')

savename='cond_healcases.mat';
save(savename,'final_cond')

savename='training_set_healcases_output_CT.mat';    %CT sinogram saved
save(savename,'Data_sinograms')

savename='CT_healcases_param.mat';    %CT image parameters
save(savename,'ellipse1_a','ellipse1_b','ellipse1_theta','elli1_eps','elli1_cond','centring_x','centring_y',...
    'ellipse2_a','ellipse2_b','ellipse2_theta','cir_rad','cir_eps','cir_cond','bg_eps','bg_cond','rad1','rad2','bone_eps','bone_cond','center1_x','center1_y',...
    'center2_x','center2_x');