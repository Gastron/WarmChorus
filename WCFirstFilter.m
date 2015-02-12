function [ y ] = WCFirstFilter( x, Fs, absorption)
%WCFIRSTFILTER Implements the first filter in the Warm Chorus algorithm
%   x: input
%   y: output
%   Fs: sampling frequency
%   absorption: this parameter controls the attenuation of high frequencies
%           it should be given a value between 0 (no attenuation) and 1
%           (total attenuation)

if absorption >1
    error('The parameter absorption has to be between 0 and 1')
end
if absorption <0
    error('The parameter absorption has to be between 0 and 1')
end

B = [1.0-absorption absorption];
A = 1;
%Note: This is a fractional delay filter too.
y = filter(B,A,x);




end

