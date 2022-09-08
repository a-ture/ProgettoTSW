
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*, it.unisa.beans.*, it.unisa.model.Carrello, java.text.*"%>
<%
Albero prodotto = (Albero) request.getAttribute("prodotto");
Collection<?> usiLocaliAll = (Collection<?>) request.getAttribute("usiLocali");
Collection<?> categorieAll = (Collection<?>) request.getAttribute("categorie");

FotoProdotto[] foto = (FotoProdotto[]) request.getSession().getAttribute("prodottoFoto");

Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> fotoProdotti = (Collection<?>) request.getAttribute("fotoProdotti");

if (prodotto == null || foto == null || fotoProdotti == null || prodotti == null) {
	response.sendRedirect("./Prodotto");
	return;
}

DecimalFormat dFormat = new DecimalFormat("0.00");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=prodotto.getNome()%></title>
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="resources/css/_bootswatch.scss">
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
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
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="resources/img/logo.png">
</head>


<style>
.checked { /*<!-- Per cambiare il colore delle stelline -->*/
	color: orange;
}

#btnCart {
	transition: all 0.5s;
}

#btnCart span {
	cursor: pointer;
	display: inline-block;
	position: relative;
	transition: 0.5s;
}

#btnCart span:after {
	content: '\002B';
	position: absolute;
	opacity: 0;
	top: 0;
	right: -20px;
	transition: 0.5s;
}

#btnCart:hover span {
	padding-right: 25px;
}

#btnCart:hover span:after {
	opacity: 1;
	right: 0;
}

.avatar {
	width: 68px;
	height: 68px;
	border-radius: 50%;
}

.years-5 {
	height: 98px;
	text-align: center;
	width: 98px;
	border-radius: 100%;
	border-style: solid;
	border-width: 14px;
	border-bottom-color: #5e7250;
	border-left-color: #5e7250;
	border-right-color: #5e7250;
	border-top-color: #5e7250;
}

.years-4 {
	height: 98px;
	text-align: center;
	width: 98px;
	border-radius: 100%;
	border-style: solid;
	border-width: 14px;
	border-bottom-color: #e5c59c;
	border-left-color: #5e7250;
	border-right-color: #5e7250;
	border-top-color: #5e7250;
}

.years-3 {
	height: 98px;
	text-align: center;
	width: 98px;
	border-radius: 100%;
	border-style: solid;
	border-width: 14px;
	border-bottom-color: #e5c59c;
	border-left-color: #e5c59c;
	border-right-color: #5e7250;
	border-top-color: #5e7250;
}

.years-2 {
	height: 98px;
	text-align: center;
	width: 98px;
	border-radius: 100%;
	border-style: solid;
	border-width: 14px;
	border-bottom-color: #e5c59c;
	border-left-color: #e5c59c;
	border-right-color: #e5c59c;
	border-top-color: #5e7250;
}

.years-1 {
	height: 98px;
	text-align: center;
	width: 98px;
	border-radius: 100%;
	border-style: solid;
	border-width: 14px;
	border-bottom-color: #e5c59c;
	border-left-color: #e5c59c;
	border-right-color: #e5c59c;
	border-top-color: #e5c59c;
}

.box {
	color: white;
	background: #c4d89d;
	width: 500px;
	height: max-content;
	border-bottom-right-radius: 20px;
	border-top-left-radius: 20px;
	padding: 20px;
	padding-right: 60px;
	box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px
		-12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px
		12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;
}

#imageCategorie {
	width: 550px;
	z-index: 23062002;
	margin-top: 100px;
	margin-left: -40px;
	border-bottom-left-radius: 20px;
	border-top-right-radius: 20px;
	box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px
		-12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px
		12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;
}

#categorie {
	display: flex;
	align-items: center;
	justify-content: center;
}
</style>
<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<br>

	<!-- Sezione Prodotto -->
	<div class="container-fluid">
		<!-- Foto Prodotto -->
		<div class="row">
			<div class=" col-5">
				<!-- Carousel -->
				<div id="demo" class="carousel slide" data-bs-ride="carousel">
					<!-- Indicators/dots -->
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#demo" data-bs-slide-to="0"
							class="active"></button>
						<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
						<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
					</div>

					<!-- The slideshow/carousel -->
					<div class="carousel-inner">
						<div class="carousel-item active">

							<img src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[0].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">

						</div>
						<div class="carousel-item">
							<img src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[1].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">
						</div>
						<div class="carousel-item">
							<img src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[2].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources//img/error.jpg'">
						</div>
					</div>

					<!-- Left and right controls/icons -->
					<button class="carousel-control-prev" type="button"
						data-bs-target="#demo" data-bs-slide="prev">
						<span class="carousel-control-prev-icon"></span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#demo" data-bs-slide="next">
						<span class="carousel-control-next-icon"></span>
					</button>
				</div>
			</div>
			<!-- Dettagli Prodotto -->
			<div class="col">
				<div class="row">
					<h1 class="font-monospace"><%=prodotto.getNome()%>
						<%
						if (!prodotto.isDisponibile()) {
						%>
						<span class="badge mx-2 bg-dark">Sold Out</span>
						<%
						} else if (prodotto.getOnSale() != 0) {
						%>
						<span class="badge mx-2 bg-dark">In saldo</span>
						<%
						}
						%>
					</h1>
				</div>
				<div class="row">
					<div class="col">
						<p>
							<i class="fa-solid fa-tree"></i>
							<%=prodotto.getSottotitolo()%>
						</p>
					</div>
					<div class="col">
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#prezzo">Cos'è incluso nel prezzo?</a>
					</div>
				</div>

				<hr>
				<div class="row">
					<div class="col">

						<%
						if (prodotto.getOnSale() != 0) {
							double sconto = (prodotto.getPrezzo() * prodotto.getSaldo()) / 100;
							double prezzo = prodotto.getPrezzo() - sconto;
						%><p class="text-danger">
							<span class="badge mx-2 bg-secondary">-<%=prodotto.getSaldo()%>%
							</span> <i class="fa-solid fa-coins"></i>
							<%=dFormat.format(prezzo)%>€
						</p>

						<%
						} else {
						%>
						<p>
							<i class="fa-solid fa-coins"></i> <strong>Prezzo: </strong>
							<%=dFormat.format(prodotto.getPrezzo())%>€
							<%
							}
							%>
						</p>
					</div>
					<div class="col">
						<p>
							<i class="fa-solid fa-location-dot"></i><strong> Paese:
							</strong>
							<%=prodotto.getPaeseDiOrigine()%>
						</p>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-6">
						<p class="card-text">
							<i class="fa-solid fa-seedling"></i><strong> Nome
								Scientifico: </strong>
							<%=prodotto.getNomeScientifico()%></p>
					</div>
					<div class="col-6">
						<p class="card-text">
							<i class="fa-solid fa-arrow-up-long"></i> <strong>
								Altezza media: </strong>
							<%=prodotto.getAltezza()%>
							metri
						</p>
					</div>
				</div>
				<hr>
				<p>
					<i class="fa-solid fa-circle-question"></i> <b>Che albero è?</b>
				</p>
				<p><%=prodotto.getDescrizioneBreve()%>
				<hr>

				<div class="text-center">
					<%
					if (prodotto.isDisponibile()) {
					%>
					<a type="button" class="btn btn-primary"
						href="Prodotto?action=aggiungiCarrello&id=<%=prodotto.getId()%>"
						id="btnCart"><span>Acquista</span></a>
					<%
					} else {
					%>
					<a type="button" class="btn btn-dark"> Prodotto Sold Out</a>
					<%
					}
					%>
				</div>
			</div>
		</div>
		<!-- Dettagli Prodotto -->
		<!-- Breve Descrizione  -->
		<div
			class="row text-center m-4 g-4 row-cols-1 row-cols-xs-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-2">
			<div class="col-6">
				<div class="card" style="background: #c4d89d;">
					<div class="card-body">
						<h4 class="card-title">Descrizione Breve</h4>
						<p class="card-text"><%=prodotto.getDescrizione()%></p>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="col">
					<div class="card" style="background: #c4d89d;">
						<div class="card-body">
							<h4 class="card-title">I miei superpoteri</h4>
							<div class="row">
								<div class="col">
									<p class="card-text">
										<i class="fa-solid fa-cloud"></i> <strong>CO2
											Assorbita</strong>
									</p>
								</div>

								<div class="col">
									<%
									int stelleColorateCo2 = prodotto.getCo2();
									int stelleNonColorateCo2 = 5 - stelleColorateCo2;
									for (int i = 0; i < stelleColorateCo2; i++) {
									%>
									<span class="fa fa-star checked"></span>
									<%
									}
									for (int i = stelleNonColorateCo2; i > 0; i--) {
									%>
									<span class="fa fa-star"></span>
									<%
									}
									%>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<p class="card-text">
										<i class="fa-solid fa-seedling"></i> <strong>Salvaguardia
											Ambientale</strong>
									</p>
								</div>
								<!-- Stelle -->
								<div class="col">
									<%
									int stelleColorate = prodotto.getSalvaguardia();
									int stelleNonColorate = 5 - stelleColorate;
									for (int i = 0; i < stelleColorate; i++) {
									%>
									<span class="fa fa-star checked"></span>
									<%
									}
									for (int i = stelleNonColorate; i > 0; i--) {
									%>
									<span class="fa fa-star"></span>
									<%
									}
									%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card" style="background: #c4d89d;">
					<div class="card-body">
						<h4 class="card-title">
							Usi Locali<a class="card-link" data-bs-toggle="modal"
								data-bs-target="#informazioniUsiLocali"><i
								class="fa-solid fa-circle-info text-end p-2"></i></a>
						</h4>
						<ul class="d-grid list-unstyled">
							<%
							Collection<UsoLocale> usiLocali = prodotto.getUsiLocali();
							if (usiLocali != null && usiLocali.size() != 0) {
								Iterator<UsoLocale> it = usiLocali.iterator();
								while (it.hasNext()) {
									UsoLocale uso = (UsoLocale) it.next();
							%>
							<li class="d-flex gap-4"><img
								class="bi text-muted flex-shrink-0 rounded-circle" width="98"
								height="98" onerror="this.src='./resources//img/error.jpg'"
								src="./ServletResources?codiceAzione=fotoUsoLocale&idUsoLocale=<%=uso.getId()%>">
								<div>
									<h5 class="mb-0"><%=uso.getNome()%></h5>
									<%=uso.getDescrizione()%>
								</div></li>
							<%
							}
							}
							%>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card" style="background: #c4d89d;">

					<div class="card-body">
						<h4 class="card-title">
							Benefici <a class="card-link" data-bs-toggle="modal"
								data-bs-target="#informazioniBenefici"><i
								class="fa-solid fa-circle-info text-end p-2"></i></a>
						</h4>

						<ul class="list-group list-group-horizontal-md text-center">
							<%
							Collection<Beneficio> benefici = prodotto.getBenefici();
							if (benefici != null && benefici.size() != 0) {
								Iterator<?> it2 = benefici.iterator();

								while (it2.hasNext()) {
									Beneficio cat = (Beneficio) it2.next();
							%>
							<li class="list-group-item">
								<div class="years-<%=(int) cat.getPercentuale()%> m-2">
									<img onerror="this.src='./resources//img/error.jpg'"
										src="./ServletResources?codiceAzione=fotoBeneficio&idBeneficio=<%=cat.getId()%>"
										class="avatar">
								</div>

								<h5><%=cat.getNome()%></h5>
								<p><%=cat.getPercentuale()%>/5
								</p>
							</li>
							<%
							}
							}
							%>

						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- Dove Viene Piantato -->
		<div class="text-center m-4">
			<br> <br>
			<h3>Dove Viene Piantato?</h3>
			<p class="lead"><%=prodotto.getDoveVienePiantato()%></p>
		</div>
		<div class="text-center">
			<img
				src="./ServletResources?codiceAzione=fotoPaeseDiOrigine&idPaese=<%=prodotto.getPaeseDiOrigine()%>"
				class="img-fluid" height="626px" width="925px"
				onerror="this.src='./resources//img/error.jpg'">
		</div>

		<!-- Categorie -->
		<%
		Collection<Categoria> cat = prodotto.getCategorie();
		if (cat != null && cat.size() != 0) {
			Iterator<Categoria> it = cat.iterator();
			while (it.hasNext()) {
				Categoria c = it.next();
		%>

		<div id="categorie">
			<div class="box">
				<h1 class="text-center">
					Perchè
					<%=c.getNome()%>?
				</h1><%=c.getDescrizione()%></div>

			<img id="imageCategorie"
				onerror="this.src='./resources//img/error.jpg'"
				src="./ServletResources?codiceAzione=fotoCategoria&idCategoria=<%=c.getId()%>"
				alt="img-200-300">
		</div>
		<%
		}
		}
		%>
		<div class="m-5"></div>
		<div class="row b-example-divider"></div>
		<!-- Cosa Vuol Dire Piantare Un albero con WoodLot -->
		<div class="row text-center m-5">
			<br> <br>
			<h2>Cosa vuol dire piantare un albero con WoodLot</h2>
			<div class="col-4">
				<h1>
					<i class="fa-solid fa-location-dot text-info"></i>
				</h1>
				<h4>Trasparenza e tracciabilità</h4>
				<p>Tutti gli Alberi sono geolocalizzati e fotografati quando
					vengono piantati. Dal momento dell'acquisto è necessario attendere
					da alcune settimane a qualche mese prima che un albero sia pronto
					per essere piantato.</p>
			</div>
			<div class="col-4">
				<h1>
					<i class="fa-solid fa-book text-warning"></i>
				</h1>
				<h4>Un racconto che dura nel tempo</h4>
				<p>Ogni albero ha il proprio Diario, una pagina online dove
					scoprirai le sue caratteristiche e seguirai la storia del progetto
					di cui fa parte.</p>
			</div>
			<div class="col-4">
				<h1>
					<i class="fa-solid fa-gift text-danger"></i>
				</h1>
				<h4>Un regalo originale</h4>
				<p>Regalare un albero è semplicissimo. Puoi farlo durante la
					procedura d'acquisto o in qualunque momento dal tuo profilo,
					scegliendo la modalità che preferisci (via mail, messaggio o
					stampando un biglietto da consegnare a mano).</p>
			</div>
		</div>

		<div class="row b-example-divider"></div>
		<!-- Prodotti Consigliati  -->
		<h1 class="m-3 text-center">Pianta altri alberi</h1>
		<div class="row row-cols-1 row-cols-md-4 mb-5 text-center">
			<%
			if (prodotti != null && prodotti.size() != 0) {
				Iterator<?> it = prodotti.iterator();
				Iterator<?> it1 = fotoProdotti.iterator();
				for (int i = 0; i < 4; i++) {
					Albero bean = (Albero) it.next();
					FotoProdotto bean1 = (FotoProdotto) it1.next();
			%>
			<div class="col">
				<div class="card h-100">
					<img src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=bean1.getNomeFoto()%>"
						class="card-img-top"
						onerror="this.src='./resources//img/error.jpg'" />
					<div class="card-body">
						<h5 class="card-title"><%=bean.getNome()%>
							<%
							if (bean.getOnSale() != 0) {
							%><span class="badge mx-2 bg-secondary">In Saldo</span>
							<%
							}
							%>
						</h5>
						<p class="card-text"><%=bean.getDescrizioneBreve()%></p>
						<p class="card-text text-center"><%=dFormat.format(bean.getPrezzo())%>
							€
						</p>
						<div class="text-center">
							<a class="btn btn-success position-relative"
								href="Prodotto?action=leggiProdotto&id=<%=bean.getId()%>">Piantalo
								Ora <%
							if (bean.getOnSale() != 0) {
							%><span
								class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">
									<span class="visually-hidden">In Saldo</span>
							</span> <%
 }
 %>
							</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
		<div class="col-md-12 text-center">
			<a class="btn btn-primary m-3" href="Catalogo" role="button">Vedi
				tutti gli alberi</a>
		</div>
	</div>
	<!-- Modal Informazioni Usi Locali -->
	<div class="modal fade" id="informazioniUsiLocali" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Usi Locali</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<%
						if (usiLocaliAll != null && usiLocaliAll.size() != 0) {
							Iterator<?> it = usiLocaliAll.iterator();
							while (it.hasNext()) {
								UsoLocale uso = (UsoLocale) it.next();
						%>
						<li class="d-flex gap-4"><img
							class="bi text-muted flex-shrink-0" width="98" height="98"
							onerror="this.src='./resources//img/error.jpg'"
							src="./ServletResources?codiceAzione=fotoUsoLocale&idUsoLocale=<%=uso.getId()%>">
							<div>
								<h5 class="mb-0"><%=uso.getNome()%></h5>
								<%=uso.getDescrizione()%>
							</div></li>
						<%
						}
						}
						%>
					</ul>
					<button type="button" class="btn btn-lg btn-primary mt-5 w-100"
						data-bs-dismiss="modal">Ho capito!</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Informazioni Benefici -->
	<div class="modal fade" id="informazioniBenefici" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Benefici</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<%
						Collection<Beneficio> beneficiAll = prodotto.getBenefici();
						if (beneficiAll != null && beneficiAll.size() != 0) {
							Iterator<?> it = beneficiAll.iterator();
							while (it.hasNext()) {
								Beneficio ben = (Beneficio) it.next();
						%>
						<li class="d-flex gap-4"><img
							class="bi text-muted flex-shrink-0" width="48" height="48"
							onerror="this.src='./resources//img/error.jpg'"
							src="./ServletResources?codiceAzione=fotoBeneficio&idBeneficio=<%=ben.getId()%>">
							<div>
								<h5 class="mb-0"><%=ben.getNome()%></h5>
								<%=ben.getDescrizione()%>
							</div></li>
						<%
						}
						}
						%>
					</ul>
					<button type="button" class="btn btn-lg btn-primary mt-5 w-100"
						data-bs-dismiss="modal">Ho capito!</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Prezzo -->
	<div class="modal fade" id="prezzo" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-3">Cos'è incluso nel prezzo?</h2>
					<img class="mx-5 my-1" src="resources/img/treedom-about-price.png"
						width="350px">
					<p class="m-1">Piantare un albero con Treedom significa
						finanziare un contadino per piantare un albero e sostenerlo fino a
						quando non sarà produttivo. Con Treedom infatti un albero è molto
						più di un albero. Ecco cosa è incluso nel prezzo:</p>
					<ol class="d-grid gap-4 my-2 list-group list-group-numbered">
						<li class="d-flex">Avvio del progetto</li>
						<li class="d-flex ">Costruzione del vivaio e produzione delle
							piantine</li>
						<li class="d-flex ">Distribuzione delle piante ai contadini</li>
						<li class="d-flex ">Messa a dimora della pianta</li>
						<li class="d-flex">Manutenzione della pianta fino al momento
							in cui non darà un reddito al contadino</li>
						<li class="d-flex ">Formazione dei contadini sulle migliori
							pratiche agro-forestali, anche con il supporto di università ed
							enti di ricerca locali</li>
						<li class="d-flex">Sostituzione delle fallanze durante i
							primi anni in cui il tasso di mortalità è più elevato</li>
						<li class="d-flex">Piantumazione di un 5% in più di alberi
							che non vengono assegnati agli utenti per coprire le fallanze</li>
						<li class="d-flex">Registrazione delle coordinate GPS
							dell'albero e monitoraggio fotografico</li>
						<li class="d-flex">Controlli annuali a campione sulle aree di
							progetto per verificare la permanenza degli alberi e la loro
							buona salute</li>
						<li class="d-flex">Approvazione della foto e controllo delle
							coordinate di ogni singolo albero da parte dei nostri agronomi
							specializzati.</li>
						<li class="d-flex">Assegnazione all’albero di un ID univoco e
							inserimento dell’albero <a
							href="ChiSiamoServlet#registroDegliAlberi" class="card-link">nel
								registro pubblico</a>
						</li>
						<li class="d-flex">Aggiornamenti periodici sul progetto, con
							un focus sui benefici ambientali e sociali, pubblicati nel Diario
							dell’Albero</li>
					</ol>
					<button type="button" class="btn btn-lg btn-primary mt-5 w-100"
						data-bs-dismiss="modal">Ho capito!</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
	<script type="text/javascript">
		// Zoom images

		// Add zoom-image class to the container of the image that you want to apply the zoom to.

		jQuery(document)
				.ready(
						function($) {

							$('.zoom-image img').click(function(event) {
								var ix = $(this).offset().left;
								var iy = $(this).offset().top;
								console.log(ix + '-' + iy);

								var mx = event.pageX;
								var my = event.pageY;
								console.log(mx + '-' + my);
							})

							$('.zoom-image img')
									.hover(
											function() {

												var img = $(this).attr('src');

												$(this)
														.after(
																"<div class='hover-image' style='background-image: url("
																		+ img
																		+ "); background-size: 1200px;'></div>");

												$(this)
														.mousemove(
																function(event) {

																	// Mouse Position
																	var mx = event.pageX;
																	var my = event.pageY;

																	// Image Position
																	var ix = $(
																			this)
																			.offset().left;
																	var iy = $(
																			this)
																			.offset().top;

																	// Mouse Position Relavtive to Image
																	var x = mx
																			- (ix);
																	var y = my
																			- (iy);

																	// Image Height and Width
																	var w = $(
																			this)
																			.width();
																	var h = $(
																			this)
																			.height();

																	// Mouse Position Relative to Image, in %
																	var xp = (-x / w)
																			* -100;
																	var yp = (-y / h)
																			* -100;

																	$(this)
																			.parent()
																			.find(
																					'.hover-image')
																			.attr(
																					'style',

																					"background-image: url("
																							+ img
																							+ "); background-size: 1200px; background-repeat: no-repeat; background-position: "
																							+ xp
																							+ "% "
																							+ yp
																							+ "%; top: "
																							+ y
																							+ "px; left: "
																							+ x
																							+ "px;");

																});

											},
											function() {

												$(this).parent().find(
														'.hover-image')
														.remove();

											});

						});
	</script>
</body>
</html>