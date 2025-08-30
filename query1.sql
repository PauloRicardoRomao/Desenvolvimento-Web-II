create database ProjetoAula;
use ProjetoAula;

create table if not exists unidade(
	idUnidade int primary key auto_increment not null,
    descUnidade varchar(30) not null,
	situacao boolean default(true),
    carimboDataHora datetime default(current_TimeStamp)
);
insert into unidade(descUnidade)
values
('Kg'), ('L');

create table if not exists produto(
	idProduto int primary key auto_increment not null,
    descProduto varchar(70) not null,
    situacao boolean default(true),
    carimboDataHora datetime default(current_TimeStamp)
);

create table if not exists dadoProduto(
	idDadoProduto int primary key auto_increment not null,
    produtoDadoProduto int not null,
    qtdDadoProduto numeric(10,3) default(0.000) not null,
	unidadeDadoProduto int not null,
	situacao boolean default(true),
    carimboDataHora datetime default(current_TimeStamp),
    foreign key (produtoDadoProduto) references produto(idProduto),
    foreign key (unidadeDadoProduto) references unidade(idUnidade)
);

create table if not exists historicoDadoProduto(
	idHistoricoDadoProduto int primary key not null,
    produtoHistoricoDadoProduto int not null,
    qtdMovimentacaoHistoricoDadoProduto double not null,
    unidadeMovimentacaoHistoricoProduto int not null,
	situacao boolean default(true),
    carimboDataHora datetime default(current_TimeStamp),
    foreign key (produtoHistoricoDadoProduto) references produto(idProduto),
    foreign key (unidadeMovimentacaoHistoricoDadoProduto) references unidade(idUnidade)
);


delimiter $$
	create procedure spCadastroProduto(
		in id int,  in descProduto varchar(70), unidade int
    )
    begin
		declare idProduto int;
		declare exit handler for sqlexception
        begin
				rollback;
                select 'Erro, procedimento abortado!' as Mensagem;
        end;
        
        start transaction;
        if id = 0 then
			insert into produto(descProduto)
            values(descProduto);
            set idProduto = last_insert_id();
            insert into dadoProduto(produtoDadoProduto, unidadeDadoProduto)
            values(idProduto, unidade);
		end if;
    end $$
delimiter ;
call spCadastroProduto(0, 'Ração para Cães', 1);

delimiter$$
	create procedure spMovimentacaoProduto(
		in produto int, 
        in qtd numeric(10.3),
        in unidade int
    )
    begin
		declare exit handler for sqlexception
        begin
			rollback;
            select 'Erro, procedimento abortado!' as Mensagem;
        end;
        
        start transaction;
        insert into historicoDadoProduto(produtoHistoricoDadoProduto, qtdMovimentacaoHistoricoProduto, 
										unidadeMovimentacaoHistoricoProduto)
        values(produto, qtd, unidade);
        update dadoProduto
        set qtdDadoProduto = qtd + qtdDadoProduto
        
        where idProduto = produto;
    end $$
delimiter ;
