DROP DATABASE IF EXISTS WOODLOT;

CREATE DATABASE WOODLOT;
USE WOODLOT;

CREATE TABLE paeseDiOrigine (
    nome VARCHAR(45) NOT NULL,
    descrizione TEXT,
    foto MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (nome)
);

CREATE TABLE usiLocali (
	id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    descrizione  TEXT,
    foto MEDIUMBLOB DEFAULT NULL,
	PRIMARY KEY (id)
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
    co2 INT NOT NULL DEFAULT 0,
    salvaguardia INT NOT NULL DEFAULT 0,
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

CREATE TABLE albero_usiLocali (
    pid BIGINT NOT NULL,
    uid BIGINT NOT NULL,
    PRIMARY KEY (pid , uid),
    FOREIGN KEY (uid)
        REFERENCES woodlot.usiLocali (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (pid)
        REFERENCES woodlot.prodotto (id)
        ON UPDATE CASCADE ON DELETE CASCADE
); 

 CREATE TABLE categoria (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL DEFAULT 'NOCATEGORY',
    descrizione VARCHAR(400) NOT NULL DEFAULT 'NODESCRIPTION',
    foto MEDIUMBLOB DEFAULT NULL,
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

CREATE TABLE benefici(
    id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione VARCHAR(400) NOT NULL,
    foto MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE kit (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione TEXT NOT NULL,
    saldo DOUBLE NOT NULL,
    foto MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE kit_alberi (
    pid BIGINT NOT NULL,
    kid BIGINT NOT NULL,
    PRIMARY KEY (pid , kid),
    FOREIGN KEY (kid)
        REFERENCES woodlot.kit (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (pid)
        REFERENCES woodlot.prodotto (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE benefici_prodotti (
    pid BIGINT NOT NULL,
    cid BIGINT NOT NULL,
    percentuale DOUBLE,
    PRIMARY KEY (pid , cid),
    FOREIGN KEY (cid)
        REFERENCES woodlot.benefici (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (pid)
        REFERENCES woodlot.prodotto (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE utente (
    id BIGINT NOT NULL AUTO_INCREMENT,
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
    regalo BOOLEAN DEFAULT FALSE,
    messaggioRegalo VARCHAR(255) NULL,
    destinatarioRegalo VARCHAR(255) NULL,
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
    stato VARCHAR(128) NOT NULL ,
    foto MEDIUMBLOB DEFAULT NULL,
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
    via VARCHAR(255) NOT NULL,
    cap VARCHAR(5) NOT NULL,
    città VARCHAR(60) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    civico INT NOT NULL,
    preferred BOOLEAN DEFAULT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK__useres FOREIGN KEY (cid)
        REFERENCES utente (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO paeseDiOrigine (nome)
	VALUES ("Guatemala");
INSERT INTO paeseDiOrigine (nome)
	VALUES ("Perù");
INSERT INTO paeseDiOrigine (nome)
	VALUES ("Italia");

INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("alessiature","alessiature@gmail.com","Alessia","Ture","cliente");
INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("frida","raffaella@gmail.com","Raffaella","Spagnuolo","cliente");
INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("cliente","cliente@gmail.com","cliente","cliente","cliente");
INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("admin","admin@gmail.com","admin","admin","admin");
    
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia, descrizioneBreve, doveVienePiantato) 
	VALUES ("Avocado", "Persea americana Mill.","Un frutto che piace a tutti, ricco di vitamine e nutrienti, per questo particolarmente apprezzato dalle mamme. In Guatemala viene utilizzato per la preparazione di molti piatti tipici, tra cui il guacamole. Le nostre piante di Avocado in Guatemala sono sostenibili a 360°: offrono supporto economico e sostegno alimentare, senza venir meno alla sostenibilità ambientale.", "65 Kg/anno di frutta prodotta", 10.00, 19.00, "Guatemala", 10, 4, 5,"Gli antichi popoli del Centro America consideravano l'Avocado un frutto dall'incredibile potere afrodisiaco, definito anche 'frutto dell'amore' il suo nome deriva dalla parola azteca ahuacalt che significa ... testicolo","Piantiamo l’avocado in Guatemala, nella regione del Petén in terreni a forte rischio desertificazione. Le piantagioni a monocoltura intensive richiedono tanta acqua, fertilizzanti e pesticidi chimici. Al contrario, nei nostri sistemi agroforestali misti, la varietà di specie assicura la stabilità e la resilienza dell’impianto. Un sistema agroforestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e produce costantemente produzioni variegate.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Caboa", "Swietenia macrophylla King","La Caoba, pianta a foglia larga nativa della foresta tropicale, è un albero alto e maestoso che sovrasta la chioma della foresta. Può crescere fino a 50 metri di altezza ed ha un tronco con un diametro fino a 2-3 metri. Si tratta di una specie ad alto fusto a rischio estinzione per via della deforestazione e per l’elevato sfruttamento del suo legno pregiato.", "330 Kg di CO2 assorbit",30.00, 18.00, "Perù", 10 ,5, 5,"Caoboa era un termine indigeno che sta per 'frutto che non si mangia'. Particolarmente appprezzato dagli ebanisti, durante gli anni  '90 il principale esportatore fu la Bolivia ma, a causa di uno sfruttamento inadeguato, in questo caso la specie è quasi scomparsa","In Perù, all’interno dell’Amazzonia peruviana, piantiamo alberi in via d’estizione, partendo da sementi storiche raccolte nella foresta. Lo scopo è quello di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Melo", "Malus domestica L.","Piantiamo meli a Milano, all’interno del Parco della Vettabbia: un grande parco periurbano a sud della città. Questi meli si inseriscono in un ambizioso progetto di agroforestazione urbana rigenerativa, portata avanti con l’azienda agricola sociale Soulfood Forestfarms.", "330 Kg di CO2 assorbita", 8.00, 35.00, "Italia", 10, 2, 2,"Un frutto, mille leggende. Esistono più di 7000 varietà in tutto il mondo: 2000 solo in Italia","Un progetto di agroforestazione a Milano. Nel Parco della Vettabbia, a un passo dai quartieri di Corvetto e Porto di Mare, stiamo lavorando con l’impresa agricola e sociale Soulfood Forestfarms a un grande progetto agroforestale volto alla rigenerazione ambientale e sociale di alcuni ettari di parco abbandonati con l’obiettivo di attivare nuovi sistemi di produzione e consumo biologici e a KM0.
Secondo questa tecnica di gestione agroforestale, si crea un ecosistema composto da alberi, arbusti e colture annuali capace di rigenerare il suolo e contribuire al mitigamento degli effetti del cambiamento climatico.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato)  
	VALUES ("Pino", "Pinus caribaea Morelet","Il pino caraibico è stato introdotto un po’ in tutto il mondo nel XIX secolo per creare monocolture destinate alla creazione di navi. Cresce rapidamente su terreni che hanno subito incendi.", "630 Kg di CO2 assorbita", 20.00, 16.00, "Guatemala", 10, 4, 2,"Il pino dei caraibi è un po' diverso dai nostri pini medirerranei. é un albero a crescita rapida, è capace di crescere al livello del mare e in terreni molto aridi. Ottimo alleato nel rigenerare terreni degradati, richiede poche cure ed una crescita molto rapida.","Nei nostri impianti forestali in Guatemala utilizziamo specie native a rapido accrescimento adattate all’ambiente e resistenti ai parassiti. Le comunità alle quali doniamo le nostre piante sono costantemente formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi forestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto . Un sistema forestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e allo stesso tempo assicura alti tassi di assorbimento di CO2.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Arancia", "Citrus × aurantium (L.)","Con l’arrivo dell’autunno le energie esplosive e dinamiche dell’estate cominciano a affievolirsi, lasciando spazio a una profonda sensibilità, tipica di Venere, Signora della Bilancia, portatrice di affinità e unione tra gli esseri umani. Grazie alla sua eleganza, Venere ti rende capace di lasciare senza parole le persone che ti circondano, dalle quali ti aspetti onestà e complicità. L’albero che meglio rappresenta le persone nate sotto il segno della Bilancia è l’Arancio. Delicato, vitale e attraente, l’arancio è portatore di gioia, equilibrio e ottimismo, inteso come la proiezione verso il futuro della luce che porti con te.", "Albero della Bilancia", 3.50, 16.00, "Italia", 10, 5, 1,"I suoi fiori sono simbolo di matrimonio e amore fin da quando, secondo la mitologia greca, Gea-Dea della terra donò un albero di arancia per le nozze di Zeus e Hera. L'arancio è un antico ibrido nato più di 4000 anni fa dall'incrocio fra il pomeolo e il mandarino","Un progetto di agroforestazione a Milano. Nel Parco della Vettabbia, a un passo dai quartieri di Corvetto e Porto di Mare, stiamo lavorando con l’impresa agricola e sociale Soulfood Forestfarms a un grande progetto agroforestale volto alla rigenerazione ambientale e sociale di alcuni ettari di parco abbandonati con l’obiettivo di attivare nuovi sistemi di produzione e consumo biologici e a KM0. Secondo questa tecnica di gestione agroforestale, si crea un ecosistema composto da alberi, arbusti e colture annuali capace di rigenerare il suolo e contribuire al mitigamento degli effetti del cambiamento climatico.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Amazzonia Forestale", "Ayahuasca","Ci spingiamo nel profondo della foresta amazzonica per recuperare sementi antiche e a rischio di estinzione.
Pashaco, Estoraque, Palisangre, Palo baston, Yacushapana, Quillobordon sono gli alberi dai nomi non facilissimi con cui preserviamo la biodiversità di questa magnifica foresta.", "300 kg di CO2 assorbita", 10.00, 18.00, "Perù", 10, 5, 4,"Alberi autocnoni dal cuore della foresta pluiviale più grande del mondo, per rigenerare e combattere la deforestazione del nostro polmone verde","In Perù, all’interno dell’Amazzonia peruviana. Piantiamo diversi alberi nativi forestali con lo scopo di proteggere e rigenerare la biodiversità con lo scopo di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Cacao", "Theobroma cacao (L.)","Cioccolato. Basta sentire la parola per rendere felici grandi e piccini. In Guatemala viene coltivato da migliaia di anni: sono proprio le popolazioni Maya ad aver scoperto e utilizzato le fave e il burro di cacao a scopo alimentare. Questo frutto era talmente importante da essere utilizzato come moneta di scambio tra i popoli indigeni maya. Tutt’ora un’ottima fonte di reddito per le famiglie contadine.", "Albero dei pesci", 6.00, 20.00, "Guatemala", 10, 2, 5,"A dare un tocco di calore alla fine dell’inverno ci pensa il segno dei Pesci che, come gli altri segni d’acqua, conferisce un tono emotivo e una profonda sensibilità al tuo modo di affrontare le giornate. Nettuno, Signore dei Pesci, ti aiuta a gestire la tua vita interiore e i tuoi stati d’animo con intuito e spirito di adattamento, permettendoti di realizzarti in una dimensione di vita particolarmente creativa ma, talvolta, priva di sicurezze. Quel che non manca è la capacità di sedurre con la tua dolcezza, vero emblema del segno. Per questo motivo l'albero dei Pesci è il Cacao, dal quale viene estratta la dolce polvere con cui si produce il cioccolato.","Piantiamo il cacao in Guatemala, nella regione del Petén. Le comunità contadine locali coltivano l’albero di cacao in terreni a rischio desertificazione. Dando vita a impianti agroforestali, e non monoculture, si assicura la rigenerazione graduale del suolo e della biodiversità animale e vegetale.
Un ecosistema stabile dove la pianta del cacao potrà crescere protetta dall’ombra di alberi ad alto fusto.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato)  
	VALUES ("Cedrela", "Cedrela odorosa L.","La Cedrela Odorata, albero sempreverde dalle dimensioni maestose, è una conifera appartenente alla famiglia delle Pinaceae. È una pianta tipica dell’America Centrale.
Ottimo alleato nel rigenerare terreni degradati, ha una crescita molto rapida.", "330 kg di CO2 assorbiti", 15.00, 16.00, "Guatemala", 10, 2, 2,"I maya e i primi coloni usavano la Cedrela principalmente per la costruzione di canoe e case, in quanto non viene attaccato dai tarli. Da allora non ha cessato di essere appprezzato per il suo legno pregiato.","Nei nostri impianti forestali in Guatemala utilizziamo specie native a rapido accrescimento adattate all’ambiente e resistenti ai parassiti. Le comunità alle quali doniamo le nostre piante sono costantemente formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi forestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto . Un sistema forestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e allo stesso tempo assicura alti tassi di assorbimento di CO2.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Chicozapote", "Manilkara zapota (L.)", "I suo frutti, dolci e prelibati, hanno un gusto che ricorda un mix di mandorla e pera. Largamente apprezzati e consumati dai popoli centroamericani e dai mammiferi della foresta pluviale. Le nostre piante di Chicozapote in Guatemala, offrono supporto economico e sostegno alimentare alle famiglie contadine, inoltre aiutano a ricostruire habitat utili per altre specie di piante e molti animali.", "40 kg/anno di frutta prodotti", 12.00, 20.00, "Guatemala", 10, 2, 3,"Gli antichi popoli mesoamericani facevano bollire la sua linfa, il 'chicle': la modellavano e la taliavano in pezzi per poterla masticare La prima gomma da masticare conosciuta. I maya usavano il legame pregiato e durevole per costruire i loro templi.","Nei nostri impianti agroforestali in Guatemala utilizziamo specie native di Chicozapote molto adattate all’ambiente, resistenti ai parassiti e super produttive. Le piante vengono allevate alternate con altre specie erbacee e piante arboree contribuendo alla rigenerazione della biodiversità. Le comunità alle quali doniamo il chicozapote sono formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi agroforestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto. Un sistema agroforestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e produce costantemente produzioni variegate.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Lime", "Citrus aurantiifolia (Christm.)", "Secondo alcuni studi genetici, probabilmente il Limone è un antico ibrido tra pompelmo e cedro. Questo agrume produce bellissimi fiori dai petali bianchi e violetti, e profumatissimi frutti. Il commercio di limoni aiuta le popolazioni migliorandone la qualità di vita.", "60 Kg/anno di frutta prodotta", 5.50, 17.00, "Guatemala", 10, 3, 4,"Sebbene in Guatemala si chiami 'Limon', in Europa è consciuto come Lime, Più piccolo e più aspro di un limone, questo frutto è molto usato nele bevande rifrenscanti.","Piantiamo il lime in Guatemala, nella regione del Petén. Le comunità contadine locali coltivano l’albero di lime in terreni a rischio desertificazione. Dando vita a impianti agroforestali, e non monoculture, si assicura la rigenerazione graduale del suolo e della biodiversità animale e vegetale.
Un sistema agroforestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e produce costantemente produzioni variegate.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Mango", "Mangifera indica (L.)", "Conosciuto soprattutto per il suo frutto è dolcissimo e ricco di Vitamina A e C,l’albero del mango è un albero “tuttofare”. Alle comunità contadine del Guatemala offre frutta, legname, materia organica per nutrire il suolo e i frutti che cadono a terra vengono utilizzati come mangime per il bestiame.", "100 kg/anno di frutta prodotta", 8.50, 18.00, "Guatemala", 10, 5, 5,"In India, secondo un'antica tradizione, se due contadini vogliono suggellare la loro amicizia, si organizzano cerimonie in cui due alberi di mango vengono 'uniti in matrimonio'. Albero dal legno solido, dai frutti dolci e dai fiori eleganti.","Piantiamo il mango in Guatemala, nella regione del Petén. Diamo vita a impianti agroforestali, e non monoculture, assicurando la rigenerazione graduale del suolo e della biodiversità animale e vegetale.
Nei sistemi agroforestali guatemaltechi le piante di mango offrono ombra e supporto ad altre piante in consociazione. I frutti e le foglie che cadano, nutrono il terreno, lo rigenerano e allo stesso tempo lo preservano dall’erosione.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Mogano", "Swietenia macrophylla", "Può raggiungere anche i 50 metri d’altezza ed è caratterizzato per un tronco molto resistente al passare degli anni anche se esposto ad agenti atmosferici, ai parassiti e ai funghi. La sua longevità lo rende il vegliardo della foresta.", "60 Kg/anno di frutta prodotta", 5.50, 17.00, "Guatemala", 10, 4, 3,"Una pianta particolarmente apprezzata nella creazione di strumenti, ad esempio le chitarre 'Gibson Les Paul'usano questo legno  dalle origini. Il legname del mogano conferisce al suono un timbro particolarmente caldo, corposo, bilancaito e ricco di sostegno.","Nei nostri impianti forestali in Guatemala utilizziamo specie native a rapido accrescimento  adattate all’ambiente e resistenti ai parassiti. Le comunità alle quali doniamo le nostre piante sono costantemente formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi forestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto . Un sistema forestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e allo stesso tempo assicura alti tassi di assorbimento di CO2.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Pesco", "Prunus persica (L.) Batsch", "Piantiamo peschi in Piemonte, nei terreni della fattoria didattica La Piemontesina, che si trova a pochi chilometri (meno di 10) dal parco fluviale del fiume Po. Piantare alberi qui ha degli effetti diretti nel contrastare siccità e desertificazione. 
L’intero progetto della fattoria nasce appunto per ridurre il dissesto idrogeologico della zona.", "60 Kg/anno di frutta prodotta", 5.00, 35.00, "Italia", 6, 5, 5, "Il Pesco è uno degli alberi che simboleggia la primavera, mentre il suo frutto rappresenta l'immortalità, soprattutto per la cultura cinese. Nell'Antico Egitto, invece, il pesco era sacro alla dea Hator e ad Arpocrate, corrispondente al dio Horus da piccolo, protettore dell'infanzia.","Un progetto di agroforestazione a Milano. Nel Parco della Vettabbia, a un passo dai quartieri di Corvetto e Porto di Mare, stiamo lavorando con l’impresa agricola e sociale Soulfood Forestfarms a un grande progetto agroforestale volto alla rigenerazione ambientale e sociale di alcuni ettari di parco abbandonati con l’obiettivo di attivare nuovi sistemi di produzione e consumo biologici e a KM0. Secondo questa tecnica di gestione agroforestale, si crea un ecosistema composto da alberi, arbusti e colture annuali capace di rigenerare il suolo e contribuire al mitigamento degli effetti del cambiamento climatico.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Pioppo", "Populus L.", "Piantiamo pioppi in Piemonte, nei terreni della fattoria didattica La Piemontesina: che si trova a pochi chilometri (meno di 10) dal parco fluviale del fiume Po. Piantare alberi qui, ha degli effetti diretti nel contrastare siccità e desertificazione. 
L’intero progetto della fattoria nasce appunto per ridurre il dissesto idrogeologico della zona.", "Salvaguardia Ambientale", 30.00, 35.00, "Italia", 5, 4, 3, "BOH BOH BHO perchè copio le cose da un sito fatto male ....","Nel vivaio della fattoria La Piemontesina, in cui crescono alberi forestali e da frutto. Gli alberi costituiscono le fondamenta delle attività educative sviluppate dalla fattoria, nata tra il 1982 e il 1984 accanto all’ex tenuta sabauda “La Mandria” di Chivasso, in provincia di Torino.
In questo Agriasilo, i piccoli imparano a prendersi cura di piante ed animali nel loro campo, orto e pollaio didattico, oltre che abituarsi a uno stile alimentare basato su prodotti di stagione coltivati in azienda.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Amazzonia da frutto", "Huicungo", "Alberi il cui solo nome è impronunciabile che producono frutti nativi della foresta più grande del mondo. Dobbiamo ancora scoprirne tutti i sapori. Aiutaci a piantarli!", "50 Kg/anno di frutta prodott", 20.00, 35.00, "Perù", 10, 4, 3,"Alberi il cui solo nome è impronunciabile che producono frutti nativi della foresta più grande del mondo.Dobbiamo ancora scoprirne tutti i sapoti. Auitaci a piantarli!","In Perù, all’interno dell’Amazzonia peruviana. Piantiamo diverse specie di alberi da frutto autoctoni con lo scopo di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES("Banano", "Musa paradisiaca", "Come quelle vene d’acqua che scorrono sotterranee per poi sgorgare improvvisamente in sorgente, lo Scorpione è il più misterioso dei segni d’Acqua. Arriva sul finire dell’autunno, quando i boschi si accendono degli ultimi gialli e rossi delle foglie. Il suo è il fascino magnetico di chi non mostra tutto e subito, ma cela in profondità la propria sensibilità, i propri desideri e le proprie fantasie. E c’è un albero che delle fantasie è inevitabilmente il principe. Chi altri, se non il Banano?","Albero dello Scorpione",
    7.0,24.90,"Perù",10,4,5,"Il Banano è una pianta erbacea gigante della famiglia delle Musaceae, che può crescere fino a 6-7 m di altezza. Originario dell'Asia, viene coltivato principalmente nel Centro America, Africa Tropicale e Filippine. Fruttifica solo in climi tropicali e necessita di protezione dai venti. Viene piantato per l'uso alimentare e per la commercializzazione dei suoi frutti.","Piantiamo l'albero nella regione del Petén. Le comunità contadine locali coltivano l’albero in terreni a rischio desertificazione. Dando vita a impianti agroforestali, e non monoculture, si assicura la rigenerazione graduale del suolo e della biodiversità animale e vegetale. Un ecosistema stabile dove la pianta del cacao potrà crescere protetta dall’ombra di alberi ad alto fusto.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Caffe","Coffea arabica","Segno di fuoco, l’Ariete rappresenta la fiamma gialla della vitalità e non è un caso che abbia inizio esattamente il 21 di marzo, primo giorno di primavera. Le giornate si allungano e le ore di luce vanno superando quelle di buio (almeno nel nostro emisfero!) e gli alberi che hanno perso le proprie foglie durante l'autunno mettono nuovi germogli. È la rinascita, il risveglio dopo il sonno invernale e cosa c'è di meglio di un bel caffè per rimettersi in moto? Per questo è proprio il Caffè l’albero che meglio rappresenta l’Ariete e la sua energia.","Albero dell'Ariete", 4.6,24.90,"Guatemala",10,3,5,"Il Caffè, dai cui semi si ricava l’omonima bevanda, appartenente alla famiglia delle Rubiaceae. Sebbene ne esistano oltre 100 specie, come ci confermano gli scaffali dei supermercati, le più diffuse sono l'arabica e la robusta. Il caffé rappresenta un'importante fonte di reddito per le comunità locali.","Nei nostri impianti forestali in Guatemala utilizziamo specie native a rapido accrescimento  adattate all’ambiente e resistenti ai parassiti. Le comunità alle quali doniamo le nostre piante sono costantemente formate sulla manutenzione sostenibile degli impianti e sulla progettazione di sistemi forestali misti in cui la varietà di specie assicurano la stabilità e la resilienza dell’impianto . Un sistema forestale stabile infatti, richiede meno input, rigenera il suolo e la biodiversità e allo stesso tempo assicura alti tassi di assorbimento di CO2.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Baobab","Adansonia digitata", "Il Baobab è una specie originaria del Madagascar e diffusa in tutta l'Africa. Celebre per la sua imponenza, pensate che il diametro del tronco può arrivare a 10 metri. È considerato il centro gravitazionale della vita sociale dei villaggi, sotto la sua ombra si tengono mercati, riunioni, danze e giochi. Viene piantato per contribuire al recupero delle foreste naturali.","-3.000Kg assorbita in un anno", 9, 75.0, "Perù",10,5,5,"I baobab si originarono milioni di anni fa in Africa orientale e successivamente i suoi semi si dispersero in altre parti del mondo generando nuove specie. In Madagascar esistono sei specie esclusive che non si trovano al di fuori di questo territorio. In Australia si trova la A. gregorii. Il baobab è presente naturalmente nella maggior parte dei paesi del Sahara. Solitamente crescono come individui solitari, ma talvolta anche in piccoli gruppi nell’ecosistema della savana dalla provincia di Limpopo nel Sud Africa fino all’Africa occidentale e nel deserto dell’Eritrea nell’Africa settentrionale.","In Perù, all’interno dell’Amazzonia peruviana. Piantiamo diverse specie di alberi da frutto autoctoni con lo scopo di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Trefosia","Tephrosia purpurea","La Tefrosia è una pianta floreale di piccole dimensioni, originaria dell'Africa tropicale, ma comunemente diffusa anche in America tropicale e nel Sud e Sud-Est asiatico. La sua altezza varia tra 0,5 e i 4 metri. La Tefrosia è un insetticida naturale e, grazie alle sue proprietà azoto fissatrici, migliora la qualità del suolo.","Albero del Capricorno",4,34.0,"Perù",10,4,4,"Il Capricorno nasce nel solstizio d’inverno, quando la natura sembra rinchiudersi in se stessa, i semi sono protetti sotto la neve e il rigore invernale tiene gli animali ben nascosti nelle loro tane. Queste caratteristiche naturali sono espresse anche nel tuo temperamento che è introverso, determinato e stoico. L’esaltazione di Marte e il domicilio di Saturno ti conferiscono la capacità di resistere alle difficoltà con dignità e forza interiore, proprio come la Tefrosia, una piccola pianta tropicale che riesce a crescere in ambienti molto ostili e secchi, migliorandone addirittura la qualità del suolo.
","In Perù, all’interno dell’Amazzonia peruviana. Piantiamo diverse specie di alberi da frutto autoctoni con lo scopo di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Moringa","Moringa oleifera","Ha un tronco eretto ma molle e dalla consistenza spugnosa. Il legno della Moringa è debole a tal punto che i rami, sottili ed intrecciati, sono penduli. I fiori, color bianco crema, sono ottimi produttori di nettare per le api. Viene piantata per facilitare la coltivazione agricola. Grazie alle sue proprietà fertilizzanti, arricchisce naturalmente i terreni impoveriti.","Albero del Toro",5,50.50,"Italia",10,4,4,"Forte, saldo e concreto, il Toro è un segno di terra che arriva nel momento in cui questa è più rigogliosa. Siamo nel pieno della primavera e Venere, il pianeta che lo governa, dona al Toro un'inarrestabile brama di bellezza. La Moringa è l'albero che meglio rappresenta questa unione di vigore e desiderio. I suoi fiori, i suoi semi e anche le sue radici sono commestibili ed altamente energetici ed anche i suoi frutti si mangiano e pare che abbiano effetti afrodisiaci. E in più hanno pure poteri curativi. Se non è fortuna questa.","Un progetto di agroforestazione a Milano. Nel Parco della Vettabbia, a un passo dai quartieri di Corvetto e Porto di Mare, stiamo lavorando con l’impresa agricola e sociale Soulfood Forestfarms a un grande progetto agroforestale volto alla rigenerazione ambientale e sociale di alcuni ettari di parco abbandonati con l’obiettivo di attivare nuovi sistemi di produzione e consumo biologici e a KM0. Secondo questa tecnica di gestione agroforestale, si crea un ecosistema composto da alberi, arbusti e colture annuali capace di rigenerare il suolo e contribuire al mitigamento degli effetti del cambiamento climatico.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Croton"," Croton macrostachyus","Il Croton è un albero che ha una chioma rotonda e aperta con un'ampia ramificazione. I frutti, verdi quando ancora non maturi, assumono poi un colore grigio. Le grandi foglie e la folta chioma rendono il Croton perfetto per fornire ombra a tutte quelle piante che necessitano di un’esposizione solare meno diretta.","Albero dell'Acquario", 3,34.90,"Perù",10,4,3,"Arriva nel cuore dell’inverno, quando fa più freddo, ma impercettibilmente le giornate tornano ad allungarsi (almeno nell’emisfero nord!) e la luce intraprende nuovamente il proprio cammino per tornare a prevalere sul buio. L’era dall’Acquario è raccontata come l’età mitica di pace, amore e fratellanza ed è per questo che l’Acquario è il segno di chi muove i propri pensieri e le proprie forze guardando al futuro, per farne dono agli altri. È rappresentato da una donna che trasporta l’acqua e la versa come dono divino. A rappresentarlo abbiamo scelto un albero come il Croton, capace di crescere alto e donare ombra e riparo agli altri alberi. Proprio per questo è uno degli alberi che, quando le foreste crescono, si trova spesso a fare da apripista per gli altri. Un avanguardista, come un vero Acquario.","In Perù, all’interno dell’Amazzonia peruviana. Piantiamo diverse specie di alberi da frutto autoctoni con lo scopo di proteggere e rigenerare la biodiversità, salvaguardare la cultura e le usanze indigene e assicurare uno sviluppo sostenibile tra società e foreste.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Mangrovia Bianca","Avicennia marina","La Mangrovia Bianca è un arbusto sempreverde di piccole e medie dimensioni con una corona arrotondata di rami sparsi; di solito cresce da 3 a 10 metri di altezza, ma occasionalmente raggiunge i 15 metri. Cresce lungo le linee costiere, resistendo a condizioni di salinità molto elevate, proteggendo il terreno dall'erosione e costituendo veri e propri habitat per molte specie di animali.","Albero dei Gemelli ",6,24.90,"Italia",10,4,4,"Il sole di Maggio accoglie l’ingresso nel segno dei Gemelli, governato dall’esuberante vitalità di Mercurio. Siamo nella piena maturità di una primavera che scalda i cuori, invita a vivere all’aperto e spogliarsi un po’, abbassando le difese in nome dell’incontro con gli altri. È su queste note che i nati dei Gemelli compongono la sinfonia del loro carattere votato alla socialità sopra ogni cosa. Il loro albero è la Mangrovia Bianca, che cresce dove l’acqua di mare s’incontra con quella dolce dei fiumi, a rammentare anche la natura doppia del segno, e le cui radici, come braccia affettuose, offrono riparo a molte specie animali. Ed abbraccio è proprio il significato di quest’albero.","Un progetto di agroforestazione a Milano. Nel Parco della Vettabbia, a un passo dai quartieri di Corvetto e Porto di Mare, stiamo lavorando con l’impresa agricola e sociale Soulfood Forestfarms a un grande progetto agroforestale volto alla rigenerazione ambientale e sociale di alcuni ettari di parco abbandonati con l’obiettivo di attivare nuovi sistemi di produzione e consumo biologici e a KM0.
Secondo questa tecnica di gestione agroforestale, si crea un ecosistema composto da alberi, arbusti e colture annuali capace di rigenerare il suolo e contribuire al mitigamento degli effetti del cambiamento climatico.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Tree Tomato","Solanum betaceum","È un albero sempreverde che può crescere fino a superare i 5 metri. Produce dei frutti che ricordano per forma i pomodori, ma a differenza del pomodoro classico questa pianta è un arbusto perenne (da qui il nome comune di questa specie che significa “Albero di Pomodoro”). Il sapore dei frutti consumati freschi, solo quando sono completamente maturi, ha una componente acida molto spiccata seguita da note dolci che creano un contrasto molto interessante.","Albero del Cancro",8.5,45.90,"Perù",10,2,3,"L’arrivo dell’estate segna l’ingresso nel segno del Cancro ed i suoi nati sanno esprimere tanto il calore quanto l’imprevedibilità del cielo di stagione. Sanno essere affettuosi e sensibili come nessun altro ed amano proteggere i loro affetti, ma così come l’arrivo di un temporale estivo, sanno mutare improvvisamente il proprio umore e fare fulmini e saette. Agli occhi di chi non è abituato ad avere a che fare con loro possono sembrare lunatici. Ma in realtà il modo più corretto per definirli è stravaganti. Per la loro sensibilità unica e il loro dargli forma in modo sorprendente. L’albero che abbiamo dedicato a questo segno è il Tree Tomato, che fa frutti che sembrano pomodori! Stravagante come i nati del Cancro.
","Nel vivaio della fattoria La Piemontesina, in cui crescono alberi forestali e da frutto. Gli alberi costituiscono le fondamenta delle attività educative sviluppate dalla fattoria, nata tra il 1982 e il 1984 accanto all’ex tenuta sabauda “La Mandria” di Chivasso, in provincia di Torino.
In questo Agriasilo, i piccoli imparano a prendersi cura di piante ed animali nel loro campo, orto e pollaio didattico, oltre che abituarsi a uno stile alimentare basato su prodotti di stagione coltivati in azienda.");
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES ("Calliandra","Calliandra calothyrsus","La Calliandra appartiene al genere di piante floreali all'interno della famiglia delle Fabaceae. In condizioni ottimali può raggiungere un'altezza di 12 metri con un tronco di 30 cm di diametro. I suoi fiori e sepali sono verdi, con degli stami a filamenti di un viola o rosso di grande bellezza per il loro colore acceso.","Albero della Vergine",7.5,23.90,"Italia",10,4,4,"È l’estate che volge al termine ad accogliere l’arrivo della Vergine, donando una sfumature d’eleganza malinconica ai nati di questo segno. Un segno che coniuga la concretezza dell’elemento Terra, a cui appartiene, con l’esuberanza di Mercurio, da cui è governato. Ecco quindi che i nati della Vergine, nelle loro migliori espressioni, sanno essere tanto ingegnosi, quanto curiosi, tanto efficienti, quanto sperimentatori. Amano organizzarsi, ma non si spaventano se devono improvvisare. Esprimono quindi la propria proverbiale intelligenza nel modo più spontaneo che ci sia: attraverso la versatilità. E versatilità è proprio il significato del loro albero, la Calliandra, capace di adattarsi e crescere in terreni di vario tipo, anche in quelli meno fertili.","Nel vivaio della fattoria La Piemontesina, in cui crescono alberi forestali e da frutto. Gli alberi costituiscono le fondamenta delle attività educative sviluppate dalla fattoria, nata tra il 1982 e il 1984 accanto all’ex tenuta sabauda “La Mandria” di Chivasso, in provincia di Torino.
In questo Agriasilo, i piccoli imparano a prendersi cura di piante ed animali nel loro campo, orto e pollaio didattico, oltre che abituarsi a uno stile alimentare basato su prodotti di stagione coltivati in azienda.");
 INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, quantità, co2, salvaguardia,descrizioneBreve, doveVienePiantato) 
	VALUES("Guava","Psidium guajava","È un alberetto caducifoglio che raggiunge un'altezza tra i 2 e i 7 metri; ha tronco diritto e ramificato. La corteccia è grigia e presenta macchie marroni.Le foglie sono semplici, di colore verde chiaro in quanto ricoperte di una fine peluria, possono raggiungere i 15 cm di lunghezza.I fiori sono bianchi, grandi, profumati, di solitari o raggruppati in piccoli grappoli.Hanno 4 o 5 sepali verdi verso l'esterno e bianchi all'interno e 4-5 petali bianchi. Gli stami sono numerosi. L'impollinazione è entomogama.Il frutto è una bacca di forma variabile (sferica, ellittica, piriforme), di colore giallo o verde-giallo, liscio o rugoso, con polpa bianca o bianco-gialla o rosa o rossa, dolce, agrodolce o acido, con numerosi semi, piccoli e bianchi. Il peso varia tra 130 e 800 g circa, con un peso medio di 390 g/frutto.","40kg di frutta/anno", 5,22.90,"Guatemala",10,4,4,"Originario dell'America Centrale, la Guava è un albero molto coltivato nei paesi tropicali. Produce bellissimi fiori bianchi, grandi e profumati e succosissimi frutti che vengono consumati sia freschi che sotto forma di succhi, nettari e confetture. È quindi un ottimo sostegno per l'economia rurale e per la sicurezza alimentare della popolazione locale.","Piantiamo l'albero in Guatemala, nella regione del Petén. Diamo vita a impianti agroforestali, e non monoculture, assicurando la rigenerazione graduale del suolo e della biodiversità animale e vegetale.Nei sistemi agroforestali guatemaltechi le piante di mango offrono ombra e supporto ad altre piante in consociazione. I frutti e le foglie che cadano, nutrono il terreno, lo rigenerano e allo stesso tempo lo preservano dall’erosione.");
 
 INSERT INTO benefici (nome,descrizione)
	VALUES ("Sicurezza alimentare", "Gli alberi daranno frutti immediatamente commestibili o che possono essere lavorati per diventarlo, assicurando risorse alimentari in modo costante nel tempo.");
 INSERT INTO benefici (nome,descrizione)
	VALUES ("Sviluppo sostenibile", "Gli alberi sono piantati in sistemi agroforestali che favoriscono l’interazione virtuosa tra le diverse specie e il loro impatto positivo sull’ambiente e sui terreni.");
INSERT INTO benefici(nome,descrizione)
	VALUES ("Sviluppo economico", "I frutti degli alberi e i prodotti derivati dalla loro trasformazione, possono essere commerciati in circuiti locali, offrendo opportunità di reddito.");
INSERT INTO benefici (nome,descrizione)
	VALUES ("Assorbimento CO2", "Nel corso del proprio ciclo vitale, ogni albero catturerà CO2 dall’atmosfera, fissandola al proprio interno. Puoi usare gli alberi che pianti per compensare le tue emissioni");
    
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (1,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (1,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (1,3,1);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (1,4,5);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (2,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (2,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (2,3,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (2,4,4);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (3,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (3,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (3,3,1);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (3,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (4,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (4,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (4,3,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (4,4,2);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (5,1,1);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (5,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (5,3,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (5,4,5);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (6,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (6,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (6,3,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (6,4,5);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (7,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (7,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (7,3,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (7,4,4);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (8,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (8,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (8,3,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (8,4,2);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (9,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (9,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (9,3,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale)  
	VALUES (9,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (10,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (10,2,1);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (10,3,1);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (10,4,4);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (11,1,1);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (11,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (11,3,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (11,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (12,1,2);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (12,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (12,3,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (12,4,5);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (13,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (13,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (13,3,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (13,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (14,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (14,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (14,3,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (14,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (15,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (15,2,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (15,3,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (15,4,2);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (16,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (16,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (16,3,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (16,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (17,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (17,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (17,3,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (17,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (18,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (18,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (18,3,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (18,4,4);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (19,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (19,2,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (19,3,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (19,4,2);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (20,1,1);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (20,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (20,3,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (20,4,4);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (21,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (21,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (21,3,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (21,4,5);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (22,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (22,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (22,3,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (22,4,5);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (23,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (23,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (23,3,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (23,4,3);   
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (24,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (24,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (24,3,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (24,4,3);   
 INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (25,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (25,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (25,3,1);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (25,4,2);   
    
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
INSERT INTO fotoProdotto (pid)
	VALUES (16);
INSERT INTO fotoProdotto (pid)
	VALUES (16);
INSERT INTO fotoProdotto (pid)
	VALUES (16);
INSERT INTO fotoProdotto (pid)
	VALUES (17);
INSERT INTO fotoProdotto (pid)
	VALUES (17);
INSERT INTO fotoProdotto (pid)
	VALUES (17);
INSERT INTO fotoProdotto (pid)
	VALUES (18);
INSERT INTO fotoProdotto (pid)
	VALUES (18);
INSERT INTO fotoProdotto (pid)
	VALUES (18);
INSERT INTO fotoProdotto (pid)
	VALUES (19);
INSERT INTO fotoProdotto (pid)
	VALUES (19);
INSERT INTO fotoProdotto (pid)
	VALUES (19);
INSERT INTO fotoProdotto (pid)
	VALUES (20);
INSERT INTO fotoProdotto (pid)
	VALUES (20);
INSERT INTO fotoProdotto (pid)
	VALUES (20);
INSERT INTO fotoProdotto (pid)
	VALUES (21);
INSERT INTO fotoProdotto (pid)
	VALUES (21);
INSERT INTO fotoProdotto (pid)
	VALUES (21);
INSERT INTO fotoProdotto (pid)
	VALUES (22);
INSERT INTO fotoProdotto (pid)
	VALUES (22);
INSERT INTO fotoProdotto (pid)
	VALUES (22);
INSERT INTO fotoProdotto (pid)
	VALUES (23);
INSERT INTO fotoProdotto (pid)
	VALUES (23);
INSERT INTO fotoProdotto (pid)
	VALUES (23);
INSERT INTO fotoProdotto (pid)
	VALUES (24);
INSERT INTO fotoProdotto (pid)
	VALUES (24);
INSERT INTO fotoProdotto (pid)
	VALUES (24);
INSERT INTO fotoProdotto (pid)
	VALUES (25);
INSERT INTO fotoProdotto (pid)
	VALUES (25);
INSERT INTO fotoProdotto (pid)
	VALUES (25);
     
INSERT INTO kit (nome, saldo, descrizione)
	VALUES ("Pianto tutto", 30, "6 alberi da piantare per te o per regalarli a chi vuoi, per rendere il mondo più verde con un click.");
INSERT INTO kit (nome, saldo, descrizione)
	VALUES ("Alberi Senza Confini", 35, "3 alberi da piantare in 3 diversi paesi, per mettere radici in tutto il mondo! ");
INSERT INTO kit (nome, saldo, descrizione)
	VALUES ("Love is in the air",30, "Due alberi per custodire un amore. Piantali insieme, lasciando che mettano solide radici e crescano facendo del bene al pianeta e a chi se ne prenderà cura. Conservando per sempre il vostro sentimento.");
INSERT INTO kit (nome, saldo, descrizione)
	VALUES ("Tutti Frutti", 40, "4 alberi da frutto da piantare per te o per regalarli a chi vuoi. Sarà un regalo anche per i contadini che raccoglieranno i frutti dei tuoi alberi.");
INSERT INTO kit (nome, saldo, descrizione)
	VALUES ("Family Trees", 20, "In molte culture gli alberi sono simbolo di legami e affetti familiari e del loro durare nel tempo. Adesso puoi piantare due alberi e regalarne uno ad un tuo familiare per custodire e tramandare il vostro legame.");
INSERT INTO kit (nome, saldo, descrizione)
	VALUES("Shade Trees",25,"Tutti noi cerchiamo riparo dal sole in questi roventi mesi estivi, e lo stesso vale per gli alberi! Alcune specie sono particolarmente generose con la propria ombra: la loro fitta chioma offre riparo a persone e animali, e permette ad altri alberi più giovani di crescere sani e forti. Scopri questi “Planet Heroes”, e piantali subito! A farli crescere ci penseremo noi.");
INSERT INTO kit (nome, saldo, descrizione)
	VALUES("Absorb CO2",50,"In questa estate di temperature da record, vorresti fare qualcosa di buono per il pianeta? Silenziose e determinate, queste tre specie forestali ti sorprenderanno con le loro incredibili proprietà. Massimizzano la loro capacità di assorbire CO₂ dall’atmosfera, trattengono l’umidità nel terreno e ne migliorano la qualità. Scopri questi “Planet Heroes”, e piantali subito! A farli crescere ci penseremo noi.");
INSERT INTO kit (nome, saldo, descrizione)
	VALUES ("Best Friends",30,"L’amicizia è fatta di tante cose e nessuna. A volte attraversa una vita, a volte può stare solo in uno sguardo. Piantando questi due alberi e regalandone uno all’amica o all’amico che vuoi, legherai il vostro sentimento a qualcosa che crescerà nel tempo e ne sarà custode.");
INSERT INTO kit (nome,saldo, descrizione)
	VALUES ("All Stars",30,"Il modo migliore per non perderti nemmeno uno dei nostri oroscopi è ... piantare tutti gli Alberi dell’Oroscopo!Questo speciale kit ti permette di farlo in un solo click.Così facendo, per un intero anno, ogni mese avrai ben 12 contenuti che ti racconteranno ciò che le stelle hanno in serbo per te.");

INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Medicina","Le foglie, le radici, la corteccia e/o i frutti vengono usati nella medicina tradizionale");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Consumo e vendita","I frutti, i semi e/o le foglie vengono mangiati dalle famiglie dei contadini o venduti nei mercati locali.");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Suolo","Migliora la qualità del suolo fissando l’azoto o riduce l'erosione grazie all'esteso apparato radicale.");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Recinzione","Permette di proteggere un’area coltivata o di dare ristoro agli animali al pascolo.");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Antivento","Protegge dal vento le giovani piante e riduce l'evaporazione dell'acqua dal suolo.");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Cosmesi","Dai suoi fiori, frutti e/o foglie si estraggono materie prime utilizzate per produrre creme o polveri.");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Allevamento","Le foglie, fresche o essiccate, vengono utilizzate come mangime per il bestiame.");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Biodiversità","Facilita il ripopolamento di varie specie animali, favorendo così in generale la varietà nella fauna e nella flora.");
INSERT INTO usiLocali (nome,descrizione)
	VALUES ("Insetticida naturale","Le foglie e/o i frutti contengono sostanze utili contro le fitopatologie e utilizzabili come insetticidi naturali.");

INSERT INTO albero_usiLocali(pid,uid)
	VALUES(1,6);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(2,8);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(2,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(3,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(4,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(4,4);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(4,5);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(5,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(5,6);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(5,7);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(6,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(6,4);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(6,5);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(7,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(8,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(8,5);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(8,4);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(9,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(9,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(10,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(10,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(11,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(11,6);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(12,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(12,4);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(12,5);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(13,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(13,6);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(13,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(14,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(14,4);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(15,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(15,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(15,8);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(16,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(17,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(17,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(18,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(18,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(18,8);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(19,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(19,9);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(20,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(20,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(20,7);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(21,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(21,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(21,8);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(22,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(22,8);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(23,1);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(23,8);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(24,3);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(24,7);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(25,2);
INSERT INTO albero_usiLocali(pid,uid)
	VALUES(25,6);

INSERT INTO kit_alberi (pid,kid)
	VALUES  (7,1);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (17,1);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (16,1);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (6,1);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (9,1);
 INSERT INTO kit_alberi (pid,kid)
	VALUES  (12,1);   
INSERT INTO kit_alberi (pid,kid)
	VALUES  (24,2);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (1,2);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (2,2);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (11,3);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (7,3);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (10,4);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (17,4);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (12,4);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (16,4);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (17,5);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (13,5);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (16,6);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (2,6);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (1,6);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (18,7);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (8,7);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (6,7);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (15,8);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (6,8);
    INSERT INTO kit_alberi (pid,kid)
	VALUES  (22,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (7,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (23,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (19,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (20,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (21,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (17,9);
    INSERT INTO kit_alberi (pid,kid)
	VALUES  (5,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (24,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (16,9);
INSERT INTO kit_alberi (pid,kid)
	VALUES  (14,9);


INSERT INTO categoria (nome,descrizione)
	VALUES ("Rischio estinzione", "L'albero è classificato come “in pericolo” nella Lista rossa delle specie minacciate dell’IUCN (Unione internazionale per la conservazione della natura) dal 2011.");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Crescita rapida", "L’albero assicura una crescita molto rapida");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Sostegno economico", "I frutti degli alberi e i prodotti derivati dalla loro trasformazione, possono essere commerciati in circuiti locali, offrendo opportunità di reddito. I contadini trattengono una parte della frutta prodotta per il consumo personale e vendono la restate al mercato più vicino, ad un prezzo di circa 0,25$ al chilo.");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Assorbimento CO2", "Nel corso del proprio ciclo vitale, ogni albero catturerà CO2 dall’atmosfera, fissandola al proprio interno. Puoi usare gli alberi che pianti per compensare le tue emissioni");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Sviluppo Sostenibile", "L’educazione è il motore dello sviluppo sostenibile. In questo Agriasilo, i valori fondamentali insegnati ai bambini sono il rispetto dell’ambiente, l’uso di materiali riciclati e l’interiorizzazione di uno stile di vita sostenibile a 360°!");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Oroscopo", "");

/* li ho messi a caso per il momento*/
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (1,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (2,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (3,3);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (4,4);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (5,5);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (6,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (7,3);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (8,2);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (9,4);
    INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (10,5);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (11,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (12,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (13,3);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (14,4);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (15,5);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (16,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (17,3);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (18,2);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (19,4);
    INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (20,5);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (21,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (22,1);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (23,3);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (24,4);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (25,5);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (22,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (7,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (19,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (20,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (21,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (17,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (5,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (24,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (16,6);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (14,6);