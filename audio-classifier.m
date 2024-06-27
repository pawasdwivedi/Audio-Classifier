[path] = uigetfile('*wav');
[audio, Fs] = audioread(path);
fileinfo = audioinfo(path);
N = fileinfo.TotalSamples;

spec = fft(audio);
y = abs(spec);
magdB = 20*log10(y);
plot(magdB)

freqResolution = Fs / N;
freq = (0:N-1) * freqResolution;

bands = {[20, 60], [60, 250], [250, 500], [500, 2000], [2000, 4000], [4000, 6000], [6000, 20000]};

avg_magdB = zeros(1, 7);

for i = 1:7
    band_no = find(freq >= bands{i}(1) & freq <= bands{i}(2));
    avg_magdB(i) = mean(magdB(band_no));
end

disp('Average Magnitudes (dB) in each band:');
disp(avg_magdB);

max_value = avg_magdB(1);

for i = 2:numel(avg_magdB)
    if avg_magdB(i) > max_value
        max_value = avg_magdB(i);
    end
end


for i = 1:7
    if avg_magdB(i) > 0.8 * max_value
        switch i
    case 1
        disp('Sub-bass');
    case 2
        disp('Mid-bass');
    case 3
        disp('low-mids');
    case 4
        disp('center-mids');
    case 5
        disp ('high-mids')
    case 6
        disp ('presence')
    case 7 
        disp('brilliance')
end


    end
    
end






