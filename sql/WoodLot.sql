DROP DATABASE IF EXISTS WOODLOT;

CREATE DATABASE WOODLOT;
USE WOODLOT;

CREATE TABLE prodotto (
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
    PRIMARY KEY (id)
);

CREATE TABLE categorie_prodotti (
    pid BIGINT NOT NULL,
    cid BIGINT NOT NULL,
    PRIMARY KEY (pid , cid),
    CONSTRAINT FKcategory FOREIGN KEY (cid)
        REFERENCES woodlot.categoria (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FKproduct FOREIGN KEY (pid)
        REFERENCES woodlot.prodotto (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE users (
    id BIGINT NOT NULL AUTO_INCREMENT,
    username VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    nome VARCHAR(45) NOT NULL,
    cognome VARCHAR(45) NOT NULL,
    password VARCHAR(45) NOT NULL,
    role VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE ordine (
    id BIGINT AUTO_INCREMENT,
    uid BIGINT NOT NULL,
    destinazione VARCHAR(255) NOT NULL,
    totaleProdotti INT NOT NULL,
    totalPagato DOUBLE NOT NULL,
    stato CHAR(30),
    regalo TINYINT DEFAULT 0,
    messaggioRegalo VARCHAR(255) NULL,
    creatodIl TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
    breveDescrizione VARCHAR(45) DEFAULT NULL,
    prezzo DOUBLE NOT NULL,
    saldo DOUBLE NOT NULL DEFAULT 0,
    quantità INT NOT NULL DEFAULT 0,
    tasse DOUBLE NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT fk_order FOREIGN KEY (oid)
        REFERENCES ordine (id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE indirizzo (
    id BIGINT AUTO_INCREMENT,
    cid BIGINT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    cognome VARCHAR(45) NOT NULL,
    indirizzo VARCHAR(255) NOT NULL,
    cap VARCHAR(5) NOT NULL,
    città VARCHAR(60) NOT NULL,
    provincia VARCHAR(2) NOT NULL,
    telefono VARCHAR(20) NULL,
    info VARCHAR(255) NULL,
    alias VARCHAR(45) NULL,
    preferred TINYINT NULL DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE INDEX cid_preferred (cid , preferred),
    CONSTRAINT FK__useres FOREIGN KEY (cid)
        REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

/*
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
);*/

INSERT INTO categoria (nome,descrizione)
	VALUES ("Sicurezza alimentare", "L’albero assicura una buona produzione di frutti, ricchi di vitamine.");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Rischio estinzione", "L'albero è classificato come “in pericolo” nella Lista rossa delle specie minacciate dell’IUCN (Unione internazionale per la conservazione della natura) dal 2011.");
 INSERT INTO categoria (nome,descrizione)
	VALUES ("Sviluppo sostenibile", "Gli alberi sono donati alla cooperativa agricola Cascinet: una comunità aperta alle relazioni con tanta terra da coltivare. Numerosi progetti sociali auto-generati dalla cittadinanza, produzione di iniziative partecipate per divertirsi e crescere insieme. Un modello sostenibile a misura di felicità!");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Crescita rapida", "L’albero assicura una crescita molto rapida");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Salvaguardia Ambientale", "Ci addentriamo nella foresta amazzonica per recuperare sementi storici di alberi forestali, che poi coltiviamo in vivaio. Questi alberi vengono inseriti in sistemi forestali misti in cui la varietà di specie assicura la stabilità e la resilienza dell’impianto.");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Sostegno economico", "Nel nostro progetto in Guatemala, si produce un cacao raffinato che offre un importante sostegno economico alle famiglie contadine che lo coltivano.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Avocado", "Persea americana Mill.","Un frutto che piace a tutti, ricco di vitamine e nutrienti, per questo particolarmente apprezzato dalle mamme. In Guatemala viene utilizzato per la preparazione di molti piatti tipici, tra cui il guacamole. Le nostre piante di Avocado in Guatemala sono sostenibili a 360°: offrono supporto economico e sostegno alimentare, senza venir meno alla sostenibilità ambientale.", "65 Kg/anno di frutta prodotta", 10.00, 19.00, "Guatemala", 10, 50.00, 50.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Caboa", "Swietenia macrophylla King","La Caoba, pianta a foglia larga nativa della foresta tropicale, è un albero alto e maestoso che sovrasta la chioma della foresta. Può crescere fino a 50 metri di altezza ed ha un tronco con un diametro fino a 2-3 metri. Si tratta di una specie ad alto fusto a rischio estinzione per via della deforestazione e per l’elevato sfruttamento del suo legno pregiato.", "330 Kg di CO2 assorbit",30.00, 18.00, "Perù", 10 ,50.00,100.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Melo", "Malus domestica L.","Piantiamo meli a Milano, all’interno del Parco della Vettabbia: un grande parco periurbano a sud della città. Questi meli si inseriscono in un ambizioso progetto di agroforestazione urbana rigenerativa, portata avanti con l’azienda agricola sociale Soulfood Forestfarms.", "330 Kg di CO2 assorbita", 8.00, 35.00, "Italia", 10, 40.00, 80.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Pino", "Pinus caribaea Morelet","Il pino caraibico è stato introdotto un po’ in tutto il mondo nel XIX secolo per creare monocolture destinate alla creazione di navi. Cresce rapidamente su terreni che hanno subito incendi.", "630 Kg di CO2 assorbita", 20.00, 16.00, "Guatemala", 10, 100.00, 40.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Arancia", "Citrus × aurantium (L.)","Dal sud della Cina, attraverso la Via della Seta, l’arancia si è diffusa in tutto l’oriente; poi grazie agli arabi in Europa e dall’Europa ha raggiunto le americhe.
Quella che piantiamo in Guatemala non è l’arancia che tutti conosciamo: è molto aspra e viene utilizzata per lo più nella preparazione di piatti tipici.", "40 kg/anno di frutta prodotta", 3.50, 16.00, "Italia", 10, 100.00, 40.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Amazzonia Forestale", "Ayahuasca","Ci spingiamo nel profondo della foresta amazzonica per recuperare sementi antiche e a rischio di estinzione.
Pashaco, Estoraque, Palisangre, Palo baston, Yacushapana, Quillobordon sono gli alberi dai nomi non facilissimi con cui preserviamo la biodiversità di questa magnifica foresta.", "300 kg di CO2 assorbit", 10.00, 18.00, "Perù", 10, 100.00, 60.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Cacao", "Theobroma cacao (L.)","Cioccolato. Basta sentire la parola per rendere felici grandi e piccini. In Guatemala viene coltivato da migliaia di anni: sono proprio le popolazioni Maya ad aver scoperto e utilizzato le fave e il burro di cacao a scopo alimentare. Questo frutto era talmente importante da essere utilizzato come moneta di scambio tra i popoli indigeni maya. Tutt’ora un’ottima fonte di reddito per le famiglie contadine.", "3 Kg/anno di fave prodotte", 6.00, 20.00, "Guatemala", 10, 20.00, 100.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Cedrela", "Cedrela odorosa L.","La Cedrela Odorata, albero sempreverde dalle dimensioni maestose, è una conifera appartenente alla famiglia delle Pinaceae. È una pianta tipica dell’America Centrale.
Ottimo alleato nel rigenerare terreni degradati, ha una crescita molto rapida.", "330 kg di CO2 assorbiti", 15.00, 16.00, "Guatemala", 10, 40.00, 40.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Chicozapote", "Manilkara zapota (L.)", "I suo frutti, dolci e prelibati, hanno un gusto che ricorda un mix di mandorla e pera. Largamente apprezzati e consumati dai popoli centroamericani e dai mammiferi della foresta pluviale. Le nostre piante di Chicozapote in Guatemala, offrono supporto economico e sostegno alimentare alle famiglie contadine, inoltre aiutano a ricostruire habitat utili per altre specie di piante e molti animali.", "40 kg/anno di frutta prodotti", 12.00, 20.00, "Guatemala", 10, 22.00, 34.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Lime", "Citrus aurantiifolia (Christm.)", "Ciao sono un Lime:Sebbene in Guatemala si chiami “Limon”, in Europa è conosciuto come Lime. Più piccolo e più aspro di un limone, questo frutto è molto usato nelle bevande rinfrescanti.", "60 Kg/anno di frutta prodotta", 5.50, 17.00, "Guatemala", 10, 70.00, 80.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Mango", "Mangifera indica (L.)", "Conosciuto soprattutto per il suo frutto è dolcissimo e ricco di Vitamina A e C,l’albero del mango è un albero “tuttofare”. Alle comunità contadine del Guatemala offre frutta, legname, materia organica per nutrire il suolo e i frutti che cadono a terra vengono utilizzati come mangime per il bestiame.", "100 kg/anno di frutta prodotta", 8.50, 18.00, "Guatemala", 10, 100.00, 100.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Mogano", "Swietenia macrophylla", "Può raggiungere anche i 50 metri d’altezza ed è caratterizzato per un tronco molto resistente al passare degli anni anche se esposto ad agenti atmosferici, ai parassiti e ai funghi. La sua longevità lo rende il vegliardo della foresta.", "60 Kg/anno di frutta prodotta", 5.50, 17.00, "Guatemala", 10, 70.00, 80.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Pesco", "Prunus persica (L.) Batsch", "Piantiamo peschi in Piemonte, nei terreni della fattoria didattica La Piemontesina, che si trova a pochi chilometri (meno di 10) dal parco fluviale del fiume Po. Piantare alberi qui ha degli effetti diretti nel contrastare siccità e desertificazione. 
L’intero progetto della fattoria nasce appunto per ridurre il dissesto idrogeologico della zona.", "60 Kg/anno di frutta prodotta", 5.00, 35.00, "Italia", 10, 100.00, 100.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Pioppo", "Populus L.", "Piantiamo pioppi in Piemonte, nei terreni della fattoria didattica La Piemontesina: che si trova a pochi chilometri (meno di 10) dal parco fluviale del fiume Po. Piantare alberi qui, ha degli effetti diretti nel contrastare siccità e desertificazione. 
L’intero progetto della fattoria nasce appunto per ridurre il dissesto idrogeologico della zona.", "Salvaguardia Ambientale", 30.00, 35.00, "Italia", 10, 90.00, 80.00);
INSERT INTO prodotto (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo, paeseDiOrigine, quantità, co2, salvaguardia) 
	VALUES ("Amazzonia da frutto", "Huicungo", "Alberi il cui solo nome è impronunciabile che producono frutti nativi della foresta più grande del mondo. Dobbiamo ancora scoprirne tutti i sapori. Aiutaci a piantarli!", "50 Kg/anno di frutta prodott", 20.00, 35.00, "Peù", 10, 90.00, 80.00);

INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (1,1);
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (1,15);      
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (1,9);      
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (1,5);   
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (1,13); 
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (2,2);
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (3,3);
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (4,4);
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (4,12);
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (5,6); 
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (5,14); 
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (5,8); 
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (6,7);  
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (6,3);    
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (6,11);  
INSERT INTO categorie_prodotti(cid,pid) 
	VALUES (6,10);   














