function [ y ] = WCISTFT( X, Fs, zeroPad )
%WCISTFT Implements the inverse short time Fourier transform
% By: Aku Rouhe and Niklas Sallinen
%   X: input matrix, where columns are ffts of windows
%   y: output
%   zeroPad: The amount of zeros added to x at STFT forward transform.
%   Fs: sampling frequency
if nargin == 2
    zeroPad =0;
end

[ window, winlen, hopsize ] = WCWindowDesign( Fs );

y = zeros(hopsize*size(X,2)+hopsize,1);
for index = 1:size(X,2)
    y(1+(index-1)*hopsize:winlen+(index-1)*hopsize,1) = ...
        y(1+(index-1)*hopsize:winlen+(index-1)*hopsize,1) + window.*ifft(X(:,index),winlen);
end
y=y(winlen+1:end-winlen-zeroPad);


end

