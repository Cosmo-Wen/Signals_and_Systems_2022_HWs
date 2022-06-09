clc; clear;

% Read audio file
info = audioinfo('Sound_clip_2022.wav'); % Gain info of audio data
[audio,Fs] = audioread('Sound_clip_2022.wav'); % Read the data of audio
audiolength = length(audio); % Gain the length of audio

% Set up sampling numbers
t = 1:1:audiolength;

% Performing Fourier Transform
FFT = fftshift(fft(fftshift(audio)));
F = (-Fs / 2: Fs / length(t): Fs / 2 - Fs / length(t)) * 2 * pi;
F = transpose(F);

% Find specific bandwidths and intensities to use
sample_piano = FFT.*(abs(F) < 2500) .* (abs(FFT) > 1000);
sample_violin = FFT.*(abs(F) > 18000) .* (abs(FFT) > 50);
sample_prof = FFT .* (abs(F) > 1200 & abs(F) < 5000) .* (abs(FFT) < 1000);

% Inverse Fourier Transform
audio_piano = ifftshift(ifft(ifftshift(sample_piano)));
audio_violin = ifftshift(ifft(ifftshift(sample_violin)));
audio_prof = ifftshift(ifft(ifftshift(sample_prof))) * 1.75;

% Write audio files
audiowrite('piano.wav', audio_piano, Fs);
audiowrite('violin.wav', audio_violin, Fs);
audiowrite('prof.wav', audio_prof, Fs);