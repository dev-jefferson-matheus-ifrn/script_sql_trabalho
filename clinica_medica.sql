/*
SCRIPT: clinica_medica
OBJETIVO: Criar banco de dados, tabelas, inserir dados, e realizar consultas
SGBD: MySQL 8.x
AUTORES: Jefferson Matheus Ferreira de Lima, Ryan Kauan Medeiros de Souza, Jose Viton dos Santos
*/

CREATE DATABASE IF NOT EXISTS clinica
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE clinica;


DROP TABLE IF EXISTS tb_agendamentos;
DROP TABLE IF EXISTS tb_horarios;
DROP TABLE IF EXISTS tb_telefones_paciente;
DROP TABLE IF EXISTS tb_medicos;
DROP TABLE IF EXISTS tb_pacientes;
DROP TABLE IF EXISTS tb_enderecos_paciente;
DROP TABLE IF EXISTS tb_especialidades;

CREATE TABLE tb_especialidades( 
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_especialidade VARCHAR(80) NOT NULL UNIQUE 
) ENGINE=Innodb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE TABLE tb_enderecos_paciente(
    id INT AUTO_INCREMENT PRIMARY KEY,
    cidade VARCHAR(30) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    nome_rua VARCHAR(80) NOT NULL,
    numero_casa VARCHAR(6) NOT NULL,
    numero_cep VARCHAR(9) NOT NULL,
    nome_bairro VARCHAR(80) NOT NULL
)ENGINE=Innodb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE TABLE tb_pacientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    sexo CHAR NOT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,

    id_endereco INT,

    CONSTRAINT fk_paciente_endereco FOREIGN KEY(id_endereco)
        REFERENCES tb_enderecos_paciente(id)
)ENGINE=Innodb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE TABLE tb_telefones_paciente(
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_telefone VARCHAR(10) UNIQUE NOT NULL,
    id_paciente INT,

   CONSTRAINT fk_telefone_paciente FOREIGN KEY(id_paciente)
        REFERENCES tb_pacientes(id)
    
)ENGINE=Innodb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE TABLE tb_medicos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curriculo VARCHAR(255) NOT NULL,

    id_especialidade INT,

    CONSTRAINT fk_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES tb_especialidades(id)
    
)ENGINE=Innodb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE TABLE tb_horarios(
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_atendimento DATE NOT NULL,
    horario_atendimento TIME NOT NULL,
    status_atendimento VARCHAR(12) NOT NULL,

    id_medico INT,

    CONSTRAINT fk_medico FOREIGN KEY (id_medico)
        REFERENCES tb_medicos(id)
)ENGINE=Innodb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE TABLE tb_agendamentos(
    id INT AUTO_INCREMENT PRIMARY KEY,

    id_paciente INT,

    id_horario INT,

    status_agendamento VARCHAR(20),

        CONSTRAINT fk_paciente FOREIGN KEY (id_paciente)
        REFERENCES tb_pacientes(id),

        CONSTRAINT fk_horario FOREIGN KEY (id_horario)
        REFERENCES tb_horarios(id)

)ENGINE=Innodb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;


-- 1. Especialidades (5 registros)
INSERT INTO tb_especialidades (nome_especialidade) VALUES 
('Cardiologia'), ('Dermatologia'), ('Pediatria'), ('Ortopedia'), ('Ginecologia');

-- 2. Endereços (5 registros)
INSERT INTO tb_enderecos_paciente (cidade, uf, nome_rua, numero_casa, numero_cep, nome_bairro) VALUES
('Natal', 'RN', 'Av. Hermes da Fonseca', '120', '59020-000', 'Tirol'),
('Parnamirim', 'RN', 'Rua Clementino Bento', '45', '59140-100', 'Centro'),
('Mossoró', 'RN', 'Rua Alberto Maranhão', '1010', '59600-005', 'Alto da Conceição'),
('Natal', 'RN', 'Rua dos Potiguares', '500', '59054-000', 'Lagoa Nova'),
('Caicó', 'RN', 'Av. Seridó', '22', '59300-000', 'Centro');

-- 3. Pacientes (5 registros)
INSERT INTO tb_pacientes (nome, cpf, data_nascimento, sexo, email, id_endereco) VALUES
('Ana Silva', '111.222.333-44', '1990-05-15', 'F', 'ana.silva@email.com', 1),
('Bruno Souza', '222.333.444-55', '1985-10-20', 'M', 'bruno.s@email.com', 2),
('Carla Dias', '333.444.555-66', '2000-01-30', 'F', 'carla.d@email.com', 3),
('Diego Lima', '444.555.666-77', '1978-03-12', 'M', 'diego.l@email.com', 4),
('Elena Rose', '555.666.777-88', '1995-07-07', 'F', 'elena.r@email.com', 5);

-- 4. Médicos (5 registros)
INSERT INTO tb_medicos (nome, curriculo, id_especialidade) VALUES
('Dr. Arnaldo Neto', 'Formado pela UFRN, 10 anos de experiência.', 1),
('Dra. Beatriz Luz', 'Especialista em pele pela USP.', 2),
('Dr. Carlos Magno', 'Residência em Pediatria no HC.', 3),
('Dra. Daniela Ohara', 'Mestre em Ortopedia pela UNICAMP.', 4),
('Dr. Estevão Ferreira', 'Pós-doutor em Ginecologia.', 5);

-- 5. Horários (15 registros para popular a agenda)
INSERT INTO tb_horarios (data_atendimento, horario_atendimento, status_atendimento, id_medico) VALUES
('2024-05-20', '08:00:00', 'Ocupado', 1), ('2024-05-20', '09:00:00', 'Disponível', 1),
('2024-05-20', '10:00:00', 'Ocupado', 2), ('2024-05-20', '11:00:00', 'Disponível', 2),
('2024-05-21', '08:00:00', 'Ocupado', 3), ('2024-05-21', '09:00:00', 'Ocupado', 3),
('2024-05-21', '14:00:00', 'Disponível', 4), ('2024-05-21', '15:00:00', 'Ocupado', 4),
('2024-05-22', '08:00:00', 'Ocupado', 5), ('2024-05-22', '09:00:00', 'Disponível', 5),
('2024-05-22', '10:00:00', 'Disponível', 1), ('2024-05-22', '11:00:00', 'Disponível', 2),
('2024-05-23', '08:00:00', 'Disponível', 3), ('2024-05-23', '09:00:00', 'Disponível', 4),
('2024-05-23', '10:00:00', 'Disponível', 5);

-- 6. Agendamentos (Conectando Pacientes aos Horários Ocupados)
INSERT INTO tb_agendamentos (id_paciente, id_horario, status_agendamento) VALUES
(1, 1, 'Confirmado'),
(2, 3, 'Confirmado'),
(3, 5, 'Pendente'),
(4, 6, 'Cancelado'),
(5, 8, 'Confirmado'),
(1, 9, 'Confirmado');
