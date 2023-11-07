DROP DATABASE IF EXISTS imobiliaria_bd;
CREATE DATABASE IF NOT EXISTS imobiliaria_bd;

ALTER SCHEMA `imobiliaria_bd`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

USE imobiliaria_bd;

CREATE TABLE IF NOT EXISTS clientes(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(80) NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	email VARCHAR(100) NOT NULL,
	telefone varchar(15) NOT NULL,
	data_nascimento DATE NOT NULL,
	sexo ENUM('Masculino', 'Feminino', 'Outro', 'N/I') NOT NULL,
	relacao_imobiliaria ENUM('Locatário(a)', 'Comprador(a)', 'Vendedor(a)') NOT NULL,
	relacao_imovel ENUM('Inquilino(a)', 'Dono(a)', 'Interessado(a)') NOT NULL,
	PRIMARY KEY(id, cpf)
);

INSERT INTO clientes VALUES
(1, 'Vera Isadora Débora Costa', '77784689055', 'vera-costa87@triunfante.com.br', '9535380022', '1974-04-15', 'Feminino', 'Vendedor(a)', 'Dono(a)'),
(2, 'Lúcia Antônia Tatiane Gomes', '73963748478', 'luciaantoniagomes@alesalvatori.com', '71984586994', '1973-01-04', 'Feminino', 'Locatário(a)', 'Dono(a)'),
(3, 'Lucas Gabriel Bento Souza', '88565962105', 'lucasgabrielsouza@plaman.com.br', '8235844156', '1976-11-20', 'Masculino', 'Comprador(a)', 'Interessado(a)'),
(4, 'Vicente Cauã Henry Sales', '51588513955', 'vicente_sales@tradevalle.com.br', '9635641858', '1973-01-20', 'Masculino', 'Vendedor(a)', 'Dono(a)'),
(5, 'Teresinha Ana Camila Gonçalves', '45725070581', 'teresinha_goncalves@aspxsistemas.com.br', '8139869889', '1970-05-12', 'Feminino', 'Locatário(a)', 'Inquilino(a)'),
(6, 'Francisco Severino Breno Martins', '86301641582', 'francisco.martins@andrepires.com.br', '63985100026', '1996-03-15', 'Masculino', 'Locatário(a)', 'Dono(a)'),
(7, 'Antonio Renato Diego Farias', '79372235962', 'antonio_farias@bb.com.br', '51984652339', '1990-02-11', 'Masculino', 'Comprador(a)', 'Interessado(a)'),
(8, 'Márcia Evelyn Ayla Baptista', '11451798431', 'marcia_evelyn@moncoes.com.br', '2825667567', '1988-09-19', 'Feminino', 'Comprador(a)', 'Interessado(a)'),
(9, 'Letícia Nicole Peixoto', '77065412903', 'leticia_nicole@yahoo.com.br', '9236869700', '1981-07-02', 'Feminino', 'Locatário(a)', 'Inquilino(a)'),
(10, 'Murilo Matheus Enrico Monteiro', '99276854835', 'murilo-monteiro84@asconnet.com.br', '6337484063', '1985-12-12', 'Masculino', 'Locatário(a)', 'Dono(a)')
;

CREATE TABLE IF NOT EXISTS imoveis(
	id INT NOT NULL AUTO_INCREMENT,
    id_imovel VARCHAR(70),
    rua VARCHAR(80) NOT NULL,
    numero VARCHAR(8) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    bairro VARCHAR(65) NOT NULL,
    cidade VARCHAR(25) NOT NULL,
    estado VARCHAR(50) NOT NULL,
	status_imovel ENUM('Disponível', 'Indisponível') NOT NULL, 
	tipo_imovel ENUM('Casa', 'Apartamento', 'Terreno', 'Sala comercial') NOT NULL,
	tipo_negocio ENUM('Venda', 'Locação') NOT NULL,
	motivo_indisponivel ENUM('Vendido', 'Alocado'),
	cpf_proprietario VARCHAR(11) NOT NULL, 
	cpf_morador VARCHAR(11),
	quantidade_quartos INT, 
	quantidade_suites INT,
	quantidade_salas_estar INT,
	quantidade_salas_jantar INT,
	quantidade_vagas_garagem INT,
	area INT,
	tem_armario_embutido BOOLEAN,
	descricao MEDIUMTEXT,
    andar INT,
    valor_condominio DOUBLE,
    possui_portaria_24h BOOLEAN,
    quantidade_banheiros INT, 
    quantidade_comodos INT,
    largura FLOAT,
    comprimento FLOAT, 
	PRIMARY KEY(id, id_imovel),
	INDEX(id, id_imovel),
    FOREIGN KEY (cpf_proprietario) REFERENCES clientes(cpf)
);

INSERT INTO imoveis VALUES																																		   
(1, '1', 'Enzo Rodovia - Curralinho', '33205', '52507-732', 'Boa Viagem', 'Campo Grande', 'SE', 'Indisponível', 'Casa', 'Venda','Vendido', '11451798431', '11451798431', 3, 2, 1, 1, 2, 50, true, 'Casa top', 1, 3000, true, 2, 5, 10, 5),
(2, '2', 'Macedo Avenida - Apiúna', '72991', '10743-034', 'Guará I', 'Belo Horizonte', 'MS','Indisponível', 'Apartamento', 'Venda', 'Vendido', '73963748478', '73963748478', 2, 2, 1, 1, 2, 48, true, 'Apartamento top', 1, 2000, true, 2, 5, 10, 4.8), 
(3, '3', 'Costa Marginal - Trindade', '66336', '28089-280', 'Cidade Nova', 'Sobral', 'AC', 'Indisponível', 'Terreno', 'Venda', 'Vendido', '88565962105', '88565962105', 3, 2, 1, 1, 2, 52, false, 'Terreno sem nada', 0, 0, false, 3, 5, 20, 30),
(4, '4', 'Franco Travessa - Vargeão', '20532', '50552-965', 'Centro', 'Teresina', 'RN', 'Indisponível', 'Casa', 'Venda', 'Vendido', '51588513955', '51588513955', 2, 1, 1, 1, 3, 80, true, 'Casa em condomínio', 0, 0, false, 2, 5, 30, 19),
(5, '5', 'Santos Travessa - Santo Anastácio', '7243', '47750-506', 'Bom Retiro', 'Campos dos Goytacazes', 'MT', 'Indisponível', 'Terreno', 'Venda', 'Vendido', 45725070581, 45725070581, 2, 1, 2, 1, 1, 30, false, 'Casinha humilde', 0, 0, false, 2, 5, 25, 10),
(6, '6', 'Esther Avenida - Santa Isabel do Ivaí', '1628', '40323-700', 'Nazaré', 'Ji-Paraná', 'AP', 'Indisponível', 'Casa', 'Locação', 'Alocado', 77784689055, 86301641582, 4, 0, 1, 1, 5, 200, false, 'Chácara', 0, 0, false, 2, 3, 10, 20),
(7, '7', 'Braga Avenida - Israelândia', '083', '57127-227', 'Bom Retiro', 'Rio Grande', 'MS', 'Disponível', 'Sala comercial', 'Locação', null, 86301641582, 77784689055, 0, 0, 2, 0, 3, 60, false, 'Salão de beleza', 0, 0, false, 2, 4, 12, 5), 
(8, '8', 'Deneval Rua - Cajazeiras do Piauí', '83576', '75739-595', 'Vila Jardim Rio Claro', 'Curitiba', 'RR', 'Disponível', 'Apartamento', 'Locação', null, 86301641582, null, 2, 1, 1, 1, 1, 48, false, 'Apartamento em conta', 6, 1500, false, 1, 5, 12, 4),
(9, '9', 'Janaína Rua - Alfredo Vasconcelos', '531', '31089-386', 'Warta', 'São Paulo', 'MT', 'Disponível', 'Terreno', 'Venda', null, 45725070581, null, 0, 0, 0, 0, 0, 60, false, 'Terreno baldio', 0, 0, false, 0, 0, 10, 6),
(10, '10', 'Macedo Rua - Brejo Alegre', '835', '15387-230', 'Jardim Sumaré', 'Araçatuba', 'SC', 'Indisponível', 'Casa', 'Venda', 'Vendido', 99276854835, 99276854835, 3, 2, 1, 1, 2, 80, false, 'Casa normal', 0, 0, false, 2, 5, 8, 10);

#############################################

DELIMITER $$
CREATE PROCEDURE muda_id_imovel()
BEGIN
    
    UPDATE imoveis SET id_imovel = CONCAT(cpf_proprietario,'-',cep,'-',numero) WHERE id_imovel NOT LIKE '%-%';

END $$
DELIMITER ;

call muda_id_imovel;

########################################


CREATE TABLE IF NOT EXISTS transacao_imovel ( 
	id INT NOT NULL AUTO_INCREMENT,
    id_imovel VARCHAR(50) REFERENCES imoveis(id_imoveis) ON UPDATE CASCADE,
    tipo_transacao ENUM('Alocado', 'Venda', 'Proposta') NOT NULL,
    valor_sugerido_proprietario DOUBLE NOT NULL,
    valor_transacao DOUBLE NOT NULL,
    feita_transicao BOOLEAN,
   	cpf_cliente_interessado VARCHAR(11),
    cpf_proprietario VARCHAR(11) NOT NULL,
    cpf_locatario VARCHAR(11),
    PRIMARY KEY(id),
	INDEX(id, id_imovel, cpf_cliente_interessado, cpf_proprietario, cpf_locatario),
    FOREIGN KEY (cpf_cliente_interessado) REFERENCES clientes(cpf),
    FOREIGN KEY (cpf_proprietario) REFERENCES clientes(cpf),
	FOREIGN KEY (cpf_locatario) REFERENCES clientes(cpf)
);


INSERT INTO transacao_imovel VALUES		      
(1, '77784689055-52507-732-33205', 'Venda', 150000, 155000, true, '51588513955', '51588513955', null),
(2, '77784689055-40323-700-1628', 'Alocado', 1500, 1500, true, '86301641582', '77784689055', '86301641582'),
(3, '73963748478-10743-034-72991', 'Venda', 200000, 220000, true, '73963748478', '73963748478', null),
(4, '88565962105-28089-280-66336', 'Venda', 600000, 600000, true, '88565962105', '88565962105', null),
(5, '51588513955-50552-965-20532', 'Venda', 800000, 800000, true, '51588513955', '51588513955', null),
(6, '45725070581-47750-506-7243', 'Venda', 820000, 820010, true, '45725070581', '45725070581', null),
(7, '45725070581-31089-386-531', 'Venda', 850000, 0, false, null, '45725070581', null),
(8, '86301641582-57127-227-083', 'Alocado', 2000, 0, false, null, '86301641582', null),
(9, '86301641582-75739-595-83576', 'Alocado', 2300, 0, false, null, '86301641582', null),
(10, '99276854835-15387-230-835', 'Venda', 780000, 800000, true, '99276854835', '99276854835', null);

CREATE TABLE IF NOT EXISTS documentos(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    tipo_documento ENUM ('DOC', 'PDF', 'Outros') NOT NULL,
    id_imovel VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO documentos VALUES
(1, 'Contrato_Vende_Vera','DOC', '77784689055-52507-732-33205'),
(2, 'Contrato_Loca_Vera','DOC', '77784689055-40323-700-1628'),
(3, 'Contrato_Loca_Lucia','PDF','73963748478-10743-034-72991'),
(4, 'Contrato_Vende_Lucas','PDF', '88565962105-28089-280-66336'),
(5, 'Contrato_Vende_Vicente','DOC', '51588513955-50552-965-20532'),
(6, 'Contrato_Vende_Teresinha','PDF', '45725070581-47750-506-7243'),
(7, 'Contrato_Vende_Teresinha2','DOC', '45725070581-31089-386-531'),
(8, 'Contrato_Loca_Francisco','PDF', '86301641582-57127-227-083'),
(9, 'Contrato_Loca_Francisco2','PDF', '86301641582-75739-595-83576'),
(10, 'Contrato_Vende_Murilo','DOC', '99276854835-15387-230-835');



SELECT * FROM clientes
