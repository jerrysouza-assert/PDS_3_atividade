% QUESTÃO 5 - Senoide com ruído aditivo
% Mostra como a FFT consegue identificar a frequência
% principal mesmo com ruído presente


clear; clc; close all;

N  = 256;
n  = 0:N-1;
f0 = 0.15;          % frequência do sinal útil
SNR_dB = 5;         % relação sinal-ruído em dB (baixa = muito ruído)

% Gerar senoide + ruído
sinal_puro = sin(2*pi*f0*n);
ruido      = randn(1, N);

% Ajustar potência do ruído conforme SNR desejada
potencia_sinal = mean(sinal_puro.^2);
potencia_ruido = potencia_sinal / (10^(SNR_dB/10));
ruido_ajustado = ruido * sqrt(potencia_ruido / mean(ruido.^2));

x = sinal_puro + ruido_ajustado;

% FFTs
X_puro  = fft(sinal_puro);
X_ruido = fft(x);

freq   = (0:N-1)/N;
metade = 1:N/2;
f_eixo = freq(metade);

mag_puro  = abs(X_puro(metade))  / N;
mag_ruido = abs(X_ruido(metade)) / N;

% --- Plotar ---
figure('Name','Questão 5 - Ruído','NumberTitle','off');

subplot(2,2,1);
plot(n, sinal_puro, 'b');
title('Sinal puro (sem ruído)');
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(2,2,2);
stem(f_eixo, mag_puro, 'b', 'filled', 'MarkerSize', 3);
title('Espectro do sinal puro');
xlabel('Freq. Normalizada'); ylabel('Magnitude'); grid on;

subplot(2,2,3);
plot(n, x, 'r');
title(sprintf('Sinal com ruído (SNR = %d dB)', SNR_dB));
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(2,2,4);
stem(f_eixo, mag_ruido, 'r', 'filled', 'MarkerSize', 3);
title('Espectro do sinal ruidoso');
xlabel('Freq. Normalizada'); ylabel('Magnitude');
% Tentar identificar o pico principal
[~, idx] = max(mag_ruido);
xline(f_eixo(idx), 'k--', sprintf('pico: f=%.3f', f_eixo(idx)));
grid on;

fprintf('Frequência verdadeira: f0 = %.4f\n', f0);
fprintf('Pico detectado no espectro: f = %.4f\n', f_eixo(idx));

% DISCUSSÃO:
% No domínio do tempo, com ruído forte, é quase impossível ver
% onde está a senoide. Mas no espectro, mesmo com o ruído espalhado
% por todas as frequências, o pico da senoide se destaca porque
% toda a sua energia está concentrada em uma única frequência.
% O ruído espalha sua energia por todo o espectro (ruído branco),
% então a amplitude média dele é baixa em cada ponto.
% Quanto menor o SNR, mais difícil fica identificar o pico,
% mas a FFT ainda é muito mais eficiente que olhar o sinal no tempo.
