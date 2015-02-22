function [ Y ] = WCFreqDomainProcess( X1, X0 )
%WCPHASELOCK Modifies the phases of an STFT as described in Warm Chorus
%   X: STFT matrix
%   Y: modified STFT matrix
Y=zeros(size(X1));
N = size(X1,1);
for index = 1:size(X1,2)
    %We get a new phase for each bin from the phase of a sum of that bin and
    %three its two neighbour bins. I believe this cannot be done for the
    %first bin nor the nyquist bin:
    %newPhases = angle( -X(1:N/2-1,index) +  X(2:N/2,index) - X(3:N/2+1,index));
    %newPhases = angle( -X(1:N/2-1,index)) + angle( X(2:N/2,index)) + angle( - X(3:N/2+1,index) );
    %WTF THAT JUST DOES NOT WORK! JUST DISTORTS THE SIGNAL.
    newPhases = angle(X1(2:N/2,index));
    
    %Amplitude processing, the amplitudes of the chorused and the original
    %signals are "cross-faded non-linearly". I took that to mean that the
    %original amplitudes averaged with the new ones with a frequency-
    %dependent weighting favouring the new amplitudes particularly at
    %higher frequencies.
    newAmplitudes = abs(X1(2:N/2,index));
    newEnergy = sum(newAmplitudes);
    oldAmplitudes = abs(X0(2:N/2,index));
    newAmplitudes = newAmplitudes + oldAmplitudes.*(linspace(0.9,0,length(oldAmplitudes))');
    newAmplitudes = newEnergy*( newAmplitudes / sum(newAmplitudes));
    
    %Now we calculate the new bins:
    newBins = newAmplitudes.*exp(1i*newPhases);
    %And recreate the fft with the original DC and nyquist bins and the new
    %bins:
    Y(:,index) = [X1(1,index); newBins; X1(N/2+1,index); conj(newBins(end:-1:1))];
end


end

