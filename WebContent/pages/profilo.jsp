<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*, it.unisa.beans.*,java.text.*"%>
<%
Utente utente = (Utente) request.getSession().getAttribute("utente");
Collection<?> indirizzi = (Collection<?>) request.getSession().getAttribute("indirizzi");

Collection<?> ordini = (Collection<?>) request.getSession().getAttribute("ordiniUtente");
Collection<?> prodottiOrdini = (Collection<?>) request.getSession().getAttribute("prodottiOrdini");

int numeroAlberiAcquistati = (int) request.getSession().getAttribute("numeroDiAlberiAcquistati");
int numeroDiRegali = (int) request.getSession().getAttribute("numeroDiRegali");
double totaleSpeso = (double) request.getSession().getAttribute("totaleSpeso");
int numeroDiOrdini = (int) request.getSession().getAttribute("numeroDiOrdini");

if (utente == null) {
	response.sendRedirect("./Login");
	return;
}

DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profilo</title>
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
<!-- jQuey -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>

<style type="text/css">
.badgeImg {
	-webkit-filter: grayscale(100%); /* Safari 6.0 - 9.0 */
	filter: grayscale(100%);
}
</style>
</head>
<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<div class="container">
		<div class="row d-flex">
			<div class="col-2">
				<img src="GetFotoUtente?idUtente=<%=utente.getId()%>"
					onerror="this.src='./resources/img/placeholderProfile.png'"
					class="rounded-circle mb-3" style="width: 150px;" />
			</div>
			<div class="col">
				<div class="row">
					<p>
						<b>Nome: </b>
						<%=utente.getNome()%>
					</p>
					<p>
						<b> Cognome: </b>
						<%=utente.getCognome()%>
					</p>
					<p>
						<b>Email:</b>
						<%=utente.getEmail()%>
					</p>
					<p>
						<b>Username:</b>
						<%=utente.getUsername()%>
					</p>
				</div>
				<div class="row">
					<a href="#modificaInformazioni" class="btn btn-primary col-5"
						id="modificaInformazioniButton">Modifica Informazioni</a>
				</div>
			</div>
			<div class="col">
				<div class="row">
					<p>
						<b>Hai effettuato:</b>
						<%=numeroDiOrdini%>
						ordini
					</p>
					<p>
						<b>Hai acquistato: </b>
						<%=numeroAlberiAcquistati%>
						alberi
					</p>
					<p>
						<b> Hai fatto: </b>
						<%=numeroDiRegali%>
						regali
					</p>
					<p>
						<b>Hai speso in totale:</b>
						<%=dFormat.format(totaleSpeso)%>
						€
					</p>

				</div>
			</div>
		</div>

	</div>
	<hr>

	<div class="container">
		<div class="row g-4">
			<!-- Sidenav START -->
			<div class="col-lg-3">
				<div class="d-flex align-items-center d-lg-none">
					<button class="border-0 bg-transparent" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#offcanvasSideNavbar"
						aria-controls="offcanvasSideNavbar">
						<i class="btn btn-primary fw-bold fa-solid fa-sliders-h"></i> <span
							class="h6 mb-0 fw-bold d-lg-none ms-2">My profile</span>
					</button>
				</div>
				<!-- Navbar START-->
				<nav class="navbar navbar-expand-lg mx-0">
					<div class="offcanvas offcanvas-start" tabindex="-1"
						id="offcanvasSideNavbar">
						<!-- Offcanvas header -->
						<div class="offcanvas-header">
							<button type="button" class="btn-close text-reset ms-auto"
								data-bs-dismiss="offcanvas" aria-label="Close"></button>
						</div>
						<!-- Offcanvas body -->
						<div class="offcanvas-body d-block px-2 px-lg-0">
							<!-- Card START -->
							<div class="card overflow-hidden">
								<!-- Cover image -->
								<div class="h-50px"
									style="background-image: url(); background-position: center; background-size: cover; background-repeat: no-repeat;"></div>
								<!-- Card body START -->
								<div class="card-body pt-0">
									<!-- Side Nav START -->
									<ul class="nav nav-link-secondary flex-column fw-bold gap-2">
										<li class="nav-item"><a class="nav-link" href="#news"
											id="newsButton"> <i class="fa-solid fa-newspaper"></i> <span>News</span>
										</a></li>
										<li class="nav-item"><a class="nav-link" href="#ordini"
											id="ordiniButton"><i class="fa-solid fa-clipboard-list"></i><span>
													Ordini </span></a></li>
										<li class="nav-item"><a class="nav-link" href="#woodLot"
											id="woodLotButton"> <i class="fa-solid fa-tree"></i><span>
													Il tuo WoodLot </span></a></li>

										<li class="nav-item"><a class="nav-link" href="#badge"
											id="badgeButton"> <i class="fa-solid fa-award"></i><span>
													Badge </span>
										</a></li>
										<li class="nav-item"><a class="nav-link"
											href="#indirizzo" id="indirizzoButton"> <i
												class="fa-solid fa-map-location-dot"></i><span>
													Indirizzi </span></a></li>
										<li class="nav-item"><a class="nav-link" href="#logout"
											id="logoutButton"> <i
												class="fa-solid fa-right-from-bracket"></i><span>Logout
											</span>
										</a></li>
									</ul>
									<!-- Side Nav END -->
								</div>
								<!-- Card body END -->
							</div>
							<!-- Card END -->
						</div>
					</div>
				</nav>
				<!-- Navbar END-->
			</div>
			<!-- Sidenav END -->

			<!-- Main content START -->
			<div class="col-md-8 col-lg-6 vstack gap-4">
				<!-- News -->
				<div id="news" class="row d-none">
					<h1 class="text-center mb-5">Le ultime news</h1>
					<!-- Pianta un albero -->
					<%
					if (numeroAlberiAcquistati == 0) {
					%>
					<div class="card mb-5" style="width: 65rem;">
						<div class="card-body text-center">
							<h5 class="card-title">
								<b>Pianta il tuo primo albero</b>
							</h5>
							<p class="card-text">Benvenuto nel tuo profilo utente!
								Consideralo il tuo passaporto nel mondo WoodLot. Qui
								visualizzerai alcuni post scritti dal nostro Content team e
								Forestry team, per cominciare a conoscerci meglio. Se quello che
								leggi ti incuriosisce, pianta il tuo primo albero! Entrerai a
								far parte della nostra community e avrai accesso a contenuti
								esclusivi.</p>
							<a href="Catalogo" class="card-link">Pianta un albero</a>
						</div>
					</div>
					<%
					} else {
					%>
					<div class="mb-5" style="width: 65rem;">

						<h5 class="card-title text-center">
							<b>Benvenuto nel tuo profilo</b>
						</h5>
						<p class="card-text">Benvenuto nel tuo profilo utente!
							Consideralo il tuo passaporto nel mondo WoodLot. Qui
							visualizzerai alcuni post scritti dal nostro Content team e
							Forestry team, per cominciare a conoscerci meglio.</p>
					</div>
					<%
					}
					%>
					<!-- News 1 -->
					<div class="card mb-5" style="width: 65rem;">
						<img class="card-img-top" src="./resources/img/profilo/news1.jpg"
							alt="Card image cap">
						<div class="card-body">
							<p class="card-text">
							<p>
								<b>L’albero giusto, nel posto giusto e per il giusto scopo.</b>
							</p>
							<p>Conosci la storia dei sei uomini e l’elefante? Sei uomini
								che non avevano mai visto un elefante scommisero di riuscire a
								descrivere con precisione il suo aspetto, tenendo gli occhi
								bendati. Ognuno di loro si mise ad esplorare una parte diversa
								dell’animale.</p>
							<p>Chi ne studiava l’orecchio concluse “l’elefante ha
								l’aspetto di un ventaglio!”, mentre chi esplorava la coda disse
								“l'elefante è sicuramente simile ad una corda”. Tutti avevano in
								parte ragione, e tutti avevano torto, perché ognuno si era
								basato su informazioni parziali, senza prendere in
								considerazione le altre.</p>
							<p>Nessun problema può essere approcciato a compartimenti
								stagni. Soprattutto se si tratta di problemi complessi come la
								lotta al cambiamento climatico. Non esistono soluzioni semplici,
								veloci, magiche. Esistono però approcci che prendono in
								considerazione tutte le parti dell’elefante. Ed è quello che
								facciamo a WoodLot.</p>
							<p>Come? Piantando l’albero giusto, nel posto giusto e per il
								giusto scopo. In un modo che porta benefici all’ambiente, ma
								anche alle persone che lo abitano</p>
						</div>
					</div>

					<!-- News 2 -->
					<div class="card mb-5" style="width: 65rem;">
						<img class="card-img-top" src="./resources/img/profilo/news2.jpg"
							alt="Card image cap">
						<div class="card-body">
							<p class="card-text">
							<p>
								<b>Il Diario dell’Albero - gli alberi che raccontano il
									mondo in cui viviamo</b>
							</p>
							<p>Siate i benvenuti! Se siete arrivati fin qui,
								probabilmente sapete già che Treedom pianta alberi con un metodo
								che porta benefici sia all’ambiente, che alle persone che lo
								abitano. Ma forse non sapete che Treedom è anche una community
								virtuale di custodi di alberi, che vive in un luogo speciale: il
								Diario dell’Albero.</p>
							<p>Se deciderai di piantare un albero, su questo wall
								comincerai a ricevere aggiornamenti sul progetto di cui
								quell’albero fa parte. Entrerai in punta di piedi nella vita
								delle persone che se ne prendono cura. Scoprirai le
								caratteristiche botaniche della specie che hai deciso di
								piantare, e imparerai moltissimso sul Paese in cui il tuo albero
								cresce.</p>
							<p>I post del Diario dell’Albero sono scritti dal nostro
								Forestry e Content Team, per aprirvi una finestra su mondi che
								ancora non conoscete, esercitare la vostra curiosità, e farvi
								sentire il più vicino possibile alla bellezza di quello che
								state contribuendo a fare. .</p>
							<p>Speriamo di ritrovarvi fra queste pagine!</p>
						</div>
					</div>

					<!-- News 3 -->
					<div class="card mb-5" style="width: 65rem;">
						<img class="card-img-top" src="./resources/img/profilo/news3.jpg"
							alt="Card image cap">
						<div class="card-body">
							<p class="card-text">
							<p>
								<b>Regala un albero</b>
							</p>
							<p>Dicono che i regali più belli sono quelli che non si
								possono incartare.</p>
							<p>In qualsiasi momento, e per qualsiasi occasione, puoi
								regalare un albero Treedom a qualcuno che ami. Basta una mail o
								un messaggio per consegnarlo al suo destinatario, e renderlo
								parte di una community di custodi di alberi che cresce ogni
								giorno.</p>
							<p>Attraverso il tuo regalo, anche i tuoi cari parteciperanno
								a rendere il mondo non solo più verde, ma anche più giusto</p>

						</div>
					</div>
				</div>
				<!-- Ordini -->
				<div id="ordini" class="row d-none">
					<h1 class="text-center">I tuoi ordini</h1>
					<%
					if (numeroDiOrdini != 0 && ordini != null) {
					%>
					<p class="text-center">Qui puoi trovare il riepilogo degli
						ordini fatti nel nostro shop</p>
					<table class="table table-hover ">
						<thead>
							<tr>
								<th scope="col">Numero Ordine</th>
								<th scope="col">Totale</th>
								<th scope="col">Numero Prodotti</th>
								<th scope="col">Effettuato il</th>
							</tr>
						</thead>
						<tbody>
							<%
							Iterator<?> it = ordini.iterator();
							while (it.hasNext()) {
								Ordine ordine = (Ordine) it.next();
							%>
							<tr>
								<th scope="row"><%=ordine.getId()%></th>
								<td><%=dFormat.format(ordine.getTotalePagato())%> €</td>
								<td><%=ordine.getTotaleProdotti()%></td>
								<td><%=ordine.getCreatoIl()%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
					<%
					} else if (numeroDiOrdini == 0) {
					%>
					<p class="text-center">
						Non hai ancora effettuato alcun ordine. Rimedia subito! Vai al <a
							href="Catalogo">catalogo</a>
					</p>

					<%
					}
					%>
				</div>
				<!-- WoodLot -->
				<div id="woodLot" class="row d-none">
					<h1 class="text-center mb-5">Il tuo WoodLot</h1>
					<%
					if (numeroAlberiAcquistati == 0) {
					%>
					<p>
						Non hai ancora alberi ...torna al <a href="Catalogo">negozio</a>
					</p>
					<%
					} else if (numeroAlberiAcquistati >= 1) {

					Iterator<?> it1 = prodottiOrdini.iterator();
					while (it1.hasNext()) {
						ProdottoOrdine prodottoOrdine = (ProdottoOrdine) it1.next();
					%>
					<div class="card text-center mb-5">
						<div class="card-header">
							Hai acquistato
							<%=prodottoOrdine.getQuantità()%>
							esemplari di:
						</div>
						<div class="card-body">
							<h5 class="card-title"><%=prodottoOrdine.getNome()%></h5>
							<p class="card-text"><%=prodottoOrdine.getDescrizione()%></p>
						</div>
						<div class="card-footer text-muted">
							Nell' ordine numero:
							<%=prodottoOrdine.getOid()%></div>
					</div>
					<%
					}
					}
					%>
				</div>
				<!-- Badge -->
				<div class="row d-none" id="badge">
					<h1 class="text-center">I tuoi badge</h1>
					<div class="row row-cols-1 row-cols-md-3 g-3 text-center">
						<div class="card-group w-100"></div>
						<!-- Astrologo -->
						<div class="card">
							<img src="./resources/img/badge/astrologo.png"
								class="card-img-top badgeImg" alt="...">
							<div class="card-body">
								<h5 class="card-title">Astrologo</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#astrologoModal">Sblocca</a>
							</div>
						</div>
						<!-- benefattore -->
						<div class="card">
							<img src="./resources/img/badge/benefattore.png"
								class="card-img-top badgeImg" alt="...">
							<div class="card-body">
								<h5 class="card-title">Benefattore</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#benefattoreModal">Sblocca</a>
							</div>
						</div>
						<!-- Giramondo -->
						<div class="card">
							<img src="./resources/img/badge/giramondo.png"
								class="card-img-top badgeImg" alt="...">
							<div class="card-body">
								<h5 class="card-title">Giramondo</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#giramondoModal">Sblocca</a>
							</div>
						</div>
						<!-- Matricola -->
						<div class="card">
							<img src="./resources/img/badge/matricola.png"
								class="card-img-top <%if (numeroAlberiAcquistati == 0) {%>badgeImg"
								<%}%> alt="...">
							<div class="card-body">
								<h5 class="card-title">Matricola</h5>
								<%
								if (numeroAlberiAcquistati == 0) {
								%>

								<%
								} else {
								%>
								<p class="text-center text-success">Sei una matricola, hai
									piantato il tuo primo albero</p>
								<%}%>
							</div>
						</div>
						<!-- Multitasking -->
						<div class="card">
							<img src="./resources/img/badge/multitasking.png"
								class="card-img-top badgeImg" alt="...">
							<div class="card-body">
								<h5 class="card-title">Multitasking</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#multitaskingModal">Sblocca</a>
							</div>
						</div>
						<!-- Tarzan -->
						<div class="card">
							<img src="./resources/img/badge/tarzan.png"
								class="card-img-top badgeImg" alt="...">
							<div class="card-body">
								<h5 class="card-title">Tarzan</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#tarzanModal">Sblocca</a>
							</div>
						</div>
					</div>
					<div class="mb-5"></div>
				</div>

				<!-- Indirizzo -->
				<div id="indirizzo" class="row d-none">
					<h1 class="text-center">I tuoi indirizzi</h1>
					<%
					if (indirizzi != null && indirizzi.size() != 0) {
						Iterator<?> it = indirizzi.iterator();
						while (it.hasNext()) {
							Indirizzo indirizzo = (Indirizzo) it.next();
					%>

					<div class="card col-4 p-3 mb-5 text-center">
						<div class="card-body">
							<h4 class="card-title">Indirizzo Di Fatturazione</h4>
							<p class="card-text">
								<b>Nome: </b>
								<%=indirizzo.getNome()%>
							</p>
							<p class="card-text">
								<b>Cognome: </b>
								<%=indirizzo.getCognome()%>
							</p>
							<p class="card-text">
								<b>Via: </b>
								<%=indirizzo.getVia()%>
							</p>
							<p class="card-text">
								<b>Civico:</b>
								<%=indirizzo.getCivico()%>
							</p>
							<p class="card-text">
								<b>Città: </b>
								<%=indirizzo.getCittà()%>
							</p>
							<p class="card-text">
								<b>Cap: </b>
								<%=indirizzo.getCAP()%>
							</p>
							<p class="card-text">
								<b>Provincia:</b>
								<%=indirizzo.getProvincia()%>
							</p>
							<p class="card-text">
								<b>Prefferd:</b>
								<%=indirizzo.isPreferred()%>
							</p>
							<form>
								<input class="form-check-input" type="checkbox" value=""
									id="condizioni" aria-describedby="invalidCheck3Feedback"
									required> <label class="form-check-label"
									for="condizioni"> Rendi preferito </label>
							</form>
						</div>
					</div>

					<%
					}
					}
					%>
				</div>

				<!-- Logout -->
				<div id="logout" class="row d-none">
					<p>
						Clicca <a href="Login?action=logout">qui</a> per effettuare il
						logout
					</p>
				</div>

				<!-- Modifica Informazioni -->
				<div class="row d-none" id="modificaInformazioni">
					<h4 class="mb-3">Modifica Informazioni</h4>
					<form class="needs-validation" novalidate autocomplete="off"
						name="checkout" action="Ordini?action=compra" method="POST">
						<div class="row g-3">
							<div class="col-sm-6">
								<label for="nome" class="form-label">Nome</label> <input
									type="text" class="form-control" id="nome" placeholder="Mario"
									required value="">
								<div class="invalid-feedback">Inserisci il tuo nome.</div>
							</div>
							<div class="col-sm-6">
								<label for="cognome" class="form-label">Congnome</label> <input
									type="text" class="form-control" id="cognome"
									placeholder="Rossi" value="" required>
								<div class="invalid-feedback">Inserisci il tuo cognome.</div>
							</div>
						</div>
						<div class="col-12">
							<label for="username" class="form-label">Username</label>
							<div class="input-group has-validation">
								<span class="input-group-text">@</span> <input type="text"
									class="form-control" id="username" placeholder="mariorossi"
									required>
								<div class="invalid-feedback">Inserisci il tuo username</div>
							</div>
						</div>

						<div class="col-12">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email"
								placeholder="you@example.com">
							<div class="invalid-feedback">Inserisci una email valida
								per ricere tutti gli aggiornamenti sul tuo ordine.</div>
						</div>

						<div class="col-12 md-5">
							<div class="form-group">
								<label for="formFile" class="form-label mt-4">Inserisci
									una nuova foto profilo </label> <input class="form-control" type="file"
									id="formFile">
							</div>
						</div>
					</form>
				</div>
				<!-- Row END -->
			</div>

		</div>
	</div>

	<!-- Modal Astrologo -->
	<div class="modal fade" id="astrologoModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Astrologo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Mira alle stelle e pianta l'albero del
					tuo segno zodiacale.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Astrologo -->
	<div class="modal fade" id="astrologoModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Astrologo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Mira alle stelle e pianta l'albero del
					tuo segno zodiacale.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Benefattore -->
	<div class="modal fade" id="benefattoreModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Benefattore</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Sii generoso e regala almeno un
					albero. Otterrai il riconoscimento quando la persona a cui hai
					regalato l'albero, lo riscatterà, diventandone così custode e
					iniziando a seguirne la storia..</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Giramondo -->
	<div class="modal fade" id="giramondoModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Giramondo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Supera i confini e pianta almeno un
					albero in 3 paesi diversi.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Matricola -->
	<div class="modal fade" id="matricolaModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Matricola</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Inizia la tua esperienza e pianta il
					tuo primo albero.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Multitasking -->
	<div class="modal fade" id="multitaskingModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Multitasking</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Gli alberi sanno essere utili in molti
					modi. Pianta alberi che assolvono ad almeno 6 dei loro 8 usi e
					benefici.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Tarzan -->
	<div class="modal fade" id="tarzanModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Tarzan</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Non essere timido e pubblica la tua
					prima foresta.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

	<script>
		$(document).ready(function() {

			$("#ordiniButton").click(function(event) {
				$("#ordini").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#woodLot").addClass("d-none");
				$("#news").addClass("d-none");
				$("#indirizzo").addClass("d-none");
				$("#logout").addClass("d-none");
				$("#modificaIndormazioni").addClass("d-none");
			});

			$("#badgeButton").click(function(event) {
				$("#badge").removeClass("d-none");
				$("#ordini").addClass("d-none");
				$("#woodLot").addClass("d-none");
				$("#news").addClass("d-none");
				$("#indirizzo").addClass("d-none");
				$("#logout").addClass("d-none");
				$("#modificaIndormazioni").addClass("d-none");
			});

			$("#woodLotButton").click(function(event) {
				$("#woodLot").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#ordini").addClass("d-none");
				$("#news").addClass("d-none");
				$("#indirizzo").addClass("d-none");
				$("#logout").addClass("d-none");
				$("#modificaIndormazioni").addClass("d-none");
			});

			$("#newsButton").click(function(event) {
				$("#news").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#ordini").addClass("d-none");
				$("#woodLot").addClass("d-none");
				$("#indirizzo").addClass("d-none");
				$("#logout").addClass("d-none");
				$("#modificaIndormazioni").addClass("d-none");
			});

			$("#indirizzoButton").click(function(event) {
				$("#indirizzo").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#ordini").addClass("d-none");
				$("#woodLot").addClass("d-none");
				$("#news").addClass("d-none");
				$("#logout").addClass("d-none");
				$("#modificaIndormazioni").addClass("d-none");
			});

			$("#modificaInformazioniButton").click(function(event) {
				$("#modificaInformazioni").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#ordini").addClass("d-none");
				$("#woodLot").addClass("d-none");
				$("#news").addClass("d-none");
				$("#indirizzo").addClass("d-none");
				$("#logout").addClass("d-none");
			});

			$("#logoutButton").click(function(event) {
				$("#logout").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#ordini").addClass("d-none");
				$("#woodLot").addClass("d-none");
				$("#news").addClass("d-none");
				$("#indirizzo").addClass("d-none");
				$("#modificaInformazioni").addClass("d-none");
			});
		});
	</script>
</body>
</html>