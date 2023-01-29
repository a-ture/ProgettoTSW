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
    descrizione TEXT,
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
    altezza DOUBLE NOT NULL DEFAULT 0,
    prezzo DOUBLE NOT NULL DEFAULT 0,
    pid VARCHAR(45) NOT NULL,
    co2 INT NOT NULL DEFAULT 0,
    salvaguardia INT NOT NULL DEFAULT 0,
    tasse DOUBLE NOT NULL DEFAULT 22.00,
    PRIMARY KEY (id),
    CONSTRAINT FKpaeseDiOrigine FOREIGN KEY (pid)
        REFERENCES woodlot.paeseDiOrigine (nome)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE fotoProdotto (
    nomeFoto INT AUTO_INCREMENT PRIMARY KEY,
    foto MEDIUMBLOB DEFAULT NULL,
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

CREATE TABLE benefici (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione VARCHAR(400) NOT NULL,
    foto MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (id)
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
    PRIMARY KEY (id)
);

CREATE TABLE ordine (
    id BIGINT AUTO_INCREMENT,
    uid BIGINT NOT NULL,
    totaleProdotti INT NOT NULL,
    totalePagato DOUBLE NOT NULL,
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
    quantità INT NOT NULL DEFAULT 0,
    tasse DOUBLE NOT NULL DEFAULT 0,
    stato VARCHAR(128) NOT NULL,
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

INSERT INTO paeseDiOrigine (nome,descrizione)
	VALUES ("Guatemala","Il nostro lavoro in Guatemala intende realizzare molteplici benefici, tarando i progetti sulle differenti realtà territoriali e sociali con le quali lavoriamo. Come accennato, una delle zone in cui operiamo si trova nell'area rurale del Petén, nel nord del paese, qui abbiamo individuato nelle specie da frutto, il perno del nostro progetto per garantire i migliori benefici ambientali e sociali. Tra le specie di alberi che contribuiscono a creare sistemi agroforestali vi sono: Lime, Mandarino, Mango, Cacao, Graviola (conosciuta anche come Corossole o Guanàbana), Sapote (tradizionale albero da frutto assai diffuso presso le civiltà precolombiane dell'America Centrale), Guava e Arancio. Gli alberi saranno piantati in sistemi agroforestali su piccola scala, secondo i principi della permacultura, un approccio che imita i processi naturali, creando consociazioni di specie diverse.");
INSERT INTO paeseDiOrigine (nome,descrizione)
	VALUES ("Perù", "Nel tempo le attività si sono allargate, grazie all'ottima collaborazione con i nostri partners in loco e alle possibilità offerte da un paese tanto vario di ambienti. Oggi i nostri progetti si sviluppano su vari fronti e in aree diverse, da quelle montane, su terreni con forti pendenze, dove gli alberi hanno anche la funzione di trattenere il terreno ed evitare il dilavamento eccessivo, a zone più pianeggianti.
 Piantiamo numerose specie tipiche come il Cedro rosato, la Guayaba, la Guanàbana, il Cacao criollo e mix di specie forestali e da frutto, compresi Cacao e Caffè, per offrire il più ampio spettro possibile di benefici ambientali e sociali. In questo senso, inoltre, nei nostri progetti in Colombia sono coinvolte anche comunità indigene appartenenti a gruppi etnici con un legame profondo e antico con la propria terra.");
INSERT INTO paeseDiOrigine (nome,descrizione)
	VALUES ("Italia","L'Italia non è solo il paese in cui WoodLot è stata fondata nel 2010, ma è anche uno dei paesi in cui piantiamo alberi. Si tratta di progetti dai numeri piuttosto contenuti, ma non per questo meno importanti.
I progetti a cui diamo vita in Italia rispettano la nostra filosofia, che è quella di produrre benefici sociali e ambientali, ma la applicano ad un contesto diverso rispetto a quelli degli altri paesi in cui lavoriamo. Se i benefici ambientali si realizzano anche in Italia grazie alla piantumazione di nuovi alberi, per i benefici sociali è decisiva la scelta dei nostri partner di progetto. Questi sono associazioni, onlus, cooperative sociali (non lavoriamo con soggetti privati) che, ad esempio, includono categorie in difficoltà nelle proprie attività oppure recuperano aree confiscate alla criminalità organizzata. L'intento è quello di sostenere progetti di grande valenza sociale.");
INSERT INTO paeseDiOrigine (nome,descrizione)
	VALUES ("Argentina","Il territorio dell'Argentina corre per 3.700 Km da nord a sud e per 1.400 da est a ovest. Al centro del paese sta la grande distesa pianeggiante della Pampa, intorno alla quale si trovano: la regione subtropicale del Gran Chaco a nord, il plateau della Patagonia a sud, mentre a ovest s'innalzano le maestose vette delle Ande. A tanta varietà d'ambienti corrisponde altrettanta varietà di fauna, che va dal caimano (o yacaré) al celebre condor delle Ande. L'avventura di WoodLot in Argentina si è svolta nelle foreste del Gran Chaco. Le risorse naturali di questa regione sono state seriamente danneggiate dalla deforestazione e Treedom ha contribuito al loro ripristino, piantando alberi utili per la popolazione locale, come ad esempio l'Algarrobo.");
    
INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("alessiature","alessiature@gmail.com","Alessia","Ture","cliente");
INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("frida","raffaella@gmail.com","Raffaella","Spagnuolo","cliente");
INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("cliente","cliente@gmail.com","cliente","cliente","cliente");
INSERT INTO utente (password,email,nome,cognome,role) 
	VALUES ("admin","admin@gmail.com","admin","admin","admin");
    
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia, descrizioneBreve)    
VALUES("Albero Dinamite", "Hura crepitans", "Il nome scientifico di questa specie è Hura Crepitans. Crepitans è un termine latino che si riferisce tanto a qualcosa che si rompe, che al rumore che questa rottura genera. Il motivo per cui questa parola è riferita al nostro albero è per via dei suoi frutti, che quando sono maturi esplodono, letteralmente, facendo schizzare i semi a gran velocità fino a 15-20 metri di distanza (alcuni dicono fino a 50 metri, ma a noi pare troppo). Ecco perché questo albero è detto anche Albero Dinamite.","A giusta distanza!",32, 67.90, "Argentina",345, 4,"Ad un albero che spara i propri semi come proiettili, è opportuno stare a distanza. Ma conviene ancora di più perché l'Albero Dinamite ha il tronco coperto di spine e tutte le sue parti contengono una sostanza altamente tossica, capace di causare la cecità se viene a contatto con gli occhi. Ecco che stare a giusta distanza diventa un consiglio da seguire con attenzione!");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia, descrizioneBreve)   
VALUES ("Anacardo", "Anacardium occidentale", "Specie originaria del Brasile, è un albero sempreverde molto ramificato. Il frutto si compone di una parte una carnosa simile ad una mela - in realtà un falso frutto - e di una parte secca: l'anacardo che tutti noi conosciamo. L'anacardo viene piantato per aiutare l'economia delle piccole comunità rurali del Senegal e per proteggere gli appezzamenti dal fuoco.", "Amore", 3, 34,"Guatemala", 7, 4,"La parola anacardo deriva dal greco 'kardia', cuore, e per questo è uno dei frutti dell'amore.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid,co2, salvaguardia,descrizioneBreve) 
	VALUES ("Arancio", "Citrus × aurantium (L.)","Originario della Cina meridionale, l'Arancio è un sempreverde che produce, oltre ai succosi frutti che tutti conosciamo, piccoli fiori bianchi e verdi molto profumati. Viene piantato per l'utilizzo alimentare e per aiutare l'economia locale attraverso il commercio di frutti.", "Ottimismo", 3.50, 16.00, "Italia", 45, 1,"Il colore arancione, tipico dei rotondi frutti di questo albero, simboleggia fiducia, ottimismo e buonumore");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid,co2, salvaguardia, descrizioneBreve) 
	VALUES ("Avocado", "Persea americana Mill.","Un frutto che piace a tutti, ricco di vitamine e nutrienti, per questo particolarmente apprezzato dalle mamme. In Guatemala viene utilizzato per la preparazione di molti piatti tipici, tra cui il guacamole. Le nostre piante di Avocado in Guatemala sono sostenibili a 360°: offrono supporto economico e sostegno alimentare, senza venir meno alla sostenibilità ambientale.", "65 Kg/anno di frutta prodotta", 10.00, 19.00, "Guatemala",  4, 5,"Gli antichi popoli del Centro America consideravano l'Avocado un frutto dall'incredibile potere afrodisiaco, definito anche 'frutto dell'amore' il suo nome deriva dalla parola azteca ahuacalt che significa ... testicolo");
    
INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
	VALUES("Banano", "Musa x paradisiaca", "Il Banano è una pianta erbacea gigante della famiglia delle Musaceae, che può crescere fino a 6-7 m di altezza. Originario dell'Asia, viene coltivato principalmente nel Centro America, Africa Tropicale e Filippine. Fruttifica solo in climi tropicali e necessita di protezione dai venti. Viene piantato per l'uso alimentare e per la commercializzazione dei suoi frutti.","Fantasie",
    7.0,24.90,"Perù",4,5,"Chiamato dagli antichi Musa, il Banano è da sempre la più maliziosa tra le fonti d'ispirazione");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
	VALUES ("Baobab","Adansonia digitata", "Il Baobab è una specie originaria del Madagascar e diffusa in tutta l'Africa. Celebre per la sua imponenza, pensate che il diametro del tronco può arrivare a 10 metri. È considerato il centro gravitazionale della vita sociale dei villaggi, sotto la sua ombra si tengono mercati, riunioni, danze e giochi. Viene piantato per contribuire al recupero delle foreste naturali.","-3.000Kg assorbita in un anno", 9, 75.0, "Argentina",3000,5,"I baobab si originarono milioni di anni fa in Africa orientale e successivamente i suoi semi si dispersero in altre parti del mondo generando nuove specie. In Madagascar esistono sei specie esclusive che non si trovano al di fuori di questo territorio. In Australia si trova la A. gregorii. Il baobab è presente naturalmente nella maggior parte dei paesi del Sahara. Solitamente crescono come individui solitari, ma talvolta anche in piccoli gruppi nell’ecosistema della savana dalla provincia di Limpopo nel Sud Africa fino all’Africa occidentale e nel deserto dell’Eritrea nell’Africa settentrionale.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
	VALUES ("Cacao", "Theobroma cacao","Il Cacao è un sempreverde che produce piccoli fiori a cinque petali, bianchi, verdi o rosei, che spuntano direttamente sul tronco o sui rami principali; i fiori più fortunati si trasformano nei celebri frutti. Viene piantato per la produzione di cacao di ottima qualità e per offrire ai contadini locali una fonte di reddito aggiuntiva.", "Dolcezza", 6.00, 20.00, "Guatemala", 24, 5,"Anche le cose apparentemente amare nascondono un animo dolce.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
	VALUES ("Caffe","Coffea arabica","Il Caffè, dai cui semi si ricava l’omonima bevanda, appartenente alla famiglia delle Rubiaceae. Sebbene ne esistano oltre 100 specie, come ci confermano gli scaffali dei supermercati, le più diffuse sono l'arabica e la robusta. Il caffé rappresenta un'importante fonte di reddito per le comunità locali.","Energia", 4.6,24.90,"Guatemala",13,5,"Il Caffè, dai cui semi si ricava l’omonima bevanda, appartenente alla famiglia delle Rubiaceae. Sebbene ne esistano oltre 100 specie, come ci confermano gli scaffali dei supermercati, le più diffuse sono l'arabica e la robusta. Il caffé rappresenta un'importante fonte di reddito per le comunità locali.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Carbonero","Calliandra carbonaria","Originaria delle montagne del Sud America, questa specie molto speciale di calliandra è diffusa dal Venezuela al Perù. Il 'carbonero', come viene chiamato localmente, cattura immediatamente l'attenzione: grazie alla sua infiorescenza a forma di testa coperta da molti stami rossi, è impossibile non notarlo. Le calliandre sono arbusti decidui o piccoli alberi che producono baccelli a forma di mezzaluna. Nonostante questa 'produttività', vengono anche piantate come alberi di sostegno per fornire ombra o migliorare il suolo.","Notturno",34, 34.50, "Argentina", 45, 5, "Come molte altre specie di calliandra, le foglie del carbonero si muovono autonomamente. Questa condizione prende il nome di 'movimenti del sonno'. Di notte le foglie si chiudono, mentre durante il giorno si aprono.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Castagno","Castanea sativa","Il Castagno è uno degli alberi che ha intrecciato profondamente la propria storia con quella degli esseri umani. Si ritiene che sia originario del Caucaso e che da lì sia stato propagato in Europa dai Greci prima e dai Romani poi. Diffuso e curato per i suoi frutti, le castagne, ed il suo legname, a partire dal XV secolo è iniziato il suo declino. Ma se la sua coltivazione è oggi ridotta, la sua importanza nella cultura di molti popoli europei rimane assolutamente centrale. Questo castagno verrà piantato nel progetto che abbiamo avviato nel cuore dei uno dei castagneti più antichi d'Europa, che si trova nel sud della Toscana e che vogliamo far crescere rigoglioso come un tempo.","Amicizia", 45, 5,"Italia",45, 5,"La storia del Castagno è la storia di una lunga amicizia fra alberi ed esseri umani. Un'amicizia da riscoprire e ... coltivare.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Grevilea","Grevillea robusta", "La Grevillea robusta raggiunge altezze di 12- 25 metri; i fiori sono di un giallo vistoso e ricchi di un nettare che attrae le api stimolandone l’integrazione con l’ecosistema e favorendo l’impollinazione delle piante. Viene utilizzata anche come pianta frangivento e consente la formazione naturale di humus mantenendo l’umidità e migliorando la qualità del suolo.","Pazienza", 25, 34.90,"Perù",56,2, "Piantato spesso a bordo strada, questo albero sopporta anche il traffico dell'ora di punta.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
	VALUES ("Limone", "Citrus aurantiifolia (Christm.)", "Secondo alcuni studi genetici, probabilmente il Limone è un antico ibrido tra pompelmo e cedro. Questo agrume produce bellissimi fiori dai petali bianchi e violetti, e profumatissimi frutti. Il commercio di limoni aiuta le popolazioni migliorandone la qualità di vita.", "Brividi", 5.50, 17.00, "Guatemala", 3, 4,"Non sempre è buono ciò che è dolce: il limone ad esempio è amato proprio per i brividi suscitati dalla sua acidità..");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Longan", "Dimocarpus longan", "Il Longan è un albero tropicale dalla chioma folta voluminosa, che può crescere fino a 12 metri d’altezza. Teme il gelo e cresce bene su terreni sabbiosi. Produce frutti commestibili simili a quelli del Litchi (albero della stessa famiglia del Longan, quella delle Sapindaceae). È originario della Cina e oggi lo si trova anche in buona parte del sudest asiatico ed anche in Australia. In tutti questi paesi i suoi frutti trovano impiego in vari usi alimentari: possono essere consumati freschi, cucinati in vari modi (dalle zuppe ai dessert) ed anche essiccati. Sono inoltre utilizzati nella medicina tradizionale cinese.", "Fantasy", 4, 45.70, "Perù", 34,3,"Il suo nome, in cinese, significa esattamente “occhio di drago”. Questo è dovuto al fatto che i suoi frutti, liberati dalla leggera scorza che li protegge, hanno una polpa quasi trasparente, attraverso cui è facile intravedere il grosso seme scuro all’interno. Una forma che può essere immaginata come il bulbo oculare … di un drago!");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Mandarino", "Citrus reticulata", "Originario della Cina, dalle foglie piccole e profumate, il Mandarino produce frutti dolci e aromatici. Un albero adulto può dare dai 400 ai 600 frutti all’anno e viene ovviamente piantato per uso alimentare e per incrementare il reddito agricolo locale grazie alla vendita dei frutti.", "Profumo",5, 24.90,"Italia",65,5,"I frutti di Mandarino, ed in particolare la loro buccia, emanano un profumo agrodolce e inebriante.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
	VALUES ("Mango", "Mangifera indica (L.)", "Conosciuto soprattutto per il suo frutto è dolcissimo e ricco di Vitamina A e C,l’albero del mango è un albero “tuttofare”. Alle comunità contadine del Guatemala offre frutta, legname, materia organica per nutrire il suolo e i frutti che cadono a terra vengono utilizzati come mangime per il bestiame.", "Felicità", 8.50, 18.00, "Guatemala", 5, 5,"Per colore, profumo e gusto, il mango è il frutto del sole e della gioia.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Mangrovia Nera", "Avicennia germinans", "La Mangrovia Nera può presentarsi come un arbusto sempreverde o un albero di piccole e medie dimensioni, con una corona arrotondata di rami sparsi. Di solito cresce dai 3 ai 12 metri di altezza, ma occasionalmente raggiunge i 25 metri. Crescendo nelle distese fangose ​​mareali, la pianta ha sviluppato un apparato radicale con molte radici respiratorie verticali, sopra il livello del suolo.","Abbraccio", 12, 65.90, "Guatemala", 65,4, "Le sue radici, che sembrano tante braccia che formano un reticolo, offrono riparo a tante specie di pesci e frenano l'erosione dei terreni a causa delle maree. L'abbraccio della Mangrovia è davvero prezioso." );

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid,  co2, salvaguardia,descrizioneBreve) 
VALUES("Melograno","Punica granatum","Si ritiene che il Melograno sia originario dell'Asia sud-occidentale. La sua coltivazione è conosciuta sin da tempi lontanissimi ed i suoi frutti così particolari hanno affascinato le popolazioni più diverse, dai Fenici agli Armeni, che hanno immaginato storie e leggende per raccontarne la nascita. Anche i suoi fiori, dal calice carnoso e dal colore rosso intenso, sono di rara bellezza. Coltivato ad albero, il Melograno può raggiungere i 7 metri d’altezza. Ha radici molto forti che affondano in profondità, rendendolo assai resistente alla siccità.
Questo melograno sarà piantato da una cooperativa agricola sociale e biologica che lavora su terreni confiscati alla criminalità organizzata.","Prosperità", 7, 56.90, "Italia", 46, 4, "I suoi fiori carnosi, i suoi frutti rigogliosi, il colore rosso dei loro chicchi, la loro parte polposa e succosa; non è un caso che per tante culture il Melograno sia stato associato alla prosperità.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid,  co2, salvaguardia,descrizioneBreve) 
VALUES("Neem", "Azadirachta indica","Nativo dell'India e della Birmania, il Neem è un albero sempreverde che può arrivare fino a 30 m di altezza. Viene usato come ombreggiante, grazie alla sua folta chioma, e come barriera anti-desertificazione, soprattutto nelle regioni sahariane. Ma la sua peculiarità è soprattutto quella che raccontata dal suo nome in Sanscrito: Sarva roda nidarini, il guaritore di tutti i malanni. Gli usi che si possono fare di ogni parte di questo albero, dalla corteccia alle foglie, sono pressoché infiniti.", "Futuro", 3, 45.90,"Perù",43,4,"L'Onu ha definito il Neem l'albero del XXI secolo.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid,  co2, salvaguardia,descrizioneBreve) 
VALUES("Nespolo Del Giappone", "Eriobotrya japonica", "l nespolo del Giappone è una pianta appartenente alla famiglia delle Rosaceae. Viene coltivata a scopo commerciale per il suo frutto, e anche come ornamentale. Non va confuso con la nespola comune o germanica, di più antica coltivazione in Europa, che è invece il frutto di un'altra rosacea, il nespolo europeo (Crataegus germanica), oggi raramente coltivata e commercializzata.", "Gioa",5,45.90,"Italia",67,3,"Quando il Nespolo del Giappone fiorisce la sua ampia chioma si punteggia di splendidi fiori bianchi dal profumo dolce e intenso. Dolcezza e intensità che è la stessa dei frutti quando sono maturi. Una vera gioia per i sensi.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid,  co2, salvaguardia,descrizioneBreve) 
VALUES("Papaya","Carica papaya","La Papaya è un piccolo sempreverde che può raggiungere i 10 metri di altezza. Il tronco contiene un succo lattiginoso, composto da papaina, usato soprattutto per scopi medicinali. Questo albero deve essere coltivato in zone calde al riparo dal vento e quindi spesso viene coltivato in coltura consociata con altri arbusti di dimensioni maggiori, con lo scopo di venderne i frutti e farne ottimi succhi di frutta.","Ammaliante", 10, 24.90, "Guatemala",56,2,"I semi della Papaya hanno un sapore che, specie all’inizio, potrebbe non piacere a tutti. Ricordano la senape e sono leggermente piccanti, ma usati in piccole dosi per arricchire di sapori i piatti giusti, sanno essere ammalianti come poche altre spezie.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve)  
	VALUES ("Pino di Aleppo", "Pinus halepensis","Il pino di Aleppo è tipico della regione mediterranea, tipicamente lo si trova in prossimità della costa, anche se nel tempo il suo areale è andato crescendo ed oggi si possono trovare pini di Aleppo anche oltre i 600 metri di altitudine. Questo albero, che cresce fino a 15 metri di altezza, si riconosce dai suoi aghi grigio-verdi, sottili, che possono essere lunghi fino a 10 cm e sono raggruppati in due sui germogli. Le piccole pigne bruno-rossastre sono simili a quelle di altri pini silvestri. La sua resina ha sentori molto caratteristici ed è utilizzata ampiamente sin dall'antichità.", "Inconfondibile", 69, 69.00, "Italia", 90, 4,"Avete mai provato il vino Retsina? Un vino greco a cui si aggiunge la resina... è la resina del pino di Aleppo. Gli dà l'inconfondibile sapore amaro.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Pomelo","Citrus maxima", "Albero che cresce dai 5 ai 10 metri, anche se in alcuni casi può raggiungere i 15, il Pomelo è famoso per i suoi frutti, capaci di misurare fino a 30 cm di diametro e pesare fino a 2 Kg. Hanno una forma che ricorda più quella di una pera che di un agrume ed in media una pianta che vive in condizioni ideali, può produrne anche 100 all’anno.", "Originalità",21, 30.00, "Guatemala", 78, 3,"Il Pomelo, insieme al Mandarino e al Cedro, è conosciuto come una delle 3 specie da cui derivano tutti gli agrumi conosciuti.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Quercia", "Quercus coccifera", "La Quercia Spinosa è un arbusto sempreverde e di solito raggiunge un'altezza di circa 3 metri. Con la sua corteccia grigia chiara e liscia, è facile da distinguere dalle altre querce. Le sue foglie di fogliame verde scuro sono lunghe fino a 5 cm. Con il tempo, alcuni dei fiori formano i frutti caratteristici della Quercia Spinosa. La sua gamma si estende su quasi tutta la regione mediterranea. Viene coltivato principalmente per i suoi frutti, che possono essere mangiati arrostiti, per esempio. Questa Quercia spinosa verrà piantata in provincia di Lecce grazie alla collaborazione con una Fondazione locale impegnata ad espandere la superficie boschiva e avviare alla rinaturalizzazione terreni abbandonati.","Protezione", 7, 69.90,"Italia", 67, 4, "Un albero che sa come proteggere se stesso e i suoi frutti: i suoi frutti sono coperti da spine corte e sporgenti. Le sue foglie sono anche spinose-dentate.");

INSERT INTO prodotto (nome, nomeScientifico, descrizione, sottotitolo, altezza, prezzo, pid, co2, salvaguardia,descrizioneBreve) 
VALUES("Vite","Vitis vinifera","La vite è un arbusto rampicante e la sua forma viene determinata dal tipo di allevamento con cui viene gestita da chi la coltiva. Esistono numerosissime varietà di vite e ciascuna ha specifiche caratteristiche rispetto alle foglie, ai fiori e soprattutto ai frutti; quell’uva che può avere forme, colori e sapori assai diversi fra loro. La storia della vite si è da millenni intrecciata a quella dell’uomo, che oggi la coltiva in tutti i continenti (con l’eccezione dell’Antartide per ovvi motivi climatici) e ne consuma i frutti sia freschi che lavorati, soprattutto nella forma di quella bevanda nota a chiunque come: vino. Questa vite sarà piantata in Campania in un progetto di recupero di aree confiscate alla criminalità organizzata.", "Euforia", 4, 70.90, "Italia",10, 2, "Il vino è una bevanda alcolica ottenuta dalla fermentazione dell’uva, frutto della vite. Nella sua lunga storia il vino si è caricato di numerosi significati simbolici e di profondi portati culturali, tuttavia è innegabile che tra i motivi del suo successo via sia anche quella sensazione magica di euforia che sa donare a chi ne fa un giusto (e moderato) consumo.");

 INSERT INTO benefici (nome,descrizione)
	VALUES ("Sicurezza alimentare", "Gli alberi daranno frutti immediatamente commestibili o che possono essere lavorati per diventarlo, assicurando risorse alimentari in modo costante nel tempo.");
 INSERT INTO benefici (nome,descrizione)
	VALUES ("Sviluppo sostenibile", "Gli alberi sono piantati in sistemi agroforestali che favoriscono l’interazione virtuosa tra le diverse specie e il loro impatto positivo sull’ambiente e sui terreni.");
INSERT INTO benefici(nome,descrizione)
	VALUES ("Sviluppo economico", "I frutti degli alberi e i prodotti derivati dalla loro trasformazione, possono essere commerciati in circuiti locali, offrendo opportunità di reddito.");

    
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (1,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (1,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (1,3,1);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (2,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (2,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (2,3,3);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (3,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (3,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (3,3,1);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (4,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (4,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (4,3,2);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (5,1,1);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (5,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (5,3,4);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (6,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (6,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (6,3,2);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (7,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (7,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (7,3,3);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (8,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (8,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (8,3,5);      
  
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (9,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (9,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (9,3,5);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (10,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (10,2,1);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (10,3,1);      
  
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (11,1,1);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (11,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (11,3,5);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (12,1,2);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (12,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (12,3,4);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (13,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (13,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (13,3,4);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (14,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (14,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (14,3,2);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (15,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (15,2,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (15,3,5);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (16,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (16,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (16,3,3);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (17,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (17,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (17,3,4);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (18,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (18,2,2);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (18,3,2);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (19,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (19,2,4);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (19,3,5);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (20,1,1);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (20,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (20,3,3);      
 
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (21,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (21,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (21,3,3);      
  
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (22,1,4);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (22,2,5);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (22,3,5);      
  
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (23,1,5);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (23,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (23,3,3);      

INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (24,1,3);
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (24,2,3);      
INSERT INTO benefici_prodotti(pid,cid,percentuale) 
	VALUES (24,3,5);      

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




INSERT INTO categoria (nome,descrizione)
	VALUES ("Rischio estinzione", "L'albero è classificato come “in pericolo” nella Lista rossa delle specie minacciate dell’IUCN (Unione internazionale per la conservazione della natura) dal 2011.");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Crescita rapida", "L’albero assicura una crescita molto rapida");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Sostegno economico", "I frutti degli alberi e i prodotti derivati dalla loro trasformazione, possono essere commerciati in circuiti locali, offrendo opportunità di reddito. I contadini trattengono una parte della frutta prodotta per il consumo personale e vendono la restate al mercato più vicino, ad un prezzo di circa 0,25$ al chilo.");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Assorbimento Anidride Carbonica", "Nel corso del proprio ciclo vitale, ogni albero catturerà CO2 dall’atmosfera, fissandola al proprio interno. Puoi usare gli alberi che pianti per compensare le tue emissioni");
INSERT INTO categoria (nome,descrizione)
	VALUES ("Sviluppo Sostenibile", "L’educazione è il motore dello sviluppo sostenibile. In questo Agriasilo, i valori fondamentali insegnati ai bambini sono il rispetto dell’ambiente, l’uso di materiali riciclati e l’interiorizzazione di uno stile di vita sostenibile a 360°!");


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
	VALUES (7,2);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (8,3);
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
	VALUES (17,2);
INSERT INTO categorie_prodotti(pid,cid) 
	VALUES (18,3);
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

