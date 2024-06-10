--criar data base

create database postgres;

--criar tabela endereço
create table endereco
(
end_cd_id serial not null,
end_tx_estado varchar(30),
end_tx_cidade varchar(30),
end_tx_bairro varchar(30),
end_tx_rua varchar(50),
end_tx_complemento varchar(10),
primary key(end_cd_id)
);

--criar tabela usuario
create table usuario
(
usu_cd_id serial not null,
usu_tx_nome_completo varchar(100),
usu_tx_cpf varchar(14),
usu_tx_telefone varchar(13),
usu_tx_email varchar(100),
usu_tx_genero varchar(20),
fk_usu_end int,
primary key(usu_cd_id)
);

--criar tabela denuncia
create table denuncia
(
den_cd_id serial not null,
den_tx_tipo_denuncia varchar(200),
den_dt_dtocorrencia date,
den_tx_descricao varchar(200),
den_tx_testemunhas varchar(200),
den_tx_evidencias varchar(10),
fk_den_usu int,
primary key(den_cd_id)
);

--criar tabela delegacia
create table delegacia
(
del_cd_id serial not null,
del_tx_telefone varchar(13),
del_dt_dtdenuncia date,
del_int_identificacao_delegacia int,
del_tx_oficialquerecebeu varchar(30),
del_tx_estadodadelegacia varchar(20),
fk_del_end int,
fk_del_den int,
primary key(del_cd_id)
);


--chave estrangeira de endereço dentro de usuario
alter table usuario
add constraint fk_usu_end
foreign key (fk_usu_end)
references endereco(end_cd_id);

--chave estrangeira do usuario dentro de denuncia
alter table denuncia
add constraint fk_den_usu
foreign key (fk_den_usu)
references usuario(usu_cd_id);

--chave estrangeira de denuncia dentro de delegacia
alter table delegacia
add constraint fk_del_den
foreign key (fk_del_den)
references denuncia(den_cd_id);

--chave estrangeira de endereço dentro de delegacia
alter table delegacia
add constraint fk_del_end
foreign key (fk_del_end)
references endereco(end_cd_id);

--insert de endereço
insert into endereco (end_tx_estado,
end_tx_cidade,
end_tx_bairro,
end_tx_rua,
end_tx_complemento)
	values 
    ('RJ', 'Petrópolis', 'Mosela', 'Rua Marechal Deodoro', 'A'),
    ('RJ', 'Petrópolis', 'Quarteirão Brasileiro', 'Rua Atilio Marotti', 'B'),
    ('RJ', 'Petrópolis', 'Quitandinha', 'Rua Rio de Janeiro', 'C'),
    ('RJ', 'Petrópolis', 'Correas', 'Rua Santos', 'D'),
    ('RJ', 'Petrópolis', 'Cascatinha', 'Rua Roberto Marinho', 'E'),
    ('RJ', 'Petrópolis', 'Mosela', 'Rua Barcelar','A'),
    ('RJ', 'Petrópolis', 'Quarteirao', 'Rua nestor','A'),
    ('RJ', 'Petrópolis', 'Quitandinha', 'Rua sao paulo','A'),
    ('RJ', 'Petrópolis', 'Correas', 'Rua de Sá Erp','A'),
	('RJ', 'Petrópolis', 'Cascatinha', 'Rua Homeopata','A');
			
--insert de usuario   
insert into usuario (usu_tx_nome_completo,
usu_tx_cpf,
usu_tx_telefone,
usu_tx_email,
usu_tx_genero,
fk_usu_end)
	values 
    ('Celio Amaral','123.456.789-12', '(24)988123456', 'celio@gmail.com', 'masculino',1),
    ('Amelia Azevedo','234.567.891-23', '(24)988654321', 'amelia@gmail.com', 'feminino',2),
    ('Arthur Oliveira','345.678.912-34', '(24)988234567', 'arthur@gmail.com', 'masculino',3),
    ('Ana Justen','456.789.123-45', '(24)98834678', 'ana@gmail.com', 'feminino',4),
    ('Lucas Washiton','567.891.234-56', '(24)988456789', 'lucas@gmail.com', 'masculino',5);

--insert de denuncia   
insert into denuncia (den_tx_tipo_denuncia,
den_dt_dtocorrencia,
den_tx_descricao,
den_tx_testemunhas,
den_tx_evidencias,
fk_den_usu)
	values
    ('Agressão', '2024-03-26', 'Homem agredido no rosto', 'Sem testemunhas', 'Sem',1),
    ('Corrupção', '2024-03-25', 'Governo é corrupto', 'Com testemunhas', 'Sem',2),
    ('Lavagem de dinheiro', '2024-03-24', 'Loja aberta no centro para lavar dinheiro', 'Sem testemunhas', 'Com',3),
    ('Batida de carro', '2024-03-23', 'Sujeito bateu o carro e fugiu', 'Com testemunhas', 'Com',4),
    ('Atropelamento', '2024-03-22', 'Vitima atropelada na venida', 'Com testemunhas', 'Sem',5);

--insert de delegacia
insert into delegacia(del_tx_telefone,
del_dt_dtdenuncia,
del_int_identificacao_delegacia,
del_tx_oficialquerecebeu,
del_tx_estadodadelegacia,
fk_del_end,
fk_del_den)
	values
	('(24)22123456','2024-03-27',101,'Oficial Geferson','RJ',6,1),
	('(24)22123456','2024-03-26',102,'Oficial Lilian','RJ',7,2),
	('(24)22123456','2024-03-25',103,'Oficial Andre','RJ',8,3),
	('(24)22123456','2024-03-24',104,'Oficial Teo','RJ',9,4),
	('(24)22123456','2024-03-23',105,'Oficial Leandro','RJ',10,5);

--join para selecionar apenas nome,cpf do usuario e estado, cidade do seu endereço 
select u.usu_tx_nome_completo,
u.usu_tx_cpf,
e.end_tx_estado,
e.end_tx_cidade
from usuario u
join endereco e
on e.end_cd_id=u.fk_usu_end;

--join para selecionar apenas identificação da delegacia, nome do oficial que recebeu a denuncia, estado e cidade 
select d.del_int_identificacao_delegacia,
d.del_tx_oficialquerecebeu,
e.end_tx_estado,
e.end_tx_cidade
from delegacia d
join endereco e
on e.end_cd_id=fk_del_end;

--join, group by e cont para juntar as informações a cima e tambem contar o numero de denuncias recebidas em cada identificaçao da delegacia
select d.del_int_identificacao_delegacia, 
d.del_tx_oficialquerecebeu, 
e.end_tx_estado, 
e.end_tx_cidade,
       count (*)  as num_denuncias
from delegacia d
join endereco e 
on e.end_cd_id = d.fk_del_end
group by d.del_int_identificacao_delegacia, 
d.del_tx_oficialquerecebeu,
e.end_tx_estado, 
e.end_tx_cidade;







   



				

