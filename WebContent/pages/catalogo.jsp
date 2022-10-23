<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> foto = (Collection<?>) request.getAttribute("fotoProdotti");

Collection<?> categorie = (Collection<?>) request.getAttribute("categorie");
Collection<?> kits = (Collection<?>) request.getAttribute("kits");
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
<style>
#regali .card:hover {
	transform: scale(1.1);
}

#regali {
	background-color: #93c572;
}

#regali .card {
	transition: transform 0.2s ease;
}

#myBtn {
	display: none; /* Hidden by default */
	position: fixed; /* Fixed/sticky position */
	bottom: 20px; /* Place the button at the bottom of the page */
	right: 30px; /* Place the button 30px from the right */
	z-index: 99; /* Make sure it does not overlap */
	border: none; /* Remove borders */
	outline: none; /* Remove outline */
	background-color: #93c572; /* Set a background color */
	color: white; /* Text color */
	cursor: pointer; /* Add a mouse pointer on hover */
	padding: 15px; /* Some padding */
	border-radius: 10px; /* Rounded corners */
	font-size: 18px; /* Increase font size */
}

#myBtn:hover {
	background-color: #c4d89d; /* Add a dark-grey background on hover */
}

.badgeImg {
	-webkit-filter: grayscale(100%); /* Safari 6.0 - 9.0 */
	filter: grayscale(100%);
}

#zodiaco img:hover {
	border-color: #E1EBEE;
	box-shadow: 0px 0px 10px 2px rgb(13, 110, 253);
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
			class="row row-cols-1  row-cols-sm-2  row-cols-md-3 row-cols-lg-6 g-4">
			<!-- Prezzo -->
			<div class="btn-group" role="group"
				aria-label="Button group with nested dropdown">
				<button type="button" class="btn btn-primary">Prezzo</button>
				<div class="btn-group" role="group">
					<button id="btnGroupDrop1" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
						<a class="dropdown-item"
							href="Catalogo?action=prezzo&sort=prezzo DESC">Prezzo più
							alto</a> <a class="dropdown-item"
							href="Catalogo?action=prezzo&sort=prezzo ASC">Prezzo più
							basso</a>
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
						if (categorie != null || categorie.size() != 0) {
							Iterator<?> it2 = categorie.iterator();

							while (it2.hasNext()) {
								Categoria cat = (Categoria) it2.next();
						%>
						<a class="dropdown-item"
							href="Catalogo?action=categoria&categoria=<%=cat.getId()%>"><%=cat.getNome()%></a>
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
							in Saldo</a>
						<hr class="dropdown-divider">
						<a class="dropdown-item" href="Catalogo?action=vediKit">Kit</a><a
							class="dropdown-item" href="Catalogo?action=vediAlberi">Alberi</a>
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
						<a class="dropdown-item"
							href="Catalogo?action=paese&paese=Guatemala">Guatemala</a> <a
							class="dropdown-item" href="Catalogo?action=paese&paese=Italia">Italia</a>
						<a class="dropdown-item" href="Catalogo?action=paese&paese=Perù">Perù</a>
					</div>
				</div>
			</div>

			<!-- Usi -->
			<div class="btn-group" role="group"
				aria-label="Button group with nested dropdown">
				<button type="button" class="btn btn-primary">Usi</button>
				<div class="btn-group" role="group">
					<button id="btnGroupDrop1" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
						<%
						if (usiLocali != null && usiLocali.size() != 0) {
							Iterator<?> it3 = usiLocali.iterator();

							while (it3.hasNext()) {
								UsoLocale uso = (UsoLocale) it3.next();
						%>
						<a class="dropdown-item"
							href="Catalogo?action=usoLocale&usoLocale=<%=uso.getNome()%>"><%=uso.getNome()%></a>
						<%
						}
						}
						%>
					</div>
				</div>
			</div>
		</div>

		<!-- Sezione Prodotti -->
		<br>
		<div class="m-3" id="sezioneAlberi">
			<h1 class="text-center">Alberi</h1>
			<p class="text-muted text-center">Anche tu puoi fare la tua parte
				creando la tua foresta. Inizia piantando il primo albero!</p>
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
				<div class="col ">
					<div class="card h-100">
						<img
							src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=bean1.getNomeFoto()%>"
							onerror="this.src='./resources//img/error.jpg'"
							class="img-prod card-img-top <%if (!bean.isDisponibile())%> badgeImg"
							alt="..." />
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
								<a
									class="btn <%if (bean.isDisponibile()) {%> btn-success <%} else {%> btn-dark <%}%>position-relative"
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
								<%
								if (!bean.isDisponibile()) {
								%>
								<p class="m-2">Questo prodotto non è attualmente disponibile</p>
								<%
								}
								%>
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

		<!-- Sezione Kit -->
		<div class="m-3" id="sezioneKit">
			<h1 class="text-center m-2">Kit</h1>
			<p class="text-muted text-center">Paghi una sola volta e dai vita
				alla tua foresta. Potrai seguire la crescita di ogni singolo albero.
			</p>
			<%
			if (kits == null || kits.size() == 0) {
			%>
			<p class="text-danger m-5">Non ci sono kit che corrispondono alla
				tua ricerca</p>
			<%
			}
			%>
			<div
				class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
				<%
				if (kits != null && kits.size() != 0) {
					Iterator<?> it2 = kits.iterator();
					while (it2.hasNext()) {
						KitAlberi kit = (KitAlberi) it2.next();
				%>
				<!-- Card  -->
				<div class="col ">
					<div class="card h-100">
						<img
							src="./ServletResources?codiceAzione=fotoKit&idKit=<%=kit.getId()%>"
							onerror="this.src='./resources//img/error.jpg'"
							class="card-img-top <%if (!kit.isDisponibile())%> badgeImg"
							alt="..." />
						<div class="card-body">
							<h5 class="card-title text-center"><%=kit.getNome()%>

							</h5>
							<p class="card-text text-center"><%=kit.getDescrizione()%></p>
							<p class="card-text text-center"><%=dFormat.format(kit.getPrezzoKit())%>
								€
							</p>
							<div class="text-center">
								<a
									class="btn <%if (kit.isDisponibile()) {%> btn-success <%} else {%> btn-dark <%}%>position-relative"
									href="Prodotto?action=leggiKit&idKit=<%=kit.getId()%>">Piantalo
									Ora </a>
								<%
								if (!kit.isDisponibile()) {
								%>
								<p class="m-2">Questo prodotto non è attualmente disponibile</p>
								<%
								}
								%>
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
	</div>

	<div class="b-example-divider"></div>

	<!-- Sezione Regalo -->
	<div class="container px-4 py-5">
		<h2 class="pb-2 border-bottom">Riscatta. Scopri. Segui.
			Riscattare un albero è bello.</h2>
		<div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
			<div class="feature col">
				<div class="feature-icon bg-primary bg-gradient fs-1">
					<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
						class="bi " width="1em" height="1em">
						<path
							d="M16 17v-1h-3v-3h3v2h2v2h-1v2h-2v2h-2v-3h2v-1h1zm5 4h-4v-2h2v-2h2v4zM3 3h8v8H3V3zm2 2v4h4V5H5zm8-2h8v8h-8V3zm2 2v4h4V5h-4zM3 13h8v8H3v-8zm2 2v4h4v-4H5zm13-2h3v2h-3v-2zM6 6h2v2H6V6zm0 10h2v2H6v-2zM16 6h2v2h-2V6z"></path></svg>
				</div>
				<h2>Riscatta l'albero</h2>
				<p>È facile! inserisci il codice alfanumerico (Treecode) o
					scannerizza il QRcode che trovi nel biglietto cartaceo che ti è
					stato consegnato. Oppure clicca il link nella email o nel messaggio
					che ti è stato inviato.</p>
			</div>
			<div class="feature col">
				<div class="feature-icon bg-primary bg-gradient">
					<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
						class="bi" width="1em" height="1em">
						<path
							d="M16.222 7.575l.122 1.615 1.605.216C19.182 9.573 20 10.55 20 11.587c0 1.048-.84 2.035-2.078 2.182l-1.459.173-.271 1.444c-.125.666-.776 1.28-1.678 1.28a1.774 1.774 0 01-1.324-.57l-1.483-1.64-1.483 1.64c-.307.34-.776.57-1.323.57-1.026 0-1.7-.766-1.707-1.525V15.127c.001-.024.004-.089.004-.16v-1.531l-1.477-.4C4.668 12.751 4 11.866 4 10.922c0-1.087.908-2.114 2.232-2.199l1.525-.098.306-1.498C8.414 5.407 10.043 4 12.113 4c2.25 0 3.963 1.653 4.109 3.575zM13 18.358c.462.198.974.309 1.514.309 1.82 0 3.333-1.257 3.644-2.912C20.32 15.498 22 13.73 22 11.587c0-2.123-1.644-3.874-3.784-4.163C17.986 4.394 15.342 2 12.113 2c-2.978 0-5.46 2.036-6.01 4.727C3.816 6.874 2 8.694 2 10.922c0 1.926 1.351 3.545 3.198 4.044 0 .028 0 .054-.002.08a1.844 1.844 0 00-.002.081c0 1.953 1.657 3.54 3.707 3.54.78 0 1.502-.23 2.099-.623v4.067a1 1 0 102 0v-3.753z"></path></svg>
				</div>
				<h2>Scopri l’albero</h2>
				<p>Ecco il tuo regalo, un albero tutto per te e per il pianeta.
					Scopri chi te lo ha regalato e la dedica che ti ha scritto.</p>

			</div>
			<div class="feature col">
				<div class="feature-icon bg-primary bg-gradient">
					<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
						class="bi" width="1em" height="1em">
						<path
							d="M20.005 2C21.107 2 22 2.898 22 3.99v16.02c0 1.099-.893 1.99-1.995 1.99H4v-4H2v-2h2v-3H2v-2h2V8H2V6h2V2h16.005zM8 4H6v16h2V4zm12 0H10v16h10V4z"></path></svg>
				</div>
				<h2>Segui la sua storia</h2>
				<p>Adesso puoi finalmente scoprire tutto del tuo albero nel suo
					Diario: una pagina on line dove puoi seguire la storia del progetto
					che l’albero contribuirà a realizzare insieme a tanti altri, così
					come curiosità sulla specie a cui appartiene. Inoltre vedrai la
					foto dell' albero nel momento in cui viene piantato e conoscerai il
					luogo esatto in cui crescerà..</p>

			</div>
		</div>
	</div>


	<div class="container" id="regali">
		<h1 class="text-center p-3">Ogni occasione è quella giusta!</h1>

		<div
			class="row row-cols-2 row-cols-lg-6 row-cols-md-4  g-2 d-flex justify-content-center text-center">
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/laurea.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Laurea</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#laurea">Scopri di piu!</a>
					</div>
				</div>
			</div>

			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/natale.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Natale</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#natale">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/oroscopo.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Oroscopo</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#oroscopo">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/bomboniere.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Bomboniere</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#bomboniere">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/nascita.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Nascita</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#nascita">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/ricorrenze.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Ricorrenze</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#ricorrenze">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/compleanno.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Compleanni</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#compleanni">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/perAmore.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Per Amore</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#amore">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/matrimoni.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Matrimoni</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#matrimonio">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/regaliSolidali.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Regali Solidali</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#solidali">Scopri di piu!</a>
					</div>
				</div>
			</div>

			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/famiglia.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Per la famiglia</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#famiglia">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<div class="col p-2">
				<div class="card h-100">
					<div class="text-center">
						<img src="resources/img/catalogo/anniversari.png" alt="..."
							width="93px" height="93px">
					</div>
					<div class="card-body">
						<h5 class="card-title">Anniversari</h5>
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#anniversario">Scopri di piu!</a>
					</div>
				</div>
			</div>
			<a type="button" class="btn btn-primary m-5" href="Catalogo">Regala
				un albero!</a>
		</div>
	</div>

	<div class="container px-4 py-5">
		<h2 class="pb-2 border-bottom">Lo sapevi che...</h2>
		<div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
			<div class="feature col">
				<div class="feature-icon bg-primary bg-gradient fs-1">
					<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
						class="bi" width="1em" height="1em">
						<path
							d="M17.363 11.045a3.615 3.615 0 015.084 0 3.55 3.55 0 010 5.047L17 21.5l-5.447-5.408a3.55 3.55 0 010-5.047 3.615 3.615 0 015.084 0l.363.36.363-.36zm1.88-6.288a5.995 5.995 0 011.689 3.338A5.613 5.613 0 0017 8.808a5.617 5.617 0 00-6.856.818 5.55 5.55 0 00-.178 7.701l.178.185 2.42 2.404L11 21.485l-8.48-8.492A6 6 0 0111 4.529a5.998 5.998 0 018.242.228z"></path></svg>
				</div>
				<h2>Esistono alberi per le coppie!</h2>
				<p>Piantali lasciando che mettano solide radici e crescano
					facendo del bene al pianeta e a chi se ne prenderà cura.
					Conservando per sempre il vostro sentimento.</p>
				<p>
					<strong>Potrai scegliere se regalare uno o entrambi gli
						alberi a chi vuoi.</strong>
				</p>

			</div>
			<div class="feature col">
				<div class="feature-icon bg-primary bg-gradient">
					<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
						class="bi" width="1em" height="1em">
						<path
							d="M14.256 21.744L12 24l-2.256-2.256C5.31 20.72 2 16.744 2 12 2 6.48 6.48 2 12 2s10 4.48 10 10c0 4.744-3.31 8.72-7.744 9.744zm-8.233-6.328C7.491 17.606 9.695 19 12.16 19c2.464 0 4.669-1.393 6.136-3.584A8.968 8.968 0 0012.16 13a8.968 8.968 0 00-6.137 2.416zM12 11a3 3 0 100-6 3 3 0 000 6z"></path></svg>
				</div>
				<h2>L’alberò risulterà piantato da te e custodito dal
					destinatario!</h2>
				<p>Il regalo sarà consegnato solo quando il destinatario
					accetterà di riceverlo. Solo a quel punto l’albero figurerà nella
					sezione “Regalati” del tuo profilo e risulterà piantato da te e
					custodito dalla persona che lo avrà ricevuto in regalo.</p>

			</div>
			<div class="feature col">
				<div class="feature-icon bg-primary bg-gradient">
					<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"
						class="bi" width="1.5em" height="1.5em">
						<path fill-rule="evenodd" clip-rule="evenodd"
							d="M14.76 5.131a6.052 6.052 0 00-2.43-.506c-3.003 0-5.507 2.188-6.06 5.082-2.31.158-4.14 2.115-4.14 4.51 0 2.071 1.363 3.811 3.226 4.349l-.002.086a2.111 2.111 0 00-.003.086c0 2.1 1.672 3.806 3.74 3.806.786 0 1.515-.248 2.118-.67v5.448h2.017v-4.59a5.03 5.03 0 01-1.914-3.323 5.724 5.724 0 01-3.266-5.191c0-2.706 1.859-4.992 4.374-5.58a7.529 7.529 0 012.34-3.507zm1.131.645a6.311 6.311 0 00-2.501 3.931c-2.309.158-4.14 2.115-4.14 4.51 0 2.071 1.363 3.811 3.226 4.348 0 .03 0 .058-.002.087l-.002.086c0 1.846 1.292 3.388 3.01 3.733 1.499-.302 2.676-1.52 2.947-3.058 2.181-.276 3.876-2.178 3.876-4.48 0-2.283-1.659-4.166-3.817-4.477a6.316 6.316 0 00-2.597-4.68z"></path>
						<path fill-rule="evenodd" clip-rule="evenodd"
							d="M20.346 22.212c.466.213.983.332 1.527.332 1.836 0 3.362-1.351 3.676-3.13 2.181-.277 3.876-2.18 3.876-4.482 0-2.282-1.659-4.165-3.817-4.476-.232-3.258-2.899-5.831-6.157-5.831-3.004 0-5.507 2.188-6.062 5.082-2.308.158-4.14 2.115-4.14 4.51 0 2.071 1.364 3.811 3.227 4.349l-.002.086c-.002.028-.003.056-.003.086 0 2.1 1.672 3.806 3.74 3.806.786 0 1.516-.248 2.118-.67v5.448h2.017v-5.11z"></path></svg>
				</div>
				<h2>Puoi regalare un kit di alberi!</h2>
				<p>I Kit ti permettono di piantare più alberi con un solo click.
					Ci sono vari Kit, ciascuno contenente un diverso numero di alberi
					di diverse specie. Puoi regalare l’intero Kit o individualmente i
					singoli alberi che lo compongono.</p>
			</div>
		</div>
	</div>

	<div class="b-example-divider"></div>

	<div class=" container text-white" style="background-color: #191970;"
		id="zodiaco">
		<h1 class="text-center">Di che albero sei?</h1>
		<p class="text-center mb-5 border-bottom">Ogni segno zodiacale ha
			il proprio albero. Sono gli Alberi dell’Oroscopo. Scopri il tuo,
			piantalo e ricevi per un intero anno i contenuti speciali
			dell’Oroscopo degli Alberi!</p>

		<div
			class="row text-center row-cols-2 row-cols-lg-6 row-cols-md-4  g-2">
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/aries.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero dell'ariete">Albero
						dell'ariete</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/taurus.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero del toro">Albero
						del Toro</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/gemini.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero dei gemelli">Albero
						dei Gemelli</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/cancer.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero del cancro">Albero
						del Cancro</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/leo.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero del leone">Albero
						del Leone</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/virgo.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero della vergine">Albero
						della Vergine</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/libra.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero della bilancia">Albero
						della Bilancia</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/scorpio.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero dello scorpione">Albero
						dello scorpione</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/sagittarius.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero del sagittario">Albero
						del Sagittario</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/capricorn.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero del Capricorno">Albero
						del Capricorno</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/aquarius.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero dell'Acquario">Albero
						dell'Acquario</a>
				</p>
			</div>
			<div class="col">
				<img class="bd-placeholder-img rounded-circle" width="140"
					style="background-color: #00008B;" height="140"
					src="resources/img/catalogo/segniZodiacali/pisces.png">
				<p class="m-1">
					<a href="Catalogo?action=vediAlbero&s=Albero dei Pesci">Albero
						dei Pesci </a>
				</p>
			</div>
		</div>

	</div>

	<div class="b-example-divider"></div>

	<div class="container">
		<h1 class="text-center m-1">Domande frequenti</h1>

		<div class="accordion" id="accordionExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseOne"
						aria-expanded="true" aria-controls="collapseOne">Come
						posso regalare un albero?</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse"
					aria-labelledby="headingOne" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>Per regalare un albero devi prima averlo acquistato. Una
							volta effettuato l’acquisto, l'albero può essere regalato in
							qualsiasi momento. Per farlo, accedi al tuo profilo, entra nella
							sezione dedicata ai tuoi alberi e clicca sull’albero che vuoi
							regalare. Qui potrai scegliere la modalità di consegna che
							preferisci tra messaggio, e-mail, o bigliettino da stampare. Se
							vuoi consegnare al volo il tuo regalo ti consigliamo di farlo con
							un messaggio. In pochi passaggi ti verrà mostrato un link da
							inviare al destinatario del regalo tramite Whatsapp, Messenger,
							SMS o qualunque tipo di messaggio privato. Se scegli di regalare
							un albero via e-mail devi semplicemente indicare l’indirizzo
							e-mail del destinatario, scegliere la data di consegna del tuo
							regalo e la lingua in cui inviare l’e-mail. L'e-mail partirà in
							automatico nel giorno e orario da te scelto. Se invece preferisci
							regalare il tuo albero con un bigliettino da stampare, nella
							sezione dedicata potrai vedere le anteprime dei biglietti e le
							lingue disponibili. Dopo aver scelto il biglietto segui le
							istruzioni per scaricarlo e stamparlo: il biglietto infatti non
							ti viene inviato via e-mail, ma puoi scaricarlo e stamparlo in
							qualsiasi momento e quante volte vuoi. Potrai scrivere a mano i
							tuoi auguri sul biglietto e consegnarlo al destinatario del
							regalo. FAI ATTENZIONE Il regalo sarà consegnato solo quando il
							destinatario accetterà di riceverlo. A quel punto l’albero
							figurerà nella sezione “Regalati” del tuo profilo. Fino a quel
							momento l’albero rimarrà nella sezione “Tuoi” del tuo profilo.</p>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseTwo"
						aria-expanded="false" aria-controls="collapseTwo">Chi
						riceve il regalo si deve iscrivere?</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse"
					aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>Sì, per ricevere in regalo un albero il destinatario deve
							iscriversi (o effettuare il login nel caso in cui sia già
							iscritto). Grazie all’iscrizione, il destinatario potrà seguire
							l’albero dal proprio profilo e ricevere gli aggiornamenti.
							Durante la procedura di riscatto, il sito fornirà tutte le
							indicazioni per creare un nuovo account, qualora il destinatario
							non ne avesse già uno.</p>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingThree">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseThree"
						aria-expanded="false" aria-controls="collapseThree">Ho
						sbagliato la procedura di regalo. Come posso rimediare?</button>
				</h2>
				<div id="collapseThree" class="accordion-collapse collapse"
					aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>La procedura di regalo può essere facilmente modificata.
							Per farlo, accedi al tuo profilo, entra nella sezione dedicata ai
							tuoi alberi e clicca sull’albero che avevi scelto di regalare.
							Qui potrai annullare la procedura di regalo e rifarla
							correttamente.</p>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingFour">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseFour"
						aria-expanded="false" aria-controls="collapseThree">Cosa
						posso fare se il destinatario non ha ricevuto l' e-mail con il mio
						regalo?</button>
				</h2>
				<div id="collapseFour" class="accordion-collapse collapse"
					aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>Per prima cosa controlla lo stato di consegna dell’albero.
							Per farlo, accedi al tuo profilo, entra nella sezione dedicata ai
							tuoi alberi e clicca sull’albero che hai regalato. Se l’albero
							risulta consegnato, nella tua casella di posta troverai un’e-mail
							di conferma dell’avvenuta consegna. Controlla qui di aver
							inserito correttamente l’indirizzo e-mail del destinatario; se ti
							accorgi che l’indirizzo è sbagliato, dal sito puoi annullare e
							rifare correttamente la procedura di regalo. Se invece
							l’indirizzo e-mail del destinatario è corretto, è possibile che
							l’e-mail sia finita nella sezione delle promozioni o dello spam.
							Invita quindi il destinatario a ricontrollare nella propria
							casella di posta elettronica senza trascurare queste sezioni.</p>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingFive">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseFive"
						aria-expanded="false" aria-controls="collapseThree">Ho
						ricevuto un albero in regalo. Cosa devo fare?</button>
				</h2>
				<div id="collapseFive" class="accordion-collapse collapse"
					aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>Se hai ricevuto l’albero con un biglietto o con gadget vai
							all’indirizzo web indicato: qui ti verrà chiesto di attivare il
							codice che trovi sul biglietto o sul gadget e, seguendo poche
							semplici istruzioni, potrai vedere il tuo albero. Tieni presente
							che per vedere l’albero è necessario iscriversi (se non hai già
							un profilo su WoodLot) o accedere con le credenziali che hai
							scelto al momento dell’iscrizione. Se hai ricevuto l’albero via
							mail, nella mail trovi il tasto “ritira il tuo regalo”: cliccaci
							e ti verranno date le istruzioni per creare un account o accedere
							a quello che hai già, dopodichè l’albero apparirà nella sezione
							“alberi - tuoi” del tuo profilo. Se invece hai ricevuto l’albero
							via messaggio, nel messaggio trovi un tasto o un link: cliccaci e
							arriverai direttamente nella sezione dedicata al tuo regalo, dove
							seguendo poche semplici istruzioni potrai vederlo. Tieni presente
							che per vedere l’albero è necessario iscriversi (se non hai già
							un profilo su WoodLot) o accedere con le credenziali che hai
							scelto al momento dell’iscrizione. In tutti i casi, questa
							procedura devi effettuarla solo la prima volta. In futuro potrai
							sempre vedere il tuo albero all’interno del tuo profilo,
							semplicemente effettuando l’accesso con le credenziali con cui ti
							sei iscritto.</p>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingSix">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseSix"
						aria-expanded="false" aria-controls="collapseThree">Posso
						annullare un regalo?</button>
				</h2>
				<div id="collapseSix" class="accordion-collapse collapse"
					aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>Sì, per farlo accedi con le tue credenziali. Vai sulla
							pagina del tuo profilo e clicca sull'albero che non vuoi più
							regalare. Nella pagina dell’albero che non vuoi più regalare
							clicca sul pulsante "In consegna" per accedere alla schermata in
							cui troverai il comando “Annulla il processo di regalo”.</p>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingSeven">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseSeven"
						aria-expanded="false" aria-controls="collapseThree">Cos’è
						un Albero dell’Oroscopo?</button>
				</h2>
				<div id="collapseSeven" class="accordion-collapse collapse"
					aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>Ad ogni segno dello Zodiaco è associato un albero con il
							suo significato ed una speciale grafica. Ogni Albero
							dell’Oroscopo riceve gli aggiornamenti che parlano della sua
							specie e del progetto di cui fa parte, esattamente come ogni
							altro albero WoodLot, ma riceve in più 12 contenuti, uno al mese
							per un intero anno, dell’Oroscopo degli Alberi.</p>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingEight">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseEight"
						aria-expanded="false" aria-controls="collapseThree">Posso
						regalare un Albero dell’Oroscopo?</button>
				</h2>
				<div id="collapseEight" class="accordion-collapse collapse"
					aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<p>Un Albero dell’Oroscopo può essere regalato esattamente
							come ogni altro albero WoodLot, secondo la normale procedura. Se
							l’albero viene regalato, il nuovo proprietario sarà colui a cui
							verranno notificati gli aggiornamenti, compresi quelli relativi
							all’Oroscopo degli Alberi.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Natale -->
	<div class="modal fade" id="natale" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Per un verde Natale!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/natale.png" width="98" height="98">
							<div>
								<h5 class="mb-0">I regali di Natale possono essere un
									grande incubo di carenza d’idee e code alle casse. Per non
									parlare dei regali per Natale originali e divertenti; quelli
									possono diventare un vero miraggio. Regalare un albero per
									Natale è la soluzione ideale per trasformare l’incubo in un
									sogno ed il miraggio in realtà.</h5>

							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Laurea -->
	<div class="modal fade" id="laurea" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Regali con lode!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/laurea.png" width="98" height="98">
							<div>
								<h5 class="mb-0">Dottore o Dottoressa che sia, di sicuro si
									merita un bel regalo per la laurea. E a qualcuno che si è
									appena laureato non puoi certo permetterti di fare un regalo
									banale! Regalando un albero non corri questo rischio</h5>

							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Oroscopo -->
	<div class="modal fade" id="oroscopo" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Un regalo stellare!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/oroscopo.png" width="98" height="98">
							<div>
								<h5 class="mb-0">Già l’oroscopo celtico associava gli
									alberi ai vari giorni del calendario. Anche noi abbiamo un
									oroscopo degli alberi. Divertiti a scoprire quale albero è
									associato al segno zodiacale delle persone a cui tieni, per
									fargli un regalo sorprendente.</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Bomboniere -->
	<div class="modal fade" id="bomboniere" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Alberi come bomboniere!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/bomboniere.png" width="98"
							height="98">
							<div>
								<h5 class="mb-0">Nascita, battesimo, comunione, cresima,
									laurea, matrimonio; tutte occasioni in cui non è facile trovare
									l’idea giusta per regalare bomboniere agli invitati. Ecco che
									gli alberi diventano una soluzione originale, per un regalo
									adatto a bambini e adulti. Utile, eco e solidale.</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Nascita -->
	<div class="modal fade" id="nascita" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Un albero è vità!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/nascita.png" width="98" height="98">
							<div>
								<h5 class="mb-0">In molte culture, alla nascita di un
									bambino, era tradizione piantare un nuovo albero. Un gesto
									concreto e di grande valenza simbolica. Oggi puoi piantare un
									albero con WoodLot e farne un regalo per neonati o utilizzarlo
									come idea regalo per un battesimo.</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Ricorrenze -->
	<div class="modal fade" id="ricorrenze" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Festeggia con un albero!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/ricorrenze.png" width="98"
							height="98">
							<div>
								<h5 class="mb-0">Non è vero che tutti giorni sono uguali.
									Il calendario è pieno di giornate speciali che meritano di
									essere celebrate. Ognuna di esse, può essere l'occasione giusta
									per regalare un albero!.</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Compleanni -->
	<div class="modal fade" id="compleanni" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Un albero di compleanno!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/compleanno.png" width="98"
							height="98">
							<div>
								<h5 class="mb-0">La canzone è sempre la solita, tanti
									auguri a te! Ma il regalo di compleanno deve essere sempre
									diverso ed avere ogni volta la giusta idea regalo è una bella
									sfida. Un albero può essere proprio quello che cercavi!</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Amore -->
	<div class="modal fade" id="amore" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Alberi per amore!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/perAmore.png" width="98" height="98">
							<div>
								<h5 class="mb-0">LPer far sorridere la tua dolce metà,
									serve un regalo che sia all’altezza del vostro amore. Un
									albero, o meglio ancora una coppia d’alberi! Una perfetta idea
									regalo. Basta un click per piantare e condividere.</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Matrimonio -->
	<div class="modal fade" id="matrimonio" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Alberi per gli sposi!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/matrimoni.png" width="98" height="98">
							<div>
								<h5 class="mb-0">E così hanno deciso di sposarsi. Ora non
									resta che scegliere l’abito per la cerimonia e i
									festeggiamenti. Ma soprattutto si tratta di trovare il giusto
									regalo di matrimonio. Che porti un messaggio d’auguri, che duri
									nel tempo e che sia di buon auspicio. Cosa c’è di meglio che
									regalare un albero per un matrimonio?</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Solidali -->
	<div class="modal fade" id="solidali" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Un albero fa bene!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/regaliSolidali.png" width="98"
							height="98">
							<div>
								<h5 class="mb-0">Non è come regalare una stella. Un albero
									ha solide radici e con WoodLot può diventare una perfetta idea
									regalo. Un regalo solidale ed ecosostenibile. Un regalo per
									offrire un pensiero green ed un gesto concreto.</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Famiglia -->
	<div class="modal fade" id="famiglia" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Un albero di famiglia!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/famiglia.png" width="98" height="98">
							<div>
								<h5 class="mb-0">Fare un regalo a qualcuno di famiglia non
									è mai semplice, anche se si tratta di persone che conosci molto
									bene! Fare di un albero WoodLot il regalo per qualsivoglia
									parente è la soluzione perfetta per sorprenderli tutti!</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Anniversario -->
	<div class="modal fade" id="anniversario" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Un albero è per sempre!</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<li class="d-flex gap-4"><img class="bi"
							src="resources/img/catalogo/anniversari.png" width="98"
							height="98">
							<div>
								<h5 class="mb-0">Un regalo per l’anniversario di un
									matrimonio? Oppure un regalo d’anniversario per chi, comunque,
									ti sopporta da anni? O un regalo per l’anniversario di un
									giorno speciale per te ed i tuoi amici. In ogni caso, regalare
									un albero è il modo perfetto per celebrare degnamente un
									anniversario importante.</h5>
							</div></li>
					</ul>
					<button type="button" class="btn btn-lg btn-primary  w-100"
						data-bs-dismiss="modal">Regala un albero!</button>
				</div>
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
	<script>$(".img-social").hover(function(){
	    $(this).attr("src", function(index, attr){
	        return attr.replace(".png", "-active.png");
	    })
	}, function(){
	    $(this).attr("src", function(index, attr){
	        return attr.replace("-active.png", ".png");
	    });
	});</script>
</body>
</html>