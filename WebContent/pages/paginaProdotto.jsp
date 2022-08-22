
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*, it.unisa.beans.*, it.unisa.model.Carrello, java.text.*"%>
<%
Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
FotoProdotto[] foto = (FotoProdotto[]) request.getSession().getAttribute("prodottoFoto");
Collection<?> categorie = (Collection<?>) request.getAttribute("categorieProdotto");

Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> fotoProdotti = (Collection<?>) request.getAttribute("fotoProdotti");

if (prodotto == null || foto == null || categorie == null || fotoProdotti == null || prodotti == null) {
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
							<img src="./GetFotoProdotto?idFoto=<%=foto[0].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">
						</div>
						<div class="carousel-item">
							<img src="./GetFotoProdotto?idFoto=<%=foto[1].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">
						</div>
						<div class="carousel-item">
							<img src="./GetFotoProdotto?idFoto=<%=foto[2].getNomeFoto()%>"
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
							<i class="fa-solid fa-tree"></i><%=prodotto.getSottotitolo()%>
						</p>
					</div>
					<div class="col">
						<p>
							<i class="fa-solid fa-location-dot"></i>
							<%=prodotto.getPaeseDiOrigine()%>
						</p>
					</div>
				</div>
				<hr>
				<div class="row"></div>
				<div class="row">
					<div class="col">
						<%
						if (categorie != null && categorie.size() != 0) {
							Iterator<?> it2 = categorie.iterator();

							while (it2.hasNext()) {
								Categoria cat = (Categoria) it2.next();
						%>
						<p class="card-text">
							<b>Benefici</b>
							<%=cat.getNome()%>
							<%
							}
							}
							%>
						
					</div>
					<div class="col">
						<p class="text-danger">
							<%
							if (prodotto.getOnSale() != 0) {
								double sconto = (prodotto.getPrezzo() * prodotto.getSaldo()) / 100;
								double prezzo = prodotto.getPrezzo() - sconto;
							%><span class="badge mx-2 bg-secondary">-<%=prodotto.getSaldo()%>%
							</span> <i class="fa-solid fa-coins"></i>
							<%=dFormat.format(prezzo)%>€
						</p>
						<%
						} else {
						%>
						<p>
							<i class="fa-solid fa-coins"></i>
							<%=dFormat.format(prodotto.getPrezzo())%>€
							<%
							}
							%>
						</p>
					</div>

				</div>
				<hr>

				<div class="row">
					<div class="col-6">
						<p class="card-text">
							<strong>Nome Scientifico: </strong>
							<%=prodotto.getNomeScientifico()%></p>
					</div>
					<div class="col-6">
						<p class="card-text">
							<strong> Altezza media: </strong>
							<%=prodotto.getAltezza()%>
							metri
						</p>
					</div>
				</div>
				<hr>
				<p>
					<b>Che albero è?</b>
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
		<div class="row text-center m-4">
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
		</div>

		<!-- Dove Viene Piantato -->
		<div class="text-center m-4">
			<br> <br>
			<h3>Dove Viene Piantato?</h3>
			<p class="lead"><%=prodotto.getDoveVienePiantato()%></p>
		</div>
		<div class="text-center">
			<img
				src="./GetFotoPaeseDiOrigine?idPaese=<%=prodotto.getPaeseDiOrigine()%>"
				class="img-fluid" height="626px" width="925px"
				onerror="this.src='./resources//img/error.jpg'">
		</div>
		<!-- Perche Categoria -->
		<div class="text-center m-5">
			<%
			if (categorie != null && categorie.size() != 0) {
				Iterator<?> it2 = categorie.iterator();

				while (it2.hasNext()) {
					Categoria cat = (Categoria) it2.next();
			%>
			<br> <br>
			<h3>
				Perchè
				<%=cat.getNome()%>?
			</h3>
			<p class="lead"><%=cat.getDescrizione()%></p>
			<%
			}
			}
			%>
		</div>
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
					Prodotto bean = (Prodotto) it.next();
					FotoProdotto bean1 = (FotoProdotto) it1.next();
			%>
			<div class="col">
				<div class="card h-100">
					<img src="./GetFotoProdotto?idFoto=<%=bean1.getNomeFoto()%>"
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
								href="Prodotto?action=leggi&id=<%=bean.getId()%>">Piantalo
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
	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>