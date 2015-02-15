function [ window, winlen, hopsize ] = WCWindowDesign( Fs )
%WCWINDOWDESIGN Designs a window for STFT
%   The window length and hopsize have to be calculated so that the windows
%   overlap in a way that always adds to one.
%   window: the actual window vector
%   winlen: the length of the window, given for convenience
%   hopsize: the amount of samples that the window has to be shifted to
%   give a constant summation.
%   Fs: sampling frequency

%A basic power of two length:
winlen = 1024;
%Hanning window needs 50% overlap:
hopsize = winlen/2;
%Periodic window type is preferred for FFT:
window = hann(winlen,'periodic');

end

