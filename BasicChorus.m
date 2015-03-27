function y = BasicChorus(x, Fs)

% This function is industry standart chorus effect
% Aku Rouhe & Niklas Sallinen
%
% x: input signal
% Fs: sampling frequency

N = 300; % the order of the comb filter
f = 0.3; % frequency of LFO
y = zeros(size(x));
b = 0.6; % gain coefficient of IIR comb
a0 = 1; % gain coefficient of direct signal
a1 = 0.7; % gain coefficient of FIR comb

% creating LFO signal:

T = length(transpose(x))/Fs;
dt = 1/Fs;
t = 0:dt:T-dt;
LFO = 150*sin(2*pi*f*t);



for n = 1:length(x)
    % IIR comb filter:
    if n-N > 0
        y(n) = x(n)-b*x(n-N);
    end;
    
    % modulated FIR comb filter:
    if n-(N+floor(LFO(n))+1) >= 1 && n-(N+floor(LFO(n))+1) < length(x)
        d_int = floor(LFO(n));
        d_frac = LFO(n)-d_int;
        y(n) = a0*y(n)+a1*((1-d_frac)*y(n-N-d_int)+(d_frac)*y(n-N-d_int-1));
    else
       y(n) = a0*x(n);
    end;
end;

y = y./max(abs(y));
