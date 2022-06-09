clc, clear;
%%
%       不知道
%     108060002  周廷紘
%     109060035  温柏崴
%     109060044  莊凱威

%% Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1
clc;    clear;

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

%% Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2
clc;    clear;

filename = 'Sound_clip_2022.wav';
info = audioinfo(filename);
[y, Fs] = audioread(filename);
t = 1 : 1 : length(y);
df = 1 / length(y);
freq = (0 : df : 1 - df) .* Fs;
F = transpose(freq);
w = fft(y);

% filter out the sound of piano
sample_noPiano = w.*(F>2000&F<45000);
audio_noPiano = ifft(sample_noPiano);
audiowrite('NoPiano.wav', real(audio_noPiano), Fs);

% convert violin to cello
[violin, Fs1] = audioread('violin.wav');
nsemitons = -20;
cello = shiftPitch(violin, nsemitons);
cello = cello * 10;
audiowrite('cello.wav', cello, Fs1);

% convert male voice to female voice
[male, Fs2] = audioread('prof.wav');
nsemitons = 12;
female = shiftPitch(male, nsemitons);
audiowrite('prof_female.wav', female, Fs2);

% merge the audios together
merge = cello + female;
audiowrite('modified_sound_clip.wav', merge, Fs2);