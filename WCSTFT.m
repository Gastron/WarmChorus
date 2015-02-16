function [ Y ] = WCSTFT( x, Fs )
%WCSTFT Implements the Short time Fourier transform
%   x: input
%   Y: output matrix, where the columns are ffts of windows.
%   Fs: sampling frequency

%Initial parameters:
[window, winlen, hopsize] = WCWindowDesign(Fs);
xindex = 1;
yindex = 1;
Y=zeros(winlen,1);

%X should have a hopsize length buffer of zeros:
x = vertcat(zeros(hopsize,1), x);

while xindex < length(x)
    if xindex + winlen < length(x)
        windowed = window.*x(xindex:xindex-1+winlen);
    else
        windowed = window.*vertcat(x(xindex:end),...
            zeros( winlen-length(x(xindex:end)) ,1) );
    end
    Y(:,yindex) = fft(windowed,winlen);
    yindex = yindex+1;
    xindex = xindex+hopsize;
end

end

