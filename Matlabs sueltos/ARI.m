function [varargout] = ARI(T)

deviceReader = audioDeviceReader

devices = getAudioDevices(deviceReader)

deviceReader = audioDeviceReader;

    deviceReader.SamplesPerFrame = 1024;

    deviceReader.SampleRate = 44100;

setup(deviceReader) ;% Función de MATLAB para autoconfigurar objetos y dismunir la carga computacional

fileWriter = dsp.AudioFileWriter('test_adq.wav', 'FileFormat', 'WAV') % Utilizo AudioFileWriter

disp('Adquisición iniciada ...')

tic;

while toc < T % Bucle de frame

    audioFromDevice = deviceReader();

    fileWriter(audioFromDevice);

end

disp('Adquisición finalizada.')

release(deviceReader)

release(fileWriter) 

clear y ty

arch_audio = 'test_adq.wav';

[y,fs]  = audioread(arch_audio);

sound(y,fs)

info = audioinfo(arch_audio) % metadata del archivo de audio

% ty = 0:seconds(1/fs):seconds(info.Duration);
% 
% ty = ty(1:end-1);
% 
% plot(ty, y);
% 
%         title 'Audio adquirido'
% 
%         xlabel 'Tiempo'
% 
%         ylabel 'Amplitud normalizada'
% 
%         ylim([-1 1])

end