# ProgettoTSW
Repository per documentare il progetto di Tecnologie e Software per il Web.

Requisiti del progetto
- Il progetto deve essere realizzato in gruppo (max 4 componenti)
  - E' possibile suddividersi i compiti durante lo sviluppo, ma al momento della discussione tutti devono essere a conoscenze dei compiti e delle funzionalità dell'intero progetto
- Il progetto deve riguardare lo sviluppo di un sito di commercio elettronico:
  - Il cliente deve poter inserire prodotti nel carrello, variarne la quantità, rimuoverli dal carrello, svuotare il carrello
  - Una volta confermato l'ordine va svuotato il carrello e deve essere possibile visualizzare l'ordine nell'elenco degli ordini effettuati
  - ...
- Va prevista la figura dell'amministratore e delle pagine a lui dedicate, accessibili solo dopo autenticazione
  - L'amministratore deve poter inserire, modificare, visualizzare e cancellare elementi del catalogo
  - Visualizzare gli ordini complessivi, dalla data x alla data y, e per cliente
  - ...
- Il sito deve essere dinamico, responsive, con persistenza dei dati
- Il sito deve girare direttamente su Tomcat (ambiente di produzione, non di sviluppo)
- Usare il modello MVC
  - Creare almeno due package: uno per le servlet, chiamato "control", ed uno per il Model, chiamato "model"
  - Il codice HTML viene creato esclusivamente dalle JSP (non dalle Servlet)
- Usare il DataSource o DriveManager per connettersi al DB. Se si usa Drive Manager utilizzare anche ConnectionPool
- Usare la sicurezza programmatica, ovvere il "token nella sessione" (ovvero il bean rappresentante l'utente)
- Le form sono controllati con javascript
  - I dati delle form vengono inviati al server solo se corretti
  - Usare le espressioni regolati per validare i campi delle form
  - Mettere il "focus" sul campo in cui l'utente sta scrivendo
  - Visualizzare le istruzioni di compilazione di ongi campo di input nel placeholder
  - Fornire i messaggi di errore quando l'utente preme il submit
- Usare JQuery per modificare il DOM in qualche pagina
- Usare JQuery + AJAX per scambiare piccole informazioni con il server (in formato JSON)
- Usare JQuewy per animare le immagini al passaggio del mouse
- Gestire le sessioni per memorizzare lo stato del carrello
  - Si salva l'ordine nel DB dopo l'acquisto
- Usare i fragment (comn include) nelle pagine JSP per creare header, footer
- Il database deve essere strutturato in modo tale che
  - Se vengono modificati il prezzo o l'iva di un prodotto acquistato successivamente all'acquisto l'ordine del cliente mantiene i dati corretti
  - Se l'amministratore cancella un prodotto non deve scomparire dagli ordini effettuati    

