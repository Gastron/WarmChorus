function [ samples ] = WCM2S( metres, Fs )
%WCM3S Converts a distance in metres to the sound travel time in samples.
%The output is rounded to whole samples.
% By: Aku Rouhe and Niklas Sallinen
%   metres: input in metres
%   Fs: sampling frequency
%   samples: output in samples

%Assuming 20 degrees celcius and dry air:
c = 343; %metres / second
cs = c/Fs; %metres / sample
samples = metres./cs;
samples = round(samples);

end

