% QUESTÃO 6 - DFT direta vs função fft()
% Implementa a DFT pela definição matemática e compara
% com o resultado da fft() do MATLAB/Octave


clear; clc; close all;

% Sinal curto (poucos pontos pra DFT direta não demorar tanto)
N = 32;
n = 0:N-1;
f0 = 0.1;
x  = sin(2*pi*f0*n) + 0.5*cos(2*pi*0.25*n);

% --- DFT DIRETA (pela definição matemática) ---
% X[k] = sum_{n=0}^{N-1} x[n] * exp(-j*2*pi*k*n/N)
tic;
X_dft = zeros(1, N);
for k = 0:N-1
    soma = 0;
    for m = 0:N-1
        soma = soma + x(m+1) * exp(-1j * 2*pi * k * m / N);
    end
    X_dft(k+1) = soma;
end
tempo_dft = toc;

% --- FFT do MATLAB ---
tic;
X_fft = fft(x);
tempo_fft = toc;

% Comparar resultados
diferenca_max = max(abs(X_dft - X_fft));

fprintf('=== Comparação DFT direta vs FFT ===\n');
fprintf('Diferença máxima entre os resultados: %.2e\n', diferenca_max);
fprintf('(Valores praticamente iguais - diferença é erro numérico)\n\n');
fprintf('Tempo DFT direta: %.6f segundos\n', tempo_dft);
fprintf('Tempo FFT:        %.6f segundos\n', tempo_fft);
fprintf('A FFT foi %.1fx mais rápida!\n\n', tempo_dft/tempo_fft);

% Complexidade teórica
fprintf('=== Custo computacional teórico ===\n');
fprintf('DFT direta: N² = %d² = %d operações\n', N, N^2);
fprintf('FFT:        N·log2(N) = %d·%.1f ≈ %d operações\n', N, log2(N), round(N*log2(N)));

% --- Plotar comparação ---
freq   = (0:N-1)/N;
metade = 1:N/2;

figure('Name','Questão 6 - DFT vs FFT','NumberTitle','off');

subplot(2,1,1);
stem(freq(metade), abs(X_dft(metade))/N, 'b', 'filled', 'MarkerSize',5); hold on;
stem(freq(metade), abs(X_fft(metade))/N, 'r--', 'filled', 'MarkerSize',3);
legend('DFT direta','FFT');
title('Espectro: DFT direta vs FFT (resultados idênticos)');
xlabel('Frequência Normalizada'); ylabel('Magnitude'); grid on;

subplot(2,1,2);
bar([tempo_dft, tempo_fft]*1000, 0.4);
set(gca,'XTickLabel',{'DFT direta','FFT'});
title('Tempo de execução (ms)');
ylabel('Tempo (ms)'); grid on;

% DISCUSSÃO:
% Os espectros são idênticos (a diferença é só erro de ponto flutuante).
% A FFT calcula exatamente a mesma coisa, mas usando o algoritmo
% de divisão e conquista de Cooley-Tukey, que reduz o número de
% operações de N² para N*log2(N). Para N=32 a diferença já aparece;
% para N=1024 ou maior, a FFT é centenas de vezes mais rápida.
