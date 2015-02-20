
fs = 44100;

track = audioread('Track22.wav');
c = track(20000:fs*2,:);
c = c./max(abs(c));
s = size(c);
c = c.*tukeywin(s(1,1),0.05);


% f_sin = 440;
% T = 2;
% dt = 1/fs;
% t = 0:dt:T-dt;
% c =sin(2*pi*f_sin*t)';

output = Harmoniser(c, fs);
output = output./max(abs(output));

out = [c; output];
soundsc(out, fs)
