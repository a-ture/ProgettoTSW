
<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> foto = (Collection<?>) request.getAttribute("fotoProdotti");
Collection<?> categorie = (Collection<?>) request.getAttribute("categorie");
if (prodotti == null || foto == null || categorie == null) {
	response.sendRedirect("./Catalogo");
	return;
}
DecimalFormat dFormat = new DecimalFormat("0.00");
%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,it.unisa.beans.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Catalogo</title>
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
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<br>

	<!-- Scritta -->
	<div class="container">
		<div class="col-md-12 text-center">
			<h1>Scegli e pianta i tuoi alberi</h1>
			<p class="lead">Hai mai pensato di piantare un albero? È un gesto
				semplice, ma con un grande impatto. Porterà benefici all'ambiente e
				alle persone, e diventerà un regalo originale per le persone che
				ami. Pianta un albero, rendi il mondo più verde!</p>
			<br> <br>
		</div>

		<!-- Scritta Per Filti -->
		<h5>Scegli l’albero in base alle sue caratteristiche</h5>

		<!-- Filtri -->
		<div>
			<!-- Prezzo -->
			<div class="btn-group" role="group"
				aria-label="Button group with nested dropdown">
				<button type="button" class="btn btn-primary">Prezzo</button>
				<div class="btn-group" role="group">
					<button id="btnGroupDrop1" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
						<a class="dropdown-item" href="Catalogo?sort=prezzo DESC">Prezzo
							più alto</a> <a class="dropdown-item" href="Catalogo?sort=prezzo ASC">Prezzo
							più basso</a>
					</div>
				</div>
			</div>
			<!-- Categoria -->

			<div class="btn-group" role="group"
				aria-label="Button group with nested dropdown">
				<button type="button" class="btn btn-primary">Categoria</button>
				<div class="btn-group" role="group">
					<button id="btnGroupDrop1" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
						<%
						if (categorie != null && categorie.size() != 0) {
							Iterator<?> it2 = categorie.iterator();

							while (it2.hasNext()) {
								Categoria cat = (Categoria) it2.next();
						%>
						<a class="dropdown-item"
							href="Catalogo?categoria=<%=cat.getId()%>"><%=cat.getNome()%></a>
						<%
						}
						}
						%>
					</div>
				</div>
			</div>

			<!-- Tipologia prodotti -->
			<div class="btn-group" role="group"
				aria-label="Button group with nested dropdown">
				<button type="button" class="btn btn-primary">Tipologia
					Prodotti</button>
				<div class="btn-group" role="group">
					<button id="btnGroupDrop1" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
						<a class="dropdown-item" href="Catalogo">Tutti</a> <a
							class="dropdown-item" href="Catalogo?action=saldi">Prodotti
							in Saldo</a> <a class="dropdown-item" href="#">Certificati</a>
					</div>
				</div>
			</div>
			<!-- Paese -->
			<div class="btn-group" role="group"
				aria-label="Button group with nested dropdown">
				<button type="button" class="btn btn-primary">Paese</button>
				<div class="btn-group" role="group">
					<button id="btnGroupDrop1" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
						<a class="dropdown-item" href="Catalogo?paese=Guatemala">Guatemala</a>
						<a class="dropdown-item" href="Catalogo?paese=Italia">Italia</a> <a
							class="dropdown-item" href="Catalogo?paese=Perù">Perù</a>
					</div>
				</div>
			</div>

		</div>
		<!-- Fine Filtri -->

		<!-- Sezione Prodotti -->
		<br>
		<div class="row row-cols-1 row-cols-md-4">
			<%
			if (prodotti != null && prodotti.size() != 0) {
				Iterator<?> it = prodotti.iterator();
				Iterator<?> it1 = foto.iterator();
				while (it.hasNext() && it1.hasNext()) {
					Prodotto bean = (Prodotto) it.next();
					FotoProdotto bean1 = (FotoProdotto) it1.next();
			%>
			<!-- Card  -->
			<div class="col ">
				<div class="card h-100">
					<img src="./GetFotoProdotto?idFoto=<%=bean1.getNomeFoto()%>"
						class="card-img-top"
						onerror="this.src='./resources//img/error.jpg'" />
					<div class="card-body">
						<h5 class="card-title text-center"><%=bean.getNome()%>
							<%
							if (bean.getOnSale() != 0) {
							%><span class="badge mx-2 bg-secondary">In Saldo</span>
							<%
							}
							%>
						</h5>
						<p class="card-text text-center"><%=bean.getDescrizioneBreve()%></p>
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
			} else {
			%>
			<p > Non ci sono prodotti che corrispondo alla tua ricerca =( Riporva!!</p> 
			<%
			}
			%>
		</div>
		<br> <br>
		<!-- Fine Sezione Prodotti -->
	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>