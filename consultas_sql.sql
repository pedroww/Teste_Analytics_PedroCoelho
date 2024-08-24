-- Active: 1724423382355@@127.0.0.1@3306-- Active: 1724423382355@@127.0.0.1@3306
CREATE DATABASE data_clean;
USE data_clean;

CREATE TABLE minha_tabela (
    ID INT,
    Data_compra DATE,
    Produto VARCHAR(100),
    Categoria VARCHAR(100),
    Quantidade INT,
    Preço FLOAT
    -- adicione mais colunas conforme necessário
);

LOAD DATA LOCAL INFILE 'https://raw.githubusercontent.com/pedroww/Teste_Analytics_PedroCoelho/main/data_clean.csv'
INTO TABLE minha_tabela
FIELDS TERMINATED BY ','  -- ou outro delimitador que seu CSV usa
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * 
FROM data_clean