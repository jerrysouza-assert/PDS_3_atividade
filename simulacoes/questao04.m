% QUESTÃO 4 - Janelamento e Vazamento Espectral
% Compara o espectro sem janela (retangular) e com
% janela de Hamming para reduzir o vazamento


clear; clc; close all;

N  = 128;
n  = 0:N-1;
f0 = 0.1;   % frequência do sinal

% Sinal original (truncado = janela retangular implícita)
x = sin(2*pi*f0*n);

% Janela de Hamming (suaviza as bordas do sinal)
janela_hamming = hamming(N)';   % transposta pra virar linha
janela_hann    = hanning(N)';

% Aplicar janelas
x_hamming = x .* janela_hamming;
x_hann    = x .* janela_hann;

% Calcular FFTs
X_ret     = fft(x);
X_hamming = fft(x_hamming);
X_hann    = fft(x_hann);

freq    = (0:N-1)/N;
metade  = 1:N/2;
f_eixo  = freq(metade);

% Escala em dB para visualizar melhor o vazamento
dB = @(V) 20*log10(abs(V(metade))/max(abs(V(metade))) + 1e-10);

mag_ret     = dB(X_ret);
mag_hamming = dB(X_hamming);
mag_hann    = dB(X_hann);

% --- Plotar janelas no tempo ---
figure('Name','Questão 4 - Janelamento','NumberTitle','off');

subplot(3,2,1);
plot(n, x, 'b');
title('Sinal sem janela (retangular)');
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(3,2,2);
plot(f_eixo, mag_ret, 'b');
title('Espectro SEM janela (nota: vazamento nas laterais)');
xlabel('Frequência Norm.'); ylabel('Magnitude (dB)'); ylim([-80 5]); grid on;

subplot(3,2,3);
plot(n, x_hamming, 'r');
title('Sinal com Janela de Hamming');
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(3,2,4);
plot(f_eixo, mag_hamming, 'r');
title('Espectro COM Janela de Hamming');
xlabel('Frequência Norm.'); ylabel('Magnitude (dB)'); ylim([-80 5]); grid on;

subplot(3,2,5);
plot(n, x_hann, 'g');
title('Sinal com Janela de Hann');
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(3,2,6);
plot(f_eixo, mag_hann, 'g');
title('Espectro COM Janela de Hann');
xlabel('Frequência Norm.'); ylabel('Magnitude (dB)'); ylim([-80 5]); grid on;

% Comparação lado a lado
figure('Name','Comparação de Janelas','NumberTitle','off');
plot(f_eixo, mag_ret, 'b', 'LineWidth', 1.5); hold on;
plot(f_eixo, mag_hamming, 'r', 'LineWidth', 1.5);
plot(f_eixo, mag_hann, 'g', 'LineWidth', 1.5);
legend('Sem janela (Retangular)','Hamming','Hann');
title('Comparação do Vazamento Espectral');
xlabel('Frequência Normalizada'); ylabel('Magnitude (dB)');
ylim([-80 5]); grid on;

% DISCUSSÃO:
% Sem janela, o espectro tem o pico correto em f0=0.1, mas
% com "caudas" largas (vazamento) que podem mascarar frequências próximas.
% Com Hamming ou Hann, o pico principal fica um pouco mais largo,
% mas as caudas laterais caem muito mais rápido, reduzindo o vazamento.
% Para análise de sinais com frequências muito próximas, a janela
% retangular pode confundir os picos. Hamming/Hann são mais confiáveis.
