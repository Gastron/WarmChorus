function [ Y, zeroPad ] = WCSTFT( x, Fs )
%WCSTFT Implements the Short time Fourier transform
% By: Aku Rouhe and Niklas Sallinen
%   x: input
%   Y: output matrix, where the columns are ffts of windows.
%   Fs: sampling frequency

%Initial parameters:
[window, winlen, hopsize] = WCWindowDesign(Fs);
xindex = 1;
yindex = 1;
Y=zeros(winlen,1);
zeroPad = 0;

%x should have a buffer of zeros:
x = [zeros(winlen,1); x;zeros(winlen,1)];

while xindex <= length(x)
    if xindex + winlen <= length(x)
        windowed = window.*x(xindex:xindex-1+winlen);
    else
        %The last frame is padded with zeros if the length of x is not a 
        %multiple of winlen:
        zeroPad = winlen-length(x(xindex:end));
        windowed = window.*vertcat(x(xindex:end),...
            zeros( zeroPad ,1) );
    end
    Y(:,yindex) = fft(windowed,winlen);
    yindex = yindex+1;
    xindex = xindex+hopsize;
end

end

