DROP DATABASE IF EXISTS WOODLOT;

CREATE DATABASE WOODLOT;
USE WOODLOT;

CREATE TABLE alberi (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(128) NOT NULL,
    nomeScientifico VARCHAR(45) DEFAULT NULL,
    descrizione TEXT NOT NULL,
    descrizioneBreve VARCHAR(45) DEFAULT NULL,
    altezza DOUBLE NOT NULL DEFAULT 0,
    prezzo DOUBLE NOT NULL DEFAULT 0,
    paeseDiOrigine VARCHAR(45) NOT NULL,
    onSale INT NOT NULL DEFAULT 0,
    quantità INT NOT NULL DEFAULT 0,
    co2 DOUBLE NOT NULL DEFAULT 0,
    salvaguardia DOUBLE NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE categoria (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL DEFAULT 'NOCATEGORY',
    descrizione VARCHAR(400) NOT NULL DEFAULT 'NODESCRIPTION',
    PRIMARY KEY (nome)
);

CREATE TABLE categorie_alberi (
    pid BIGINT NOT NULL,
    cid BIGINT NOT NULL,
    PRIMARY KEY (pid , cid),
    CONSTRAINT FKcategory FOREIGN KEY (cid)
        REFERENCES woodlot.categoria (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FKproduct FOREIGN KEY (pid)
        REFERENCES woodlot.alberi (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE utente (
    Email CHAR(30),
    Password CHAR(255),
    Nome CHAR(20),
    PRIMARY KEY (Email , Password)
);

CREATE TABLE amministratore (
    Email CHAR(50),
    Password CHAR(255),
    PRIMARY KEY (Email , Password)
);

CREATE TABLE ordine (
    id BIGINT AUTO_INCREMENT,
    uid BIGINT NOT NULL,
    destinatione VARCHAR(255) NOT NULL,
    totaleProdotti INT NOT NULL,
    totalPagato DOUBLE NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_user FOREIGN KEY (uid)
        REFERENCES users (id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);
	
CREATE TABLE prodotto_ordine (
    id BIGINT AUTO_INCREMENT,
    oid BIGINT NOT NULL,
    nome VARCHAR(128) NOT NULL,
    descrizione TEXT NOT NULL,
    piccolaDescrizione VARCHAR(45) DEFAULT NULL,
    prezzo DOUBLE NOT NULL,
    saldo DOUBLE NOT NULL DEFAULT 0,
    quantità INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT fk_order FOREIGN KEY (oid)
        REFERENCES orders (id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE MetodoDiPagamento (
    Numero CHAR(16),
    TitolareCarta CHAR(30),
    Tipo CHAR(20),
    Scadenza DATE,
    CVV CHAR(3),
    PasswordUtente CHAR(255),
    EmailUtente CHAR(30),
    FOREIGN KEY (EmailUtente , PasswordUtente)
        REFERENCES Utente (Email , Password)
        ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (PasswordUtente , EmailUtente , Numero)
);

CREATE TABLE Indirizzo (
    Destinatario CHAR(50),
    Via CHAR(30),
    NumeroCivico INT,
    CAP INT,
    Tipo ENUM('Spedizione', 'Fatturazione'),
    EmailUtente CHAR(30),
    PasswordUtente CHAR(255),
    FOREIGN KEY (EmailUtente , PasswordUtente)
        REFERENCES Utente (Email , Password)
        ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (Destinatario , Tipo , EmailUtente , PasswordUtente)
);
