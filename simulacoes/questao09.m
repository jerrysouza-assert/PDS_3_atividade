% QUESTÃO 9 - Frequência fundamental + harmônico
% Simula o tipo de sinal visto em vibração mecânica:
% uma componente principal e seus múltiplos (harmônicos)


clear; clc; close all;

N  = 512;
Fs = 1000;   % Hz
n  = 0:N-1;
t  = n/Fs;   % tempo em segundos

% Frequência fundamental (ex: rotação de uma máquina a 50 Hz)
f_fund = 50;          % Hz - componente principal
f_harm = 2*f_fund;    % 100 Hz - 2° harmônico (falha típica de engrenagem)
f_harm3 = 3*f_fund;   % 150 Hz - 3° harmônico

% Amplitudes (o harmônico tem amplitude menor)
A1 = 1.0;    % componente principal
A2 = 0.4;    % 2° harmônico
A3 = 0.2;    % 3° harmônico

% Sinal composto
x = A1*sin(2*pi*f_fund*t) + A2*sin(2*pi*f_harm*t) + A3*sin(2*pi*f_harm3*t);

% FFT
X      = fft(x);
freq   = (0:N-1)*(Fs/N);   % frequência em Hz
metade = 1:N/2;
mag    = abs(X(metade)) / N;
f_eixo = freq(metade);

% --- Plotar ---
figure('Name','Questão 9 - Harmônicos','NumberTitle','off');

subplot(2,1,1);
plot(t(1:100)*1000, x(1:100), 'b');
title('Sinal de vibração no domínio do tempo');
xlabel('Tempo (ms)'); ylabel('Amplitude'); grid on;

subplot(2,1,2);
stem(f_eixo, mag, 'r', 'filled', 'MarkerSize', 3);
title('Espectro de Magnitude - Identificação de Harmônicos');
xlabel('Frequência (Hz)'); ylabel('Magnitude');
xlim([0 Fs/2]);
% Marcar as frequências conhecidas
xline(f_fund,  'b--', sprintf('%d Hz (fundamental)', f_fund));
xline(f_harm,  'g--', sprintf('%d Hz (2° harmônico)', f_harm));
xline(f_harm3, 'm--', sprintf('%d Hz (3° harmônico)', f_harm3));
grid on;

% Identificar picos automaticamente
[picos, idx] = findpeaks(mag, 'MinPeakHeight', 0.05, 'SortStr','descend');
fprintf('=== Picos detectados no espectro ===\n');
for i = 1:min(5, length(idx))
    fprintf('  f = %6.1f Hz  |  magnitude = %.4f\n', f_eixo(idx(i)), picos(i));
end

% DISCUSSÃO:
% Máquinas rotativas geralmente produzem vibrações com frequência
% igual à velocidade de rotação (frequência fundamental) mais
% harmônicos (múltiplos inteiros). A presença de harmônicos no
% espectro e a relação entre as amplitudes desses picos é usada
% no diagnóstico de falhas:
%   - 2° harmônico forte: pode indicar desbalanceamento
%   - 3° harmônico: pode indicar problemas em engrenagens
% Sem a análise espectral, seria muito difícil identificar
% essas componentes só observando o sinal no tempo.
