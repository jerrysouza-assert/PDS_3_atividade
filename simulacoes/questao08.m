% QUESTÃO 8 - Influência do número de amostras
% Compara a resolução espectral para sinais com
% durações diferentes (mesma frequência fundamental)


clear; clc; close all;

f0 = 0.1;  % frequência fundamental (igual nos dois)

% Sinal curto
N1 = 32;
n1 = 0:N1-1;
x1 = sin(2*pi*f0*n1);

% Sinal longo
N2 = 256;
n2 = 0:N2-1;
x2 = sin(2*pi*f0*n2);

% FFT de cada um (zero-padding não é usado aqui, cada um com seu N)
X1 = fft(x1);
X2 = fft(x2);

f1 = (0:N1-1)/N1;
f2 = (0:N2-1)/N2;

m1 = 1:N1/2;
m2 = 1:N2/2;

mag1 = abs(X1(m1))/N1;
mag2 = abs(X2(m2))/N2;

% --- Plotar ---
figure('Name','Questão 8 - Resolução Espectral','NumberTitle','off');

subplot(2,2,1);
plot(n1, x1, 'b-o', 'MarkerSize', 3);
title(sprintf('Sinal curto: N=%d amostras', N1));
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(2,2,2);
stem(f1(m1), mag1, 'b', 'filled', 'MarkerSize', 4);
title(sprintf('Espectro (N=%d) | Resolução: Δf = 1/N = %.4f', N1, 1/N1));
xlabel('Frequência Normalizada'); ylabel('Magnitude'); grid on;
xline(f0,'r--','f0');

subplot(2,2,3);
plot(n2, x2, 'r');
title(sprintf('Sinal longo: N=%d amostras', N2));
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(2,2,4);
stem(f2(m2), mag2, 'r', 'filled', 'MarkerSize', 3);
title(sprintf('Espectro (N=%d) | Resolução: Δf = 1/N = %.4f', N2, 1/N2));
xlabel('Frequência Normalizada'); ylabel('Magnitude'); grid on;
xline(f0,'b--','f0');

fprintf('=== Resolução Espectral ===\n');
fprintf('N=%d: resolução Δf = 1/%d = %.4f\n', N1, N1, 1/N1);
fprintf('N=%d: resolução Δf = 1/%d = %.4f\n', N2, N2, 1/N2);
fprintf('Sinal mais longo tem %.0fx melhor resolução!\n', N2/N1);

% DISCUSSÃO:
% A resolução espectral é dada por Δf = 1/N (em frequência normalizada).
% Com N=32, cada ponto no espectro representa uma faixa de 1/32 ≈ 0.031.
% Com N=256, essa faixa cai para 1/256 ≈ 0.004.
% Isso significa que com mais amostras, conseguimos distinguir
% frequências mais próximas. Por exemplo, duas frequências em
% f=0.10 e f=0.11 seriam indistinguíveis com N=32, mas apareceriam
% como dois picos separados com N=256.
