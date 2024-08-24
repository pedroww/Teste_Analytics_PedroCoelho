library(ggplot2)
library(dplyr)
library(lubridate)

SimulateData = function(n = 50, seed = NULL){
  if(n<50){
    stop("'n' deve ser pelo menos 50")
  }
  set.seed(seed)
  
  #dataframe com as identificações dos produtos para fazer o join posteriormente
  df_ID = data.frame(ID = 1:10,
                     Produto = c('Smartphone', 'Fone', 'Carregador',
                                 'Tablet', 'Notebook',
                                 'Impressora', 'Monitor', 'TV',
                                 'Máquina de lavar', 'Geladeira'),
                     Categoria = c(rep('Portátil', 4),
                                   rep('Informática', 3),
                                   rep('Eletrodoméstico', 3)),
                     Preço = c(1500, 150, 100,
                               2000, 3000, 1000,
                               800, 2500, 2250,
                               3000))
  
  #gerando datas aleatórias dentro do intervalo [01-01-2023,31-12-2023]
  dates = sort(sample(seq(as.POSIXct('2023-01-01'), as.POSIXct('2023-12-31'), by = "day"), n))
  #gerando amostra dos produtos
  produtos = sample(df_ID$Produto, n, replace = T)
  qtd = qtd = sample(1:10, n,replace = T, prob = seq(0.01,.99,length.out=10))
  
  df_sim = data.frame(Data = dates,
                      Produto = produtos,
                      Quantidade = qtd)
  
  dados_sim = left_join(df_sim, df_ID, by = 'Produto')
  
  #variaveis q terão NAs
  vars_nas = c('ID', 'Produto', 'Categoria')
  #numero de NAs em cada variável
  number_nas = list('ID' = sample(1:4,1), 'Produto' = sample(1:4,1), 'Categoria' = sample(1:4,1))
  #linhas que terão NAs
  linhas_nas = lapply(number_nas, sample, x=1:nrow(dados_sim), replace = F)
  #inserindo os NAs dos dados
  for (i in 1:length(linhas_nas)) {
    dados_sim[linhas_nas[[i]], names(linhas_nas)[i]] = NA
  }
  
  #inserindo duplicatas (no max 5)
  qtd_dup = sample(1:5,1)
  remover = sample(1:n, size = qtd_dup, replace = F)
  dados_sim = dados_sim[-remover,]
  linhas_dup = sample(1:dim(dados_sim)[1], size = qtd_dup, replace = F)
  duplicatas = dados_sim[linhas_dup,]
  dados_sim = rbind(dados_sim, duplicatas)
  
  #reordenando as colunas
  dados_sim = dados_sim[,c('ID', 'Data', 'Produto',
                           'Categoria', 'Quantidade', 'Preço')]
  
  rownames(dados_sim) = NULL
  
  return(dados_sim)

}

dados = SimulateData(100, seed = 123)

#identificando variáveis com valores faltantes
colSums(is.na(dados))

dados[rowSums(is.na(dados))>0,]

#podemos recuperar os dados faltantes através das demais variáveis
dados[is.na(dados$ID) & dados$Produto == 'Impressora', 'ID'] = 6
dados[is.na(dados$ID) & dados$Produto == 'Máquina de lavar', 'ID'] = 9
dados[is.na(dados$ID) & dados$Produto == 'TV', 'ID'] = 8
dados[is.na(dados$Produto) & dados$ID == 9, 'Produto'] = 'Máquina de lavar'
dados[is.na(dados$Categoria), 'Categoria'] = 'Informática'


#verificando se todos NAs foram corrigidos
colSums(is.na(dados))

#identificando as duplicatas
dados[duplicated(dados),]

#salvando o conjunto de dados sem duplicatas
dados_clean = dados[!duplicated(dados),]

#salvando o conjunto de dados num arquivo csv
#write.csv(dados_clean, 'C:/Users/pedro/OneDrive/Pedro/Estágios e empregos/Quod/data_clean.csv', row.names = F)


#criando a coluna Venda_total
dados_clean$Venda_total = dados_clean$Quantidade*dados_clean$Preço

#produto com maior venda total
dados_clean |> group_by(Produto) |> summarise(Total_vendido = sum(Venda_total)) |>
  arrange(desc(Total_vendido))






