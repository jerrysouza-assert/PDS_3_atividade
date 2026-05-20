% QUESTÃO 7 - Resposta ao impulso e estabilidade
% Função de transferência: H(z) = 1 / (1 - 0.8*z^-1)
% Analisa se o sistema é estável pela resposta ao impulso
% e pela posição dos polos no plano-z


clear; clc; close all;

% Coeficientes do filtro (numerador e denominador)
% H(z) = 1 / (1 - 0.8*z^-1)  =>  b = [1], a = [1, -0.8]
b = [1];
a = [1, -0.8];

% --- Resposta ao impulso (via filtro aplicado ao delta) ---
N = 60;
delta = [1, zeros(1,N-1)];   % impulso unitário
h = filter(b, a, delta);

% --- Plotar resposta ao impulso ---
figure('Name','Questão 7 - Estabilidade','NumberTitle','off');

subplot(2,2,1);
stem(0:N-1, h, 'b', 'filled', 'MarkerSize', 4);
title('Resposta ao Impulso h[n]');
xlabel('Amostras (n)'); ylabel('Amplitude');
grid on;

% --- Diagrama de polos e zeros ---
subplot(2,2,2);
zplane(b, a);
title('Diagrama de Polos e Zeros (plano-z)');
% Polo em z = 0.8 (dentro do círculo unitário -> estável)

% --- Módulo da resposta ao impulso (decaimento) ---
subplot(2,2,3);
stem(0:N-1, abs(h), 'r', 'filled', 'MarkerSize', 4);
title('Módulo de h[n] (verifica se converge para zero)');
xlabel('Amostras (n)'); ylabel('|h[n]|');
grid on;

% --- Resposta em frequência ---
subplot(2,2,4);
[H, w] = freqz(b, a, 512);
plot(w/pi, abs(H), 'g', 'LineWidth', 1.5);
title('Resposta em Frequência |H(e^{j\omega})|');
xlabel('Frequência Normalizada (\pi rad/amostra)');
ylabel('Magnitude'); grid on;

% --- Verificar estabilidade ---
polos = roots(a);

fprintf('=== Análise de Estabilidade ===\n');
fprintf('Polo(s) do sistema: z = %.4f\n', polos);
fprintf('Módulo do polo: |z| = %.4f\n', abs(polos));

if all(abs(polos) < 1)
    fprintf('STATUS: SISTEMA ESTÁVEL\n');
    fprintf('(Todos os polos estão dentro do círculo unitário)\n');
else
    fprintf('STATUS: SISTEMA INSTÁVEL\n');
    fprintf('(Existe polo fora do círculo unitário)\n');
end

fprintf('\nValor de h[n] em n=0: %.4f\n', h(1));
fprintf('Valor de h[n] em n=%d: %.2e\n', N-1, h(end));
fprintf('A sequência vai decaindo para zero -> confirma estabilidade\n');

% DISCUSSÃO:
% O polo de H(z) está em z = 0.8, que tem módulo 0.8 < 1.
% Como o polo está dentro do círculo unitário no plano-z,
% o sistema é estável. Isso se confirma olhando h[n]:
% a sequência começa em 1 e vai decaindo exponencialmente,
% convergindo para zero. Se o polo fosse > 1 (ex: z=1.2),
% h[n] cresceria indefinidamente = sistema instável.
