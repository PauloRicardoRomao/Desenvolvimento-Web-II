create database if not exists Loja;
use Loja;
/*drop database loja;*/

create table if not exists  produto(
	idProduto int auto_increment primary key not null,
    nomeProduto varchar(100),
    precoProduto numeric(10,2)
);


select * from produto