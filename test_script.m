
fs = 44100;

sound = audioread('Track22.wav');
clip = sound(20000:fs*3,:);
clip = clip./max(abs(clip));
s = size(clip);
clip = clip.*tukeywin(s(1,1),0.05);

output = WCHarmoniser(clip, fs);
output = output./max(abs(output));

out = [clip; output];
soundsc(out, fs)

%% Aku's tests
clear
[sig, Fs] = audioread('Track22.wav');
x = sig(5*Fs:10*Fs);
%x = sin(2*pi*300/Fs*(1:5*Fs))';
%y = WarmChorus(x,Fs);
[X,zeroPad] = WCSTFT(x,Fs);
Y = WCPhaseLock(X);
y = WCISTFT(Y,Fs,zeroPad);

