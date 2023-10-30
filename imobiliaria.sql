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
	relacao_imobiliaria ENUM('Inquilino(a)', 'Locatário(a)', 'Comprador(a)', 'Vendedor(a)') NOT NULL,
	relacao_imovel ENUM('Inquilino(a)', 'Dono(a)', 'Interessado(a)') NOT NULL,
	PRIMARY KEY(id, cpf)
);

INSERT INTO clientes VALUES
(1, 'Vera Isadora Débora Costa', '77784689055', 'vera-costa87@triunfante.com.br', '9535380022', '1974-04-15', 'Feminino', 'Inquilino(a)', 'Inquilino(a)'),
(2, 'Lúcia Antônia Tatiane Gomes', '73963748478', 'luciaantoniagomes@alesalvatori.com', '71984586994', '1973-01-04', 'Feminino', 'Locatário(a)', 'Dono(a)'),
(3, 'Lucas Gabriel Bento Souza', '88565962105', 'lucasgabrielsouza@plaman.com.br', '8235844156', '1976-11-20', 'Masculino', 'Comprador(a)', 'Interessado(a)'),
(4, 'Vicente Cauã Henry Sales', '51588513955', 'vicente_sales@tradevalle.com.br', '9635641858', '1973-01-20', 'Masculino', 'Vendedor(a)', 'Dono(a)'),
(5, 'Teresinha Ana Camila Gonçalves', '45725070581', 'teresinha_goncalves@aspxsistemas.com.br', '8139869889', '1970-05-12', 'Feminino', 'Inquilino(a)', 'Inquilino(a)'),
(6, 'Francisco Severino Breno Martins', '86301641582', 'francisco.martins@andrepires.com.br', '63985100026', '1996-03-15', 'Masculino', 'Locatário(a)', 'Dono(a)'),
(7, 'Antonio Renato Diego Farias', '79372235962', 'antonio_farias@bb.com.br', '51984652339', '1990-02-11', 'Masculino', 'Comprador(a)', 'Interessado(a)'),
(8, 'Márcia Evelyn Ayla Baptista', '11451798431', 'marcia_evelyn@moncoes.com.br', '2825667567', '1988-09-19', 'Feminino', 'Vendedor(a)', 'Dono(a)'),
(9, 'Letícia Nicole Peixoto', '77065412903', 'leticia_nicole@yahoo.com', '9236869700', '1981-07-02', 'Feminino', 'Inquilino(a)', 'Inquilino(a)'),
(10, 'Murilo Matheus Enrico Monteiro', '99276854835', 'murilo-monteiro84@asconnet.com.br', '6337484063', '1985-12-12', 'Masculino', 'Locatário(a)', 'Dono(a)')
;

CREATE TABLE IF NOT EXISTS imoveis(
	id INT NOT NULL AUTO_INCREMENT,
    id_imovel VARCHAR(25) UNIQUE,
    rua VARCHAR(80) NOT NULL,
    numero VARCHAR(4) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    bairro VARCHAR(65) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    estado VARCHAR(50) NOT NULL,
	status ENUM('Disponível', 'Indisponível') NOT NULL,
	tipo_imovel ENUM('Casa', 'Apartamento', 'Terreno', 'Sala comercial') NOT NULL,
	tipo_negocio ENUM('Venda', 'Locação') NOT NULL,
	motivo_indisponivel ENUM('Vendido', 'Alocado'),
	cpf_proprietario VARCHAR(11) NOT NULL,
	cpf_morador VARCHAR(11) NOT NULL,
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
    FOREIGN KEY (cpf_proprietario) REFERENCES clientes(cpf),
    INDEX(id, id_imovel)
);

DELIMITER $
	CREATE TRIGGER before_imoveis_insert 
	BEFORE INSERT ON imoveis 
	FOR EACH ROW 
	BEGIN
		IF(NEW.status = 'Indisponível' AND (NEW.motivo_indisponivel IS NULL OR NEW.motivo_indisponivel = '')) THEN
			SIGNAL SQLSTATE '45000' set message_text='Quando a coluna `status` for `Indisponível`, a coluna `motivo_indisponivel` não pode ser nulo';
        END IF;
		IF(NEW.status = 'Disponível' AND (NEW.motivo_indisponivel IS NOT NULL OR NEW.motivo_indisponivel != '')) THEN
			SIGNAL SQLSTATE '45000' set message_text='Quando a coluna `status` for `Disponível`, a coluna `motivo_indisponivel` não pode ser preenchido';
        END IF;
		
        SET NEW.id_imovel = CONCAT(NEW.cpf_proprietario, '-', NEW.cep, '-', NEW.rua);
    END$$
DELIMITER ;

CREATE TABLE IF NOT EXISTS transacao_imovel (
	id INT NOT NULL AUTO_INCREMENT,
    id_imovel VARCHAR(25),
    tipo_transacao ENUM('Alocado', 'Venda', 'Proposta') NOT NULL,
    valor_sugerido_proprietario DOUBLE NOT NULL,
    valor_transacao DOUBLE NOT NULL,
    feita_transicao BOOLEAN,
   	cpf_cliente_interessado VARCHAR(11),
    cpf_proprietario VARCHAR(11) NOT NULL,
    cpf_locatario VARCHAR(11) UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY (id_imovel) REFERENCES imoveis(id_imovel),
    FOREIGN KEY (cpf_cliente_interessado) REFERENCES clientes(cpf),
    FOREIGN KEY (cpf_proprietario) REFERENCES clientes(cpf),
	FOREIGN KEY (cpf_locatario) REFERENCES clientes(cpf)
);

CREATE TABLE IF NOT EXISTS documentos(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    tipo_documento ENUM ('DOC', 'PDF', 'Outros') NOT NULL,
    id_imovel VARCHAR(25) NOT NULL,
    PRIMARY KEY(id)
);

SELECT * FROM clientes