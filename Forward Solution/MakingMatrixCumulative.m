clear all;clc;close all;


tic
% % % % % % % % arrayProbes=[ 26 24 21 15 8 6 3 5 7 12 20 23];

arrayProbes=[ 22 20 18 14 8 6 3 5 7 11 17 19];
% % % % % % % % arrayProbes=gpuArray([22 20 18 14 8 6 3 5 7 11 17 19]);

II=length(arrayProbes)

NoOfProbes=12;
MatrixAnomalyOnePosition=zeros(NoOfProbes,NoOfProbes);
% % % % % % % % % % % MatrixCumulative=zeros(II*(NoOfProbes-1),JJ);
% % % MatrixCumulative=zeros(II*(NoOfProbes-1),1);


k=1;
jj=1;
Matrixx=[];
% % MatrixCumulative=gpuArray(Matrixx)
MatrixCumulative=[];
load('epsr_samples_unheal.mat')

for jj=1:size(final_epsr,1)
    for ii=1:II
        
         T = readtable(['dataUnhealthy_' num2str(jj) '_' num2str(ii) '.csv']);
        Matrix=[ T.emw_Ez_V_m__Freq_0_5];
        MatrixAnomalyOnePosition(:,ii)=Matrix;
        
        k=k+1
        
    end 
    
     MatrixAnomalyOnePosition
    
    MatrixAnomalyOnePosition=tril(MatrixAnomalyOnePosition,-1)
    vectorOnePosition = nonzeros(MatrixAnomalyOnePosition)
% % %      MatrixCumulative=[MatrixCumulative ; vectorOnePosition']
         MatrixCumulative=[MatrixCumulative ; conj(vectorOnePosition')] %%%%%%%this line is edited later
end

size(MatrixCumulative)
MatrixCumulativeReal=real(MatrixCumulative);
MatrixCumulativeImag=imag(MatrixCumulative);
MatrixCumulativeNorm=abs(MatrixCumulative);
MatrixCumulativeAngle=angle(MatrixCumulative);

save('Unhealthy_freq_0_5_MatrixCumulativeComplexfield','MatrixCumulative')
save('Unhealthy_freq_0_5_MatrixCumulativeComplexfieldReal','MatrixCumulativeReal')
save('Unhealthy_freq_0_5_MatrixCumulativeComplexfieldImag','MatrixCumulativeImag')
save('Unhealthy_freq_0_5_MatrixCumulativeComplexfieldNorm','MatrixCumulativeNorm')
save('Unhealthy_freq_0_5_MatrixCumulativeComplexfieldAngl','MatrixCumulativeAngle')

writematrix(MatrixCumulative,'Unhealthy_freq_0_5_MatrixCumulativeComplexfield.csv')
writematrix(real(MatrixCumulative),'Unhealthy_freq_0_5_MatrixCumulativeComplexfieldReal.csv')
writematrix(imag(MatrixCumulative),'Unhealthy_freq_0_5_MatrixCumulativeComplexfieldImag.csv')
writematrix(abs(MatrixCumulative),'Unhealthy_freq_0_5_MatrixCumulativeComplexfieldNorm.csv')
writematrix(angle(MatrixCumulative),'Unhealthy_freq_0_5_MatrixCumulativeComplexfieldAngle.csv')

toc