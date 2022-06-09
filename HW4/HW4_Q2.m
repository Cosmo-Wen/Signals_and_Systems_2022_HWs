clc, clear;

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