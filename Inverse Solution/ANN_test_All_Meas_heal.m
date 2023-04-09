clear all
close all
clc

% Meas_no=4:10;
proj_var=60;  %120
rot_var=72;   %180

N_train=1600;

%% healthy samples
load Dataset_1Case_OnlyHealthy_1G_MatrixCumulativeComplexfield MatrixCumulative
Ez_s_75_heal = MatrixCumulative;
real_Ez_s_75=real(Ez_s_75_heal(1:N_train,:));
imag_Ez_s_75=imag(Ez_s_75_heal(1:N_train,:));
total_Ez_s_75=[real_Ez_s_75 imag_Ez_s_75];
%adding noise to MW data
S = RandStream('mt19937ar','Seed',5489);
total_Ez_s_75_noise_heal = awgn(total_Ez_s_75,20,'measured',S);

load training_set_healcases_output_CT Data_sinograms    %larger
data_sino_heal = Data_sinograms;

data_sinograms_all = [data_sino_heal];   %
total_Ez_s_75_all = [total_Ez_s_75_noise_heal];

%for normalization
%[total_Ez_s_75_all, PS] = mapminmax(total_Ez_s_75_all,-1,1);
%total_Ez_s_75_all = total_Ez_s_75_all/max(abs(total_Ez_s_75_all(:)));
%total_Ez_s_75_all = normalize(total_Ez_s_75_all);
%total_Ez_s_75_all = (total_Ez_s_75_all - mean(total_Ez_s_75_all(:)))/std(total_Ez_s_75_all(:));
%total_Ez_s_75_all = total_Ez_s_75_all - min(total_Ez_s_75_all);



for vvv=40:proj_var
    start = 33;
%     if(vvv == 41)
%         start = 30;
%     end
    
    for yyy=start:rot_var
        training_target_heal = data_sinograms_all(1:N_train,vvv,yyy);  %(700*1)
        training_target_all = [training_target_heal];
        inputs=(total_Ez_s_75_all)';   %same input 700*132 for all combinations
        targets=(training_target_all)';  %epsr_all;  %target changes depending on V,Y
        
        %net = feedforwardnet([20 30 40 30 20 ],'trainbr');  %60 40 20 10   
        net = feedforwardnet([20 30 40 30 20]);
        %net = feedforwardnet([64,32,16]);
        %net = fitnet([20 30 40 30 20]);
        %%see it for better fitting operation: https://fr.mathworks.com/help/deeplearning/ref/fitnet.html
        % %net.trainParam.min_grad=1e-10;
        % % net.trainFcn = 'trainbr';
        net.trainParam.epochs=1000;
        %net.trainParam.miniBatchSize = 64;
        net.output.processFcns = {'mapminmax'};
        net.input.processFcns = {'mapminmax'};
        
        net.divideParam.trainRatio = 70/100;
        net.divideParam.valRatio = 30/100;
        net.divideParam.testRatio = 0/100;
        
%         net.layers{1}.transferFcn = 'poslin';
%         net.layers{2}.transferFcn = 'poslin';
%         net.layers{3}.transferFcn = 'poslin';
%         net.layers{4}.transferFcn = 'poslin';
%         net.layers{5}.transferFcn = 'poslin';
        %net.layers{6}.transferFcn = 'poslin';
        
        V=num2str(vvv)
        Y=num2str(yyy)
        
        [net,tr]=train(net,inputs,targets,'useGPU','yes');

        F_name=['Neu_net_proj',num2str(V),'_rot',num2str(Y)];
      
        save(['G:\Thesis Work\MWtoCTpaper\only healthy\feedfwdnet\' F_name],'net','tr');
        
    end
end

% [c,cm] = confusion(testtarget,Netoutput);
% fprintf('Percentage Correct Classification : %f%%\n', 100*(1-c));
% fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
% fprintf('Number of correctly identified images out of 80 :%i \n', sum(diag(cm)));
