/*
 * Script SQL com comandos (DDL) para criação de tabelas, chaves primárias e estrangeiras no MySQL.
 *
 * Simulação de um sistema de vendas, inicialmente com duas entidades principais: Cliente e Pedido.
 *
 * Pequena analise sobre as tabelas definidas nesse script SQL:
 * - Um cliente possui 0 ou muitos (n) pedidos - Many To One;
 * - Cada pedido possui 1 ou muitos (n) itens - Many To One;
 *
 * Módulo: Banco de dados
 * Autor: Eder Magalhães
 */

/* Cria uma nova instância no MySQL, se ainda não existir. */
CREATE DATABASE IF NOT EXISTS ap /*!40100 DEFAULT CHARACTER SET latin1 */;
USE ap;

/* Primeiro elimina a tabela caso ela exista. */
DROP TABLE IF EXISTS cliente;

/* Depois cria a tabela para armazenar dados do cliente. */
CREATE TABLE cliente (
  id INT(10) not null auto_increment,
  nome VARCHAR(50),
  email VARCHAR(70),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS pedido;

/* Cria a tabela para armazenar os pedidos do cliente (compra). */
CREATE TABLE pedido (
  id INT(10) not null auto_increment,
  idCliente INT(10), /* ligação com a tabela cliente */
  dataPedido DATETIME,
  PRIMARY KEY (id),
  CONSTRAINT FOREIGN KEY (idCliente) REFERENCES cliente (id)
);

DROP TABLE IF EXISTS pedido_item;

/* Cria a tabela para armazenar os itens de um pedido. */
CREATE TABLE pedido_item (
  id INT(10) not null auto_increment,
  idPedido INT(10), /* ligação com a tabela pedido */
  descricao VARCHAR(50),
  preco DOUBLE,
  PRIMARY KEY (id),
  CONSTRAINT FOREIGN KEY (idPedido) REFERENCES pedido (id)
);
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --

/*
 * Script SQL com comandos (DML) para preencher a base de dados de clientes e pedidos.
 *
 * Módulo: Banco de dados
 * Autor: Eder Magalhães
 */

USE ap;

/* Inserção de 3 clientes. */
INSERT INTO cliente (nome, email) VALUES ('Carlos Jose', 'carlos@uol.com.br');
INSERT INTO cliente (nome, email) VALUES ('Maria Paula', 'paula@gmail.com');
INSERT INTO cliente (nome, email) VALUES ('Claudia', 'claudia@ig.com.br'); 

/* Insere 2 pedidos, o primeiro do Carlos Jose e o segundo da Maria Paula. */
INSERT INTO pedido (dataPedido, idCliente) VALUES (SYSDATE(), 1); /* carlos */
INSERT INTO pedido (dataPedido, idCliente) VALUES (SYSDATE(), 2); /* maria */

/* Insere um item no pedido do Carlos Jose */
INSERT INTO pedido_item (descricao, preco, idPedido) VALUES ('Camisa', 120.5, 1);

/* Insere dois itens no pedido da Maria Paula */
INSERT INTO pedido_item (descricao, preco, idPedido) VALUES ('Livro', 50.7, 2);
INSERT INTO pedido_item (descricao, preco, idPedido) VALUES ('Calça', 220.2, 2);


-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-------------



/*
 * Script SQL com um exemplo de function, um bloco de código que acessa/manipula os registros no banco
 * e no final retorna um resultado para quem o chamou.
 *
 * Essa função tem como objetivo devolver o valor da venda (ou compra) de um determinado cliente.
 * Por isso como entrada ele recebe o argumento com identificador do cliente, e retorna um valor
 * double representando o valor total dos itens do pedido.
 *
 * No MySQL é possível chamar essa função sozinha, ou atrelada a um resultado de SELECT, veja os exemplos:
 *   SELECT calculaValorVenda(1) AS totalVenda; --aciona a função exclusivamente para o cliente 1
 *   SELECT c.nome, calculaValorVenda(c.id) FROM cliente c; -- aciona a função para cada registro da consulta
 *
 * Módulo: Banco de dados
 * Autor: Eder Magalhães
 */

USE ap;

DELIMITER $$

DROP FUNCTION IF EXISTS calculaValorVenda$$
/* Recebe como argumento o código do cliente (id) e retorna um double, o valor da venda*/
CREATE FUNCTION calculaValorVenda (codCliente INT) RETURNS DOUBLE
BEGIN
  -- define a variável que irá armazenar o total da venda
  DECLARE somaVenda DOUBLE;

  -- soma os precos de cada item comprado pelo cliente
  SELECT SUM(i.preco) INTO somaVenda 
  FROM pedido p, pedido_item i WHERE i.idPedido = p.id AND p.idCliente = codCliente;

  -- retorna o resultado da consulta
  RETURN somaVenda;

END$$

DELIMITER ;

-- xxxxxxxxxxxxxxxxxxxxxxxx-------------

/*
 * Script SQL com um exemplo de procedure, um bloco de código que manipula os registros no banco.
 * Diferente de uma function, a procedure não devolve resultado no fim do processamento.
 *
 * Essa procedure define um bloco de código com a capacidade de inserir registros nas tabelas:
 * cliente, pedido e pedido_item;
 * Uma alternativa interessante para simular um determinado número de cadastros.
 *
 * No MySQL para chamar uma procedure é necessário o comando call, por exemplo:
 *   call preencheBasePedidos(10);
 *
 * Módulo: Banco de dados
 * Autor: Eder Magalhães
 */

USE ap;

DELIMITER $$

DROP PROCEDURE IF EXISTS preencheBasePedidos$$
/* Recebe como argumento a quantidade de registros deve ser inserida em cada tabela. */
CREATE PROCEDURE preencheBasePedidos (qtd INT)
BEGIN

  --definição de algumas variáveis da procedure.
  DECLARE $nome VARCHAR(50);
  DECLARE $email VARCHAR(70);
  DECLARE $descricao VARCHAR(50);
  DECLARE $preco DOUBLE;

  DECLARE x INT;

  -- inicializa a variável de controle do loop
  SET x = 1;

  -- de 1 até o valor informado no argumento qtd
  WHILE x <= qtd DO
    -- a cada iteração do loop, insere um registro em cada tabela
    SET $nome = CONCAT('Cliente ',x);
    SET $email = CONCAT('cliente',x,'gmail.com');
    
    INSERT INTO cliente(nome, email) VALUES($nome, $email);

    -- LAST_INSERT_ID informa o último valor de id (auto_increment) gerado pelo MySQL.
    INSERT INTO pedido(idCliente, dataPedido) VALUES(LAST_INSERT_ID(), SYSDATE());

    SET $descricao = CONCAT('Produto ',x);
    SET $preco = 10 * x; --10, 20, 30 ...

    INSERT INTO pedido_item(idPedido, descricao, preco) VALUES(LAST_INSERT_ID(), $descricao, $preco);

    -- incrementa a variável de controle do loop
    SET x = x + 1;
  END WHILE;
  
END$$

DELIMITER ;

-- xxxxxxxxxxxxxxxxxxx---------

/*
 * Script SQL com comandos de consulta das informações na base de dados de clientes e pedidos.
 *
 * Módulo: Banco de dados
 * Autor: Eder Magalhães
 */

USE ap;

/* Consulta basica, de todos os clientes cadastrados. */
SELECT * FROM cliente;


/* Consulta o email de clientes que possuem nome começando com Maria. */
SELECT email FROM cliente WHERE nome like 'Maria %';


/* Mesma consulta definindo alias (apelido) para a tabela e tratando letras minusculas/maisculas. */
SELECT c.email FROM cliente c WHERE UPPER(c.nome) like 'MARIA %';


/* Consulta utilizando funções do MySQL para formatar dados.
 * Nesse consulta todos os clientes cadastros e exibe os campos:
 *   - nome com todas as letras maíusculas - Função do MySQL: UPPER;
 *   - informa o tamanho do campo de email - Função do MySQL: LENGTH;
 *   - inverte os caracteres que formam o nome do cliente - Função do MySQL: REVERSE;
 */
SELECT UPPER(c.nome), LENGTH(c.email), REVERSE(c.nome) FROM cliente c;


/* Verifica a quantidade de clientes cadastrados. Note o alias (apelido) no resultado (AS qtde). */
SELECT COUNT(c.id) AS qtde FROM cliente c;


/* Consulta informações do pedido, item e clientes, de todos os clientes que compraram. (join requerido) */
SELECT c.nome, p.dataPedido, i.descricao, i.preco
FROM cliente c, pedido p, pedido_item i
WHERE p.idCliente = c.id --liga a tabela pedido com cliente, soh traz os clientes que possuem pedido
  AND i.idPedido = p.id; --liga a tabela de itens com a pedido


/*
 * Consulta traz o nome e data de compra (pedido). Mas é preciso considerar todos os cliente!
 * Os clientes que não compraram devem aparecer, mas o campo de data deve ficar vazio.
 * O inner join não atende essa situação, por isso utilizamos o LEFT OUTER JOIN (join opcional).
 */
SELECT c.nome, p.dataPedido
FROM cliente c LEFT OUTER JOIN pedido p ON p.idCliente = c.id;


/* Utilizando funções do MySQL para extrair informações do banco, sem o uso de tabelas: */
SELECT SYSDATE(); --retorna a data atual no servidor MySQL

SELECT CONCAT('Consulta',' no ', 'MySQL') AS texto; --devolve um registro, com o texto passado na função

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx----------




