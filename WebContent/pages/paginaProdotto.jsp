
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

if (prodotto == null || foto == null || categorie == null) {
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
<!-- Per cambiare il colore delle stelline -->
<style>
.checked {
	color: orange;
}
</style>
<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<br>

	<!-- Sezione Prodotto -->
	<div class="container">
		<br>
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
					<h1 class="font-monospace"><%=prodotto.getNome()%></h1>
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
						<p>
							<i class="fa-solid fa-coins"></i>
							<%=dFormat.format(prodotto.getPrezzo())%>€
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
					<a type="button" class="btn btn-primary"
						href="Prodotto?action=aggiungiCarrello&id=<%=prodotto.getId()%>">Acquista</a>
				</div>
			</div>
		</div>


		<!-- Fine Sezione Prodotto -->

		<!-- Dettagli Prodotto -->
		<!-- Breve Descrizione  -->
		<br> <br>
		<div class="row text-center">
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
		<div class="text-center">
			<br> <br>
			<h3>Dove Viene Piantato?</h3>
			<p class="lead"><%=prodotto.getDoveVienePiantato()%></p>
		</div>
		<div class="text-center">
			<img
				src="./GetFotoPaeseDiOrigine?idPaese=<%=prodotto.getPaeseDiOrigine()%>"
				class="img-fluid" height="626px" width="925px">
		</div>
		<!-- Perche Categoria -->
		<div class="text-center">
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
		<br> <br>
		<!-- Cosa Vuol Dire Piantare Un albero con WoodLot -->
		<div class="row text-center">
			<br> <br>
			<h2>Cosa vuol dire piantare un albero con WoodLot</h2>
			<div class="col-4">
				<h1>
					<i class="fa-solid fa-location-dot"></i>
				</h1>
				<h4>Trasparenza e tracciabilità</h4>
				<p>Tutti gli Alberi sono geolocalizzati e fotografati quando
					vengono piantati. Dal momento dell'acquisto è necessario attendere
					da alcune settimane a qualche mese prima che un albero sia pronto
					per essere piantato.</p>
			</div>
			<div class="col-4">
				<h1>
					<i class="fa-solid fa-book"></i>
				</h1>
				<h4>Un racconto che dura nel tempo</h4>
				<p>Ogni albero ha il proprio Diario, una pagina online dove
					scoprirai le sue caratteristiche e seguirai la storia del progetto
					di cui fa parte.</p>
			</div>
			<div class="col-4">
				<h1>
					<i class="fa-solid fa-gift"></i>
				</h1>
				<h4>Un regalo originale</h4>
				<p>Regalare un albero è semplicissimo. Puoi farlo durante la
					procedura d'acquisto o in qualunque momento dal tuo profilo,
					scegliendo la modalità che preferisci (via mail, messaggio o
					stampando un biglietto da consegnare a mano).</p>
			</div>
		</div>

		<!-- Prodotti Consigliati  -->
		<div class="col-md-12 text-center">
			<h1>Pianta altri alberi</h1>
			<br> <br>

			<div class="row row-cols-1 row-cols-md-4">
				<!-- Card 1 -->
				<div class="col">
					<div class="card h-100">
						<img src="./GetFotoProdotto?idFoto=1" class="card-img-top"
							onerror="this.src='./resources//img/error.jpg'" />
						<div class="card-body">
							<h5 class="card-title">Card title</h5>
							<p class="card-text">This is a longer card with supporting
								text below as a natural lead-in to additional content. This
								content is a little bit longer.</p>
							<div class="text-center">
								<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
									Ora</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Card 1 -->
				<div class="col">
					<div class="card h-100">
						<img src="./GetFotoProdotto?idFoto=1" class="card-img-top"
							onerror="this.src='./resources//img/error.jpg'" />
						<div class="card-body">
							<h5 class="card-title">Card title</h5>
							<p class="card-text">This is a longer card with supporting
								text below as a natural lead-in to additional content. This
								content is a little bit longer.</p>
							<div class="text-center">
								<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
									Ora</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Card 1 -->
				<div class="col">
					<div class="card h-100">
						<img src="./GetFotoProdotto?idFoto=1" class="card-img-top"
							onerror="this.src='./resources//img/error.jpg'" />
						<div class="card-body">
							<h5 class="card-title">Card title</h5>
							<p class="card-text">This is a longer card with supporting
								text below as a natural lead-in to additional content. This
								content is a little bit longer.</p>
							<div class="text-center">
								<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
									Ora</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Card 1 -->
				<div class="col">
					<div class="card h-100">
						<img src="./GetFotoProdotto?idFoto=1" class="card-img-top"
							onerror="this.src='./resources//img/error.jpg'" />
						<div class="card-body">
							<h5 class="card-title">Card title</h5>
							<p class="card-text">This is a longer card with supporting
								text below as a natural lead-in to additional content. This
								content is a little bit longer.</p>
							<div class="text-center">
								<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
									Ora</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br> <br>
		</div>

	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>