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

