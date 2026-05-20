# PDS – Estudo Dirigido Parte 3
## Organização do Repositório



├── teoria/
│   └── resumo_teorico.docx       ← Resumo conceitual dos tópicos
├── simulacoes/
│   ├── questao01.m              ← Senoide discreta e FFT
│   ├── questao02.m              ← Soma de senoides
│   ├── questao03.m              ← Aliasing
│   ├── questao04.m              ← Janelamento (Hamming/Hann)
│   ├── questao05.m              ← Sinal com ruído aditivo
│   ├── questao06.m              ← DFT direta vs fft()
│   ├── questao07.m              ← Transformada-Z e estabilidade
│   ├── questao08.m              ← Resolução espectral
│   ├── questao09.m              ← Harmônicos e vibração mecânica
│   └── questao10.m              ← Análise de sinal real simulado
├── resultados/
│   ├── questao01.ofig              ← Senoide discreta e FFT
│   ├── questao02.ofig              ← Soma de senoides
│   ├── questao03.ofig              ← Aliasing
│   ├── questao04_janelamento.ofig  ← Janelamento (Hamming/Hann)
│   ├── questao04_comaracao.ofig    ← Compara o espectro sem janela (retangular) e com janela de Hamming para reduzir o vazamento
│   ├── questao05.ofig              ← Sinal com ruído aditivo
│   ├── questao06.ofig              ← DFT direta vs fft()
│   ├── questao07.ofig              ← Transformada-Z e estabilidade
│   ├── questao08.ofig              ← Resolução espectral
│   ├── questao09.ofig              ← Harmônicos e vibração mecânica
│   └── questao10.ofig              ← Análise de sinal real simulado└── 
└── README.md

## Como Executar

Os scripts foram desenvolvidos para Octave.  
Para rodar no Octave, instale o pacote `signal`:

pkg install -forge signal
pkg load signal
```

Para rodar cada questão, abra o Octave e execute:
navegue até a pasta e rode diretamente pelo nome do arquivo.



## Resumo das Questões

| # | Tema | Conceito principal |

1 - Senoide e FFT | Como a FFT revela a frequência de um sinal |
2 - Soma de senoides | Separação de componentes no espectro |
3 - Aliasing | Efeito da amostragem insuficiente |
4 - Janelamento | Redução do vazamento espectral |
5 - Sinal com ruído | FFT na presença de perturbações |
6 - DFT direta vs FFT | Equivalência e eficiência computacional |
7 - Transformada-Z | Estabilidade pelo diagrama de polos |
8 - Resolução espectral | Influência do número de amostras |
9 - Harmônicos | Diagnóstico de falhas mecânicas |
10 - Sinal real | Aplicação prática em vibração de motor |



## Problema Norteador (PBL)

*Como identificar, a partir do conteúdo espectral de um sinal real, informações sobre o comportamento dinâmico de um sistema físico, e quais limitações práticas devem ser consideradas?*

As questões 9 e 10 respondem diretamente a essa pergunta: a análise espectral (FFT) permite identificar frequências características de funcionamento e falhas em máquinas. As principais limitações práticas são:

**Taxa de amostragem inadequada** → aliasing (Q3)
**Truncamento do sinal** → vazamento espectral (Q4)
**Ruído de fundo** → pode mascarar componentes fracas (Q5)
**Número de amostras pequeno** → baixa resolução espectral (Q8)



## Ferramentas Utilizadas

- GNU Octave 9.x ou superior
- Funções: `fft`, `fftshift`, `filter`, `freqz`, `zplane`, `hamming`, `hann`, `findpeaks`
