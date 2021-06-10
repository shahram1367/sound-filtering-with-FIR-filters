clc
clear
close all
beep off

addpath ('data')
addpath ('function')
% import audio signal to MATLAB
[y, Fs] = audioread('record1234.wav');
audioSignal = y(:,1);
inputSignal = audioSignal';

% Design hann window
hannCoeffs = coeffs(hannFIR);
hannFilter = hannCoeffs.Numerator;

% Design kaiser window
kaiserCoeffs = coeffs(kaiserFIR);
kaiserFilter = kaiserCoeffs.Numerator;

% Design blackman window
blackmanCoeffs = coeffs(blackmanFIR);
blackmanFilter = blackmanCoeffs.Numerator;

figure
subplot 311
stem(hannFilter)
title 'hann window coefficients'

subplot 312
stem(kaiserFilter)
title 'kaiser window coefficients'

subplot 313
stem(blackmanFilter)
title 'blackman window coefficients'

% using hann window in filtering
hannOutput = myConv1(inputSignal,hannFilter);
% using kaiser window in filtering 
kaiserOutput = myConv1(inputSignal,kaiserFilter);
% using blackman window in filtering 
blackmanOutput = myConv1(inputSignal,blackmanFilter);


% it is just for comparing my convolution function with MATLAB conv function
figure
subplot 211
stem(hannOutput)
grid on
title 'Conv with myFunction'

subplot 212
zConv = conv(inputSignal,hannFilter);
stem(zConv) 
grid on
title 'Conv with MATLAB Function'


% Compare results with input signal
figure
subplot 411
f_audioSignal = linspace(0,Fs,length(inputSignal));
plot(f_audioSignal,abs(fftshift(fft(inputSignal))))
% xlim ([400000 800000]);
title ' FFT of input signal'

subplot 412
f_hannOutput = linspace(0,Fs,length(hannOutput));
plot (f_hannOutput,abs(fftshift(fft(hannOutput))))
title 'FFT of filtered signal (hann)'

subplot 413
f_kaiserOutput = linspace(0,Fs,length(kaiserOutput));
plot(f_kaiserOutput,abs(fftshift(fft(kaiserOutput))))
title 'FFT of filtered signal (kaiser)'

subplot 414
f_blackmanOutput = linspace(0,Fs,length(blackmanOutput));
plot(f_blackmanOutput,abs(fftshift(fft(blackmanOutput))))
title 'FFT of filtered signal (blackman)'

eng_in = inputSignal*inputSignal';
Eng_out= hannOutput*hannOutput';
Eng_kaiserOut = kaiserOutput*kaiserOutput';
Eng_blackmanOut = blackmanOutput*blackmanOutput';

% Display results
disp(['sampling frequency =',num2str(Fs)])
disp(['cutoff frequency = ' , num2str(4000)])
disp(['order = ',num2str(10)])
disp(['Energy of input signal = ',num2str(eng_in)]);
disp(['Energy of output signal by hannFilter = ',num2str(Eng_out)]);
disp(['Energy of output signal by kaiser window= ',num2str(Eng_kaiserOut)]);
disp(['Energy of output signal by blackman window= ',num2str(Eng_kaiserOut)]);
disp(['conclusion'])
disp(['filtered signal with kaiser window has lower noise than others in this project'])

filename = 'output_hann.wav';
audiowrite(filename,hannOutput,Fs);


filename = 'output_kaiser.wav';
audiowrite(filename,kaiserOutput,Fs);

filename = 'output_blackman.wav';
audiowrite(filename,blackmanOutput,Fs);

sound(inputSignal,Fs)
pause(27)
sound(kaiserOutput,Fs)