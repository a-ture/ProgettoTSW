<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,it.unisa.beans.*, java.text.*"%>
<%
Collection<?> ordini = (Collection<?>) request.getAttribute("ordini");
Collection<?> utenti = (Collection<?>) request.getAttribute("utenti");
Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> kits = (Collection<?>) request.getAttribute("kits");
Collection<?> categorie = (Collection<?>) request.getAttribute("categorie");
Collection<?> usi = (Collection<?>) request.getAttribute("usi");

if (request.getAttribute("totaleIncassi") == null) {
	response.sendRedirect("./Admin");
	return;
}

double totale = (double) request.getAttribute("totaleIncassi");
DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="resources/css/_bootswatch.scss">
<link rel="stylesheet" type="text/css"
	href="resources/css/styleAdmin.css">

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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- MyScript -->
<script src="resources/scripts/adminScript.js"></script>
<!-- MyScript -->
<script src="resources/scripts/adminScriptTable.js"></script>

<style>
input.invalid {
	background-color: #ffdddd;
}
/* Hide all steps by default: */
.tab {
	display: none;
}
/* Make circles that indicate the steps of the form: */
.step {
	height: 15px;
	width: 15px;
	margin: 0 2px;
	background-color: #bbbbbb;
	border: none;
	border-radius: 50%;
	display: inline-block;
	opacity: 0.5;
}

/* Mark the active step: */
.step.active {
	opacity: 1;
}

/* Mark the steps that are finished and valid: */
.step.finish {
	background-color: #04AA6D;
}
</style>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="resources/img/logo.png">
</head>
<body>
	<div class="container-fluid">
		<nav id="adminNav"
			class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
			<div class="container-fluid">
				<a class="navbar-brand" href="Home">WoodLot</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#dashboard"><i
								class="fas fa-tachometer-alt"> Pannello di Controllo</i></a></li>
						<li class="nav-item dropdown"><a class="nav-link"
							href="#prod"><i class="fas fa-tshirt"> Gestione Prodotti</i></a></li>
						<li class="nav-item"><a class="nav-link" href="#ordine"><i
								class="fas fa-shopping-cart"> Gestione Ordini</i></a></li>
						<li class="nav-item"><a class="nav-link" href="#user"><i
								class="fas fa-user-circle"> Gestione Utenti</i></a></li>
						<li class="nav-item "><a class="nav-link "
							data-bs-toggle="modal" data-bs-target="#exampleModal"><i
								class="fas fa-sign-out-alt"> Log Out</i></a></li>
					</ul>
				</div>
			</div>
		</nav>

		<div id="dashboard">
			<div class="home-content">
				<h1 class="mb-5 border-bottom text-center">Welcome back!</h1>
				<div class="overview-boxes">

					<div class="box">
						<div class="right-side">
							<div class="box-topic">Totale Ordini</div>
							<div class="number"><%=ordini.size()%></div>

						</div>
						<i class='bx bx-cart-alt cart'><i class="fas fa-shopping-cart"></i></i>
					</div>

					<div class="box">
						<div class="right-side">
							<div class="box-topic">Totale Utenti</div>
							<div class="number"><%=utenti.size()%></div>

						</div>
						<i class='bx bxs-cart-add cart two'><i
							class="fas fa-user-circle"> </i></i>
					</div>

					<div class="box">
						<div class="right-side">
							<div class="box-topic">Totale Prodotti</div>
							<div class="number"><%=prodotti.size() + kits.size()%></div>

						</div>
						<i class='bx bx-cart cart three'><i class="fas fa-tshirt">
						</i></i>
					</div>

					<div class="box">
						<div class="right-side">
							<div class="box-topic">Totale Incassi</div>
							<div class="number"><%=dFormat.format(totale)%>€
							</div>

						</div>
						<i class='bx bxs-cart-download cart four'><i
							class="fas fa-money-bill-alt"></i></i>
					</div>
				</div>
			</div>

			<div class="row d-flex justify-content-center my-5">
				<div class="tabb">

					<div class="row mt-2">
						<div class="col">
							<div class="text-center fw-bold h3">Ordini</div>
						</div>
					</div>

					<div class="row mt-1" style="display: flex;">
						<!-- Cerca Per id   -->
						<div class="col-md-3 mx-5">
							<div class="input-group mb-3">
								<input type="text" class="form-control"
									placeholder="Cerca per id" aria-label="Recipient's username"
									aria-describedby="button-addon2" id="myInput1"
									onkeyup="myFunctionId(0,'myInput1','myTable')">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</div>

						<!-- Cerca Per Cliente   -->
						<div class="col-md-3 mx-5">
							<div class="input-group mb-3">
								<input type="text" class="form-control"
									placeholder="Cerca per cliente"
									aria-label="Recipient's username"
									aria-describedby="button-addon2" id="myInput2"
									onkeyup="myFunctionId(1,'myInput2','myTable')">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2">
									<i class="fa-solid fa-magnifying-glass"></i>

								</button>
							</div>
						</div>

						<!-- Cerca Per Data  -->
						<div class="col-md-3 mx-5">
							<div class="input-group mb-3">
								<input type="text" class="form-control"
									placeholder="dd/MM/yy - dd/MM/yy"
									aria-label="Recipient's username"
									aria-describedby="button-addon2" id="myInput3">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2" onclick="myFunctionOrderData()">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</div>
					</div>

					<table class="table" id="myTable">
						<thead>
							<tr>
								<th scope="col">Codice</th>
								<th scope="col">Utente</th>
								<th scope="col">Totale</th>
								<th scope="col">N. Prodotti</th>
								<th scope="col">Data</th>
								<th scope="col">Azioni</th>
							</tr>
						</thead>
						<tbody id="tableBodyOrdini">
							<%
							if (ordini != null && ordini.size() != 0) {
								Iterator<?> it2 = ordini.iterator();
								while (it2.hasNext()) {
									Ordine o = (Ordine) it2.next();
							%>
							<tr>
								<td scope="row" class="nr"><%=o.getId()%></td>
								<td class="utente"><%=o.getUtente().getEmail()%></td>
								<td class="totale"><%=dFormat.format(o.getTotalePagato())%>€</td>
								<td class="nProdotti"><%=o.getTotaleProdotti()%></td>
								<td class="data"><%=o.getCreatoIl()%></td>
								<td><a class="botteneIdOrdine"> <i
										class="fa-solid fa-eye"></i></a> <a class="vediFotoOrdine"><i
										class="fa-solid fa-images"></i></a></td>

							</tr>
							<%
							}
							}
							%>
						</tbody>

					</table>
				</div>
			</div>
			<!-- Ordini -->
			<div id="ordineAlert" class="alert alert-success m-5 d-none"
				role="alert">
				<div class="row">
					<div class="col">
						<h4 class="alert-heading" id="numeroOrdineAlert"></h4>
					</div>
					<div class="col-1 text-end">
						<button type="button" class="btn-close" id="closeOrdineAlert"
							aria-label="Close"></button>
					</div>
				</div>
				<p>L'ordine contiene i seguenti prodotti:</p>
				<ol id="prodottiOrdineAlert"></ol>
				<hr>
				<p class="mb-0" id="dettaglioOrdineAlert"></p>
				<hr>
				<p class="mb-0" id="UtenteOrdineAlert"></p>
			</div>

			<div class="alert alert-success  m-5 d-none" role="alert"
				id="ordineFotoAlert">
				<div class="row">
					<div class="col">
						<h4 class="alert-heading" id="ordineFotoIdAlert"></h4>
					</div>
					<div class="col-1 text-end">
						<button type="button" class="btn-close" id="closeOrdineFotoAlert"
							aria-label="Close"></button>
					</div>
				</div>
				<div class="row">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">Id</th>
								<th scope="col">Nome</th>
								<th scope="col">Prezzo</th>
								<th scope="col">Saldo</th>
								<th scope="col">Quantità</th>
								<th scope="col">Stato</th>
								<th scope="col">Foto</th>
								<th scope="col">Azioni</th>
							</tr>
						</thead>
						<tbody id="tableBody">

						</tbody>
					</table>
				</div>
			</div>

			<div class="row d-flex justify-content-center my-5">
				<div class="tabb">
					<div class="row mt-2">
						<div class="text-center fw-bold h3">Alberi</div>
					</div>
					<div class="row mt-1" style="display: flex;">
						<!-- Cerca Per Id -->
						<div class="col-md-3 m-5">
							<div class="input-group mb-3">
								<input type="text" class="form-control"
									placeholder="Cerca per id" aria-label="Recipient's username"
									aria-describedby="button-addon2" id="myInput4"
									onkeyup="myFunctionId(0,'myInput4','myTable2')">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</div>
						<!-- Cerca Per Paese  -->
						<div class="col-md-3 m-5">
							<div class="input-group mb-3">
								<input type="text" class="form-control"
									placeholder="Cerca per paese" aria-label="Recipient's username"
									aria-describedby="button-addon2" id="myInput5"
									onkeyup="myFunctionId(2,'myInput5','myTable2')">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</div>


						<!-- Cerca Per Disponibile/ In Saldo / Prezzo  -->
						<div class="col-md-3 m-5">
							<div class="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button"
									id="dropdownMenuButton2" data-bs-toggle="dropdown"
									aria-expanded="false">Ordina Per</button>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton3">

									<li onclick="sortTableNumb('myTable2',5)"><a
										class="dropdown-item">Saldo</a></li>
									<li onclick="sortTableNumb('myTable2',6)"><a
										class="dropdown-item">Quantità</a></li>

								</ul>
							</div>
						</div>
					</div>

					<table class="table" id="myTable2">
						<thead>
							<tr>
								<th scope="col">Id</th>
								<th scope="col" onclick="sortTableAlf(1,'myTable2')">Nome</th>
								<th scope="col" onclick="sortTableAlf(2,'myTable2')">Paese</th>
								<th scope="col" onclick="sortTableAlf(3,'myTable2')">Prezzo</th>
								<th scope="col">In saldo</th>
								<th scope="col">Saldo</th>
								<th scope="col">Quantità</th>
								<th scope="col">Azioni</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (prodotti != null && prodotti.size() != 0) {
								Iterator<?> it12 = prodotti.iterator();
								while (it12.hasNext()) {
									Albero a = (Albero) it12.next();
							%>
							<tr>
								<td scope="row" class="nr"><%=a.getId()%></td>
								<td><%=a.getNome()%></td>
								<td><%=a.getPaeseDiOrigine()%></td>
								<td><%=dFormat.format(a.getPrezzo())%>€</td>
								<td><%=a.getOnSale()%></td>
								<td><%=a.getSaldo()%></td>
								<td><%=a.getQuantità()%></td>
								<td><a class="botteneIdProdottoVedi"><i
										class="fa-solid fa-eye"></i></a> <a
									class="botteneIdProdottoModifica"><i
										class="fa-solid fa-pen-to-square"></i></a> <a
									href="Prodotto?action=eliminaAlberoCatalogo&id=<%=a.getId()%>"><i
										class="fa-solid fa-circle-xmark"></i></a> <a class="vediFoto"><i
										class="fa-solid fa-images"></i></a></td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<div id="prodottoAlert" class="alert alert-success m-5 d-none"
				role="alert">
				<div class="row">
					<div class="col">
						<h4 class="alert-heading" id="prodottoIdAlert"></h4>
					</div>
					<div class="col-1 text-end">
						<button type="button" class="btn-close" id="closeProdottoAlert"
							aria-label="Close"></button>
					</div>
				</div>
				<p id="prodottoDescrizioneAlert"></p>
				<hr>
				<p>L'albero ha i seguenti benefici:</p>
				<ol id="prodottoBeneficiAlert"></ol>
				<hr>
				<p>L'albero ha le seguenti categorie:</p>
				<ol id="prodottoCategorieAlert"></ol>
				<hr>
				<p>L'albero ha i seguenti usi locali:</p>
				<ol id="prodottoUsiLocaliAlert"></ol>
				<hr>
			</div>

			<div class="alert alert-success  m-5 d-none" role="alert"
				id="prodottoFotoAlert">
				<div class="row">
					<div class="col">
						<h4 class="alert-heading" id="prodottoFotoIdAlert"></h4>
					</div>
					<div class="col-1 text-end">
						<button type="button" class="btn-close"
							id="closeProdottoFotoAlert" aria-label="Close"></button>
					</div>
				</div>
				<div class="row">
					<div class="col-4">
						<div class="row">
							<img src="" class="rounded " alt="..." id="foto1"
								onerror="this.src='./resources//img/error.jpg'">
						</div>
						<p id="fotoCodice1">Foto n.</p>
						<a class="btn btn-primary my-3 uploadFoto-1"> Upload Foto</a>
					</div>
					<div class="col-4">
						<div class="row">
							<img src="" class="rounded  " alt="..." id="foto2"
								onerror="this.src='./resources//img/error.jpg'">
						</div>
						<p id="fotoCodice2">Foto n.</p>
						<a class="btn btn-primary my-3 uploadFoto-2"> Upload Foto</a>

					</div>
					<div class="col-4">
						<div class="row">
							<img src="" class="rounded  " alt="..." id="foto3"
								onerror="this.src='./resources//img/error.jpg'">
						</div>
						<p id="fotoCodice3">Foto n.</p>
						<a class="btn btn-primary my-3 uploadFoto-3"> Upload Foto</a>
					</div>
				</div>

			</div>

			<div class="row d-flex justify-content-center my-5">
				<div class="tabb">
					<div class="row mt-2">
						<div class="text-center fw-bold h3">Kits</div>
					</div>
					<div class="row mt-1" style="display: flex;">
						<!-- Cerca Per Id -->
						<div class="col-md-3 m-5">
							<div class="input-group mb-3">
								<input type="text" class="form-control"
									placeholder="Cerca per id" aria-label="Recipient's username"
									aria-describedby="button-addon2" id="myInput6"
									onkeyup="myFunctionId(0,'myInput6','myTable4')">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</div>
						<!-- Cerca Per Nome  -->
						<div class="col-md-3 m-5">
							<div class="input-group mb-3">
								<input type="text" class="form-control"
									placeholder="Cerca per nome" aria-label="Recipient's username"
									aria-describedby="button-addon2" id="myInput7"
									onkeyup="myFunctionId(1,'myInput7','myTable4')">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</div>
						<!-- Cerca Per Disponibile/ In Saldo  -->
						<div class="col-md-3 m-5">
							<div class="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button"
									id="dropdownMenuButton1" data-bs-toggle="dropdown"
									aria-expanded="false">Ordina Per</button>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton5">
									<li><a class="dropdown-item" href="#">Disponibilità</a></li>
									<li onclick=""><a class="dropdown-item">Prezzo</a></li>
								</ul>
							</div>
						</div>
					</div>

					<table class="table" id="myTable4">
						<thead>
							<tr>
								<th scope="col">Id</th>
								<th scope="col" onclick="sortTableAlf(1,'myTable4')">Nome</th>
								<th scope="col">Saldo</th>
								<th scope="col">Prezzo Kit</th>
								<th scope="col">Disponibile</th>
								<th scope="col">Azioni</th>
							</tr>
						</thead>
						<%
						if (kits != null && kits.size() != 0) {
							Iterator<?> it13 = kits.iterator();
							while (it13.hasNext()) {
								KitAlberi k = (KitAlberi) it13.next();
						%>
						<tr>
							<td scope="row" class="nr"><%=k.getId()%></td>
							<td><%=k.getNome()%></td>
							<td><%=k.getSaldo()%>%</td>
							<td><%=dFormat.format(k.getPrezzoKit())%>€</td>
							<td><%=k.isDisponibile()%></td>
							<td><a class="botteneIdKitVedi"><i
									class="fa-solid fa-eye"></i></a> <a class="botteneIdKitModifica"><i
									class="fa-solid fa-pen-to-square"></i></a> <a
								href="Prodotto?action=eliminaKitCatalogo&id=<%=k.getId()%>"><i
									class="fa-solid fa-circle-xmark"></i></a></td>
						</tr>
						<%
						}
						}
						%>
					</table>
				</div>
			</div>

			<div id="kitAlert" class="alert alert-success m-5 d-none"
				role="alert">
				<div class="row">
					<div class="col">
						<h4 class="alert-heading" id="kitIdAlert"></h4>
					</div>
					<div class="col-1 text-end">
						<button type="button" class="btn-close" id="closeKitAlert"
							aria-label="Close"></button>
					</div>
				</div>
				<p id="kitDescrizioneAlert"></p>
				<hr>
				<p>Il kit comprende i seguenti alberi:</p>
				<ol id="prdottiKitAlert"></ol>
				<hr>
			</div>

			<div class="row d-flex justify-content-center my-5">
				<div class="tabb">
					<div class="row mt-2">
						<div class="text-center fw-bold h3">Utenti</div>
					</div>

					<table class="table" id="myTable3">
						<thead>
							<tr>
								<th scope="col">Id</th>
								<th scope="col" onclick="sortTableAlf(1,'myTable3')">Username</th>
								<th scope="col" onclick="sortTableAlf(2,'myTable3')">Email</th>
								<th scope="col" onclick="sortTableAlf(3,'myTable3')">Nome</th>
								<th scope="col" onclick="sortTableAlf(4,'myTable3')">Cognome</th>

							</tr>
						</thead>
						<%
						if (utenti != null && utenti.size() != 0) {
							Iterator<?> it14 = utenti.iterator();
							while (it14.hasNext()) {
								Utente u = (Utente) it14.next();
						%>
						<tr>
							<td scope="row"><%=u.getId()%></td>
							<td><%=u.getUsername()%></td>
							<td><%=u.getEmail()%></td>
							<td><%=u.getNome()%></td>
							<td><%=u.getCognome()%></td>

						</tr>
						<%
						}
						}
						%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- Prodotto -->

		<div id="prod" class="text-center fw-bold h3">Gestione Prodotti</div>

		<div class="form  my-5">
			<form action="Prodotto?action=inserisciAlbero"
				class="needs-validation" novalidate autocomplete="off"
				enctype="multipart/form-data" method="POST" id="prodottoForm">

				<div class="tab">
					<!-- Tab 1 -->
					<div class="fw-bold h3">Albero</div>
					<hr>
					<div id="tab1"></div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Nome:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome" name="nome">
							<div class="invalid-feedback">Inserisci un nome valido</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Nome Scientifico:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome scientifico" name="nomeScientifico">
							<div class="invalid-feedback">Inserisci un nome valido</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3">
							<h5>Prezzo:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci il prezzo" name="prezzo">
							<div class="invalid-feedback">Inserisci un prezzo valido</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3">
							<h5>Sottotitolo</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci sottotitolo" name="sottotitolo">
							<div class="invalid-feedback">Inserisci un sottotitolo
								valido</div>
						</div>
					</div>
					<div class="row">
						<div class="col-3">
							<h5>Descrizione Breve:</h5>
						</div>
						<div class="col-9">
							<textarea class="form-control"
								placeholder="Inserisci la descrizione" name="descrizioneBreve"> </textarea>
							<div class="invalid-feedback">Inserisci una descrizione</div>
						</div>
					</div>
					<div class="row">
						<div class="col-3">
							<h5>Descrizione:</h5>
						</div>
						<div class="col-9">
							<textarea class="form-control"
								placeholder="Inserisci la descrizione" name="descrizione"> </textarea>
							<div class="invalid-feedback">Inserisci una descrizione</div>
						</div>

					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>CO2:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome" name="co2">
							<div class="invalid-feedback">Inserisci un numero tra 1 e 5
							</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Salvaguardia:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome" name="salvaguardia">
							<div class="invalid-feedback">Inserisci un numero tra 1 e 5
							</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Altezza:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci l'altezza dell'albero " name="altezza">
							<div class="invalid-feedback">Inserisci un'altezza</div>
						</div>
					</div>
				</div>
				<!-- Tab 2 -->
				<div class="tab">
					<div class="fw-bold h3">Dettagli Prodotto</div>
					<hr>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>OnSale</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci 1 per indicare onSale, 0 viceversa"
								name="onSale">
							<div class="invalid-feedback">Inserisci 1 per indicare
								onSale, 0 viceversa</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Saldo:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci il saldo " name="saldo">
							<div class="invalid-feedback">Inserisci un importo valido</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Quantità:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome scientifico" name="quantità">
							<div class="invalid-feedback">Inserisci una quantità valida</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Tasse:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome" name="tasse">
							<div class="invalid-feedback">Inserisci un importo valido</div>
						</div>
					</div>
				</div>
				<!-- Tab 3 -->
				<div class="tab">
					<div class="fw-bold h3">Paese</div>
					<hr>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Paese:</h5>
						</div>
						<div class="col-9">
							<select class="form-select form-select-sm" name="paese">
								<option selected value="Per&ugrave;">Perù</option>
								<option value="Guatemala">Guatemala</option>
								<option value="Italia">Italia</option>
							</select>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Dove viene piantato:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome scientifico"
								name="doveVienePiantato">
							<div class="invalid-feedback">Inserisci una descrizione</div>
						</div>
					</div>
				</div>
				<!-- Tab 4 -->
				<div class="tab">
					<div class="fw-bold h3">Benefici</div>
					<hr>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Sicurezza alimentare:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome" name="ben1">
							<div class="invalid-feedback">Inserisci un numero da 1 a 5</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Sviluppo sostenibile:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome scientifico" name="ben2">
							<div class="invalid-feedback">Inserisci un numero da 1 a 5</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Assorbimento CO2:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome scientifico" name="ben4">
							<div class="invalid-feedback">Inserisci un numero da 1 a 5</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Sviluppo economico:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci nome" name="ben3">
							<div class="invalid-feedback">Inserisci un numero da 1 a 5</div>
						</div>
					</div>
				</div>
				<!-- Tab 5 -->
				<div class="tab">
					<div class="fw-bold h3">Categoria</div>
					<hr>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Categorie:</h5>
						</div>
						<div class="col-9">
							<select class="form-select" multiple
								aria-label="multiple select example" name="categorie">
								<%
								if (categorie != null && categorie.size() != 0) {
									Iterator<?> it = categorie.iterator();
									while (it.hasNext()) {
										Categoria c = (Categoria) it.next();
								%>
								<option value="cat<%=c.getId()%>"><%=c.getNome()%></option>
								<%
								}
								}
								%>
							</select>
						</div>
					</div>
				</div>
				<!-- Tab 6 -->
				<div class="tab">
					<div class="fw-bold h3">Uso Locale</div>
					<hr>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Usi Locali:</h5>
						</div>
						<div class="col-9">
							<select class="form-select" multiple
								aria-label="multiple select example" name="usi">
								<%
								if (usi != null && usi.size() != 0) {
									Iterator<?> it1 = usi.iterator();
									while (it1.hasNext()) {
										UsoLocale c = (UsoLocale) it1.next();
								%>
								<option value="uso<%=c.getId()%>"><%=c.getNome()%></option>
								<%
								}
								}
								%>
							</select>
						</div>
					</div>
				</div>
				<div class="tab" id="tab2">
					<div class="fw-bold h3">Upload Foto</div>
					<hr>
					<div class="row">
						<div class="col-3">
							<h5>Prima Foto:</h5>
						</div>
						<div class="col-9">
							<input type="file" class="form-control" id="inputGroupFile01"
								name="foto1">
						</div>
					</div>
					<div class="row">
						<div class="col-3">
							<h5>Seconda Foto:</h5>
						</div>
						<div class="col-9">
							<input type="file" class="form-control" id="inputGroupFile02"
								name="foto2">
						</div>
					</div>
					<div class="row">
						<div class="col-3">
							<h5>Terza Foto:</h5>
						</div>
						<div class="col-9">
							<input type="file" class="form-control" id="inputGroupFile03"
								name="foto3">
						</div>
					</div>
				</div>
			</form>

			<div class="container-fluid mt-5">
				<div style="overflow: auto;">
					<div style="float: right;">
						<button class="btn btn-dark" type="button" id="prevBtn"
							onclick="nextPrev(-1)">Previous</button>
						<button class="btn btn-dark" type="button" id="nextBtn"
							onclick="nextPrev(1)">Next</button>
					</div>
				</div>
				<div style="text-align: center; margin-top: 40px;">
					<span class="step"></span> <span class="step"></span> <span
						class="step"></span> <span class="step"></span> <span class="step"></span><span
						class="step"></span>
				</div>
			</div>
		</div>
		<div class="form my-5 d-none" id="uploadFoto">
			<form action="Prodotto?action=aggiornaFotoAlbero"
				enctype="multipart/form-data" method="POST">
				<div class="fw-bold h3">Upload Foto</div>
				<hr>
				<div class="row">
					<div class="col-3">
						<h5>Codice:</h5>
					</div>
					<div class="col-9">
						<input type="text" class="form-control" name="codice"
							id="codiceFotoUpload">
					</div>
				</div>
				<div class="row">
					<div class="col-3">
						<h5>Foto:</h5>
					</div>
					<div class="col-9">
						<input type="file" class="form-control" id="inputGroupFile01"
							name="foto1">
					</div>
				</div>
				<br />
				<div class="row justify-content-center">
					<button type="submit" class="col-3 btn btn-outline-dark">Inserisci</button>

				</div>
			</form>
		</div>
	</div>

	<div class="form my-5">
		<form action="Prodotto?action=inserisciKit" method="POST"
			enctype="multipart/form-data" id="kitForm" name="kitForm"
			onSubmit="return validateKit();">
			<div class="fw-bold h3">Kit</div>
			<hr>
			<div class="row align-items-center d-none" id="idKitForm">
				<div class="col-3 ">
					<h5>Codice:</h5>
				</div>
				<div class="col-9">
					<input class="form-control " type="text"
						placeholder="Inserisci nome" name="idKit">

				</div>
			</div>
			<div class="row align-items-center">
				<div class="col-3 ">
					<h5>Nome:</h5>
				</div>
				<div class="col-9">
					<input class="form-control" type="text"
						placeholder="Inserisci nome" name="nomeKit">
					<div class="invalid-feedback">Inserisci un nome valido</div>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<h5>Descrizione:</h5>
				</div>
				<div class="col-9">
					<textarea class="form-control"
						placeholder="Inserisci la descrizione" name="descrizioneKit"> </textarea>
					<div class="invalid-feedback">Inserisci una descrizione
						adeguata</div>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<h5>Foto:</h5>
				</div>
				<div class="col-9">
					<input type="file" class="form-control" name="fotoKit">
				</div>
			</div>
			<div class="row align-items-center">
				<div class="col-3 ">
					<h5>Saldo:</h5>
				</div>
				<div class="col-9">
					<input class="form-control" type="text"
						placeholder="Inserisci saldo " name="saldoKit">
					<div class="invalid-feedback">Inserisci un importo valido</div>
				</div>
			</div>
			<div class="row align-items-center">
				<div class="col-3 ">
					<h5>Alberi:</h5>
				</div>
				<div class="col-9">
					<select class="form-select" multiple name="alberiKit"
						aria-label="multiple select example">
						<%
						if (prodotti != null && prodotti.size() != 0) {
							Iterator<?> it1 = prodotti.iterator();
							while (it1.hasNext()) {
								Albero c = (Albero) it1.next();
						%>
						<option value="alb<%=c.getId()%>"><%=c.getNome()%></option>
						<%
						}
						}
						%>
					</select>
				</div>
			</div>
			<div class="row justify-content-center mt-4">
				<button type="submit" class="col-3 btn btn-outline-dark"
					id="kitFormButton">Inserisci</button>
			</div>
		</form>
	</div>

	<!-- Sezione Ordine -->
	<div id="ordine" class="text-center fw-bold h3">Gestione Ordine</div>
	<div class="form  my-5 d-none" id="uploadFotoOrdineForm">
		<form action="Admin?action=aggiornaProdottoOrdine"
			enctype="multipart/form-data" method="POST">
			<div class="fw-bold h3">Aggiornamento Alberi</div>
			<hr>
			<div class="row">
				<div class="col-3">
					<h5>Codice:</h5>
				</div>
				<div class="col-9">
					<input type="text" class="form-control" name="codice"
						id="codiceProdottoUpload">
				</div>
			</div>
			<div class="row align-items-center">
				<div class="col-3 ">
					<h5>Stato:</h5>
				</div>
				<div class="col-9">
					<select class="form-select form-select-sm" name="stato">
						<option selected value="seme">Seme</option>
						<option value="vivaio">Vivaio</option>
						<option value="piantato">Piantato</option>
						<option value="fotografato">Fotografato</option>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<h5>Foto:</h5>
				</div>
				<div class="col-9">
					<input type="file" class="form-control" id="inputGroupFile02"
						name="foto">
				</div>
			</div>
			<div class="row justify-content-center mt-4">
				<button type="submit" class="col-3 btn btn-outline-dark">Aggiorna</button>
			</div>
		</form>
	</div>
	<!-- Modal di log out -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<i class="fas fa-sign-out-alt"> Log Out</i>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Sei sicuro di voler uscire?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Annulla</button>
					<a href="Login?action=logout" class="btn btn-dark"> Procedi </a>
				</div>
			</div>
		</div>
	</div>

	<script>
	// per il form
	var currentTab = 0; 
	showTab(currentTab); 

	function showTab(n) {
		
		var x = document.getElementsByClassName("tab");
		x[n].style.display = "block";

		if (n == 0) {
			document.getElementById("prevBtn").style.display = "none";
		} else {
			document.getElementById("prevBtn").style.display = "inline";
		}
		if (n == (x.length - 1)) {
			document.getElementById("nextBtn").innerHTML = "Submit";
		} else {
			document.getElementById("nextBtn").innerHTML = "Next";
		}
		fixStepIndicator(n)
	}

	function nextPrev(n) {
		var x = document.getElementsByClassName("tab");
		if (n == 1 && !validateForm())
			return false;
		x[currentTab].style.display = "none";
		currentTab = currentTab + n;
		
		if (currentTab >= x.length) {
			document.getElementById("prodottoForm").submit();
			return false;
		}
		showTab(currentTab);
	}

	function validateForm() {
		var x, y, i, valid = true;
		x = document.getElementsByClassName("tab");
		y = x[currentTab].getElementsByTagName("input");
		z = x[currentTab].getElementsByTagName("textarea");
		
		for (r = 0; r < z.length; r++) {
			if(z[r].name ==  "descrizione" || z[r].name == "descrizioneBreve" ){
				if (z[r].value != "" && z[r].lenght != 0) {
					z[r].classList.add("was-validated");
					z[r].classList.add("is-valid");
				}
				else {
					z[r].classList.add("is-invalid");
					valid = false;
				}
			}
		}
		
		for (i = 0; i < y.length; i++) {
		
			if(y[i].name ==  "nome" ){
				if (validateNome(y[i])) {
					y[i].classList.add("was-validated");
					y[i].classList.add("is-valid");
				}
				else {
					y[i].classList.add("is-invalid");
					valid = false;
				}
			}
				
			if( y[i].name == "sottotitolo" || y[i].name == "nomeScientifico" || y[i].name=="doveVienePiantato" ){
				if (y[i].value == "") {
					y[i].classList.add("is-invalid");
					valid = false;
				} else {
					y[i].classList.add("is-valid");
					y[i].classList.add("was-validated");
				}
			}
			
			if(y[i].name ==  "prezzo" ){
				if (validatePrice(y[i])) {
					y[i].classList.add("was-validated");
					y[i].classList.add("is-valid");
				}
				else {
					y[i].classList.add("is-invalid");
					valid = false;
				}
			}
			
			if(y[i].name ==  "co2" || y[i].name ==  "salvaguardia" || y[i].name == "ben1"  ||  y[i].name == "ben2"
					||  y[i].name == "ben3" ||  y[i].name == "ben4"){
				if (validate5(y[i])) {
					y[i].classList.add("was-validated");
					y[i].classList.add("is-valid");
				}
				else {
					y[i].classList.add("is-invalid");
					valid = false;
				}
			}
			
			if(y[i].name ==  "altezza"){
				if (validateHeight(y[i])) {
					y[i].classList.add("was-validated");
					y[i].classList.add("is-valid");
				}
				else {
					y[i].classList.add("is-invalid");
					valid = false;
				}
			}
			
			if(y[i].name ==  "tasse" || y[i].name ==  "saldo" || y[i].name=="quantità"){
				if (validateNumber(y[i])) {
					y[i].classList.add("was-validated");
					y[i].classList.add("is-valid");
				}
				else {
					y[i].classList.add("is-invalid");
					valid = false;
				}
			}
			
			if(y[i].name ==  "onSale"){
				if (validateOnSale(y[i])) {
					y[i].classList.add("was-validated");
					y[i].classList.add("is-valid");
				}
				else {
					y[i].classList.add("is-invalid");
					valid = false;
				}
			}
		}
		if (valid) {
			document.getElementsByClassName("step")[currentTab].className += " finish";
		}
		return valid; 
	}

	function fixStepIndicator(n) {
		var i, x = document.getElementsByClassName("step");
		for (i = 0; i < x.length; i++) {
			x[i].className = x[i].className.replace(" active", "");
		}
		x[n].className += " active";
	}
	

	function validateOnSale(y) {
		let regex = /^[01]+$/;
		let str = y.value;
		if (str.match(regex) && str != "") {
			return true;
		} else {
			return false;
		}
	}
	function validateHeight(y) {
		let regex = /^\d{0,9}(\.\d{0,2}){0,1}$/;
		let str = y.value;
		if (str.match(regex) && str != "") {
			return true;
		} else {
			return false;
		}
	}
	
	function validateNome(y) {
		let regex = /^[A-Za-z_ ]+$/;
		let str = y.value;
		if (str.match(regex)) {
			return true;
		} else {
			return false;
		}
	}
	
	function validate5(y) {
		let str = y.value;
		if (str>0 && str<=5) {
			return true;
		} else {
			return false;
		}
	}
	
	function validatePrice(y) {
		let regex = /^\d+(?:[.,]\d+)*$/;
		let str = y.value;
		if (str.match(regex)) {
			return true;
		} else {
			return false;
		}
	}
	
	function validateText(y) {
		let regex = /^[a-zA-Z]([0-9a-zA-Z]){1,10}$/;
		let str = y.value;
		if (regex.test(str)) {
			return true;
		} else {
			return false;
		}
	}
	
	function validateNumber(y) {
		let regex = /^[0-9]+$/;
		let str = y.value;
		if (str.match(regex)) {
			return true;
		} else {
			return false;
		}
	}
	
	function validateKit (){
		var nome =document.kitForm.nomeKit;
		var descrizione =document.kitForm.descrizioneKit;
		var saldo =document.kitForm.saldoKit;
		var valid= true; 
		
		if(!validateNome(nome)){
			nome.classList.add("was-validated");
			nome.classList.add("is-invalid");
			valid=false;
		}else {
			nome.classList.add("was-validated");
			nome.classList.add("is-valid");
		}
		if (descrizione.value == ""){
			descrizione.classList.add("was-validated");
			descrizione.classList.add("is-invalid");
			valid=false;
		}
		else {
			descrizione.classList.add("was-validated");
			descrizione.classList.add("is-valid");
		}
		
		if (!validateNumber(saldo)){
			saldo.classList.add("was-validated");
			saldo.classList.add("is-invalid");
			valid=false;
		}
		else {
			saldo.classList.add("was-validated");
			saldo.classList.add("is-valid");
		}
		return valid;
	}
	
	</script>

	<script>
	
	function myFunctionOrderData() {
		
		$.get('OrdineJSON?action=data&date=' + $("#myInput3").val(), function(resp) {
			printTableOrder(resp);
		}).fail(function() {
			alert("Request failed.");
		});

	}
	
	function printTableOrder(j){
		$("#tableBodyOrdini").empty(); 
		
		j.forEach((e) => {
			$("#tableBodyOrdini").append('<tr> <td scope="row" class="nr">'+e.id+'</td>'+
					'<td>'+e.utente.email+'</td><td>'+e.totalePagato+'</td><td>'+e.totaleProdotti+'</td><td>'+e.creatoIl.date+'</td></tr>'); 
		});
		
	}
	$(document).ready(function() {

		$(".botteneIdKitVedi").click(function() {
			var $row = $(this).closest("tr");
			var $id = $row.find(".nr").text();
			$.get('KitJSON?codice=' + $id, function(resp) {
				printKit(resp);
			}).fail(function() {
				alert("Request failed.");
			});
		});

		$(".botteneIdProdottoVedi").click(function() {
			var $row = $(this).closest("tr");
			var $id = $row.find(".nr").text();
			$.get('ProdottoJSON?action=vista&codice=' + $id, function(resp) {
				printProdotto(resp);
			}).fail(function() {
				alert("Request failed.");
			});
		});

		$(".vediFoto").click(function() {
			var $row = $(this).closest("tr");
			var $id = $row.find(".nr").text();
			$.get('ProdottoJSON?action=vediFoto&codice=' + $id, function(resp) {
				printProdottoFoto(resp);
			}).fail(function() {
				alert("Request failed.");
			});

			$(".uploadFoto-1").click(function() {
				var $nomeFoto = $("#fotoCodice1").html().substring(7);
				$("#codiceFotoUpload").val($nomeFoto);
				$("#uploadFoto").removeClass("d-none")
			});
			$(".uploadFoto-2").click(function() {
				var $nomeFoto = $("#fotoCodice2").html().substring(7);
				$("#codiceFotoUpload").val($nomeFoto);
				$("#uploadFoto").removeClass("d-none")
			});
			$(".uploadFoto-3").click(function() {
				var $nomeFoto = $("#fotoCodice3").html().substring(7);
				$("#codiceFotoUpload").val($nomeFoto);
				$("#uploadFoto").removeClass("d-none")
			});

		});

		$(".vediFotoOrdine").click(function() {
			var $row = $(this).closest("tr");
			var $id = $row.find(".nr").text();

			$.get('OrdineJSON?action=vedi&codice=' + $id, function(resp) {
				printFotoOrdine(resp);
			}).fail(function() {
				alert("Request failed.");
			});

		});

		$(".botteneIdKitModifica").click(function() {
			var $row = $(this).closest("tr");
			var $id = $row.find(".nr").text();
			$.get('KitJSON?action=vista&codice=' + $id, function(resp) {
				printKitForm(resp);
			}).fail(function() {
				alert("Request failed.");
			});
		});

		$(".botteneIdProdottoModifica").click(function() {
			var $row = $(this).closest("tr");
			var $id = $row.find(".nr").text();
			$.get('ProdottoJSON?action=vista&codice=' + $id, function(resp) {
				printProdottoForm(resp);
			}).fail(function() {
				alert("Request failed.");
			});
		});

		$(".botteneIdOrdine").click(function() {
			var $row = $(this).closest("tr");
			var $codice = $row.find(".nr").text();
			$.get('OrdineJSON?action=vedi&codice=' + $codice, function(resp) {
				printDettagliOrdine(resp);
			}).fail(function() {
				alert("Request failed.");
			});
		});

		$("#closeOrdineAlert").click(function() {
			$("#ordineAlert").addClass("d-none");
		});

		$("#closeProdottoAlert").click(function() {
			$("#prodottoAlert").addClass("d-none");
		});

		$("#closeKitAlert").click(function() {
			$("#kitAlert").addClass("d-none");
		});

		$("#closeProdottoFotoAlert").click(function() {
			$("#prodottoFotoAlert").addClass("d-none");
		});

		$("#closeOrdineFotoAlert").click(function() {
			$("#ordineFotoAlert").addClass("d-none");
		});

	});
	function uploadFotoAlbero(id) {
		$("#uploadFotoOrdineForm").removeClass("d-none");
		$("#codiceProdottoUpload").val(id);
	}
	function printFotoOrdine(j) {
		var i = 0;
		$("#ordineFotoAlert").removeClass("d-none");

		$("#tableBody").empty();
		j.items.forEach((e) => {
			$("#tableBody").append('<tr> <td class="nrOrder">' + e.id + '</td><td>' + e.nome + '</td>' +
				'<td>' + e.prezzo + '</td><td>' + e.saldo + '</td><td>' + e.quantità +
				'</td><td>' + e.stato + '</td><td><img src="./GetFotoProdottoOrdine?idProdottoOrdine=' + e.id
				+ '" class="img-thumbnail bg-secondary bg-gradient" style="max-width:60px;"></td> <td><a class="aggiornaAlbero" onclick="uploadFotoAlbero(' + e.id + ')"><i class="fa-solid fa-pen-to-square"></i></a></td></tr>');
		});

	}

	function printDettagliOrdine(json) {
		$("#ordineAlert").removeClass("d-none");
		$("#numeroOrdineAlert").empty().append("<h4>Dettaglio ordine n." + json.id + "</h4>");

		$("#prodottiOrdineAlert").empty();
		json.items.forEach((e) => {
			$("#prodottiOrdineAlert").append("<li>" + "<b>Nome:</b> " + e.nome + ", Prezzo: " + e.prezzo + ", Quantità: "
				+ e.quantità + ", Saldo: " + e.saldo + "%, tasse: " + e.tasse + "%, Stato: " + e.stato +
				"</li>");
		});

		$("#dettaglioOrdineAlert").empty().append("<b>N. Prodotti:</b>" + json.totaleProdotti + ", ");
		$("#dettaglioOrdineAlert").append("<b>Totale Ordine:</b>" + json.totalePagato + ", ");
		$("#dettaglioOrdineAlert").append("<b>Regalo?:</b>" + ", ");
		$("#dettaglioOrdineAlert").append("<b>Messaggio Regalo</b>" + json.messaggioRegalo + ", ");
		$("#dettaglioOrdineAlert").append("<b>Destinatario Regalo</b>" + json.destinatarioRegalo + ", ");

		$("#dettaglioOrdineAlert").empty().append("Ordine effettuato dall'utente: " + json.utente.id + "(" + json.utente.nome + " "
			+ json.utente.cognome + ")" + ". E-mail:" +
			json.utente.email);
	};

	function printProdotto(j) {
		$("#prodottoAlert").removeClass("d-none");
		$("#prodottoIdAlert").empty().append("<h4>Dettaglio prodotto id." + j.id + "</h4>");

		$("#prodottoDescrizioneAlert").empty().append("<b>Nome Scientifico: </b>" + j.nomeScientifico + ",  sottotitolo: " + j.sottotitolo
			+ ", descrizione breve:" + j.descrizioneBreve
			+ " ,descrizione:" + j.descrizione + "<br>"
			+ "Paese:" + j.paeseDiOrigine + " " + j.doveVienePiantato + "<br>"
			+ "Altezza:" + j.altezza + " ,co2:" + j.co2 + " ,salvaguardia: " + j.salvaguardia);

		$("#prodottoBeneficiAlert").empty();
		j.benefici.forEach((e) => {
			$("#prodottoBeneficiAlert").append("<li>" + "<b>Beneficio:</b> " + e.nome + ", con valore: " + e.percentuale +
				"</li>");
		});

		$("#prodottoCategorieAlert").empty();
		j.categorie.forEach((e) => {
			$("#prodottoCategorieAlert").append("<li>" + "<b>Nome:</b> " + e.nome + ", descrizione: " + e.descrizione +
				"</li>");
		});

		$("#prodottoUsiLocaliAlert").empty();
		j.usiLocali.forEach((e) => {
			$("#prodottoUsiLocaliAlert").append("<li>" + "<b>Nome:</b> " + e.nome + ", descrizione: " + e.descrizione +
				"</li>");
		});
	}

	function printProdottoFoto(j) {
		var i = 0;
		$("#prodottoFotoAlert").removeClass("d-none");
		$("#prodottoFotoIdAlert").empty().append("<h4>Foto prodotto." + "</h4>")

		j.forEach((e) => {
			i++;
			$("#foto" + i).attr("src", "./GetFotoProdotto?idFoto=" + e.nomeFoto);
			$("#fotoCodice" + i).empty().append("Foto n." + e.nomeFoto);
		});
	}

	function printKit(j) {
		$("#kitAlert").removeClass("d-none");
		$("#kitIdAlert").empty().append("<h4>Dettaglio kit n." + j.id + "</h4>")
		$("#kitDescrizioneAlert").empty().append("<b> Nome: </b>" + j.nome + ", descrizione:" + j.descrizione + ", saldo:" + j.saldo);

		$("#prdottiKitAlert").empty();
		j.alberi.forEach((e) => {
			$("#prdottiKitAlert").append("<li>" + "<b>Nome:</b> " + e.nome + ", prezzo: " + e.prezzo +
				"€</li>");
		});
	}

	function printProdottoForm(j) {

		$('#tab1').append('<div class="row align-items-center" id="codiceProdotto">	<div class="col-3 "> <h5>Codice:</h5>'
			+ ' </div>	<div class="col-9">	<input class="form-control " type="text" name="codiceProdotto"> </div> </div>');
		$('input[name="codiceProdotto"]').val(j.id);
		$('input[name="nome"]').val(j.nome);
		$('input[name="nomeScientifico"]').val(j.nomeScientifico);
		$('input[name="prezzo"]').val(j.prezzo);
		$('input[name="sottotitolo"]').val(j.sottotitolo);
		$('textArea[name="descrizioneBreve"]').val(j.descrizioneBreve);
		$('textArea[name="descrizione"]').val(j.descrizione);
		$('input[name="co2"]').val(j.co2);
		$('input[name="salvaguardia"]').val(j.salvaguardia);
		$('input[name="altezza"]').val(j.altezza);
		$('input[name="onSale"]').val(j.onSale);
		$('input[name="co2"]').val(j.co2);
		$('input[name="saldo"]').val(j.saldo);
		$('input[name="quantità"]').val(j.quantità);
		$('input[name="doveVienePiantato"]').val(j.doveVienePiantato);
		$('input[name="tasse"]').val(j.tasse);
		$('select[name="paese"]').val(j.paeseDiOrigine);

		j.benefici.forEach((e) => {
			$('input[name=ben' + e.id + ']').val(e.percentuale);
		});

		j.categorie.forEach((e) => {
			$('select[name=categorie] option[value="cat' + e.id + '"]').attr("selected", 1);
		});

		j.usiLocali.forEach((e) => {
			$('select[name=usi] option[value="uso' + e.id + '"]').attr("selected", 1);
		});

		$('#prodottoForm').attr("action", "Prodotto?action=aggiornaAlbero");
		$('#tab2').remove();

	}

	function printKitForm(j) {
		$('#kitForm').attr("action", "Prodotto?action=aggiornaKit")
		$('#kitFormButton').html("Modifica")
		$('#idKitForm').removeClass("d-none")
		$('input[name="idKit"]').val(j.id);
		$('input[name="nomeKit"]').val(j.nome);
		$('input[name="nomeScientifico"]').val(j.nomeScientifico);
		$('input[name="saldoKit"]').val(j.saldo);
		$('textArea[name="descrizioneKit"]').val(j.descrizione);
			j.alberi.forEach((e) => {
				$('select[name=alberiKit] option[value="alb' + e.id + '"]').attr("selected", 1);
			});
	}
	</script>
</body>
</html>