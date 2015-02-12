function [ y ] = WarmChorus( x, Fs )
%WarmChorus implements the warm chorus algorithm
%   x: input signal
%   Fs: sampling frequency
%   y: output signal

%Make sure we have a row vector
transposeOutput = 0;
xsize = size(x);
if xsize(1) > xsize(2)
    x=x';
    transposeOutput = 1;
end

%First stage: Multi-tap delay, takes one input and gives out rows of
%delayed versions.
y = WCMultiTapDelay(x, 8);

%Second stage: Harmonisers. The first row is not harmonised.
for row = 2:size(y,1)
    y(row,:) = WCHarmoniser(y(row),Fs);
end

%Third stage: Filters. The first and second rows are not filtered.
for row = 3:size(y,1)
    y(row,:) = WCFirstFilter(y(row),Fs);
end

%Fourth stage: Gain
%TODO: FIND GOOD VALUES SOMEWHERE
FourthStageGains = [1 1 1 1 1 1 1 1];
for row = 1:size(y,1)
    y(row,:) = FourthStageGains(row).*y(row);
end

%Fifth stage: Walsh-Hadamard transform
y = WCWalshHadamard(y);

%Sixth stage: Delays. The first row is not delayed
for row = 2:size(y,1)
    y(row,:) = [0 y(row,1:end-1)];
end

%Seventh stage: Another round of harmonisers. The first row is not
%harmonised.
for row = 2:size(y,1)
    y(row,:) = WCHarmoniser(y(row),Fs);
end

%Eighth stage: Another round of filters. The first two rows are not
%filtered.
for row = 3:size(y,1)
    y(row,:) = WCFirstFilter(y(row),Fs);
end

%Ninth stage: Another round of gain.
%TODO: FIND GOOD VALUES SOMEWHERE
NinthStageGains = [1 1 1 1 1 1 1 1];
for row = 1:size(y,1)
    y(row,:) = NinthStageGains(row).*y(row);
end

%Summation:
y = sum(y,1);
%Normalisation:
y = y.*(1/sqrt(8));

%The dry, delayed path:
DelayedInput = [0 x(1:end-1)];

%STFT:
y = WCSTFT(DelayedInput,y,Fs);

if transposeOutput
    y=y';
end
end

