function out = loop(input, phasor,f, fs)

out = zeros(size(input));
r = 50*abs(rand(1));

winlen = round(fs/(f));
w = hann(winlen);

for n = 2:length(input)
    
    if n-floor(phasor(n)+r) >= 2
        d1 = floor(phasor(n)+r);
        frac = phasor(n)+r- d1;
        out(n) = (1-frac)* input(n-d1)+ frac *input(n-d1-1);
    end;
    
    if abs(phasor(n) - phasor(n-1)) > 450
        
        r = 50*abs(rand(1));
        
        if n - winlen > 0
            out(n-winlen:n-1) = out(n-winlen:n-1).*w;
        else
            out(1:n-1) = out(1:n-1).*hann(n-1);
        end;
        
        if n + winlen > length(input)  
            last = n;
            
            
        end;
    end;
end;
out(last:end) = out(last:end).*w(1:length(input)-last+1);

out = filter([0.7 0.6 0.7 0.9 0.7 0.7 0.8 0.7 1]...
            ,[1 0.7 0.8 0.7 0.7 0.9 0.7 0.6 0.7],out);