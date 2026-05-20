% QUESTÃO 3 - Aliasing
% Demonstra o que acontece quando amostramos um sinal
% com taxa insuficiente (abaixo de Nyquist)


clear; clc; close all;

% --- Sinal analógico de referência (alta resolução) ---
% simula uma senoide de 400 Hz
f_sinal = 400;       % Hz - frequência do sinal real

% Taxa de amostragem correta (acima de Nyquist: > 2*400 = 800 Hz)
Fs_ok  = 2000;       % 2000 Hz - OK, acima do limite
% Taxa de amostragem insuficiente (aliasing)
Fs_bad = 500;        % 500 Hz - abaixo do limite de Nyquist para 400 Hz

N = 128;

% Gera amostras com as duas taxas
n_ok  = 0:N-1;
n_bad = 0:N-1;

t_ok  = n_ok  / Fs_ok;
t_bad = n_bad / Fs_bad;

x_ok  = sin(2*pi*f_sinal*t_ok);
x_bad = sin(2*pi*f_sinal*t_bad);

% FFT de ambos
X_ok  = fft(x_ok);
X_bad = fft(x_bad);

freq_ok  = (0:N-1) * Fs_ok  / N;
freq_bad = (0:N-1) * Fs_bad / N;

metade = 1:N/2;

mag_ok  = abs(X_ok(metade))  / N;
mag_bad = abs(X_bad(metade)) / N;

f_ok  = freq_ok(metade);
f_bad = freq_bad(metade);

% --- Plotar ---
figure('Name','Questão 3 - Aliasing','NumberTitle','off');

subplot(2,2,1);
plot(t_ok(1:50)*1000, x_ok(1:50));
title(sprintf('Sinal amostrado corretamente\nFs = %d Hz', Fs_ok));
xlabel('Tempo (ms)'); ylabel('Amplitude'); grid on;

subplot(2,2,2);
stem(f_ok, mag_ok, 'b', 'filled', 'MarkerSize', 3);
title('Espectro - Amostragem OK');
xlabel('Frequência (Hz)'); ylabel('Magnitude');
xline(f_sinal,'r--','400 Hz');
grid on;

subplot(2,2,3);
plot(t_bad(1:50)*1000, x_bad(1:50));
title(sprintf('Sinal com aliasing\nFs = %d Hz (insuficiente)', Fs_bad));
xlabel('Tempo (ms)'); ylabel('Amplitude'); grid on;

subplot(2,2,4);
stem(f_bad, mag_bad, 'r', 'filled', 'MarkerSize', 3);
title('Espectro - COM ALIASING');
xlabel('Frequência (Hz)'); ylabel('Magnitude');
% A frequência real é 400 Hz, mas como Fs=500, Nyquist=250 Hz
% O alias aparece em: |f_sinal - Fs_bad| = |400-500| = 100 Hz
f_alias = abs(f_sinal - Fs_bad);
xline(f_alias,'k--',sprintf('Alias: %d Hz',f_alias));
grid on;

fprintf('Frequência real do sinal: %d Hz\n', f_sinal);
fprintf('Nyquist para Fs=%d Hz: %d Hz\n', Fs_bad, Fs_bad/2);
fprintf('Como %d > %d (Nyquist), ocorre aliasing.\n', f_sinal, Fs_bad/2);
fprintf('O alias aparece em: |%d - %d| = %d Hz\n', f_sinal, Fs_bad, f_alias);

% DISCUSSÃO:
% Com Fs=2000 Hz, o espectro mostra corretamente o pico em 400 Hz.
% Com Fs=500 Hz (abaixo de Nyquist=800 Hz para este sinal),
% a frequência de 400 Hz não pode ser representada e aparece
% "disfarçada" como 100 Hz. Isso é aliasing: a frequência original
% é perdida para sempre.
