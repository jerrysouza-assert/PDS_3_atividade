% QUESTÃO 1 - Senoide discreta e FFT
% Gera uma senoide de frequência normalizada f0=0.1
% com N=128 amostras e calcula o espectro via FFT


clear; clc; close all;

%  sinal
N  = 128;       % número de amostras
f0 = 0.1;       % frequência normalizada (ciclos por amostra)
n  = 0:N-1;     % vetor de amostras

% Gerar a senoide
x = sin(2*pi*f0*n);

% Calcular a FFT
X = fft(x);

% Eixo de frequência normalizada (0 a 1, mas só até 0.5 é significativo)
freq = (0:N-1)/N;

% Módulo do espectro (só a metade positiva)
metade = 1:N/2;
magnitude = abs(X(metade)) / N;
eixo_freq = freq(metade);

% --- Plotar ---
figure('Name','Questão 1','NumberTitle','off');

subplot(2,1,1);
plot(n, x, 'b-o', 'MarkerSize', 3);
title('Sinal no Domínio do Tempo');
xlabel('Amostras (n)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(eixo_freq, magnitude, 'r', 'filled', 'MarkerSize', 4);
title('Espectro de Magnitude (FFT)');
xlabel('Frequência Normalizada');
ylabel('Magnitude');
% Marca a frequência dominante
[pico, idx] = max(magnitude);
xline(eixo_freq(idx), 'k--', sprintf('f = %.2f', eixo_freq(idx)), 'LabelVerticalAlignment','bottom');
grid on;

% Mostrar resultado no terminal
fprintf('Frequência dominante encontrada: f = %.4f\n', eixo_freq(idx));
fprintf('(Frequência esperada: f0 = %.4f)\n', f0);
