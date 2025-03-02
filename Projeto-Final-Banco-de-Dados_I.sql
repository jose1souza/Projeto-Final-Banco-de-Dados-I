-- a tabela salas foi criada como entidade. 
-- a descrição é utilizada para informar tipo e numero do local onde será realizada a aula
-- ex: laboratorio de redes, sala 2, lab3...

CREATE DATABASE IF NOT EXISTS trabalhoDeBD;
use trabalhoDeBD;

CREATE TABLE IF NOT EXISTS salas (
  ID_Sala INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_Sala)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- a tabela agendamentos é uma entidade. Foi criada com o intuito de reservar as salas 
-- para uma horário de atendimento.
CREATE TABLE IF NOT EXISTS agendamentos (
  ID_Agendamento INT NOT NULL AUTO_INCREMENT,
  Data DATE NOT NULL,
  Hora TIME NOT NULL,
  Sala_ID INT NOT NULL,
  PRIMARY KEY (ID_Agendamento),
  INDEX fk_agendamento_sala (Sala_ID),
  CONSTRAINT fk_agendamento_sala FOREIGN KEY (Sala_ID) REFERENCES salas (ID_Sala) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela para cadastrar os emails de alunos e professores.
CREATE TABLE IF NOT EXISTS emails (
  ID_Email INT NOT NULL AUTO_INCREMENT,
  Email VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (ID_Email)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela para cadastrar os números de telefone com DDD de professores e alunos.
CREATE TABLE IF NOT EXISTS telefones (
  ID_Telefone INT NOT NULL AUTO_INCREMENT,
  DDD CHAR(3) NOT NULL,
  Numero CHAR(9) DEFAULT NULL,
  PRIMARY KEY (ID_Telefone)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para cadastrar os assistentes (cada assistente tem 1 aluno e cada aluno tem 1 assistente).
CREATE TABLE IF NOT EXISTS assistentes (
  ID_Assistente INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_Assistente)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela para cadastrar os endereços dos alunos e professores
CREATE TABLE IF NOT EXISTS enderecos (
  ID_Endereco INT NOT NULL AUTO_INCREMENT,
  CEP CHAR(8) NOT NULL,
  Rua VARCHAR(45) NOT NULL,
  Bairro VARCHAR(45) NOT NULL,
  Cidade VARCHAR(45) NOT NULL,
  Numero SMALLINT NOT NULL,
  PRIMARY KEY (ID_Endereco)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para cadastrar os alunos
CREATE TABLE IF NOT EXISTS alunos (
  ID_Aluno INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  Assistente_ID INT NOT NULL,
  Endereco_ID INT NOT NULL,
  PRIMARY KEY (ID_Aluno),
  INDEX fk_aluno_assistente (Assistente_ID),
  INDEX fk_aluno_endereco (Endereco_ID),
  CONSTRAINT fk_aluno_assistente FOREIGN KEY (Assistente_ID) REFERENCES assistentes (ID_Assistente) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_aluno_endereco FOREIGN KEY (Endereco_ID) REFERENCES enderecos (ID_Endereco) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela para colocar qual o tipo dio material (ex:slide, livro, artigo...)
CREATE TABLE IF NOT EXISTS tipos_materiais (
  ID_Tipo INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_Tipo)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para cadastrar o material utilizado nos horarios de atendimento
CREATE TABLE IF NOT EXISTS materiais_apoio (
  ID_Material INT NOT NULL AUTO_INCREMENT,
  Link VARCHAR(255) DEFAULT NULL,
  Tipo_Material_ID INT NOT NULL,
  PRIMARY KEY (ID_Material),
  INDEX fk_material_tipo (Tipo_Material_ID),
  CONSTRAINT fk_material_tipo FOREIGN KEY (Tipo_Material_ID) REFERENCES tipos_materiais (ID_Tipo) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para cadastrar as diciplinas
CREATE TABLE IF NOT EXISTS disciplinas (
  ID_Disciplina INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  Material_ID INT NOT NULL,
  PRIMARY KEY (ID_Disciplina),
  INDEX fk_disciplina_material (Material_ID),
  CONSTRAINT fk_disciplina_material FOREIGN KEY (Material_ID) REFERENCES materiais_apoio (ID_Material) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para cadastrar os eventos que podem ocorrer
CREATE TABLE IF NOT EXISTS eventos (
  ID_Evento INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) DEFAULT NULL,
  Local VARCHAR(45) DEFAULT NULL,
  Data DATE DEFAULT NULL,
  Hora TIME DEFAULT NULL,
  PRIMARY KEY (ID_Evento)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para cadastrar professores
CREATE TABLE IF NOT EXISTS professores (
  ID_Professor INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  Agendamento_ID INT NOT NULL,
  Endereco_ID INT NOT NULL,
  PRIMARY KEY (ID_Professor),
  INDEX fk_professor_agendamento (Agendamento_ID),
  INDEX fk_professor_endereco (Endereco_ID),
  CONSTRAINT fk_professor_agendamento FOREIGN KEY (Agendamento_ID) REFERENCES agendamentos (ID_Agendamento) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_professor_endereco FOREIGN KEY (Endereco_ID) REFERENCES enderecos (ID_Endereco) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para os professores reservarem um horaruo de atendimento
CREATE TABLE IF NOT EXISTS horarios_atendimento (
  ID_Horario INT NOT NULL AUTO_INCREMENT,
  Data DATE NOT NULL,
  Hora TIME DEFAULT NULL,
  Professor_ID INT NOT NULL,
  Sala_ID INT NOT NULL,
  Disciplina_ID INT NOT NULL,
  PRIMARY KEY (ID_Horario),
  INDEX fk_horario_professor (Professor_ID),
  INDEX fk_horario_sala (Sala_ID),
  INDEX fk_horario_disciplina (Disciplina_ID),
  CONSTRAINT fk_horario_professor FOREIGN KEY (Professor_ID) REFERENCES professores (ID_Professor) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_horario_sala FOREIGN KEY (Sala_ID) REFERENCES salas (ID_Sala) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_horario_disciplina FOREIGN KEY (Disciplina_ID) REFERENCES disciplinas (ID_Disciplina) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela entidade para os alunos darem suas opiniões sobre os atendimentos
CREATE TABLE IF NOT EXISTS feedbacks (
  ID_Feedback INT NOT NULL AUTO_INCREMENT,
  Nota SMALLINT NOT NULL,
  Comentario VARCHAR(255) DEFAULT NULL,
  Aluno_ID INT NOT NULL,
  Disciplina_ID INT NOT NULL,
  PRIMARY KEY (ID_Feedback),
  INDEX fk_feedback_aluno (Aluno_ID),
  INDEX fk_feedback_disciplina (Disciplina_ID),
  CONSTRAINT fk_feedback_aluno FOREIGN KEY (Aluno_ID) REFERENCES alunos (ID_Aluno) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_feedback_disciplina FOREIGN KEY (Disciplina_ID) REFERENCES disciplinas (ID_Disciplina) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


-- é uma tabela para ligar o aluno em suas disciplinas
CREATE TABLE IF NOT EXISTS aluno_disciplinas (
  Aluno_ID INT NOT NULL,
  Disciplina_ID INT NOT NULL,
  PRIMARY KEY (Aluno_ID, Disciplina_ID),
  CONSTRAINT fk_aluno_disciplina FOREIGN KEY (Aluno_ID) REFERENCES alunos (ID_Aluno) ON DELETE CASCADE,
  CONSTRAINT fk_disciplina_aluno FOREIGN KEY (Disciplina_ID) REFERENCES disciplinas (ID_Disciplina) ON DELETE CASCADE
) ENGINE = InnoDB;


-- é uma tabela para ligar os alunos aos seus respectivos telefones
CREATE TABLE IF NOT EXISTS aluno_telefones (
  Aluno_ID INT NOT NULL,
  Telefone_ID INT NOT NULL,
  PRIMARY KEY (Aluno_ID, Telefone_ID),
  CONSTRAINT fk_aluno_telefone FOREIGN KEY (Aluno_ID) REFERENCES alunos (ID_Aluno) ON DELETE CASCADE,
  CONSTRAINT fk_telefone_aluno FOREIGN KEY (Telefone_ID) REFERENCES telefones (ID_Telefone) ON DELETE CASCADE
) ENGINE = InnoDB;


-- é uma tabela para ligar os alunos aos seus respectivos emails
CREATE TABLE IF NOT EXISTS aluno_emails (
  Aluno_ID INT NOT NULL,
  Email_ID INT NOT NULL,
  PRIMARY KEY (Aluno_ID, Email_ID),
  CONSTRAINT fk_aluno_email FOREIGN KEY (Aluno_ID) REFERENCES alunos (ID_Aluno) ON DELETE CASCADE,
  CONSTRAINT fk_email_aluno FOREIGN KEY (Email_ID) REFERENCES emails (ID_Email) ON DELETE CASCADE
) ENGINE = InnoDB;


-- é uma tabela para ligar os professores aos seus respectivos emails
CREATE TABLE IF NOT EXISTS professor_emails (
  ID_Professor INT NOT NULL,
  ID_Email INT NOT NULL,
  PRIMARY KEY (ID_Professor, ID_Email),
  CONSTRAINT fk_prof_email_prof FOREIGN KEY (ID_Professor) REFERENCES professores (ID_Professor) ON DELETE CASCADE,
  CONSTRAINT fk_prof_email_email FOREIGN KEY (ID_Email) REFERENCES emails (ID_Email) ON DELETE CASCADE
) ENGINE = InnoDB;


-- é uma tabela para ligar os professores aos seus respectivos telefones
CREATE TABLE IF NOT EXISTS professor_telefones (
  ID_Professor INT NOT NULL,
  ID_Telefone INT NOT NULL,
  PRIMARY KEY (ID_Professor, ID_Telefone),
  CONSTRAINT fk_prof_tel_prof FOREIGN KEY (ID_Professor) REFERENCES professores (ID_Professor) ON DELETE CASCADE,
  CONSTRAINT fk_prof_tel_tel FOREIGN KEY (ID_Telefone) REFERENCES telefones (ID_Telefone) ON DELETE CASCADE
) ENGINE = InnoDB;


-- é uma tabela para ligar os professores aos seus respectivas disciplinas
CREATE TABLE IF NOT EXISTS professor_disciplinas (
  ID_Professor INT NOT NULL,
  ID_Disciplina INT NOT NULL,
  PRIMARY KEY (ID_Professor, ID_Disciplina),
  CONSTRAINT fk_prof_disc_prof FOREIGN KEY (ID_Professor) REFERENCES professores (ID_Professor) ON DELETE CASCADE,
  CONSTRAINT fk_prof_disc_disc FOREIGN KEY (ID_Disciplina) REFERENCES disciplinas (ID_Disciplina) ON DELETE CASCADE
) ENGINE = InnoDB;


-- é uma tabela para cadastrar as salas que um evento vai ser realizado
CREATE TABLE IF NOT EXISTS eventos_salas (
  Evento_ID INT NOT NULL,
  Sala_ID INT NOT NULL,
  PRIMARY KEY (Evento_ID, Sala_ID),
  INDEX fk_eventos_salas_evento (Evento_ID),
  INDEX fk_eventos_salas_sala (Sala_ID),
  CONSTRAINT fk_eventos_salas_evento FOREIGN KEY (Evento_ID) REFERENCES eventos (ID_Evento) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_eventos_salas_sala FOREIGN KEY (Sala_ID) REFERENCES salas (ID_Sala) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


-- é uma tabela para anotar quais alunos estarão/estavam em cada atendimento
CREATE TABLE IF NOT EXISTS horario_aluno (
  Horario_ID INT NOT NULL,
  Aluno_ID INT NOT NULL,
  PRIMARY KEY (Horario_ID, Aluno_ID),
  INDEX fk_horario (Horario_ID),
  INDEX fk_aluno (Aluno_ID),
  CONSTRAINT fk_horario FOREIGN KEY (Horario_ID) REFERENCES horarios_atendimento (ID_Horario) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_aluno FOREIGN KEY (Aluno_ID) REFERENCES alunos (ID_Aluno) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- inserindo dados nas salas
INSERT INTO salas(Descricao)
VALUES 	('Sala 1'),
        ('Sala 2'),
        ('Sala 3'),
        ('Sala 4'),
        ('Sala 5');
        
SELECT * FROM salas;

-- inserindo dados nos eventos
INSERT INTO eventos (Nome, Local, Data, Hora)
VALUES  ('Feira1','Sala 1','2025-01-02','07:00:00'),
        ('Feira2','Sala 2','2025-01-07','08:00:00'),
        ('Feira3','Sala 3','2025-01-05','09:00:00'),
        ('Feira4','Sala 4','2025-01-04','10:00:00'),
        ('Feira5','Sala 5','2025-01-03','11:00:00');
        
SELECT * FROM eventos;

-- inserindo dados nos eventos das salas
INSERT INTO eventos_salas(Evento_ID,Sala_ID)
VALUES  (1,1),
		(1,2),
		(2,3),
        (2,4),
		(3,1),
		(3,2),
		(4,5),
		(4,4),
		(5,2),
		(5,5);

-- inserindo dados nos endereços
INSERT INTO enderecos(ID_Endereco,CEP,Rua,Bairro,Cidade,Numero)
VALUES 	(1,'12345678','Rua dos Borros','Centro','Divinópolis',1),
        (2,'12345678','Rua dos Rarros','Centro','Divinópolis',2),
        (3,'12345678','Rua dos Cupim','Centro','Divinópolis',3),
        (4,'12345678','Rua da Rua','Centro','Divinópolis',4),
        (5,'12345678','Rua da Ana','Centro','Divinópolis',5),
        (6,'12345678','Rua do José','Centro','Divinópolis',6),
        (7,'12345678','Rua do Cebolinha','Centro','Divinópolis',7),
        (8,'12345678','Rua do Cascão','Centro','Divinópolis',8),
        (9,'12345678','Rua Joaquim','Centro','Divinópolis',9),
        (10,'12345678','Rua da Manhã','Centro','Divinópolis',10);
        
SELECT * FROM enderecos;

-- inserindo dados dos agendamentos
INSERT INTO agendamentos (Data,Hora,Sala_ID)
VALUES ('2025-01-08','10:00:00',1),
       ('2025-01-08','11:00:00',2),
       ('2025-01-08','12:00:00',3),
       ('2025-01-08','13:00:00',4),
       ('2025-01-08','14:00:00',5);
       
SELECT *FROM agendamentos;

-- inserindo dados dos emails dos professores e alunos
INSERT INTO emails (Email)
VALUES  ('professor1@gmail.com'),
        ('professor2@gmail.com'),
        ('professor3@gmail.com'),
        ('professor4@gmail.com'),
        ('professor5@gmail.com'),
        ('professor6@gmail.com'),
        ('professor7@gmail.com'),
        ('aluno1@gmail.com'),
        ('aluno2@gmail.com'),
        ('aluno3@gmail.com'),
        ('aluno4@gmail.com'),
        ('aluno5@gmail.com'), 
        ('aluno6@gmail.com'),
        ('aluno7@gmail.com'),
        ('aluno8@gmail.com');
        
SELECT * FROM emails;

-- inserindo dados dos telefones dos professores e alunos
INSERT INTO telefones (DDD, Numero)
VALUES  ('035','999999110'),
		('035','999999999'),
        ('035','999999991'),
        ('035','999999992'),
        ('035','999999993'),
        ('035','999999935'),
        ('035','999999994'),
        ('035','999999995'),
        ('035','999999996'),
        ('035','999999997'),
        ('035','999999998'),
        ('035','999999910'),
        ('035','999999990'),
        ('035','999999911');
        
SELECT * FROM  telefones;

-- inserindo dados dos assistentes dos alunos
INSERT INTO assistentes (Nome)
VALUES  ('Augusto'), 
        ('Ana'),
        ('Joao'),
        ('Maria'),
        ('Julia');
        
SELECT * FROM assistentes;

-- inserindo dados dos tipos de materias das disciplinas
INSERT INTO tipos_materiais (Descricao)
VALUES  ('Slide'),
        ('Livro'),
        ('Artigo'),
        ('Outros'),
        ('Outros'),
        ('Outros'),
        ('Video');
        
SELECT * FROM tipos_materiais;

-- inserindo dados dos materiais de apoio das disciplinas
INSERT INTO materiais_apoio (Link, Tipo_Material_ID) 
VALUES  ('www.slide.com',1),
        ('www.livro.com',2),
        ('www.artigo.com',3),
        ('www.outro.com',4),
        ('www.outro.com',5),
        ('www.outro.com',6),
        ('www.video.com',7);
        
SELECT * FROM materiais_apoio;

-- inserindo dados das disciplinas
INSERT INTO disciplinas (Nome, Material_ID)
VALUES  ('Inglês',1),
        ('Matemática',2),
        ('Programação',3),
        ('Banco de Dados',4),
        ('Administração',5),
        ('Jogos',6),
        ('Matemática Discreta',7);
        
SELECT * FROM disciplinas;

-- inserindo dados dos alunos
INSERT INTO alunos (Nome, Assistente_ID, Endereco_ID)
VALUES  ('José',1,6),
        ('Carol',2,7),
        ('Isabela',3,8),
        ('Carlos',4,9),
        ('Flávio',5,10);
        
SELECT * FROM alunos;

-- inserindo dados dos feedbacks feitos pelos alunos
INSERT INTO feedbacks(Nota,Comentario,Aluno_ID,Disciplina_ID)
VALUES 	(1,'Muito ruim',1,1),
        (2,'Ruim',1,2),
        (3,'Bom',2,3),
        (4,'Quase Perfeito',3,4),
        (5,'Perfeito',4,5);
        
SELECT * FROM feedbacks;

-- inserindo dados dos professores
INSERT INTO professores(Nome,Agendamento_ID,Endereco_ID)
VALUES 	('Marcela',1,6),
        ('Marcelo',2,7),
        ('Fábio',3,8),
        ('Ana',4,9),
        ('Lígia',5,10);
        
SELECT * FROM professores;

-- inserindo dados dos horarios de atendimentos feito pelos professores
INSERT INTO horarios_atendimento(Data,Hora,Sala_ID,Professor_ID,Disciplina_ID)
VALUES 	('2025-02-02','07:00:00',1,1,1),
        ('2025-03-07','08:00:00',2,2,2),
        ('2025-04-05','09:00:00',3,3,3),
        ('2025-05-04','10:00:00',4,4,4),
        ('2025-06-03','11:00:00',5,5,4);
        
SELECT * FROM horarios_atendimento;	

-- inserindo os emails aos alunos
INSERT aluno_emails (Aluno_ID,Email_ID) 
VALUES  (1,8), 
		(1,9),
        (2,10),
        (3,11),
        (3,12),
        (4,13),
        (5,14);

-- inserindo os alunos nas disciplinas
INSERT aluno_disciplinas (Aluno_ID,Disciplina_ID) 
VALUES  (1,1), 
		(1,2),
        (2,3),
        (3,4),
        (3,5),
        (4,1),
        (5,3);
        
-- inserindo os telefones nos alunos
INSERT aluno_telefones (Aluno_ID,Telefone_ID) 
VALUES  (1,7), 
		(1,8),
        (2,9),
        (3,10),
        (3,11),
        (4,12),
        (5,13);

-- inserindo os telefones aos professores
INSERT professor_telefones (ID_Professor,ID_Telefone) 
VALUES  (1,1), 
		(1,2),
        (2,3),
        (3,4),
        (4,5),
        (5,6);

-- inserindo os emails aos professores
INSERT professor_emails (ID_Professor,ID_Email) 
VALUES  (1,1), 
		(1,2),
        (2,3),
        (3,4),
        (3,5),
        (4,6),
        (5,7);

-- inserindo as disciplinas aos professores
INSERT professor_disciplinas (ID_Professor,ID_Disciplina) 
VALUES  (1,1), 
		(1,2),
        (2,3),
        (3,4),
        (3,5),
        (4,6),
        (5,7);

-- inserindo os alunos ao horario de atendimento
INSERT Horario_Aluno (Horario_ID,Aluno_ID) 
VALUES  (1,1), 
		(1,2),
        (2,3),
        (3,2),
        (3,4),
        (3,5),
        (4,5),
        (5,5);

-- Consultas SQL:
-- 1. Execute pelo menos 10 consultas SQL, incluindo:
-- a. Junção de tabelas.
-- b. Funções de agregação (como COUNT, SUM, AVG).
-- c. Utilização de operadores lógicos e relacionais.
-- d. Ordenação e agrupamento de resultados.

-- A
-- Mostrando todos os dados de telefone relacionado à alunos usando o INNER JOIN para a Junção de tabelas.

SELECT al.nome AS aluno, t.ddd, t.numero 
FROM aluno_telefones AS a 

INNER JOIN alunos AS al 
ON a.Aluno_ID = al.ID_Aluno

INNER JOIN telefones AS t 
ON a.Telefone_ID = t.ID_Telefone;

-- -------------------------------------------------------------

-- Mostrando todos os nomes das disciplinas dos professores utilizando o INNER JOIN para a Junção de tabelas.

SELECT p.nome AS Professor, d.nome AS Disciplina 
FROM professores AS p

INNER JOIN professor_disciplinas AS pd 
ON p.ID_Professor = pd.ID_Professor

INNER JOIN disciplinas AS d 
ON pd.ID_Disciplina = d.ID_Disciplina;

-- ------------------------------------------------------------

-- Mostrando os dados da tabela tipos de materiais utilizando o INNER JOIN para a Junção de tabelas.

SELECT m.ID_Material,m.link,t.Descricao FROM materiais_apoio AS m
INNER JOIN tipos_materiais AS t
ON m.Tipo_Material_ID = t.ID_Tipo;

-- -------------------------------------------------------------

-- Mostrando os nomes dos assistentes ligados à alunos usando o INNER JOIN para a Junção de tabelas.

SELECT a.nome AS nome_assistente,al.nome AS nome_aluno FROM alunos AS al
INNER JOIN assistentes AS a
ON a.ID_Assistente = al.Assistente_ID;

-- -------------------------------------------------------------

-- B
-- Mostrando o total de números de telefones de cada aluno usando Funções de agregação 
-- (no caso utilizamos o COUNT) para contar quantos telefones tem cada aluno.

SELECT a.nome AS Nome_aluno, COUNT(alt.Telefone_ID) AS total_telefones
FROM aluno_telefones AS alt

INNER JOIN alunos AS a
ON alt.Aluno_ID = a.ID_Aluno

INNER JOIN telefones AS t 
ON alt.Telefone_ID = t.ID_Telefone

GROUP BY a.nome
HAVING COUNT(alt.Telefone_ID) != 3;

-- -------------------------------------------------------------

-- Mostrando o total de disciplinas de cada professor utilizando Funções de agregação 
-- (no caso utilizamos o COUNT) para contar quantas disciplinas tem cada professor.

SELECT p.nome AS Nome_professor, COUNT(pd.ID_Disciplina) AS total_disciplinas
FROM professor_disciplinas AS pd

INNER JOIN professores AS p
ON pd.ID_Professor = p.ID_Professor

INNER JOIN disciplinas AS d 
ON pd.ID_Disciplina = d.ID_Disciplina

GROUP BY p.nome
HAVING COUNT(pd.ID_Disciplina) > 1;

-- -------------------------------------------------------------

-- C
-- Mostrando os dados da tabela telefone dos alunos Flávio e José
--  utilizando o INNER JOIN e o WHERE além dos operadores lógicos e relacionais.

SELECT al.nome AS aluno, t.ddd, t.numero 
FROM aluno_telefones AS a 

INNER JOIN alunos AS al 
ON a.Aluno_ID = al.ID_Aluno

INNER JOIN telefones AS t 
ON a.Telefone_ID = t.ID_Telefone
WHERE al.nome = 'Flávio' OR al.nome = 'José';

-- ---------------------------------------------------------

-- Mostrando os professores que ensinam uma disciplina cujo o nome começa com a letra F
-- utilizando o INNER JOIN e o WHERE além dos operadores lógicos e relacionais.

SELECT p.nome AS Professor, d.nome AS Disciplina 
FROM professores AS p

INNER JOIN professor_disciplinas AS pd 
ON p.ID_Professor = pd.ID_Professor

INNER JOIN disciplinas AS d 
ON pd.ID_Disciplina = d.ID_Disciplina
WHERE p.ID_Professor > 2 AND p.nome LIKE 'F%' ;

-- ---------------------------------------------------------
-- D
-- Mostrando apenas os números de alguns alunos,
-- utilizando o GROUP BY para realizar o agrupamento de resultados.

SELECT a.nome AS alunos,  t.numero AS telefones
FROM aluno_telefones AS alt

INNER JOIN alunos AS a 
ON alt.Aluno_ID = a.ID_Aluno

INNER JOIN telefones AS t 
ON alt.Telefone_ID = t.ID_Telefone
GROUP BY a.nome;

-- ------------------------------------------------------
-- Mostrando todos os números de telefone, inclusive quem tem mais de um
-- utilizando o ORDER BY para realizar a ordenação de resultados.
SELECT a.nome AS alunos,  t.numero AS telefones
FROM aluno_telefones AS alt

INNER JOIN alunos AS a 
ON alt.Aluno_ID = a.ID_Aluno

INNER JOIN telefones AS t 
ON alt.Telefone_ID = t.ID_Telefone
ORDER BY t.numero DESC;