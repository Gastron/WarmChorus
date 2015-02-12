function output = harmonizer(input, fs)

f = 1.1;
T = length(transpose(input))/fs;
dt = 1/fs;
t = 0:dt:T-dt;
p1 = 500*(1+sawtooth(2*pi*f*t))/2;
p2 = 500*(1+sawtooth(2*pi*f*t+pi/2))/2;
p3 = 500*(1+sawtooth(2*pi*f*t+pi))/2;
p4 = 500*(1+sawtooth(2*pi*f*t+3*pi/2))/2;

output = loop(input,p1,f,fs)+loop(input,p2,f,fs)...
   +loop(input,p3,f,fs)+loop(input,p4,f,fs);
