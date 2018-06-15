--COMENTARIOS GERAIS:
-- -> TALVEZ FAZER END VIRAR UMA TABELA?

CREATE TABLE FORNECEDOR(
	CNPJ VARCHAR2(18) NOT NULL,
	NOME VARCHAR2(75) NOT NULL,
	TELEFONE VARCHAR2(13) NOT NULL,
	DADOS_BANCARIOS NUMBER NOT NULL,
	CONSTRAINT PK_FORNECEDOR PRIMARY KEY (CNPJ),
	CONSTRAINT FK_FORNECEDOR FOREIGN KEY(DADOS_BANCARIOS) REFERENCES DADOS_BANCARIOS(ID) ON DELETE CASCADE
	CONSTRAINT CK_FORNECEDOR_CNPJ CHECK (CNPJ LIKE '__.___.___/____-__'),
	CONSTRAINT CK_FORNECEDOR_TELEFONE CHECK (TELEFONE LIKE '(__)____-____')
);

CREATE TABLE DADOS_BANCARIOS(
	ID NUMBER NOT NULL AUTO_INCREMENT,
	BANCO VARCHAR2(3) NOT NULL,
	AGENCIA VARCHAR2(4) NOT NULL,
	CONTA VARCHAR2(10) NOT NULL,
	TIPO_CONTA VARCHAR(2) NOT NULL,

	CONSTRAINT PK_DADOS_BANCARIOS (ID),
	CONSTRAINT UQ_DADOS_BANCARIOS UNIQUE (BANCO, AGENCIA, CONTA),
	CONSTRAINT CK_TIPO_CONTA CHECK (UPPER(TIPO_CONTA) IN ("CC" , "CP"))
);

CREATE TABLE CLIENTE(
	CPF VARCHAR2(13) NOT NULL,
	NOME VARCHAR2(75) NOT NULL,
	DADOS_BANCARIOS NUMBER NOT NULL,
	TEL_FIXO VARCHAR2(10),
	TEL_MOVEL VARCHAR2(11) NOT NULL,
	ENDERECO VARCHAR(200) NOT NULL,

	CONSTRAINT PK_CLIENTE PRIMARY KEY (CPF),
	CONSTRAINT FK_CLIENTE FOREIGN KEY (DADOS_BANCARIOS) REFERENCES DADOS_BANCARIOS(ID) ON DELETE CASCADE
	CONSTRAINT CK_CLIENTE_CPF CHECK (CPF LIKE '___.___.___-__'),
	CONSTRAINT CK_CLIENTE_TEL_FIXO CHECK (TEL_FIXO LIKE '(__)____-____'),
	CONSTRAINT CK_FORNECEDOR_TEL_MOVEL CHECK (TEL_MOVEL LIKE '(__)_____-____')
);

CREATE TABLE FESTA(
	CLIENTE VARCHAR(13) NOT NULL,
	DATA DATE NOT NULL,
	NUMERO_CONVIDADOS NUMBER(5) NOT NULL, 
	TIPO CHAR(1) NOT NULL,
	PRECO NUMBER(8,2),
	CASA_FESTA VARCHAR(75) NOT NULL,
	GERENTE VARCHAR(13) NOT NULL,

	CONSTRAINT PK_FESTA PRIMARY KEY (CLIENTE, DATA),
	CONSTRAINT FK1_FESTA FOREIGN KEY CLIENTE REFERENCES CLIENTE(CPF) ON DELETE CASCADE,
	CONSTRAINT FK2_FESTA FOREIGN KEY CASA_FESTA REFERENCES CASA_FESTA(NOME) ON DELETE CASCADE,
	CONSTRAINT FK3_FESTA FOREIGN KEY GERENTE REFERENCES GERENTE(CPF) ON DELETE CASCADE,
	CONSTRAINT CK_FESTA_TIPO CHECK (TIPO IN ('A', 'C'))
);

CREATE TABLE ANIVERSARIO(
	CLIENTE VARCHAR(13) NOT NULL,
	DATA DATE NOT NULL,
	NOME_ANIVERSARIANTE VARCHAR2(75),
	TEMA VARCHAR2(30),
	FAIXA_ETARIA VARCHAR2(5)

	CONSTRAINT PK_ANIVERSARIO PRIMARY KEY (CLIENTE, DATA),
	CONSTRAINT FK_ANIVERSARIO FOREIGN KEY (CLIENTE, DATA) REFERENCES FESTA(CLIENTE, DATA) ON DELETE CASCADE,
	CONSTRAINT CK_FAIXA_ETARIA CHECK (UPPER(FAIXA_ETARIA) IN ("0-3","4-7","8-13","14+"))
);

CREATE TABLE CASAMENTO(
	CLIENTE VARCHAR(13) NOT NULL,
	DATA DATE NOT NULL,
	NOIVO1 VARCHAR2(75),
	NOIVO2 VARCHAR2(75),

	CONSTRAINT PK_CASAMENTO PRIMARY KEY (CLIENTE, DATA),
	CONSTRAINT FK_CASAMENTO FOREIGN KEY (CLIENTE, DATA) REFERENCES FESTA(CLIENTE, DATA) ON DELETE CASCADE
);

CREATE TABLE CASA_FESTA(
	NOME VARCHAR2(75) NOT NULL,
	ENDERECO VARCHAR2(200) NOT NULL,

	CONSTRAINT PK_CASA_FESTA PRIMARY KEY NOME
);

CREATE TABLE BARRACA_RASPADINHA(
	ID NUMBER(3) NOT NULL AUTO_INCREMENT,
	CLIENTE VARCHAR2(13) NOT NULL,
	DATA DATE NOT NULL,
	NUMERO NUMBER NOT NULL,
	OPERADOR VARCHAR2(13) NOT NULL,

	CONSTRAINT PK_BARRACA_RASPADINHA PRIMARY KEY (ID),
	CONSTRAINT UQ_BARRACA_RASPADINHA UNIQUE (CLIENTE, DATA, NUMERO),
	CONSTRAINT FK1_BARRACA_RASPADINHA FOREIGN KEY (CLIENTE, DATA) REFERENCES ANIVERSARIO(CLIENTE, DATA) ON DELETE CASCADE,
	CONSTRAINT FK2_BARRACA_RASPADINHA FOREIGN KEY OPERADOR REFERENCES OPERADOR(CPF) ON DELETE CASCADE
);

CREATE TABLE ILHA_PERFORMANCE(
	ID NUMBER(3) NOT NULL AUTO_INCREMENT,
	CLIENTE VARCHAR2(13) NOT NULL,
	DATA DATE NOT NULL,
	NUMERO NUMBER(3) NOT NULL,
	BARTENDER VARCHAR2(13) NOT NULL,

	CONSTRAINT PK_ILHA_PERFORMANCE PRIMARY KEY (ID),
	CONSTRAINT UQ_ILHA_PERFORMANCE UNIQUE (CLIENTE, DATA, NUMERO),
	CONSTRAINT FK1_ILHA_PERFORMANCE FOREIGN KEY (CLIENTE, DATA) REFERENCES ANIVERSARIO(CLIENTE, DATA) ON DELETE CASCADE,
	CONSTRAINT FK2_ILHA_PERFORMANCE FOREIGN KEY BARTENDER REFERENCES BARTENDER(CPF) ON DELETE CASCADE
);

CREATE TABLE GERENTE(
	CPF VARCHAR2(13) NOT NULL,
	NOME VARCHAR2(75) NOT NULL,
	TEL_FIXO VARCHAR2(13),
	TEL_MOVEL VARCHAR2(14) NOT NULL,
	COMISSAO NUMBER(7,2) NOT NULL,

	CONSTRAINT PK_GERENTE PRIMARY KEY (CPF),
	CONSTRAINT CK_GERENTE_CPF CHECK (CPF LIKE '___.___.___-__'),
	CONSTRAINT CK_GERENTE_TEL_FIXO CHECK (TEL_FIXO LIKE '(__)____-____'),
	CONSTRAINT CK_GERENTE_TEL_MOVEL CHECK (TEL_FIXO LIKE '(__)_____-____')
);

CREATE TABLE BARTENDER(
	CPF VARCHAR2(13) NOT NULL,
	NOME VARCHAR2(75) NOT NULL,
	TEL_FIXO VARCHAR2(13),
	TEL_MOVEL VARCHAR2(14) NOT NULL,
	COMISSAO NUMBER(7,2) NOT NULL,

	CONSTRAINT PK_BARTENDER PRIMARY KEY (CPF),
	CONSTRAINT CK_BARTENDER_CPF CHECK (CPF LIKE '___.___.___-__'),
	CONSTRAINT CK_BARTENDER_TEL_FIXO CHECK (TEL_FIXO LIKE '(__)____-____'),
	CONSTRAINT CK_BARTENDER_TEL_MOVEL CHECK (TEL_FIXO LIKE '(__)_____-____')
);

CREATE TABLE OPERADOR_RASPADINHA(
	CPF VARCHAR2(13) NOT NULL,
	NOME VARCHAR2(75) NOT NULL,
	TEL_FIXO VARCHAR2(13),
	TEL_MOVEL VARCHAR2(14) NOT NULL,
	COMISSAO NUMBER(7,2) NOT NULL,

	CONSTRAINT PK_OPERADOR_RASPADINHA PRIMARY KEY (CPF),
	CONSTRAINT CK_OPERADOR_RASPADINHA_CPF CHECK (CPF LIKE '___.___.___-__'),
	CONSTRAINT CK_OPERADOR_RASPADINHA_TEL_FIXO CHECK (TEL_FIXO LIKE '(__)____-____'),
	CONSTRAINT CK_OPERADOR_RASPADINHA_TEL_MOVEL CHECK (TEL_FIXO LIKE '(__)_____-____')
);

CREATE TABLE GARCOM(
	CPF VARCHAR2(14) NOT NULL,
	NOME VARCHAR2(75) NOT NULL,
	TEL_FIXO VARCHAR2(13),
	TEL_MOVEL VARCHAR2(14) NOT NULL,
	COMISSAO NUMBER(7,2) NOT NULL,

	CONSTRAINT PK_GARCOM PRIMARY KEY (CPF),
	CONSTRAINT CK_GARCOM_CPF CHECK (CPF LIKE '___.___.___-__'),
	CONSTRAINT CK_GARCOM_TEL_FIXO CHECK (TEL_FIXO LIKE '(__)____-____'),
	CONSTRAINT CK_GARCOM_TEL_MOVEL CHECK (TEL_FIXO LIKE '(__)_____-____')
);

CREATE TABLE BEBIDA(
	NOME VARCHAR(30) NOT NULL,
	VOLUME NUMBER(4) NOT NULL,
	QUANTIDADE NUMBER(5) NOT NULL,
	BANDEJA_BOOL VARCHAR(1) NOT NULL,
	PRECO NUMBER(6,2) NOT NULL,

	CONSTRAINT PK_BEBIDAS PRIMARY KEY (NOME, VOLUME)
);

CREATE TABLE INGREDIENTE(
	NOME VARCHAR2(30) NOT NULL,
	PRECO NUMBER(6,2) NOT NULL,
	CATEGORIA VARCHAR(30) NOT NULL,

	--pensar em algumas categorias prontas para ja colocar a verificaçao aqui
	CONSTRAINT PK_INGREDIENTE PRIMARY KEY (NOME),
);

CREATE TABLE GARCOM_FESTA(
	CLIENTE VARCHAR(13) NOT NULL,
	DATA DATE NOT NULL,
	GARCOM VARCHAR(13) NOT NULL,

	CONSTRAINT PK_GARCOM_FESTA PRIMARY KEY (CLIENTE, DATA, GARCOM)
);

CREATE TABLE BEBIDA_BANDEJA_FESTA(
	CLIENTE VARCHAR2(13) NOT NULL,
	DATA DATE NOT NULL,
	BEBIDA VARCHAR(30) NOT NULL,
	VOLUME NUMBER(4) NOT NULL,
	QUANTIDADE NUMBER(5) NOT NULL,

	CONSTRAINT PK_BEBIDA_BANDEJA_FESTA PRIMARY KEY (CLIENTE, DATA, BEBIDA, VOLUME),
	CONSTRAINT FK1_BEBIDA_BANDEJA_FESTA FOREIGN KEY (CLIENTE, DATA) REFERENCES FESTA(CLIENTE, DATA) ON DELETE CASCADE,
	CONSTRAINT FK2_BEBIDA_BANDEJA_FESTA FOREIGN KEY (BEBIDA, VOLUME) REFERENCES BEBIDA(NOME, VOLUME) ON DELETE CASCADE
);

CREATE TABLE DRINK(
	NOME VARCHAR2(30) NOT NULL,
	CONSTRAINT PK_DRINK PRIMARY KEY (NOME)
);

CREATE TABLE RASPADINHA(
	SABOR VARCHAR2(30) NOT NULL,
	CONSTRAINT PK_RASPADINHA PRIMARY KEY (SABOR)
);

CREATE TABLE BEBIDAS_DRINK(
	DRINK VARCHAR2(30) NOT NULL,
	BEBIDA VARCHAR2(30) NOT NULL,
	VOLUME NUMBER(4) NOT NULL
	QUANTIDADE NUMBER(5) NOT NULL,

	CONSTRAINT PK_BEBIDAS_DRINK PRIMARY KEY (BRINK, BEBIDA, VOLUME),
	CONSTRAINT FK1_BEBIDAS_DRINK FOREIGN KEY (BEBIDA, VOLUME) REFERENCES BEBIDA(NOME, VOLUME) ON DELETE CASCADE,
	CONSTRAINT FK2_BEBIDAS_DRINK FOREIGN KEY (DRINK) REFERENCES DRINK(NOME) ON DELETE CASCADE,
);

CREATE TABLE INGREDIENTES_RASPADINHA(
	RASPADINHA VARCHAR2(30) NOT NULL,
	INGREDIENTE VARCHAR2(30) NOT NULL,
	QUANTIDADE NUMBER(2) NOT NULL,

	CONSTRAINT PK_INGREDIENTES_RASPADINHA PRIMARY KEY (RASPADINHA, INGREDIENTE),
	CONSTRAINT FK1_INGREDIENTES_RASPADINHA FOREIGN KEY (RASPADINHA) REFERENCES RASPADINHA(NOME) ON DELETE CASCADE,
	CONSTRAINT FK2_INGREDIENTES_RASPADINHA FOREIGN KEY (INGREDIENTE) REFERENCES INGREDIENTE(NOME) ON DELETE CASCADE,
);

CREATE TABLE INGREDIENTES_DRINK(
	RASPADINHA VARCHAR2(30) NOT NULL,
	DRINK VARCHAR2(30) NOT NULL,
	QUANTIDADE NUMBER(2) NOT NULL,

	CONSTRAINT PK_INGREDIENTES_RASPADINHA PRIMARY KEY (RASPADINHA, INGREDIENTE),
	CONSTRAINT FK1_INGREDIENTES_DRINK FOREIGN KEY (RASPADINHA) REFERENCES RASPADINHA(NOME) ON DELETE CASCADE,
	CONSTRAINT FK2_INGREDIENTES_DRINK FOREIGN KEY (DRINK) REFERENCES DRINK(NOME) ON DELETE CASCADE,
);

CREATE TABLE DRINK_ILHA(
	DRINK VARCHAR2(30) NOT NULL,
	ILHA NUMBER(3) NOT NULL,
	QUANTIDADE NUMBER(2) NOT NULL,

	CONSTRAINT PK_DRINK_ILHA PRIMARY KEY (DRINK, ILHA),
	CONSTRAINT FK1_DRINK_ILHA FOREIGN KEY (DRINK) REFERENCES DRINK(NOME) ON DELETE CASCADE,
	CONSTRAINT FK2_DRINK_ILHA FOREIGN KEY (ILHA) REFERENCES ILHA_PERFORMANCE(ID) ON DELETE CASCADE,
);

CREATE TABLE RASPADINHA_BARRACA(
	RASPADINHA VARCHAR2(30) NOT NULL,
	BARRACA NUMBER(3) NOT NULL,
	QUANTIDADE NUMBER(2) NOT NULL,

	CONSTRAINT PK_RASPADINHA_BARRACA PRIMARY KEY (DRINK, ILHA),
	CONSTRAINT FK1_RASPADINHA_BARRACA FOREIGN KEY (RASPADINHA) REFERENCES RASPADINHA(NOME) ON DELETE CASCADE,
	CONSTRAINT FK2_RASPADINHA_BARRACA FOREIGN KEY (BARRACA) REFERENCES BARRACA_RASPADINHA(ID) ON DELETE CASCADE,
);

CREATE TABLE VENDA_BEBIDA(
	FORNECEDOR VARCHAR2(18),
	NOME VARCHAR(30) NOT NULL,
	VOLUME NUMBER NOT NULL,
	DATA DATE NOT NULL,
	VALOR NUMBER(8,2) NOT NULL,
	QUANTIDADE NUMBER(4) NOT NULL,

	CONSTRAINT PK_VENDA_BEBIDA PRIMARY KEY (FORNECEDOR, NOME, VOLUME, DATA),
	CONSTRAINT FK1_VENDA_BEBIDA FOREIGN KEY (FORNECEDOR) REFERENCES FORNECEDOR(CNPJ),
	CONSTRAINT FK1_VENDA_BEBIDA FOREIGN KEY (NOME, VOLUME) REFERENCES BEBIDA(NOME, VOLUME),
);

CREATE TABLE VENDA_INGREDIENTES(
	FORNECEDOR VARCHAR2(18),
	INGREDIENTE VARCHAR2(30),
	DATA DATE,
	VALOR NUMBER(8,2) NOT NULL,
	QUANTIDADE NUMBER(4) NOT NULL,

	CONSTRAINT PK_VENDA_INGREDIENTES PRIMARY KEY (FORNECEDOR, INGREDIENTE, DATA),
	CONSTRAINT FK1_VENDA_INGREDIENTES FOREIGN KEY (FORNECEDOR) REFERENCES FORNECEDOR(CNPJ),
	CONSTRAINT FK2_VENDA_INGREDIENTES FOREIGN KEY (INGREDIENTE) REFERENCES INGREDIENTE(NOME),
);
