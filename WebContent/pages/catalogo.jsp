<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> foto = (Collection<?>) request.getAttribute("fotoProdotti");

Collection<?> categorie = (Collection<?>) request.getAttribute("categorie");
Collection<?> usiLocali = (Collection<?>) request.getAttribute("usiLocali");

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
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="resources/img/logo.png">
</head>
<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<br>

	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fa-solid fa-arrow-up"></i> Torna su
	</button>



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
		<div
			class="row row-cols-1  row-cols-sm-2  row-cols-md-3 row-cols-lg-6 g-4 ">
			<!-- Prezzo -->
			<div class="dropdown">
				<a class="btn btn-primary dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">Prezzo </a>

				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						href="Catalogo?action=prezzo&sort=prezzo DESC">Prezzo più alto</a></li>
					<li><a class="dropdown-item"
						href="Catalogo?action=prezzo&sort=prezzo ASC">Prezzo più basso</a></li>
				</ul>
			</div>
			<!-- Categoria -->
			<div class="dropdown">
				<a class="btn btn-primary dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">Categoria </a>

				<ul class="dropdown-menu">
					<%
					if (categorie != null || categorie.size() != 0) {
						Iterator<?> it2 = categorie.iterator();

						while (it2.hasNext()) {
							Categoria cat = (Categoria) it2.next();
					%>
					<li><a class="dropdown-item"
						href="Catalogo?action=categoria&categoria=<%=cat.getId()%>"><%=cat.getNome()%></a></li>
					<%
					}
					}
					%>
				</ul>
			</div>
			<!-- Paese -->
			<div class="dropdown">
				<a class="btn btn-primary dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">Paesi </a>

				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						href="Catalogo?action=paese&paese=Guatemala">Guatemala</a></li>
					<li><a class="dropdown-item"
						href="Catalogo?action=paese&paese=Italia">Italia</a></li>
					<li><a class="dropdown-item"
						href="Catalogo?action=paese&paese=Perù">Perù</a></li>
						<li><a class="dropdown-item"
						href="Catalogo?action=paese&paese=Argentina">Argentina</a></li>
				</ul>
			</div>
			<!-- Usi -->
			<div class="dropdown">
				<a class="btn btn-primary dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">Usi locali </a>

				<ul class="dropdown-menu">
					<%
					if (usiLocali != null && usiLocali.size() != 0) {
						Iterator<?> it3 = usiLocali.iterator();

						while (it3.hasNext()) {
							UsoLocale uso = (UsoLocale) it3.next();
					%>
					<li><a class="dropdown-item"
						href="Catalogo?action=usoLocale&usoLocale=<%=uso.getNome()%>"><%=uso.getNome()%></a></li>

					<%
					}
					}
					%>
				</ul>
			</div>
		</div>


		<!-- Sezione Prodotti -->
		<br>
		<div class="m-3" id="sezioneAlberi">
			<h1 class="text-center">Alberi</h1>
			<p class="text-center">Anche tu puoi fare la tua parte creando la
				tua foresta. Inizia piantando il primo albero!</p>
			<%
			if (prodotti == null || prodotti.size() == 0) {
			%>
			<p class="text-danger m-5">Non ci sono alberi che corrispondono
				alla tua ricerca</p>
			<%
			}
			%>
			<div
				class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3"
				id="catalogo">
				<%
				if (prodotti != null && prodotti.size() != 0) {
					Iterator<?> it = prodotti.iterator();
					Iterator<?> it1 = foto.iterator();
					while (it.hasNext() && it1.hasNext()) {
						Albero bean = (Albero) it.next();
						FotoProdotto bean1 = (FotoProdotto) it1.next();
				%>
				<!-- Card  -->
				<div
					class="col-lg-3 col-md-6 col-xs-12 col-sm-6
                            col-xs-12 d-flex justify-content-center">

					<div class="card text-center"
						style="max-width: 18rem; border-radius: 25px;">
						<img
							src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=bean1.getNomeFoto()%>"
							onerror="this.src='./resources//img/error.jpg'"
							class="card-img-top" />
						<div class="card-body">
							<h5 class="card-title"><%=bean.getNome()%></h5>
							<p class="card-text">
								<strong>CO<sub>2</sub></strong>:
								-<%=bean.getCo2()%>
								kg
							</p>
						</div>
						<ul class="list-group list-group-light list-group-small">
							<li class="list-group-item px-4"><strong>Prezzo:</strong> <%=dFormat.format(bean.getPrezzo())%>
								€</li>
						</ul>
						<div class="card-body">
							<a href="Prodotto?action=leggiProdotto&id=<%=bean.getId()%>"
								class="btn btn-rounded"
								style="background-color: #5E7250; color: white">Scopri di
								più!</a>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

	<script type="text/javascript">
		// per animare il button torna su
		//Get the button:
		mybutton = document.getElementById("myBtn");

		// When the user scrolls down 20px from the top of the document, show the button
		window.onscroll = function() {
			scrollFunction()
		};

		function scrollFunction() {
			if (document.body.scrollTop > 20
					|| document.documentElement.scrollTop > 20) {
				mybutton.style.display = "block";
			} else {
				mybutton.style.display = "none";
			}
		}

		// When the user clicks on the button, scroll to the top of the document
		function topFunction() {
			document.body.scrollTop = 0; // For Safari
			document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
		}
	</script>
	<!-- Cambiare src on hover -->
	<script>
		$(".img-social").hover(function() {
			$(this).attr("src", function(index, attr) {
				return attr.replace(".png", "-active.png");
			})
		}, function() {
			$(this).attr("src", function(index, attr) {
				return attr.replace("-active.png", ".png");
			});
		});
	</script>
</body>
</html>