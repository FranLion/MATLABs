function RRFFTplot(S)

try
    Nx = 2^16;  % number of samples to synthesize
    B = [0.049922035 -0.095993537 0.050612699 -0.004408786];
    A = [1 -2.494956002   2.017265875  -0.522189400];
    nT60 = round(log(1000)/(1-max(abs(roots(A))))); % T60 est.
    v = randn(1,Nx+nT60); % Gaussian white noise: N(0,1)
    x = filter(B,A,v);    % Apply 1/F roll-off to PSD
    x = x(nT60+1:end);    % Skip transient response
    z=repmat(x,1,S);
    z=z/max(abs(z));
    t= 0:1/Nx:length(z)/Nx-1/Nx;

    %fft
    Fs = Nx;            % Sampling frequency
    T = 1/Fs;             % Sampling period
    L = Fs*S;             % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:(L/2))/L;
    Y = fft(z);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    P1=20*log(P1/max(abs(P1)));
    plot(f,P1); xlabel('tiempo [s]'); ylabel('Amplitud'); grid on;
    
catch
    errordlg('parametros de entrada incorrectos');
end

end