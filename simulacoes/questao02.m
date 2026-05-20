% QUESTÃO 2 - Soma de duas senoides com FFT
% Mostra como o espectro separa componentes que
% se misturam no domínio do tempo


clear; clc; close all;

N  = 128;
n  = 0:N-1;

% Duas frequências diferentes
f1 = 0.1;   % componente 1
f2 = 0.3;   % componente 2

% Gerar as senoides e somá-las
x1 = sin(2*pi*f1*n);
x2 = sin(2*pi*f2*n);
x  = x1 + x2;

% FFT do sinal somado
X    = fft(x);
freq = (0:N-1)/N;

metade    = 1:N/2;
magnitude = abs(X(metade)) / N;
eixo_freq = freq(metade);

% --- Plotar ---
figure('Name','Questão 2','NumberTitle','off');

subplot(3,1,1);
plot(n, x1, 'b'); hold on; plot(n, x2, 'r');
legend('Senoide f1=0.1','Senoide f2=0.3');
title('Sinais individuais no tempo');
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
plot(n, x, 'k');
title('Sinal somado x = x1 + x2 (difícil separar no tempo)');
xlabel('Amostras'); ylabel('Amplitude'); grid on;

subplot(3,1,3);
stem(eixo_freq, magnitude, 'm', 'filled', 'MarkerSize', 4);
title('Espectro do sinal somado (FFT separa as duas frequências)');
xlabel('Frequência Normalizada'); ylabel('Magnitude');
xline(f1,'b--', sprintf('f1=%.1f',f1));
xline(f2,'r--', sprintf('f2=%.1f',f2));
grid on;

fprintf('Picos detectados no espectro:\n');
[picos, idx] = findpeaks(magnitude, 'MinPeakHeight', 0.3);
for i = 1:length(idx)
    fprintf('  f = %.4f  |  magnitude = %.4f\n', eixo_freq(idx(i)), picos(i));
end

% DISCUSSÃO (comentário):
% No domínio do tempo, os dois sinais se misturam e fica difícil
% dizer quais frequências estão presentes. Já no espectro (FFT),
% aparecem dois picos claros exatamente em f1=0.1 e f2=0.3,
% mostrando que a análise em frequência é muito mais informativa.
