function [ y ] = WCISTFT( X, Fs )
%WCISTFT Implements the inverse short time Fourier transform
%   X: input matrix, where columns are ffts of windows
%   y: output
%   Fs: sampling frequency

%We only really need the winlen and hopsize:
[ window, winlen, hopsize ] = WCWindowDesign( Fs );

y = zeros(hopsize*size(X,2)+hopsize,1);
for index = 1:size(X,2)
    y(1+(index-1)*hopsize:winlen+(index-1)*hopsize,1) = ...
        y(1+(index-1)*hopsize:winlen+(index-1)*hopsize,1) + ifft(X(:,index),winlen);
end
y=y(hopsize:end-hopsize);


end

