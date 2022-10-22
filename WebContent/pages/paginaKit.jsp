<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*, it.unisa.beans.*, it.unisa.model.Carrello, java.text.*"%>
<%
KitAlberi kit = (KitAlberi) request.getAttribute("kit");
FotoProdotto[] foto = (FotoProdotto[]) request.getAttribute("fotoKit");
Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> fotoProdotti = (Collection<?>) request.getAttribute("fotoProdotti");

DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=kit.getNome()%></title>
<!--CSS-->
<link rel="stylesheet" type="text/css" href="resources/css/style.css">

<style>
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

.layout {
	display: flex;
	display: flex;
	justify-content: center;
	margin: 0;
	color: #f0f0f0;
	margin: 0;
}

.cardKit {
	position: relative;
	width: 500px;
	height: 500px;
	margin: 10px;
	max-height: 500px;
}

.cardKit img {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 15px;
}

.overlay {
	position: absolute;
	bottom: 0;
	width: 90%;
	transition: .5s ease;
	opacity: 0;
	color: white;
	font-size: 25px;
	padding: 10px;
	text-align: center;
	border-radius: 15px;
}

.cardKit:hover .overlay {
	opacity: 1;
}
</style>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="resources/img/logo.png">
</head>

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
						<%
						for (int y = 0; y < foto.length; y++) {
						%>
						<%
						if (y == 0) {
						%>
						<button type="button" data-bs-target="#demo"
							data-bs-slide-to="<%=y%>" class="active"></button>
						<%
						} else {
						%>
						<button type="button" data-bs-target="#demo"
							data-bs-slide-to="<%=y%>"></button>
						<%
						}
						}
						%>

					</div>

					<!-- The slideshow/carousel -->
					<div class="carousel-inner">
						<%
						for (int y = 0; y < foto.length; y++) {
						%>
						<%
						if (y == 0) {
						%>

						<div class="carousel-item active">
							<img src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[y].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">
						</div>
						<%
						} else {
						%>
						<div class="carousel-item">
							<img src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[y].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">
						</div>
						<%
						}
						}
						%>

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
					<h1 class="font-monospace"><%=kit.getNome()%>
						<%
						if (!kit.isDisponibile()) {
						%>
						<span class="badge mx-2 bg-dark">Sold Out</span>
						<%
						}
						%>
					</h1>
				</div>
				<div class="row">
					<div class="col">
						<p>
							<i class="fa-solid fa-tree"></i> <strong>Kit da <%=kit.getNumeroAlberi()%>
								alberi
							</strong>
						</p>
					</div>
					<div class="col">
						<p>
							<i class="fa-solid fa-earth-americas"></i> -
							<%=kit.getCO2()%>
							kg di CO2
						</p>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col">
						<p>
							<i class="fa-solid fa-sack-dollar"></i> Acquistando questo kit
							riceverai il
							<%=kit.getSaldo()%>% di sconto su ogni albero del kit.
							Risparmerai
							<%=dFormat.format(kit.getPrezzoAlberi() - kit.getPrezzoKit())%>€
						</p>
					</div>
					<div class="col">
						<p>
							<i class="fa-solid fa-coins"></i>
							<%=dFormat.format(kit.getPrezzoKit())%>€
						</p>
					</div>
				</div>
				<hr>
				<p>
					<b> <i class="fa-solid fa-leaf"></i> Che kit è?
					</b>
				</p>
				<p><%=kit.getDescrizione()%>
				<hr>

				<div class="text-center">
					<%
					if (kit.isDisponibile()) {
					%>
					<a type="button" class="btn btn-primary" id="btnCart"
						href="Prodotto?action=aggiungiCarrelloKit&idKit=<%=kit.getId()%>"
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
		<div class="m-5">
			<div class="text-center">
				<h1>
					Più informazioni su
					<%=kit.getNome()%></h1>
				<p class="text-muted">Il kit contiene i seguenti alberi:</p>

			</div>
		</div>
		<div class="layout   row row-cols-1 row-cols-md-6">
			<%
			int z = 0;
			Collection<Albero> alberi = kit.getAlberi();
			if (alberi != null && alberi.size() != 0) {

				Iterator<Albero> it = alberi.iterator();
				while (it.hasNext()) {
					Albero albero = it.next();
			%>
			<div class="cardKit">
				<img src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[z].getNomeFoto()%>"
					onerror="this.src='./resources/img/error.jpg'" alt="Avatar"
					class="image">
				<div class="overlay">
					<a href="Prodotto?action=leggiProdotto&id=<%=albero.getId()%>"><%=albero.getNome()%></a>
				</div>
			</div>
			<%
			z++;
			}
			}
			%>
		</div>
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
			<a class="btn btn-primary text-center m-3" href="Catalogo"
				role="button">Vedi tutti gli alberi</a>
		</div>
	</div>

	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

</body>
</html>