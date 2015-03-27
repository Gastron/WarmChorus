function [ y ] = WCMultiTapDelay( x, delays )
%WCMULTITAPDELAY Returns given number of delayed rows
% By: Aku Rouhe and Niklas Sallinen
%   The outputs all have the same length, i.e. the vectors are truncated.
%   The outputs are delayed by adding zeros.
%   x: input
%   num: number of taps
%   y: output

%Initalisation:
num = length(delays);
y = zeros(length(x),num);
%The amounts of delay.

if length(delays) < num
    error('More delay taps requested than are currently supported.')
end
if length(x) < delays(num)
    error('With the amount of taps requested, the input signal was not sufficiently long')
end

for i = 1:num
    y(:,i)= vertcat(zeros(delays(i), 1), x(1:end-delays(i)));
end

end

