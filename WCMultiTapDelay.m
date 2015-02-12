function [ y ] = WCMultiTapDelay( x, num )
%WCMULTITAPDELAY Returns given number of delayed rows
%   The outputs all have the same length, i.e. the vectors are truncated.
%   The outputs are delayed buy adding zeros.
%   x: input
%   num: number of taps
%   y: output
y = zeros(num,length(x));
for tap = 0:num-1
    y(tap+1,:)=[zeros(1, tap) x(1:end-tap)];
end

end

