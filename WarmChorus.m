function [ y ] = WarmChorus( x, Fs, dist, skill)
%WarmChorus implements the warm chorus algorithm
% By: Aku Rouhe and Niklas Sallinen
%   x: input signal
%   Fs: sampling frequency
%   y: output signal
%   skill: skill factor of players (0 < skill < inf)(best values: 0.3-1)
%   dist:  max distance between players (m)


%Make sure we have a column vector
transposeOutput = 0;
if size(x,1) < size(x,2)
    x=x';
    transposeOutput = 1;
end

%First stage: Multi-tap delay, takes one input and gives out cols of
%delayed versions for each inputted delay.
delays = [0 WCM2S(dist/7,Fs) WCM2S(dist*2/7,Fs) WCM2S(dist*3/7,Fs)...
    WCM2S(dist*4/7,Fs) WCM2S(dist*5/7,Fs) WCM2S(dist*6/7,Fs) WCM2S(dist,Fs)];
y = WCMultiTapDelay(x, delays);

%Second stage: Harmonisers. The first col is not harmonised.
detune = 1/(0.13+skill).*[0 0 0.7 1.3 1.5 2.1 3.5 4]; 
for col = 2:size(y,2)
    y(:,col) = WCHarmoniser(y(:,col),Fs,detune(col));
end

%Third stage: Filters. The first and second cols are not filtered.

Absorptions = tanh(dist/10).*[0 0 0.03 0.05 0.07 0.07 0.07 0.13];
for col = 3:size(y,2)
    y(:,col) = WCFirstFilter(y(:,col),Fs,Absorptions(col));
end

%Fourth stage: Gain
MeanGains = [0.9 0.8 0.8 0.8 0.7 0.7 0.6 0.6];
Variances = [0.13 0.2 0.1 0.2 0.25 0.3 0.5 0.6];
for col = 1:size(y,2)
    y(:,col) = WCRandRamp(y(:,col),Fs,MeanGains(col),Variances(col));
end

%Fifth stage: Hadamard matrix multiplication for diffusion.
y = WCHadamard(y);

%Sixth stage: Delays. The first col is not delayed
for col = 2:size(y,2)
    y(:,col) = [zeros(delays(col),1); y(1:end-delays(col),col)];
end

%Seventh stage: Another round of harmonisers. The first col is not
%harmonised.
for col = 2:size(y,2)
    y(:,col) = WCHarmoniser(y(:,col),Fs,detune(col));
end

%Eighth stage: Another round of filters. The first two cols are not
%filtered.
for col = 3:size(y,2)
    y(:,col) = WCFirstFilter(y(:,col),Fs,Absorptions(col));
end

%Ninth stage: Another round of ramps.
for col = 1:size(y,2)
    y(:,col) = WCRandRamp(y(:,col),Fs,MeanGains(col),Variances(col));
end

%Summation:
y = sum(y,2);
%Normalisation:
y = y.*(1/sqrt(8));


%STFT:
[Y, zeroPady] = WCSTFT(y,Fs);
[X, zeroPadx] = WCSTFT(x,Fs);

Y = WCFreqDomainProcess(Y,X);
y = WCISTFT(Y,Fs,zeroPady);

if transposeOutput
    y=y';
end
y=y./max(abs(y));
end

