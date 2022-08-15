DROP DATABASE IF EXISTS WOODLOT;

CREATE DATABASE WOODLOT;
USE WOODLOT;

CREATE TABLE paeseDiOrigine (
    nome VARCHAR(45) NOT NULL,
    descrizione  TEXT,
    foto MEDIUMBLOB DEFAULT NULL,
	PRIMARY KEY (nome)
);

CREATE TABLE prodotto (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(128) NOT NULL,
    nomeScientifico VARCHAR(45) DEFAULT NULL,
    descrizione TEXT NOT NULL,
	sottotitolo VARCHAR(45) DEFAULT NULL,
    descrizioneBreve TEXT DEFAULT NULL, 
    doveVienePiantato TEXT DEFAULT NULL,
    altezza DOUBLE NOT NULL DEFAULT 0,
    prezzo DOUBLE NOT NULL DEFAULT 0,
    pid VARCHAR(45) NOT NULL,
    onSale INT NOT NULL DEFAULT 0,
    quantità INT NOT NULL DEFAULT 0,
    co2 DOUBLE NOT NULL DEFAULT 0,
    salvaguardia DOUBLE NOT NULL DEFAULT 0,
    saldo DOUBLE NOT NULL DEFAULT 0,
    tasse DOUBLE NOT NULL DEFAULT 22.00,
    disponibile BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (id),
    CONSTRAINT FKpaeseDiOrigine FOREIGN KEY (pid)
        REFERENCES woodlot.paeseDiOrigine (nome)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE fotoProdotto (
    nomeFoto INT AUTO_INCREMENT PRIMARY KEY,
    foto mediumblob default null,
    pid BIGINT NOT NULL,
   CONSTRAINT FKprodotto FOREIGN KEY (pid)
        REFERENCES prodotto (id)     
        ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE utente (
    id BIGINT NOT NULL AUTO_INCREMENT,
    username VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    nome VARCHAR(45) NOT NULL,
    cognome VARCHAR(45) NOT NULL,
    password VARCHAR(45) NOT NULL,
    role VARCHAR(45) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE ordine (
    id BIGINT AUTO_INCREMENT,
    uid BIGINT NOT NULL,
    totaleProdotti INT NOT NULL,
    totalePagato DOUBLE NOT NULL,
    regalo TINYINT DEFAULT 0,
    messaggioRegalo VARCHAR(255) NULL,
    creatoIl TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_user FOREIGN KEY (uid)
        REFERENCES utente (id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);
	
CREATE TABLE prodottoOrdine (
    id BIGINT AUTO_INCREMENT,
    oid BIGINT NOT NULL,
    nome VARCHAR(128) NOT NULL,
    descrizione TEXT NOT NULL,
    breveDescrizione TEXT DEFAULT NULL,
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
    civico INT NOT NULL,
    preferred TINYINT NULL DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE INDEX cid_preferred (cid , preferred),
    CONSTRAINT FK__useres FOREIGN KEY (cid)
        REFERENCES utente (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE codicePromozionale(
	id BIGINT AUTO_INCREMENT,
    codice VARCHAR(45) NOT NULL,
    dataInizioValidità DATE,
    dataFineValidità DATE,
    scontoApplicato DOUBLE,
    descrizione VARCHAR(45),
    PRIMARY KEY (id)
);

CREATE TABLE codicePromozionaleUsato (
    pid BIGINT,
    uid BIGINT,
    oid BIGINT,
    FOREIGN KEY (pid)
        REFERENCES codicePromozionale (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (oid)
        REFERENCES ordine (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (uid)
        REFERENCES utente (id)
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

INSERT INTO paeseDiOrigine (nome)
	VALUES ("Guatemala");
INSERT INTO paeseDiOrigine (nome)
	VALUES ("Perù");
INSERT INTO paeseDiOrigine (nome)
	VALUES ("Italia");

INSERT INTO utente (username,password,email,nome,cognome,role) 
	VALUES ("alessiature","alessiature","alessiature@gmail.com","Alessia","Ture","cliente");
INSERT INTO utente (username,password,email,nome,cognome,role) 
	VALUES ("cliente","cliente","cliente@gmail.com","cliente","cliente","cliente");
INSERT INTO utente (username,password,email,nome,cognome,role) 
	VALUES ("admin","admin","admin@gmail.com","admin","admin","admin");
    
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

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia, descrizioneBreve, doveVienePiantato) 
	VALUES ("Avocado", "Persea americana Mill.","Un frutto che piace a tutti, ricco di vitamine e nutrienti, per questo particolarmente apprezzato dalle mamme. In Guatemala viene utilizzato per la preparazione di molti piatti tipici, tra cui il guacamole. Le nostre piante di Avocado in Guatemala sono sostenibili a 360°: offrono supporto economico e sostegno alimentare, senza venir meno alla sostenibilità ambientale.", "65 Kg/anno di frutta prodotta", 10.00, 19.00, "Guatemala", 10, 50.00, 50.00,"Gli antichi popoli del Centro America consideravano l'Avocado un frutto dall'incredibile potere afrodisiaco, definito anche 'frutto dell'amore' il suo nome deriva dalla parola azteca ahuacalt che significa ... testicolo","Piantiamo l’avocado in Guatemala, nella regione del Petén in terreni a forte rischio desertificazione. Le piantagioni a monocoltura intensive richiedono tanta acqua, fertilizzanti e pesticidi chimici. Al contrario, nei nostri sistemi agroforestali misti, la varietà di specie assicura la stabilità e la resilienza dell’impianto. Un sistema agroforestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e produce costantemente produzioni variegate.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Caboa", "Swietenia macrophylla King","La Caoba, pianta a foglia larga nativa della foresta tropicale, è un albero alto e maestoso che sovrasta la chioma della foresta. Può crescere fino a 50 metri di altezza ed ha un tronco con un diametro fino a 2-3 metri. Si tratta di una specie ad alto fusto a rischio estinzione per via della deforestazione e per l’elevato sfruttamento del suo legno pregiato.", "330 Kg di CO2 assorbit",30.00, 18.00, "Perù", 10 ,50.00,100.00,"Caoboa era un termine indigeno che sta per 'frutto che non si mangia'. Particolamrmente appprezzato dagli ebanisti, durante gli anni  '90 il principlae esportatore fu la Bolivia ma, a causa di uno sfruttamento inadeguato, in questo caso la specie è quasi scomparsa","In Perù, all’interno dell’Amazzonia peruviana, piantiamo alberi in via d’estizione, partendo da sementi storiche raccolte nella foresta. Lo scopo è quello di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Melo", "Malus domestica L.","Piantiamo meli a Milano, all’interno del Parco della Vettabbia: un grande parco periurbano a sud della città. Questi meli si inseriscono in un ambizioso progetto di agroforestazione urbana rigenerativa, portata avanti con l’azienda agricola sociale Soulfood Forestfarms.", "330 Kg di CO2 assorbita", 8.00, 35.00, "Italia", 10, 40.00, 80.00,"Un frutto, mille leggende. Esistono più di 7000 varietà in tutto il mondo: 2000 solo in Italia","Un progetto di agroforestazione a Milano. Nel Parco della Vettabbia, a un passo dai quartieri di Corvetto e Porto di Mare, stiamo lavorando con l’impresa agricola e sociale Soulfood Forestfarms a un grande progetto agroforestale volto alla rigenerazione ambientale e sociale di alcuni ettari di parco abbandonati con l’obiettivo di attivare nuovi sistemi di produzione e consumo biologici e a KM0.
Secondo questa tecnica di gestione agroforestale, si crea un ecosistema composto da alberi, arbusti e colture annuali capace di rigenerare il suolo e contribuire al mitigamento degli effetti del cambiamento climatico.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato)  
	VALUES ("Pino", "Pinus caribaea Morelet","Il pino caraibico è stato introdotto un po’ in tutto il mondo nel XIX secolo per creare monocolture destinate alla creazione di navi. Cresce rapidamente su terreni che hanno subito incendi.", "630 Kg di CO2 assorbita", 20.00, 16.00, "Guatemala", 10, 100.00, 40.00,"Il pino dei caraibi è un po' diverso dai nostri pini medirerranei. é un albero a crescita rapida, è capace di crescere al livello del mare e in terreni molto aridi. Ottimo alleato nel rigenerare terreni degradati, richiede poche cure ed una crescita molto rapida.","Nei nostri impianti forestali in Guatemala utilizziamo specie native a rapido accrescimento adattate all’ambiente e resistenti ai parassiti. Le comunità alle quali doniamo le nostre piante sono costantemente formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi forestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto . Un sistema forestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e allo stesso tempo assicura alti tassi di assorbimento di CO2.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Arancia", "Citrus × aurantium (L.)","Dal sud della Cina, attraverso la Via della Seta, l’arancia si è diffusa in tutto l’oriente; poi grazie agli arabi in Europa e dall’Europa ha raggiunto le americhe.
Quella che piantiamo in Guatemala non è l’arancia che tutti conosciamo: è molto aspra e viene utilizzata per lo più nella preparazione di piatti tipici.", "40 kg/anno di frutta prodotta", 3.50, 16.00, "Italia", 10, 100.00, 40.00,"I suoi fiori sono simbolo di matrimonio e amore fi da quando, secondo la mitologia greca, Gea-Dea della terra donò un albero di arancia per le nozze di Zeus e Hera. L'arancio è un antico ibrido nato più di 4000 anni fa dall'incrocio fra il pomeolo e il mandarino","Piantiamo l’arancia in Guatemala, nella regione del Petén. Le comunità contadine locali coltivano l’albero di arancia in terreni a rischio desertificazione. Dando vita a impianti agroforestali, e non monoculture, si assicura la rigenerazione graduale del suolo e della biodiversità animale e vegetale.
Un sistema agroforestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e produce costantemente produzioni variegate.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Amazzonia Forestale", "Ayahuasca","Ci spingiamo nel profondo della foresta amazzonica per recuperare sementi antiche e a rischio di estinzione.
Pashaco, Estoraque, Palisangre, Palo baston, Yacushapana, Quillobordon sono gli alberi dai nomi non facilissimi con cui preserviamo la biodiversità di questa magnifica foresta.", "300 kg di CO2 assorbit", 10.00, 18.00, "Perù", 10, 100.00, 60.00,"Alberi autocnoni dal cuore della foresta pluiviale più grande del mondo, per rigenerare e combattere la deforestazione del nostro polmone verde","In Perù, all’interno dell’Amazzonia peruviana. Piantiamo diversi alberi nativi forestali con lo scopo di proteggere e rigenerare la biodiversità con lo scopo di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Cacao", "Theobroma cacao (L.)","Cioccolato. Basta sentire la parola per rendere felici grandi e piccini. In Guatemala viene coltivato da migliaia di anni: sono proprio le popolazioni Maya ad aver scoperto e utilizzato le fave e il burro di cacao a scopo alimentare. Questo frutto era talmente importante da essere utilizzato come moneta di scambio tra i popoli indigeni maya. Tutt’ora un’ottima fonte di reddito per le famiglie contadine.", "3 Kg/anno di fave prodotte", 6.00, 20.00, "Guatemala", 10, 20.00, 100.00,"Come dicevano gli aztechi, il frutto del cacao nasconde un tesoro di semi amari come le soffrenze dell'amore, forti come il coraggio rossi come il sangue","Piantiamo il cacao in Guatemala, nella regione del Petén. Le comunità contadine locali coltivano l’albero di cacao in terreni a rischio desertificazione. Dando vita a impianti agroforestali, e non monoculture, si assicura la rigenerazione graduale del suolo e della biodiversità animale e vegetale.
Un ecosistema stabile dove la pianta del cacao potrà crescere protetta dall’ombra di alberi ad alto fusto.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato)  
	VALUES ("Cedrela", "Cedrela odorosa L.","La Cedrela Odorata, albero sempreverde dalle dimensioni maestose, è una conifera appartenente alla famiglia delle Pinaceae. È una pianta tipica dell’America Centrale.
Ottimo alleato nel rigenerare terreni degradati, ha una crescita molto rapida.", "330 kg di CO2 assorbiti", 15.00, 16.00, "Guatemala", 10, 40.00, 40.00,"I maya e i primi coloni usavano la Cedrela principalmente per la costruzione di canore e case, in quanto non viene attaccato dai tarli. Da allora non ha cessato di essere appprezzato per il suo legno pregiato.","Nei nostri impianti forestali in Guatemala utilizziamo specie native a rapido accrescimento adattate all’ambiente e resistenti ai parassiti. Le comunità alle quali doniamo le nostre piante sono costantemente formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi forestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto . Un sistema forestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e allo stesso tempo assicura alti tassi di assorbimento di CO2.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Chicozapote", "Manilkara zapota (L.)", "I suo frutti, dolci e prelibati, hanno un gusto che ricorda un mix di mandorla e pera. Largamente apprezzati e consumati dai popoli centroamericani e dai mammiferi della foresta pluviale. Le nostre piante di Chicozapote in Guatemala, offrono supporto economico e sostegno alimentare alle famiglie contadine, inoltre aiutano a ricostruire habitat utili per altre specie di piante e molti animali.", "40 kg/anno di frutta prodotti", 12.00, 20.00, "Guatemala", 10, 22.00, 34.00,"Gli antichi popoli mesoamericano facevano bollire la sua linfa, il 'chicle': la modellavano e la taliavano in pezzi per poterla masticare La prima gomma da masticare conosciuta. I maya usavano il legame pregiato e durevole per costuire i loro templi.","Nei nostri impianti agroforestali in Guatemala utilizziamo specie native di Chicozapote molto adattate all’ambiente, resistenti ai parassiti e super produttive. Le piante vengono allevate alternate con altre specie erbacee e piante arboree contribuendo alla rigenerazione della biodiversità. Le comunità alle quali doniamo il chicozapote sono formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi agroforestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto. Un sistema agroforestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e produce costantemente produzioni variegate.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Lime", "Citrus aurantiifolia (Christm.)", "Ciao sono un Lime:Sebbene in Guatemala si chiami “Limon”, in Europa è conosciuto come Lime. Più piccolo e più aspro di un limone, questo frutto è molto usato nelle bevande rinfrescanti.", "60 Kg/anno di frutta prodotta", 5.50, 17.00, "Guatemala", 10, 70.00, 80.00,"Sebbene in Guatemala si chiami 'Limon', in Europa è consciuto come Lime, Più piccolo e più aspro di un limone, questo frutto è molto usato nele bevande rifrenscanti.","Piantiamo il lime in Guatemala, nella regione del Petén. Le comunità contadine locali coltivano l’albero di lime in terreni a rischio desertificazione. Dando vita a impianti agroforestali, e non monoculture, si assicura la rigenerazione graduale del suolo e della biodiversità animale e vegetale.
Un sistema agroforestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e produce costantemente produzioni variegate.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Mango", "Mangifera indica (L.)", "Conosciuto soprattutto per il suo frutto è dolcissimo e ricco di Vitamina A e C,l’albero del mango è un albero “tuttofare”. Alle comunità contadine del Guatemala offre frutta, legname, materia organica per nutrire il suolo e i frutti che cadono a terra vengono utilizzati come mangime per il bestiame.", "100 kg/anno di frutta prodotta", 8.50, 18.00, "Guatemala", 10, 100.00, 100.00,"In India, secondo un'antica tradizione, se due contadini vogliono suggellare la loro amicizia, si organizzano cerimonie in cui due alberi di mango vengono 'uniti in matrimonio'. Albero dal legno solido, dai frutti dolci e dai fiori eleganti.","Piantiamo il mango in Guatemala, nella regione del Petén. Diamo vita a impianti agroforestali, e non monoculture, assicurando la rigenerazione graduale del suolo e della biodiversità animale e vegetale.
Nei sistemi agroforestali guatemaltechi le piante di mango offrono ombra e supporto ad altre piante in consociazione. I frutti e le foglie che cadano, nutrono il terreno, lo rigenerano e allo stesso tempo lo preservano dall’erosione.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Mogano", "Swietenia macrophylla", "Può raggiungere anche i 50 metri d’altezza ed è caratterizzato per un tronco molto resistente al passare degli anni anche se esposto ad agenti atmosferici, ai parassiti e ai funghi. La sua longevità lo rende il vegliardo della foresta.", "60 Kg/anno di frutta prodotta", 5.50, 17.00, "Guatemala", 10, 70.00, 80.00,"Una pianta particolarmente apprezzata nella creazione di strumenti, ad esempio le chitarre 'Gibson Les Paul'usano questo legno  dalle origini. Il legnaome del mogano conferisce al suono un timbro particolarmente caldo, corposo, bilancaito e ricco di sostegno.","Nei nostri impianti forestali in Guatemala utilizziamo specie native a rapido accrescimento  adattate all’ambiente e resistenti ai parassiti. Le comunità alle quali doniamo le nostre piante sono costantemente formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi forestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto . Un sistema forestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e allo stesso tempo assicura alti tassi di assorbimento di CO2.
");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Pesco", "Prunus persica (L.) Batsch", "Piantiamo peschi in Piemonte, nei terreni della fattoria didattica La Piemontesina, che si trova a pochi chilometri (meno di 10) dal parco fluviale del fiume Po. Piantare alberi qui ha degli effetti diretti nel contrastare siccità e desertificazione. 
L’intero progetto della fattoria nasce appunto per ridurre il dissesto idrogeologico della zona.", "60 Kg/anno di frutta prodotta", 5.00, 35.00, "Italia", 10, 100.00, 100.00, "BOH BOH BHO perchè copio le cose da un sito fatto male ....","BOH BOH BHO perchè copio le cose da un sito fatto male ....");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Pioppo", "Populus L.", "Piantiamo pioppi in Piemonte, nei terreni della fattoria didattica La Piemontesina: che si trova a pochi chilometri (meno di 10) dal parco fluviale del fiume Po. Piantare alberi qui, ha degli effetti diretti nel contrastare siccità e desertificazione. 
L’intero progetto della fattoria nasce appunto per ridurre il dissesto idrogeologico della zona.", "Salvaguardia Ambientale", 30.00, 35.00, "Italia", 10, 90.00, 80.00, "BOH BOH BHO perchè copio le cose da un sito fatto male ....","Nel vivaio della fattoria La Piemontesina, in cui crescono alberi forestali e da frutto. Gli alberi costituiscono le fondamenta delle attività educative sviluppate dalla fattoria, nata tra il 1982 e il 1984 accanto all’ex tenuta sabauda “La Mandria” di Chivasso, in provincia di Torino.
In questo Agriasilo, i piccoli imparano a prendersi cura di piante ed animali nel loro campo, orto e pollaio didattico, oltre che abituarsi a uno stile alimentare basato su prodotti di stagione coltivati in azienda.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Amazzonia da frutto", "Huicungo", "Alberi il cui solo nome è impronunciabile che producono frutti nativi della foresta più grande del mondo. Dobbiamo ancora scoprirne tutti i sapori. Aiutaci a piantarli!", "50 Kg/anno di frutta prodott", 20.00, 35.00, "Perù", 10, 90.00, 80.00,"Alberi il cui solo nome è impronunciabile che producono frutti nativi della foresta più grande del mondo.Dobbiamo ancora scoprirne tutti i sapoti. Auitaci a piantarli!","In Perù, all’interno dell’Amazzonia peruviana. Piantiamo diverse specie di alberi da frutto autoctoni con lo scopo di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");

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
    
INSERT INTO fotoProdotto (pid)
	VALUES (1);
INSERT INTO fotoProdotto (pid)
	VALUES (1);
INSERT INTO fotoProdotto (pid)
	VALUES (1);
INSERT INTO fotoProdotto (pid)
	VALUES (2);
INSERT INTO fotoProdotto (pid)
	VALUES (2);
INSERT INTO fotoProdotto (pid)
	VALUES (2);
INSERT INTO fotoProdotto (pid)
	VALUES (3);
INSERT INTO fotoProdotto (pid)
	VALUES (3);
INSERT INTO fotoProdotto (pid)
	VALUES (3);
INSERT INTO fotoProdotto (pid)
	VALUES (4);
INSERT INTO fotoProdotto (pid)
	VALUES (4);
INSERT INTO fotoProdotto (pid)
	VALUES (4);
INSERT INTO fotoProdotto (pid)
	VALUES (5);
INSERT INTO fotoProdotto (pid)
	VALUES (5);
INSERT INTO fotoProdotto (pid)
	VALUES (5);
INSERT INTO fotoProdotto (pid)
	VALUES (6);
INSERT INTO fotoProdotto (pid)
	VALUES (6);
INSERT INTO fotoProdotto (pid)
	VALUES (6);
INSERT INTO fotoProdotto (pid)
	VALUES (7);
INSERT INTO fotoProdotto (pid)
	VALUES (7);
INSERT INTO fotoProdotto (pid)
	VALUES (7);
INSERT INTO fotoProdotto (pid)
	VALUES (8);
INSERT INTO fotoProdotto (pid)
	VALUES (8);
INSERT INTO fotoProdotto (pid)
	VALUES (8);
INSERT INTO fotoProdotto (pid)
	VALUES (9);
INSERT INTO fotoProdotto (pid)
	VALUES (9);
INSERT INTO fotoProdotto (pid)
	VALUES (9);
INSERT INTO fotoProdotto (pid)
	VALUES (10);
INSERT INTO fotoProdotto (pid)
	VALUES (10);
INSERT INTO fotoProdotto (pid)
	VALUES (10);
INSERT INTO fotoProdotto (pid)
	VALUES (11);
INSERT INTO fotoProdotto (pid)
	VALUES (11);
INSERT INTO fotoProdotto (pid)
	VALUES (11);
INSERT INTO fotoProdotto (pid)
	VALUES (12);
INSERT INTO fotoProdotto (pid)
	VALUES (12);
INSERT INTO fotoProdotto (pid)
	VALUES (12);
    INSERT INTO fotoProdotto (pid)
	VALUES (13);
INSERT INTO fotoProdotto (pid)
	VALUES (13);
INSERT INTO fotoProdotto (pid)
	VALUES (13);
INSERT INTO fotoProdotto (pid)
	VALUES (14);
INSERT INTO fotoProdotto (pid)
	VALUES (14);
INSERT INTO fotoProdotto (pid)
	VALUES (14);
INSERT INTO fotoProdotto (pid)
	VALUES (15);
INSERT INTO fotoProdotto (pid)
	VALUES (15);
INSERT INTO fotoProdotto (pid)
	VALUES (15);
    
INSERT INTO codicePromozionale (codice,dataInizioValidità,dataFineValidità,scontoApplicato,descrizione)
	VALUES("ESTATE30","2022-06-20","2022-09-01", 20, "Saldi estivi"); 