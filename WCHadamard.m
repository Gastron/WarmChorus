function [ y ] = WCHadamard( x, Fs )
%WCHADAMARD The Hadamard matrix used for diffusion in warm
%chorus
% By: Aku Rouhe and Niklas Sallinen
%   x: input
%   y: output
%   Fs: sampling frequency
A=hadamard(size(x,2));
y = x*A;

end

