% QUESTÃO 10 - Análise espectral de sinal real simulado
% Simula uma vibração mecânica com componentes realistas:
% rotação principal + harmônico + ruído de fundo
% (caso não tenha áudio real disponível)

clear; clc; close all;

% Parâmetros do sistema simulado
Fs      = 4000;    % Hz - taxa de amostragem
duracao = 1.0;     % segundos
N       = Fs * duracao;
t       = (0:N-1)/Fs;

% Componentes do sinal (simulando motor com falha de rolamento)
f_rot    = 60;    % Hz - frequência de rotação (3600 RPM)
f_falha  = 180;   % Hz - frequência de falha (3x fundamental = rolamento danificado)
f_ruido  = 0;     % ruído branco adicionado depois

% Gerar sinal
x_motor  = 1.0 * sin(2*pi*f_rot*t);
x_falha  = 0.3 * sin(2*pi*f_falha*t);
x_ruido  = 0.15 * randn(1, N);

x = x_motor + x_falha + x_ruido;

% FFT com janela de Hamming (boa prática para sinais reais)
janela = hamming(N)';
x_jan  = x .* janela;

X      = fft(x_jan);
freq   = (0:N-1)*(Fs/N);
metade = 1:N/2;
mag    = abs(X(metade)) / (N/2);
f_eixo = freq(metade);

% --- Plotar ---
figure('Name','Questão 10 - Sinal Real Simulado','NumberTitle','off');

% Sinal no tempo (só os primeiros 500ms para melhor visualização)
amostras_vis = round(0.05*Fs);  % 50ms
subplot(3,1,1);
plot(t(1:amostras_vis)*1000, x(1:amostras_vis), 'b');
title('Sinal de vibração (tempo) - 50ms');
xlabel('Tempo (ms)'); ylabel('Amplitude (g)'); grid on;

% Espectro completo
subplot(3,1,2);
plot(f_eixo, mag, 'r');
title('Espectro de Magnitude (0 – Nyquist)');
xlabel('Frequência (Hz)'); ylabel('Magnitude'); grid on;
xlim([0 500]);

% Zoom na região de interesse
subplot(3,1,3);
stem(f_eixo(f_eixo <= 400), mag(f_eixo <= 400), 'g', 'filled', 'MarkerSize', 2);
title('Espectro com zoom (0 – 400 Hz) - identificação de componentes');
xlabel('Frequência (Hz)'); ylabel('Magnitude'); grid on;
xline(f_rot,   'b--', sprintf('%d Hz (rotação)', f_rot));
xline(f_falha, 'r--', sprintf('%d Hz (falha!)', f_falha));

% Identificar picos
[picos, idx] = findpeaks(mag(f_eixo <= 400), 'MinPeakHeight', 0.05, ...
                          'MinPeakProminence', 0.04, 'SortStr','descend');
freqs_pico   = f_eixo(f_eixo <= 400);

fprintf('=== Análise Espectral do Sinal Real Simulado ===\n');
fprintf('Frequência de amostragem: %d Hz\n', Fs);
fprintf('Duração do sinal: %.1f s (%d amostras)\n', duracao, N);
fprintf('Resolução espectral: Δf = %.4f Hz\n\n', Fs/N);

fprintf('Picos encontrados no espectro:\n');
for i = 1:min(5, length(idx))
    fprintf('  f = %6.1f Hz  |  magnitude = %.4f\n', freqs_pico(idx(i)), picos(i));
end

fprintf('\nInterpretação física:\n');
fprintf('  Pico em ~%d Hz -> frequência de rotação do motor (esperado)\n', f_rot);
fprintf('  Pico em ~%d Hz -> 3° harmônico, indicativo de falha no rolamento\n', f_falha);
fprintf('  Ruído de fundo distribuído por todo o espectro\n');

% DISCUSSÃO:
% Este sinal simula uma leitura de acelerômetro instalado em um motor.
% A análise espectral permite identificar:
%   1. A frequência de rotação do motor (componente principal em 60 Hz)
%   2. Uma possível falha de rolamento (pico em 180 Hz = 3x60)
%   3. Ruído elétrico ou mecânico de fundo
% Na prática, técnicos de manutenção preditiva usam exatamente
% essa abordagem para detectar falhas antes que causem paradas.
% O sinal no tempo não permite essa conclusão diretamente.
