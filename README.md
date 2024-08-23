# Teste_Analytics_PedroCoelho

O arquivo DataSimulation.R é o script que gera os dados de forma aleatória. Nele está a função SimulateData(n, seed), em que n define a quantidade de observações a serem geradas e, caso n seja menor que 50, a função retorna uma mensagem de erro. A fim de permitir a reprodutibilidade dos resultados, uma seed pode ser escolhida.
Foram considerados 10 produtos dividos em 3 categorias da seguinte forma:
- Portátil: smartphone (ID = 1, preço = 1500), fone (ID = 2, preço = 150), carregador (ID = 3, preço = 100), tablet (ID = 4, preço = 2000);
- Informática: notebook (ID = 5, preço = 3000), impressora (ID = 6, preço = 1000), monitor (ID =  7, preço = 800), TV (ID = 8, preço = 3500);
- Eletrodoméstico: máquina de lavar (ID = 9, preço = 2750) e geladeira (ID = 10, preço = 4500).
Para gerar um novo conjunto de dados, é só chamar a função SimulateData(n, seed), com o tamanho (n) e a seed desejada.
