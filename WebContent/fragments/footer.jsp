<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="resources/css/_bootswatch.scss">

<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<!-- FontAwesome -->
<script src="https://kit.fontawesome.com/6bd8866cc2.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<footer class="bg-dark text-center text-black sticky-bottom">
		<!-- Section: Social media -->
		<section class="mb-4">
			<!-- Facebook -->
			<a class="btn btn-outline-light btn-floating m-1"
				href="https://www.facebook.com" role="button"><i
				class="fab fa-facebook-f"></i></a>

			<!-- Twitter -->
			<a class="btn btn-outline-light btn-floating m-1"
				href="https://twitter.com" role="button"><i
				class="fab fa-twitter"></i></a>

			<!-- Snapchat -->
			<a class="btn btn-outline-light btn-floating m-1"
				href="https://snapchat.com" role="button"><i
				class="fa-brands fa-snapchat"></i></a>

			<!-- Instagram -->
			<a class="btn btn-outline-light btn-floating m-1"
				href="https://www.instagram.com" role="button"><i
				class="fab fa-instagram"></i></a>

			<!-- TikTok -->
			<a class="btn btn-outline-light btn-floating m-1"
				href="https://www.tiktok.com" role="button"><i
				class="fa-brands fa-tiktok"></i></a>

			<!-- Pinterest -->
			<a class="btn btn-outline-light btn-floating m-1"
				href="https://www.pinterest.com" role="button"><i
				class="fa-brands fa-pinterest"></i></a>
		</section>
		<!-- Section: Social media -->
		<ul class="list-inline">
			<li class="list-inline-item"><a href="Catalogo">Alberi</a></li>
			<li class="list-inline-item"><a href="ChiSiamoServlet">Chi
					Siamo</a></li>
			<li class="list-inline-item">
				<!-- Button trigger modal cookie --> <a href="#"
				data-bs-toggle="modal" data-bs-target="#exampleModal">Preferenze
					Cookie</a>
			</li>
			<li class="list-inline-item"><a href="condizioni.jsp">Condizioni
					d'utilizzo</a></li>
			<li class="list-inline-item"><a href="privacy.jsp">Privacy</a></li>
		</ul>
		<p class="copyright">WoodLot © 2022</p>
	</footer>


	<!-- Modal Cookei -->
	<div class="modal fade " id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<i class="fa-solid fa-cookie-bite"></i> &nbsp Cookie Policy
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>Questo documento contiene informazioni in merito alle
						tecnologie che consentono a questa Applicazione di raggiungere gli
						scopi descritti di seguito. Tali tecnologie permettono al Titolare
						di raccogliere e salvare informazioni (per esempio tramite
						l’utilizzo di Cookie) o di utilizzare risorse (per esempio
						eseguendo uno script) sul dispositivo dell’Utente quando
						quest’ultimo interagisce con questa Applicazione.</p>
					<p>Per semplicità, in questo documento tali tecnologie sono
						sinteticamente definite “Strumenti di Tracciamento”, salvo vi sia
						ragione di differenziare. Per esempio, sebbene i Cookie possano
						essere usati in browser sia web sia mobili, sarebbe fuori luogo
						parlare di Cookie nel contesto di applicazioni per dispositivi
						mobili, dal momento che si tratta di Strumenti di Tracciamento che
						richiedono la presenza di un browser. Per questo motivo,
						all’interno di questo documento il termine Cookie è utilizzato
						solo per indicare in modo specifico quel particolare tipo di
						Strumento di Tracciamento.</p>
					<p>Alcune delle finalità per le quali vengono impiegati
						Strumenti di Tracciamento potrebbero, inoltre richiedere il
						consenso dell’Utente. Se viene prestato il consenso, esso può
						essere revocato liberamente in qualsiasi momento seguendo le
						istruzioni contenute in questo documento.</p>
					<p>Questa Applicazione utilizza Strumenti di Tracciamento
						gestiti direttamente dal Titolare (comunemente detti Strumenti di
						Tracciamento “di prima parte”) e Strumenti di Tracciamento che
						abilitano servizi forniti da terzi (comunemente detti Strumenti di
						Tracciamento “di terza parte”). Se non diversamente specificato
						all’interno di questo documento, tali terzi hanno accesso ai
						rispettivi Strumenti di Tracciamento. Durata e scadenza dei Cookie
						e degli altri Strumenti di Tracciamento simili possono variare a
						seconda di quanto impostato dal Titolare o da ciascun fornitore
						terzo. Alcuni di essi scadono al termine della sessione di
						navigazione dell’Utente.</p>
					<p>In aggiunta a quanto specificato nella descrizione di
						ciascuna delle categorie di seguito riportate, gli Utenti possono
						ottenere informazioni più dettagliate ed aggiornate sulla durata,
						così come qualsiasi altra informazione rilevante - quale la
						presenza di altri Strumenti di Tracciamento - nelle privacy policy
						dei rispettivi fornitori terzi (tramite i link messi a
						disposizione) o contattando il Titolare.</p>
					<p>
						Per avere ulteriori informazioni riguardo ai consumatori
						californiani e ai loro diritti sulla privacy, gli Utenti possono
						consultare la <a href="privacy.jsp">privacy policy.</a>
					</p>
					<p>
						<b>Attività strettamente necessarie a garantire il
							funzionamento di questa Applicazione e la fornitura del Servizio

						</b>
					</p>
					<p>Questa Applicazione utilizza Cookie comunemente detti
						“tecnici” o altri Strumenti di Tracciamento analoghi per svolgere
						attività strettamente necessarie a garantire il funzionamento o la
						fornitura del Servizio.</p>

					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<h2 class="accordion-header" id="headingOne">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapseOne"
									aria-expanded="false" aria-controls="collapseOne">
									Registrazione ed autenticazione fornite direttamente da questa
									Applicazione</button>
							</h2>
							<div id="collapseOne" class="accordion-collapse collapse"
								aria-labelledby="headingOne" data-bs-parent="#accordionExample"
								style="">
								<div class="accordion-body">
									<p>Con la registrazione o l’autenticazione l’Utente
										consente a questa Applicazione di identificarlo e di dargli
										accesso a servizi dedicati. I Dati Personali sono raccolti e
										conservati esclusivamente a scopo di registrazione o di
										identificazione. I Dati raccolti sono solo quelli necessari a
										fornire il servizio richiesto dall’Utente. Registrazione
										diretta (questa Applicazione) L’Utente si registra compilando
										il modulo di registrazione e fornendo direttamente a questa
										Applicazione i propri Dati Personali. Dati Personali trattati:
										città, cognome, Cookie, data di nascita, Dati di utilizzo,
										email, immagine di profilo, lingua, nazione, nome, Partita
										IVA, password e ragione sociale.</p>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="headingTwo">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapseTwo"
									aria-expanded="false" aria-controls="collapseTwo">
									Gestione di landing page e pagine di invito</button>
							</h2>
							<div id="collapseTwo" class="accordion-collapse collapse"
								aria-labelledby="headingTwo" data-bs-parent="#accordionExample"
								style="">
								<div class="accordion-body">
									<p>Questo tipo di servizi permette di costruire e gestire
										landing page e pagine di invito, ossia pagine di presentazione
										di un prodotto o servizio, che possono consentire
										l'inserimento delle proprie informazioni di contatto, come
										l'indirizzo email. La gestione di queste pagine comporta il
										trattamento, da parte di questi servizi, dei Dati Personali
										raccolti tramite tali pagine, inclusi quelli di i Dati di
										Utilizzo. Unbounce (Unbounce Marketing Solutions Inc.)
										Unbounce è un servizio di gestione di landing page fornito da
										Unbounce Marketing Solutions Inc. che permette a questa
										Applicazione di raccogliere indirizzi email degli Utenti
										interessati al proprio servizio. Unbounce permette al Titolare
										del Trattamento di tener traccia ed analizzare la risposta da
										parte dell’Utente, in termini di traffico o di comportamento,
										in relazione a modifiche della struttura, del testo o di
										qualunque altro componente delle landing page create. Dati
										Personali trattati: Dati di utilizzo, email e Strumento di
										Tracciamento. Luogo del trattamento: Canada – Privacy Policy.
									</p>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="headingThree">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapseThree"
									aria-expanded="false" aria-controls="collapseThree">
									Ottimizzazione e distribuzione del traffico</button>
							</h2>
							<div id="collapseThree" class="accordion-collapse collapse"
								aria-labelledby="headingThree"
								data-bs-parent="#accordionExample" style="">
								<div class="accordion-body">
									<p>Questo tipo di servizi permette a questa Applicazione di
										distribuire i propri contenuti tramite dei server dislocati
										sul territorio e di ottimizzare le prestazioni della stessa. I
										Dati Personali trattati dipendono dalle caratteristiche e
										della modalità d’implementazione di questi servizi, che per
										loro natura filtrano le comunicazioni fra questa Applicazione
										ed il browser dell’Utente. Vista la natura distribuita di
										questo sistema, è difficile determinare i luoghi in cui
										vengono trasferiti i contenuti, che potrebbero contenere Dati
										Personali dell’Utente. Cloudflare (Cloudflare Inc.) Cloudflare
										è un servizio di ottimizzazione e distribuzione del traffico
										fornito da Cloudflare Inc. Le modalità di integrazione di
										Cloudflare prevedono che questo filtri tutto il traffico di
										questa Applicazione, ossia le comunicazioni fra questa
										Applicazione ed il browser dell’Utente, permettendo anche la
										raccolta di dati statistici su di esso. Dati Personali
										trattati: Strumenti di Tracciamento. Luogo del trattamento:
										Stati Uniti – Privacy Policy.</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>