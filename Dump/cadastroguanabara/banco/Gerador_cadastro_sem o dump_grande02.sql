-- comentarios
-- a linha abaixo cria um banco de dados
create database cadastro;
-- a linha abaixo escolhe o banco de dados
use cadastro;
-- o bloco de instrucoes abaixo cria uma tabela 
create table pessoas(
nome varchar (30),
idade tinyint,
sexo char(1),
peso float,
altura float,
nacionalidade varchar(20)
);

-- o comando abaixo descreve a tabela

describe pessoas;

-- o comando faz uma lista de banco de dados
show databases;

-- o comando abre o banco de dados selecionado
use cadastro;

-- o camando abaixo mostra informacoes do banco de dados aberto
status;

-- o comando mostra as tabelas
show tables;

-- o comando descreve a tabela pessoas
desc pessoas;

-- o comando abaixo abandona destroi o banco de dados
-- cuidado com este comando
drop database cadastro;

-- vamos acrescentar parametros, os parametros em 
-- banco de dados se chama constraints

-- comando para criar o banco
create database cadastro
-- parametros, 'constraint' para aceitar ç e ~
default character set utf8
default collate utf8_general_ci;


-- comando abaixo vai mostrar a diferenca de usar 
-- constraint e nao usar
create database meubanco;
-- deleta o banco meu banco
drop database meubanco;

drop database cadastro;

-- banco sera reconstruido de maneira mais estruturada
create database cadastro
default character set utf8
default collate utf8_general_ci;

use cadastro;

create table pessoas ( 

id int not null auto_increment, -- autonumerar
nome varchar(30) not null, -- constraint not null serve para evitar campo em branco
nascimento date, -- date usado para data
sexo enum ('M','F'),-- enum usado para  definir opcoes
peso decimal(5,2),
altura decimal(5,2),-- o cinco numero de casas o dois numero d depois da virgula
nacionalidade varchar(20) default 'Brasil', -- se digitar em branco fica Brasil
primary key (id) -- chave primaria sera o id
)default charset = utf8;-- para aceiar ç e ~
-- tuplas = linhas

describe pessoas;

-- comando para inserir dados na tabela pessoas no banco cadastro
insert into	pessoas
(id, nome, nascimento, sexo, peso, altura, nacionalidade)
values
('1','Godofedo','1984-01-02','M','77.5','1.83','Brasil'),
('2','Ana','1986-05-02','F','73.5','1.53','Mexico'),
('3','Joao','1985-01-04','M','72.5','1.33','Brasil');

-- comando selecte para fazer listas
select * from pessoas;

-- comando alterar tabelas
alter table pessoas
add column profissao varchar(10);

-- comando remover uma coluna
alter table pessoas
drop column profissao;

-- comando para adicionar coluna depois de campo 'x',
-- setando que campo nao pode ser null passando a constraint vazio. 
alter table pessoas
add column profissao varchar(10) not null default '' after nome;

-- comando para adicionar coluna no inicio,
alter table pessoas
add column codigo int first;

-- comando para modificar varchar(20) para varchar(30),
alter table pessoas
modify column profissao varchar(35);

-- comando para renomear uma coluna,
alter table pessoas
change column prof profi varchar(20) not null default '';


-- comando para renomear toda a tabela,
alter table pessoas
rename to gafanhotos;

-- comando select para fazer listas
select * from pessoas;
desc pessoas;
select * from gafanhotos;
desc gafanhotos;

show tables;
show databases;

-- xxxxxxxxxxxxxxxxxxx
create table if not exists cursos ( -- criar cursos se a tabela nao exixtir
nome varchar(30) not null unique,
descricao text,
carga int unsigned,-- unsigned siginifca que a carga nao podera assumir valores negativos
totaulas int unsigned, -- unsigned siginifca que a totaulas nao podera assumir valores negativos
ano year default '2016' -- default quando vazio o campo o valor padrao sera 2016
) default charset=utf8; -- charset a tabela aceitara ç e ~ 

-- acrescentar o id e torna-lo chave primaria
alter table cursos
add column idcurso int first; -- o campo sera criado no começo da tabela

alter table cursos
add primary key (idcurso); -- o campo recebe valor de chave primaria

alter table cursos
drop column nome;

alter table cursos
add column nome varchar(25) unique	after idcurso; -- valor unico e inicia o campo apos idcurso

select * from cursos;
desc cursos;

create table if not exists teste(
id int,
nome varchar(10),
idade int
);

insert into teste value
('1','pedro','22'),
('2','Maria','12'),
('3','Maricota','77');

select * from teste;
desc teste;

-- xxxxxxxxxxxxxxx
-- comando para apagar uma tabela
drop table if exists teste;

-- ddl comandos de definicao
-- exemplos crate database
-- create table
-- alter table
-- drop table

-- dml comandos de manipulacao
-- exemplos
-- insert into
-- update
-- delete

-- DQL  data query language
-- select

use cadastro;
select * from cursos;
desc cursos;
insert into cursos values
('1','HTML4','Curso de html5','40','37','2014'),
('2','Algoritmos','logica','20','37','2014'),
('3','Photoshop','dicas','10','37','2014'),
('4','PGP','Curso de html5','40','37','2010'),
('5','Jarva','introducao a linguagem','10','29','2000'),
('6','Mysql','banco de dados','30','37','2016'),
('7','Word','curso completo','40','37','2016'),
('8','Sapateado','dancas ritmicas','40','37','2018'),
('9','Cozinha arabe','aprenda a fazer kibe','5','37','2018'),
('10','Youtuber','gerar polemicas','7','37','2018');

update cursos
set nome = 'PHP', ano = '2015'
where idcurso = '4'; 

update cursos
set nome = 'HTML5', 
where idcurso = '1';

update cursos
set nome = 'java', ano = '2015', carga = '40'
where idcurso = '5'
limit 1;

update cursos
set ano = '2018', carga = '0'
where ano = '2050'
limit 1 ;

delete from cursos
where idcurso='8';

delete from cursos
where ano='2050';
limit 2;

truncate table cursos;

select * from cursos;

select * from cursos
order by nome ASC;

select * from cursos
order by nome DESC;

select nome, carga, ano from cursos
order by nome DESC;

select nome, carga, ano from cursos
order by nome ASC;

select nome, carga from cursos
where ano = '2016';

select nome, descricao, ano from cursos
where ano <= 2015
order by nome;

select nome, descricao from cursos
where ano >= 2015
order by nome;

select nome, descricao, ano from cursos
where ano != 2015
order by nome;

select nome, descricao, ano from cursos
where ano != 2015
order by nome;

select nome, descricao, ano from cursos
where ano <> 2015
order by nome;

select nome, ano from cursos
where ano between 2014 and 2015 -- between 'entre'
order by ano desc, nome asc; -- desc descrescente asc crescente

select nome, descricao, ano from cursos
where ano in (2014, 2016, 2020) -- o in pega somente as faixas fixas
order by ano;

select * from cursos -- where = onde
where carga > 35 and totaulas < 30
order by nome;

select * from cursos -- where = onde
where carga > 35 or totaulas < 30
order by nome;

-- like parecido
-- % = curinga
select * from cursos
where nome like 'p%'; -- like semelhantes % curinga

-- like parecido
-- % = curinga
select * from cursos
where nome like 'a%'; -- like semelhantes % curinga
-- % encontra varios ou nenhum caracter

-- like parecido
-- % = curinga
select * from cursos
where nome like '%a'; -- like semelhantes % curinga
-- % encontra varios ou nenhum caracter
-- procurar qualquer coisa que termine com a

-- like parecido
-- % = curinga
select * from cursos
where nome like '%a%'; -- like semelhantes % curinga
-- % encontra varios ou nenhum caracter
-- procurar qualquer coisa que tenha a letra a

-- like parecido
-- % = curinga
select * from cursos
where nome not like '%a%'; -- like semelhantes % curinga
-- % encontra varios ou nenhum caracter
-- procurar qualquer coisa que tenha nao tenha a letra a

update cursos set nome = 'PáOO' where idcurso = '9';
UPDATE `cadastro1`.`cursos` SET `nome`='PAOO' WHERE `idcurso`='9';

select * from cursos
where nome like 'PH%P_';-- onderline serve para procurar qualquer coisa apos

select * from gafanhotos
where nome like '%_silva%';

select * from gafanhotos
where nome like '%silva';

select distinct	nacionalidade from gafanhotos;
-- distinct seta uma unica vez um dado na tabela

select distinct	carga from cursos
order by carga;

select * from cursos;
select count(*) from cursos; -- count conta os campos

select * from cursos where carga > 40;
select count(*) from cursos where carga > 40; -- count conta os campos

select count(*) from cursos; -- count conta os campos

select * from cursos order by carga; -- posso ir no final e descubrir a maior carga ou
select max(carga) from cursos; -- assim descubro a maior carga

select * from cursos where ano = '2016';
select max(totaulas) from cursos where ano = '2016';
-- max descubra qual a maior

select * from cursos where ano = '2016';
select min(totaulas) from cursos where ano = '2016';
-- min descubra qual a menor

select * from cursos where ano = '2016';
select nome, min(totaulas) from cursos where ano = '2016';
-- min descubra qual a menor e o nome 

select * from cursos where ano = '2016';

select sum(totaulas) from cursos where ano = '2016';
-- comando sum procede a soma dos campos

select avg(totaulas) from cursos where ano = '2016';
-- comando avg procede a media dos campos

select * from cursos;

select totaulas from cursos;

select distinct totaulas, count(*) from cursos
group by totaulas
order by totaulas;
-- organiza, agrupa e conta 

select * from cursos where totaulas = 30;

select * from cursos where totaulas = 12;

select * from cursos where totaulas > 20;

select * from cursos where totaulas > 30
group by carga;

select carga, count(*) from cursos where totaulas = 30
group by carga;

select carga, count(nome) from cursos where totaulas = 30
group by carga;

select ano, count(*) from cursos
group by ano
having count(ano) < 2013  
order by count(*) desc;

select avg(carga) from cursos;

select carga, count(*) from cursos
where ano > 2015
group by carga;

select carga, count(*) from cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos);






























 















 




