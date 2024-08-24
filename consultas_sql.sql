-- Active: 1724423382355@@127.0.0.1@3306-- Active: 1724423382355@@127.0.0.1@3306
CREATE DATABASE data_clean;
USE data_clean;

CREATE TABLE dados (
    ID INT,
    Data_compra DATE,
    Produto VARCHAR(100),
    Categoria VARCHAR(100),
    Quantidade INT,
    Preço FLOAT
);

LOAD DATA LOCAL INFILE 'C:/Users/pedro/OneDrive/Pedro/Estágios e empregos/Quod/data_clean.csv'
INTO TABLE dados
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT *
FROM dados;

SELECT Produto, Categoria, SUM(Preço*Quantidade) as Total_vendido
FROM dados 
GROUP BY Produto, Categoria
ORDER BY Total_vendido DESC;

--Produtos que venderam menos em total de vendas
SELECT Produto, SUM(Preço*Quantidade) as Total_vendas
FROM dados
WHERE MONTH(Data_compra) = 6
GROUP BY Produto
ORDER BY Total_vendas;

--Produtos que venderam menos em quantidade
SELECT Produto, SUM(Quantidade) as Quantidade
FROM dados
WHERE MONTH(Data_compra) = 6
GROUP BY Produto
ORDER BY Quantidade;