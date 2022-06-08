info = audioinfo('Sound_clip_2022.wav'); %Gain info of audio data
[audio,Fs] = audioread('Sound_clip_2022.wav'); %Read the data of audio
audiolength = length(audio); %Gain the length of audio

%Set up sampling numbers
t = 1:1:audiolength;
T = t/48000; %Since the value gained is 48000

%Checking (Needed to be deleted when handed)
figure(1),
plot(T,audio(1:audiolength));
xlabel('Time');
ylabel('Audio Signal');
title('Original Audio File Signal in Time Domain');

%Performing Fourier Transform
T = transpose(T);
FFT = fft(audio);
FFT_p = fft(audio_pro);
f= 0:(Fs/audiolength):Fs-(Fs/audiolength);    


F = transpose(f);

sample_piano = FFT.*(F<400|F>47600);
sample_violin = FFT.*(F<44000&F>4000);
sample_prof = FFT.*(F<800&F>200);

audio_piano = ifft(sample_piano);
audio_violin = ifft(sample_violin);
audio_prof = ifft(sample_prof);

audiowrite('piano.wav', audio_piano, Fs);
audiowrite('prof.wav', audio_prof, Fs);
audiowrite('violin.wav', audio_violin, Fs);
