CREATE DATABASE PIZZARIA_JRS;

USE PIZZARIA_JRS;

CREATE TABLE PRODUTO(
ID_PRODUTO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NM_PRODUTO VARCHAR(255) NOT NULL,
DS_PRODUTO VARCHAR(255) NULL DEFAULT NULL,
VAL_PRODUTO DOUBLE(10,2) NOT NULL);

CREATE TABLE CLIENTE(
NM_CLIENTE VARCHAR(255) NOT NULL,
CD_TELEFONE VARCHAR(16) NOT NULL,
CD_CEP VARCHAR(9) NOT NULL,
NM_BAIRRO VARCHAR(255) NOT NULL, 
NM_ENDERECO VARCHAR(255) NOT NULL,
CD_NUMERO VARCHAR(10) NOT NULL,
CD_COMPLEMENTO VARCHAR(15) NOT NULL,
CONSTRAINT PK_TELEFONE PRIMARY KEY(CD_TELEFONE)
);

CREATE TABLE STATUS_PEDIDO(
ID_STATUS INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NM_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE PEDIDO(
ID_PEDIDO INT NOT NULL AUTO_INCREMENT,
CD_TELEFONE_CLIENTE VARCHAR(16) NOT NULL,
DS_OBSERVACAO VARCHAR(255) NULL,
DT_EFETUADO DATETIME NOT NULL,
DT_ENTREGUE DATETIME NULL,
ID_STATUS_PEDIDO INT NOT NULL,
VAL_TOTAL DOUBLE(10,2) NULL,
CONSTRAINT PK_PEDIDO 
		PRIMARY KEY(ID_PEDIDO),
CONSTRAINT FK_TELEFONE_CLIENTE
		FOREIGN KEY(CD_TELEFONE_CLIENTE)
        REFERENCES CLIENTE(CD_TELEFONE),
CONSTRAINT FK_STATUS_PEDIDO
		FOREIGN KEY(ID_STATUS_PEDIDO)
        REFERENCES STATUS_PEDIDO(ID_STATUS)
);

CREATE TABLE PRODUTO_PEDIDO(
ID_PEDIDO INT NOT NULL,
ID_PRODUTO INT NOT NULL,
QT_PRODUTO INT NOT NULL DEFAULT 1,
VAL_UNIT DOUBLE(10,2) NOT NULL,
CONSTRAINT FK_PEDIDO
		FOREIGN KEY(ID_PEDIDO)
		REFERENCES PEDIDO(ID_PEDIDO),
CONSTRAINT FK_PRODUTO
		FOREIGN KEY(ID_PRODUTO)
		REFERENCES PRODUTO(ID_PRODUTO)
);

INSERT INTO PRODUTO(NM_PRODUTO, DS_PRODUTO, VAL_PRODUTO) VALUES
("ALHO", "PIZZA DE MUSSARELA COBERTA COM ALHO", "12.00"),
("CALABRESA", "PIZZA DE CALABRESA COBERTA COM CEBOLA", "12.00"),
("MUSSARELA", "PIZZA DE MUSSARELA COM ORÉGANO E TOMATE", "12.00"),
("DOIS QUEIJOS", "PIZZA DE CATUPIRY COM MUSSARELA", "12.00"),
("BRÓCOLIS", "PIZZA DE BRÓCOLIS COBERTO COM MUSARELA", "12.00"),
("MISTA", "PIZZA DE PRESUNTO COBERTO COM MUSSARELA", "12.00"),
("CATUPIRY", "PIZZA DE CATUPIRY", "12.00"),
("MILHO", "PIZZA DE MUSSARELA COBERTO COM MILHO", "12.00"),
("CAIPIRA", "PIZZA DE FRANGO E MILHO COBERTO COM CATUPIRY", "12.00"),
("ATUM", "PIZZA DE ATUM COBERTO COM CEBOLA", "12.00"),
("ESCAROLA", "PIZZA DE ESCAROLA COBERTA COM MUSSARELA", "12.00"),
("PAULISTA", "PIZZA DE CALABRESA COBERTA COM MUSSARELA", "12.00"),
("GUARANA ANTARTICA 2L", "REFRIGERANTE", "7.00"),
("GUARANA ANTARTICA LATA", "REFRIGERANTE", "4.00"),
("COCA-COLA 2L", "REFRIGERANTE", "9.00"),
("COCA-COLA LATA", "REFRIGERANTE", "4.00"),
("SUCO DE LARANJA", "SUCO NATURAL", "6.00"),
("SUCO DE LIMÃO", "SUCO NATURAL", "6.00");

INSERT INTO STATUS_PEDIDO(NM_STATUS) VALUES
("ABERTO"),
("EM ENTREGA"),
("CANCELADO"),
("ENTREGUE");

INSERT INTO CLIENTE(NM_CLIENTE, CD_TELEFONE, CD_CEP, NM_BAIRRO, NM_ENDERECO, CD_NUMERO, CD_COMPLEMENTO) VALUES
("JUNIOR SANTOS", "1398107-1988", "11305503", "CIDADE NAUTICA", "RUA 10", "192", "CASA 02"),
("RODRIGO SANTOS", "1398107-2132", "11922503", "PARQUE SAO VICENTE", "RUA 22", "192", "CASA"),
("ROSANE SANTOS", "139154-1988", "11232503", "BOQUEIRAO", "RUA 23", "192", "APRT 2"),
("JOSEFA SANTOS", "1391235-1232", "11123503", "CATIAPOA", "RUA 43", "192", "CASA"),
("ANA SANTOS", "1392342-3243", "11123503", "JAPUI", "RUA 11", "192", "CASA");


INSERT INTO PEDIDO(CD_TELEFONE_CLIENTE, DS_OBSERVACAO, DT_EFETUADO, DT_ENTREGUE, ID_STATUS_PEDIDO, VAL_TOTAL) VALUES
("1398107-1988", "ENTREGA EM 50 MINUTOS", "2019/07/04", "2019/07/04", "3", "30.00");

INSERT INTO PRODUTO_PEDIDO(ID_PEDIDO, ID_PRODUTO, QT_PRODUTO, VAL_UNIT) VALUES
(1, 2, 1, "20.00"),
(1, 5, 1, "10.00");

SELECT PE.ID_PEDIDO, CL.NM_CLIENTE, PR.NM_PRODUTO, PR.VAL_PRODUTO FROM PRODUTO_PEDIDO AS PP
INNER JOIN PEDIDO AS PE
INNER JOIN PRODUTO AS PR
INNER JOIN CLIENTE AS CL
ON PP.ID_PEDIDO = PE.ID_PEDIDO AND PP.ID_PRODUTO = PR.ID_PRODUTO AND PE.CD_TELEFONE_CLIENTE = CL.CD_TELEFONE;

#Juntando tabelas COM INNER JOIN#
SELECT PE.ID_PEDIDO, CL.NM_CLIENTE, PE.DT_ENTREGUE, ST.NM_STATUS, PE.VAL_TOTAL FROM PEDIDO AS PE
INNER JOIN CLIENTE AS CL
INNER JOIN STATUS_PEDIDO AS ST
ON PE.CD_TELEFONE_CLIENTE = CL.CD_TELEFONE AND PE.ID_STATUS_PEDIDO = ST.ID_STATUS;

#Juntando tabelas sem usar INNER JOIN#
SELECT PE.ID_PEDIDO, CL.NM_CLIENTE, PE.DT_ENTREGUE, ST.NM_STATUS, PE.VAL_TOTAL
	FROM PEDIDO PE,
    CLIENTE CL,
    STATUS_PEDIDO ST
WHERE PE.CD_TELEFONE_CLIENTE = CL.CD_TELEFONE AND PE.ID_STATUS_PEDIDO = ST.ID_STATUS;
