function [ y ] = WCHarmoniser( x, Fs, detune )

%The Harmoniser for the Warm Chorus
%	x: input
%	y: output
%	Fs: sampling frequency

%% generating phasor signals:

f = 0.1*(0.1+detune); % frequency of phasor function
p = zeros(length(x),4); % empty matrix for phasor signals

% constans to help to generate phasor signal:
T = length(transpose(x))/Fs;
dt = 1/Fs;
t = 0:dt:T-dt;
coef = 200*(0.7+detune);
r = zeros(4,1);

% genarating sawtooth signals for phasor:
for k = 1:4
    p(:,k) =coef*(1-sawtooth(2*pi*f*t+(k-1).*pi/2))/2;
    r(k) = 0.5+0.5*abs(rand(1)); % random number to get randomization to transpose
end;



%% initializing output and helping variables:


y_k = zeros(length(x),4);  % output for different phasors initialized
y = zeros(size(x)); % output sequence
lst = zeros(4,1);   % additional variable to localize the place of the last window
%d = 0;  % delay of the signal initialized to zero

%% creating the window for windowing:

winlen = round(Fs/f)+1; % window length
w = hann(winlen); % Hanning window



%% transposing the signal and windowing:

for n = 2:length(x)
    for k = 1:4
        
        % modulated delay line to transpose the signal:
        if n-floor(p(n,k)*r(k)) >= 2
            
            d = p(n,k)*r(k);     % delay
            d_int = floor(d); % integer part of delay
            d_frac = d-d_int; % fractional part of delay 
            
            % delayed output signal:
            y_k(n,k) =...
                ((1-d_frac).*x(n-d_int)+ (d_frac).* x(n-d_int-1));
        end;
        
        % windowing:
        if abs(p(n,k) - p(n-1,k)) > coef*0.8 % finding the peaks of phasor
            
            r(k) =  0.5+0.5*abs(rand(1)); % new random for every window
            
            if n - winlen > 0 % checking if full window fits
                y_k(n-winlen:n-1,k) = y_k(n-winlen:n-1,k).*w;
                
            else % adding part of the window if not
                y_k(1:n-1,k) = y_k(1:n-1,k).*w(winlen-n+2:end);
            end;
            
            if n + winlen > length(x) 
                % checking place for last window if full doesnt fit
                lst(k) = n;
            end;
        end;
    end;
    %d=0; % delay to zero after each loop of phasors
end;

% the last window:
for k = 1:4
    if lst(k) ~= 0
        y_k(lst(k):end,k)=...
            y_k(lst(k):end,k).*w(1:length(x)-lst(k)+1);
    end;
end;

%% allpass filter:
for k = 1:4
    y_k(:,k) = filter([0.7 0.6 0.7 0.9 0.7 0.7 0.8 0.7 1]...
                     ,[1 0.7 0.8 0.7 0.7 0.9 0.7 0.6 0.7],y_k(:,k));
end;


%% summing the results of different phasor signals:

for k = 1:4
    y = y+y_k(:,k);
end;
