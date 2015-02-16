function [ Y ] = WCPhaseLock( X )
%WCPHASELOCK Modifies the phases of an STFT as described in Warm Chorus
%   X: STFT matrix
%   Y: modified STFT matrix
Y=zeros(size(X));
N = size(X,1);
for index = 1:size(X,2)
    newPhases = angle( -X(1:N/2-1,index) +  X(2:N/2,index) - X(3:N/2+1,index));
    newBins = abs(X(2:N/2,index)).*exp(1i*newPhases);
    Y(:,index) = [X(1,index); newBins; X(N/2+1,index); conj(newBins(end:-1:1))];
end


end

