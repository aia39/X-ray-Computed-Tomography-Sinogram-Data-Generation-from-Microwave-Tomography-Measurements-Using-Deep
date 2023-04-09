clear all
clc
close all

N_train=1600;
proj_var = 60;   %120
rot_var = 72;    %180

total_psnr = 0;
total_rmse = 0;
total_ssim = 0;

total_psnr_filt = 0;
total_rmse_filt = 0;
total_ssim_filt = 0;

total_psnr_img = 0;
total_rmse_img = 0;
total_ssim_img = 0;

total_psnr_img_filt = 0;
total_rmse_img_filt = 0;
total_ssim_img_filt = 0;

%% healthy samples
load Dataset_1Case_OnlyHealthy_1G_MatrixCumulativeComplexfield MatrixCumulative
Ez_s_75_heal = MatrixCumulative;
real_Ez_s_75=real(Ez_s_75_heal((N_train+1):length(MatrixCumulative),:));
imag_Ez_s_75=imag(Ez_s_75_heal((N_train+1):length(MatrixCumulative),:));
total_Ez_s_75=[real_Ez_s_75 imag_Ez_s_75];
%adding noise to MW data
S = RandStream('mt19937ar','Seed',5489);
total_Ez_s_75_noise_heal = awgn(total_Ez_s_75,20,'measured',S);

load training_set_healcases_output_CT Data_sinograms    %larger
data_sino_heal = Data_sinograms;

data_sinograms_all = Data_sinograms((N_train+1):length(MatrixCumulative),:,:);
%data_sinograms_all = [data_sino_heal];   %
total_Ez_s_75_all = [total_Ez_s_75_noise_heal];

%for normalization
%total_Ez_s_75_all = total_Ez_s_75_all/max(abs(total_Ez_s_75_all(:)));
%total_Ez_s_75_all = normalize(total_Ez_s_75_all);
%total_Ez_s_75_all = (total_Ez_s_75_all - mean(total_Ez_s_75_all(:)))/std(total_Ez_s_75_all(:));


%total_Ez_s_75_all = (total_Ez_s_75_all - mean(total_Ez_s_75_all(:)))/std(total_Ez_s_75_all(:));
%total_Ez_s_75_all = total_Ez_s_75_all - min(total_Ez_s_75_all);

test_inputs = total_Ez_s_75_all;   %1-1000 healthy, 1001-2000 unhealthy


for iter = 1:400
%% Actual sinogram
actual= zeros(proj_var,rot_var);
sample = iter   %enter 1-400
tic
for proj=1:proj_var
    for rot=1:rot_var
        actual(proj,rot)=data_sinograms_all(sample,proj,rot);
    end
end


%% Model Inference
R = zeros(proj_var,rot_var);

%%  %%%%
% if(sample<1001)
% %for healthy sample (when prev sample >700 and <1000)
% sample = sample-700;
% else
% %for unhealthy sample (when prev sample >1700)
% sample = sample-1400;
% end
%%  %%%%

for proj=1:proj_var
    for rot=1:rot_var
        F_name=['Neu_net_proj',num2str(proj),'_rot',num2str(rot),'.mat']; 
        %load(['G:\Thesis Work\Codes_To_Hasnine_Akib_Tasrif\fitnet_all_weights_mixed\' F_name]);  %all_weights_mixed_normalized
        %load(['G:\Thesis Work\Codes_To_Hasnine_Akib_Tasrif\all_weights_mixed_normalized\' F_name]);
        load(['G:\Thesis Work\MWtoCTpaper\only healthy\casecadfwdnet_scg\' F_name]); %feedfwdnet_lesslayers
        Estimated = net(test_inputs'); %we need to contruct R
        R(proj,rot) = Estimated(sample);
        %actual=testing_target_actual;
    end
end
time = toc;

fprintf('Total elapsed time:%.3f\n', time)

J = medfilt2(R);


%% Inverse radon tranform for constructing CT image
start=0;
step=5;  %10
stop=359; %179
N = 60;  %60
I1 = iradon(R,start:step:stop, N);
I_act = iradon(actual,start:step:stop, N);
%Perform unfiltered backprojection.
%FI2 = iradon(R,start:step:stop, N, 'linear','none');

I2 = iradon(J,start:step:stop, N);


%%
vdsrSSIM = ssim(R,actual);
vdsrPSNR = psnr(R,actual);
vdsrRMSE = immse(R,actual);


total_ssim = total_ssim + vdsrSSIM;
total_psnr = total_psnr + vdsrPSNR;
total_rmse = total_rmse + vdsrRMSE;

%after filtering
vdsrSSIM = ssim(J,actual);
vdsrPSNR = psnr(J,actual);
vdsrRMSE = immse(J,actual);


total_ssim_filt = total_ssim_filt + vdsrSSIM;
total_psnr_filt = total_psnr_filt + vdsrPSNR;
total_rmse_filt = total_rmse_filt + vdsrRMSE;

%on image
vdsrSSIM = ssim(I1,I_act);
vdsrPSNR = psnr(I1,I_act);
vdsrRMSE = immse(I1,I_act);


total_ssim_img = total_ssim_img + vdsrSSIM;
total_psnr_img = total_psnr_img + vdsrPSNR;
total_rmse_img = total_rmse_img + vdsrRMSE;


%on filtered image
vdsrSSIM = ssim(I2,I_act);
vdsrPSNR = psnr(I2,I_act);
vdsrRMSE = immse(I2,I_act);


total_ssim_img_filt = total_ssim_img_filt + vdsrSSIM;
total_psnr_img_filt = total_psnr_img_filt + vdsrPSNR;
total_rmse_img_filt = total_rmse_img_filt + vdsrRMSE;


% figure(7)
error = abs(I_act-I2);
% imshow(error)

% figure(8)
error_sin = abs(actual-J);
% imshow(error_sin)

end

fprintf('Sinogram error... ');
total_ssim/400
total_rmse/400
total_psnr/400

fprintf('Sinogram error after filtering... ');
total_ssim_filt/400
total_psnr_filt/400
total_rmse_filt/400

fprintf('Estimated image error... ');
total_ssim_img/400
total_psnr_img/400 
total_rmse_img/400 

fprintf('Estimated image error after filtering sinogram... ');
total_ssim_img_filt/400
total_psnr_img_filt/400
total_rmse_img_filt/400