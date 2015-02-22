
fs = 44100;

track = audioread('Track22.wav');
c = track(20000:fs*3,:);
c = c./max(abs(c));
s = size(c);
c = c.*tukeywin(s(1,1),0.05);


% f_sin = 200;
% T = 2;
% dt = 1/fs;
% t = 0:dt:T-dt;
% c =sin(2*pi*f_sin*t)';


output = WCHarmoniser(c, fs);
output = output./max(abs(output));
out = [c;output];
soundsc(out, fs)




%% Aku's tests
clear
[sig, Fs] = audioread('Track22.wav');
x = sig(22*Fs:27*Fs);
%x = sin(2*pi*300/Fs*(1:5*Fs))';
y = WarmChorus(x,Fs);
%[X,zeroPad] = stft(x,1024,512,Fs);
%Y = WCFreqDomainProcess(X);
%y = istft(Y,1024,512,zeroPad);
