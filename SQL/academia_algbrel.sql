CREATE DATABASE IF NOT EXISTS `Academia`;

USE `Academia`;

CREATE TABLE IF NOT EXISTS `Usuario` (
    `matricula` INT AUTO_INCREMENT NOT NULL UNIQUE,
    `nome` VARCHAR(255) NOT NULL,
    `endereco` VARCHAR(255) NOT NULL,
    `data_nascimento` DATE NOT NULL,
    `data_inicio` DATE NOT NULL,
    `foto` LONGBLOB NOT NULL,
    PRIMARY KEY (`matricula`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Usuario_Telefone` (
    `usuario` INT NOT NULL,
    `telefone` INT NOT NULL,
    PRIMARY KEY (`usuario` , `telefone`),
    CONSTRAINT FOREIGN KEY (`usuario`) REFERENCES `Usuario` (`matricula`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Funcionario` (
    `registro_funcionario` INT NOT NULL UNIQUE AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,
    `endereco` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`registro_funcionario`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Funcionario_Telefone` (
    `codigo_funcionario` INT NOT NULL,
    `telefone` INT NOT NULL,
    PRIMARY KEY (`codigo_funcionario` , `telefone`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Manutencao` (
    `codigo_funcionario` INT NOT NULL UNIQUE,
    `area` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`codigo_funcionario`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Estagiario` (
    `codigo_funcionario` INT NOT NULL UNIQUE,
    `area` VARCHAR(255) NOT NULL,
    `instituicao_de_ensino` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`codigo_funcionario`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Professor` (
    `codigo_funcionario` INT NOT NULL UNIQUE,
    PRIMARY KEY (`codigo_funcionario`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Professor_Especialidade` (
    `codigo_professor` INT NOT NULL,
    `especialidade` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`codigo_professor` , `especialidade`),
    CONSTRAINT FOREIGN KEY (`codigo_professor`) REFERENCES `Professor` (`codigo_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Nutricionista` (
    `codigo_funcionario` INT NOT NULL UNIQUE,
    `CFN` INT NOT NULL UNIQUE,
    PRIMARY KEY (`codigo_funcionario`),
	CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Fisioterapeuta` (
    `codigo_funcionario` INT NOT NULL UNIQUE,
    `CREFITO` INT NOT NULL UNIQUE,
    PRIMARY KEY (`codigo_funcionario`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Administracao` (
    `codigo_funcionario` INT  NOT NULL UNIQUE,
    `area` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`codigo_funcionario`),
    CONSTRAINT FOREIGN KEY(`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Equipamento` (
    `codigo_equipamento` INT NOT NULL UNIQUE AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,
    `video_funcionamento` LONGBLOB,
    PRIMARY KEY (`codigo_equipamento`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Reparo` (
    `codigo_funcionario` INT NOT NULL,
    `codigo_equipamento` INT NOT NULL,
    `descricao_reparo` VARCHAR(255) NOT NULL,
    `data_reparo` DATETIME NOT NULL,
    PRIMARY KEY (`codigo_funcionario` , `codigo_equipamento` , `data_reparo`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Manutencao` (`codigo_funcionario`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`codigo_equipamento`) REFERENCES `Equipamento` (`codigo_equipamento`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Modalidade` (
    `codigo_modalidade` INT NOT NULL UNIQUE AUTO_INCREMENT,
    `nome` VARCHAR(255),
    `descricao` VARCHAR(255),
    `dias` VARCHAR(255),
    `horarios` VARCHAR(255),
    PRIMARY KEY (`codigo_modalidade`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Modalidades_Ministradas` (
    `codigo_professor` INT NOT NULL,
    `codigo_modalidade` INT NOT NULL,
    PRIMARY KEY (`codigo_professor` , `codigo_modalidade`),
    CONSTRAINT FOREIGN KEY (`codigo_professor`) REFERENCES `Professor` (`codigo_funcionario`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`codigo_modalidade`)  REFERENCES `Modalidade` (`codigo_modalidade`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Estagiario_Eh_Supervisionado` (
    `codigo_estagiario` INT NOT NULL UNIQUE,
    `codigo_supervisor` INT NOT NULL,
    PRIMARY KEY (`codigo_estagiario` , `codigo_supervisor`),
    CONSTRAINT FOREIGN KEY (`codigo_estagiario`) REFERENCES `Estagiario` (`codigo_funcionario`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`codigo_supervisor`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Inscricao` (
    `matricula_usuario` INT NOT NULL,
    `codigo_modalidade` INT NOT NULL,
    PRIMARY KEY (`matricula_usuario` , `codigo_modalidade`),
    CONSTRAINT FOREIGN KEY (`matricula_usuario`) REFERENCES `Usuario` (`matricula`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`codigo_modalidade`) REFERENCES `Modalidade` (`codigo_modalidade`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Consulta_Nutri` (
    `matricula_usuario` INT NOT NULL,
    `cod_nutri` INT NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY (`matricula_usuario` , `cod_nutri` , `data_hora`),
    CONSTRAINT FOREIGN KEY (`matricula_usuario`) REFERENCES `Usuario` (`matricula`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`cod_nutri`) REFERENCES `Nutricionista` (`codigo_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Consulta_Fisio` (
    `matricula_usuario` INT NOT NULL,
    `cod_fisio` INT NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY (`matricula_usuario` , `cod_fisio` , `data_hora`),
    CONSTRAINT FOREIGN KEY (`matricula_usuario`) REFERENCES `Usuario` (`matricula`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`cod_fisio`) REFERENCES `Fisioterapeuta` (`codigo_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Elabora_Treino` (
    `matricula_usuario` INT NOT NULL,
    `cod_prof` INT NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY (`matricula_usuario` , `cod_prof` , `data_hora`),
    CONSTRAINT FOREIGN KEY (`matricula_usuario`) REFERENCES `Usuario` (`matricula`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`cod_prof`) REFERENCES `Professor` (`codigo_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

/*
    `codigo_modalidade` INT NOT NULL UNIQUE AUTO_INCREMENT,
    `nome` VARCHAR(255),
    `descricao` VARCHAR(255),
    `dias` VARCHAR(255),
    `horarios` VARCHAR(255),
*/

INSERT INTO `Usuario`
VALUES (DEFAULT, 'aecio', 'octogonal', '1997-09-17', '2018-09-17', 'blobbbb');

INSERT INTO `Usuario`
VALUES (DEFAULT, 'lucas', 'cruzeiro', '1996-09-17', '2018-11-02', 'blobbbbaa');

INSERT INTO `Modalidade`
VALUES (DEFAULT, 'crossfit', 'balancar corda e pular', 'ter-qui', '14h-15h');

INSERT INTO `Modalidade`
VALUES (DEFAULT, 'karate', 'luta de contato', 'seg-qua', '08h-09h');

INSERT INTO `Inscricao`
VALUES (1, 1);

INSERT INTO `Inscricao`
VALUES (1, 2);

INSERT INTO `Inscricao`
VALUES (2, 1);

INSERT INTO `Inscricao`
VALUES (2, 2);

INSERT INTO `Usuario_Telefone`
VALUES (1, 99997777);

INSERT INTO `Usuario_Telefone`
VALUES (1, 99998888);

INSERT INTO `Usuario_Telefone`
VALUES (2, 88885555);

/* seleciona nome e telefone de todos os alunos de karate*/
SELECT Usuario_Telefone.telefone, usuario.nome from (usuario_telefone JOIN usuario on (usuario.matricula = usuario_telefone.usuario) JOIN inscricao on (usuario.matricula = inscricao.matricula_usuario) JOIN modalidade on (inscricao.codigo_modalidade = modalidade.codigo_modalidade)) where Inscricao.codigo_modalidade = (select modalidade.codigo_modalidade from modalidade where modalidade.nome = 'karate');

/*
CREATE TABLE IF NOT EXISTS `Funcionario` (
    `registro_funcionario` INT NOT NULL UNIQUE AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,
    `endereco` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`registro_funcionario`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Funcionario_Telefone` (
    `codigo_funcionario` INT NOT NULL,
    `telefone` INT NOT NULL,
    PRIMARY KEY (`codigo_funcionario` , `telefone`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Manutencao` (
    `codigo_funcionario` INT NOT NULL UNIQUE,
    `area` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`codigo_funcionario`),
    CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;
*/


/* nome e telefone dos funcionarios que participarão da manutenção elétrica */

INSERT INTO `Funcionario`
VALUES (DEFAULT, 'Augusto', 'Cruzeiro');

INSERT INTO `Funcionario`
VALUES (DEFAULT, 'Marcos', 'Aguas Claras');

INSERT INTO `Funcionario`
VALUES (DEFAULT, 'Joao', 'Sudoeste');

INSERT INTO `Funcionario_Telefone`
VALUES (1, 22234112);

INSERT INTO `Funcionario_Telefone`
VALUES (1, 32234112);

INSERT INTO `Funcionario_Telefone`
VALUES (2, 12234112);

INSERT INTO `Funcionario_Telefone`
VALUES (2, 52234112);

INSERT INTO `Manutencao`
VALUES (1, 'eletrica');

INSERT INTO `Manutencao`
VALUES (2, 'eletrica');

SELECT Funcionario_Telefone.telefone, Funcionario.nome from (funcionario_telefone JOIN funcionario on (funcionario.registro_funcionario = funcionario_telefone.codigo_funcionario) JOIN manutencao on (funcionario.registro_funcionario = manutencao.codigo_funcionario)) where manutencao.area = 'eletrica';



/* dentro da area de eletrica, verificar a disponibilidade do multimetro (quando o mesmo estara sendo utilizado em alguma manutenção)*/


INSERT INTO `Equipamento`
VALUES (DEFAULT, 'multimetro', 'blob');

INSERT INTO `Equipamento`
VALUES (DEFAULT, 'amperimetro', 'blob');

INSERT INTO `Reparo`
VALUES (1, 1, 'eletrica', '2019-07-14');

INSERT INTO `Reparo`
VALUES (1, 2, 'eletrica', '2019-07-14');

INSERT INTO `Reparo`
VALUES (2, 1, 'eletrica', '2019-07-14');


SELECT reparo.data_reparo from (funcionario join manutencao on (funcionario.registro_funcionario = manutencao.codigo_funcionario) join reparo on (funcionario.registro_funcionario = reparo.codigo_funcionario) join equipamento on (equipamento.codigo_equipamento = reparo.codigo_equipamento)) where equipamento.nome = 'multimetro' AND manutencao.area = 'eletrica' group by reparo.data_reparo;

/* consulta do nome dos funcionários que possuem algum estagiário supervisionado*/
/*CREATE TABLE IF NOT EXISTS `Estagiario_Eh_Supervisionado` (
    `codigo_estagiario` INT NOT NULL UNIQUE,
    `codigo_supervisor` INT NOT NULL,
    PRIMARY KEY (`codigo_estagiario` , `codigo_supervisor`),
    CONSTRAINT FOREIGN KEY (`codigo_estagiario`) REFERENCES `Estagiario` (`codigo_funcionario`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`codigo_supervisor`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Nutricionista` (
    `codigo_funcionario` INT NOT NULL UNIQUE,
    `CFN` INT NOT NULL UNIQUE,
    PRIMARY KEY (`codigo_funcionario`),
	CONSTRAINT FOREIGN KEY (`codigo_funcionario`) REFERENCES `Funcionario` (`registro_funcionario`) ON DELETE CASCADE
) ENGINE = InnoDB;
*/

INSERT INTO `estagiario`
VALUES (3, 'nutricao', 'UnB');

INSERT INTO `nutricionista`
VALUES (3, 1234);

INSERT INTO `estagiario_eh_supervisionado`
VALUES (

/* consertar o esquema da PK estagiario codigo (que por enquanto faz referencia ao funcionario)
SELECT funcionario.nome from (funcionario join estagiario_eh_supervisionado on (funcionario.registro_funcionario = estagiario_eh_supervisionado.codigo_supervisor) join estagiario on (estagiario.codigo_funcionario = estagiario_eh_supervisionado.codigo_estagiario));