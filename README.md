# Teste_Analytics_PedroCoelho

O arquivo DataSimulation.R é o script que gera os dados de forma aleatória. Nele está a função SimulateData(n, seed), em que n define a quantidade de observações a serem geradas e, caso n seja menor que 50, a função retorna uma mensagem de erro. A fim de permitir a reprodutibilidade dos resultados, uma seed pode ser escolhida.
Foram considerados 10 produtos dividos em 3 categorias da seguinte forma:
- Portátil: smartphone, fone, carregador, tablet
- Informática: notebook, impressora, monitor, TV
- Eletrodoméstico: máquina de lavar e geladeira.
