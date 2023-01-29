<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,it.unisa.beans.*, java.text.*, java.time.*, java.time.format.DateTimeFormatter"%>

<%
Collection<?> ordini = (Collection<?>) request.getSession().getAttribute("ordini");
Collection<?> utenti = (Collection<?>) request.getSession().getAttribute("utenti");
Collection<?> prodotti = (Collection<?>) request.getSession().getAttribute("prodotti");
Collection<?> categorie = (Collection<?>) request.getSession().getAttribute("categorie");
Collection<?> usi = (Collection<?>) request.getSession().getAttribute("usi");

DecimalFormat dFormat = new DecimalFormat("0.00");

if (ordini == null || utenti == null || prodotti == null || categorie == null || usi == null) {
	response.sendRedirect("./Admin");
	return;
}
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- MyScript -->
<script src="resources/scripts/adminScript.js"></script>

<!-- MyScript -->
<script src="resources/scripts/adminScriptTable.js"></script>
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
						<li class="nav-item dropdown"><a class="nav-link active"
							href="#prod"><i class="fas fa-tshirt"> Gestione Prodotti</i></a></li>
						<li class="nav-item"><a class="nav-link active"
							href="#ordine"><i class="fas fa-shopping-cart"> Gestione
									Ordini</i></a></li>
						<li class="nav-item"><a class="nav-link active" href="#user"><i
								class="fas fa-user-circle"> Gestione Utenti</i></a></li>
						<li class="nav-item active"><a class="nav-link active"
							href="#" data-bs-toggle="modal" data-bs-target="#exampleModal"><i
								class="fas fa-sign-out-alt"> Log Out</i></a></li>
					</ul>
				</div>
			</div>
		</nav>

		<div id="dashboard">
			<br> <br>
			<h1 class="my-5 text-center">Welcome back!</h1>
			<div class="count-up mt-3 mb-5 text-center">
				<div class="wrapper">
					<div class="card h-100 w-100">
						<img src="resources/img/chiSiamo/info_users.svg" height="200"
							width="200" class="card-img-top">
						<div class="card-body">
							<h5 class="card-title">Utenti</h5>
							<div class="counter" data-count="<%=utenti.size()%>">0</div>
						</div>
					</div>
				</div>
				<div class="wrapper">
					<div class="card h-100">
						<img src="resources/img/chiSiamo/info_countries.svg" height="200"
							width="200" class="card-img-top">
						<div class="card-body">
							<h5 class="card-title text-center">Ordini</h5>
							<div class="counter" data-count="<%=ordini.size()%>">0</div>
						</div>
					</div>
				</div>
				<div class="wrapper">
					<div class="card h-100">
						<img src="resources/img/chiSiamo/info_trees.svg" height="200"
							width="200" class="card-img-top">
						<div class="card-body">
							<h5 class="card-title">Prodotti</h5>
							<div class="counter" data-count="<%=prodotti.size()%>">0</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container my-5" id="registroDegliAlberi">
			<h1 class="text-center mb-3">Ordini</h1>
			<div
				class="row row-cols-1  row-cols-sm-1  row-cols-md-3 g-3 text-center">

				<!-- Cerca Per id   -->
				<div class="col">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Cerca per id"
							aria-describedby="button-addon2" id="myInput1"
							onkeyup="myFunctionId(0,'myInput1','myTable')">
						<button class="btn btn-outline-success" type="button"
							id="button-addon2">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
				</div>

				<!-- Cerca Per Cliente   -->
				<div class="col">
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="Cerca per cliente" aria-describedby="button-addon2"
							id="myInput2" onkeyup="myFunctionId(1,'myInput2','myTable')">
						<button class="btn btn-outline-success" type="button"
							id="button-addon2">
							<i class="fa-solid fa-magnifying-glass"></i>

						</button>
					</div>
				</div>

				<!-- Cerca Per Data  -->
				<div class="col">
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="dd/MM/yy - dd/MM/yy"
							aria-describedby="button-addon2" id="myInput3">
						<button class="btn btn-outline-success" type="button"
							id="button-addon2" onclick="myFunctionOrderData()">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="table-responsive-sm">
				<table class="table text-center my-2 bg-white " id="myTable">
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
								DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy");
								String formatDateTime = o.getCreatoIl().format(format);
						%>
						<tr>
							<td scope="row" class="nr"><%=o.getId()%></td>
							<td class="utente"><%=o.getUtente().getEmail()%></td>
							<td class="totale"><%=dFormat.format(o.getTotalePagato())%>€</td>
							<td class="nProdotti"><%=o.getTotaleProdotti()%></td>
							<td class="data"><%=formatDateTime%></td>
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
		<div id="ordineAlert" class="alert alert-success m-5 d-none "
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
			<ol id="prodottiOrdineAlert" class="text-black"></ol>
			<hr>
			<p class="mb-0" id="dettaglioOrdineAlert"></p>
			<hr>
			<p class="mb-0" id="UtenteOrdineAlert"></p>
		</div>

		<div class="alert alert-success  m-5 d-none text-black" role="alert"
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
				<div class="table-responsive-md">
					<table class="table bg-white">
						<thead>
							<tr>
								<th scope="col">Id</th>
								<th scope="col">Nome</th>
								<th scope="col">Prezzo</th>
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
		</div>


		<div class="container my-5" id="registroDegliAlberi">
			<h1 class="text-center mb-3">Alberi</h1>
			<div
				class="row row-cols-1  row-cols-sm-1  row-cols-md-2 g-3 text-center">
				<!-- Cerca Per Id -->
				<div class="col ">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Cerca per id"
							aria-describedby="button-addon2" id="myInput4"
							onkeyup="myFunctionId(0,'myInput4','myTable2')">
						<button class="btn btn-outline-success" type="button"
							id="button-addon2">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
				</div>
				<!-- Cerca Per Paese  -->
				<div class="col ">
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="Cerca per paese" aria-describedby="button-addon2"
							id="myInput5" onkeyup="myFunctionId(2,'myInput5','myTable2')">
						<button class="btn btn-outline-success" type="button"
							id="button-addon2">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="table-responsive-sm">
				<table class="table bg-white" id="myTable2">
					<thead>
						<tr>
							<th scope="col">Id</th>
							<th scope="col" onclick="sortTableAlf(1,'myTable2')">Nome</th>
							<th scope="col" onclick="sortTableAlf(2,'myTable2')">Paese</th>
							<th scope="col" onclick="sortTableAlf(3,'myTable2')">Prezzo</th>

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
							<td><%=a.getPaeseDiOrigine().getNome()%></td>
							<td><%=dFormat.format(a.getPrezzo())%>€</td>

							<td><a class="botteneIdProdottoVedi" href="#prodottoIdAlert"><i
									class="fa-solid fa-eye"></i></a> <a
								class="botteneIdProdottoModifica" href="#ordine"><i
									class="fa-solid fa-pen-to-square"></i></a> <a
								href="Prodotto?action=eliminaAlberoCatalogo&id=<%=a.getId()%>"><i
									class="fa-solid fa-circle-xmark"></i></a> <a class="vediFoto"
								href="#prodottoFotoAlert"><i class="fa-solid fa-images"></i></a></td>
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
			<ol id="prodottoBeneficiAlert" class="text-black"></ol>
			<hr>
			<p>L'albero ha le seguenti categorie:</p>
			<ol id="prodottoCategorieAlert" class="text-black"></ol>
			<hr>
			<p>L'albero ha i seguenti usi locali:</p>
			<ol id="prodottoUsiLocaliAlert" class="text-black"></ol>
			<hr>
		</div>

		<div class="alert alert-success  m-5 d-none text-black" role="alert"
			id="prodottoFotoAlert">
			<div class="row">
				<div class="col">
					<h4 class="alert-heading" id="prodottoFotoIdAlert"></h4>
				</div>
				<div class="col-1 text-end">
					<button type="button" class="btn-close" id="closeProdottoFotoAlert"
						aria-label="Close"></button>
				</div>
			</div>
			<div class="row">
				<div class="col-4">
					<div class="row">
						<img src="" class="rounded img-fluid " alt="..." id="foto1"
							onerror="this.src='./resources//img/error.jpg'" style="max-height:250px">
					</div>
					<p id="fotoCodice1">Foto n.</p>
					<a class="btn btn-primary my-3 uploadFoto-1"> Upload Foto</a>
				</div>
				<div class="col-4">
					<div class="row">
						<img src="" class="rounded img-fluid  " alt="..." id="foto2"
							onerror="this.src='./resources//img/error.jpg'" height="400" width="400"> 
					</div>
					<p id="fotoCodice2">Foto n.</p>
					<a class="btn btn-primary my-3 uploadFoto-2"> Upload Foto</a>

				</div>
				<div class="col-4">
					<div class="row">
						<img src="" class="rounded img-fluid " alt="..." id="foto3"
							onerror="this.src='./resources//img/error.jpg'" height="400" width="400">
					</div>
					<p id="fotoCodice3">Foto n.</p>
					<a class="btn btn-primary my-3 uploadFoto-3"> Upload Foto</a>
				</div>
			</div>

		</div>



		<div class="container my-5" id="registroDegliAlberi">
			<h1 class="text-center mb-3">Utenti</h1>
			<div class="table-responsive-sm">
				<table class="table bg-white  " id="myTable3">
					<thead>
						<tr>
							<th scope="col">Id</th>
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

		<!-- Prodotto -->

		<div id="prod" class="text-center fw-bold h3">Gestione Prodotti</div>

		<div class="form  container mb-3">
			<form action="Prodotto?action=inserisciAlbero" accept-charset="UTF-8"
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
								placeholder="Inserisci il nome dell'albero" name="nome">
							<div class="invalid-feedback">Inserisci un nome valido</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Nome Scientifico:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci il nome scientifico"
								name="nomeScientifico">
							<div class="invalid-feedback">Inserisci un nome valido</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3">
							<h5>Prezzo:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci il prezzo dell'albero" name="prezzo">
							<div class="invalid-feedback">Inserisci un prezzo valido</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 col-xs-6">
							<h5>Sottotitolo</h5>
						</div>
						<div class="col-9 ">
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
							<h5>
								CO<sub>2</sub>:
							</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci un numero intero" name="co2">
							<div class="invalid-feedback">Inserisci un numero intero</div>
						</div>
					</div>
					<div class="row">
						<div class="col-3 col-xs-12">
							<h5>Salvaguardia:</h5>
						</div>
						<div class="col-9 ">
							<input class="form-control" type="text"
								placeholder="Inserisci un numero intero tra 1 e 5"
								name="salvaguardia">
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
							<h5>Tasse:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci l'importo delle tasse" name="tasse">
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
								<option selected value="Perù">Perù</option>
								<option value="Guatemala">Guatemala</option>
								<option value="Italia">Italia</option>
								<option value="Argentina">Argentina</option>
							</select>
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
								placeholder="Inserisci un numero intero tra 1 e 5" name="ben1">
							<div class="invalid-feedback">Inserisci un numero da 1 a 5</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Sviluppo sostenibile:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci un numero intero tra 1 e 5" name="ben2">
							<div class="invalid-feedback">Inserisci un numero da 1 a 5</div>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-3 ">
							<h5>Sviluppo economico:</h5>
						</div>
						<div class="col-9">
							<input class="form-control" type="text"
								placeholder="Inserisci un numero intero tra 1 e 5" name="ben3">
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
								name="foto1" placeholder="Inserisci la foto dell'albero">
						</div>
					</div>
					<div class="row">
						<div class="col-3">
							<h5>Seconda Foto:</h5>
						</div>
						<div class="col-9">
							<input type="file" class="form-control" id="inputGroupFile02"
								name="foto2" placeholder="Inserisci la foto dell'albero">
						</div>
					</div>
					<div class="row">
						<div class="col-3">
							<h5>Terza Foto:</h5>
						</div>
						<div class="col-9">
							<input type="file" class="form-control" id="inputGroupFile03"
								name="foto3" placeholder="Inserisci la foto dell'albero">
						</div>
					</div>
				</div>
			</form>

			<div class="container-fluid mt-5">
				<div style="overflow: auto;">
					<div style="float: right;">
						<button class="btn btn-primary" type="button" id="prevBtn"
							onclick="nextPrev(-1)">Previous</button>
						<button class="btn btn-primary" type="button" id="nextBtn"
							onclick="nextPrev(1)">Next</button>
					</div>
				</div>
				<div style="text-align: center; margin-top: 40px;">
					<span class="step"></span> <span class="step"></span> <span
						class="step"></span> <span class="step"></span> <span class="step"></span>
					<span class="step"></span><span class="step"></span>
				</div>
			</div>
		</div>
		<div class="container form my-5 d-none" id="uploadFoto">
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
							name="foto1" placeholder="Inserisci la foto dell'albero">
					</div>
				</div>
				<br />
				<div class="row justify-content-center">
					<button type="submit" class="col-3 btn btn-primary">Inserisci</button>

				</div>
			</form>
		</div>
	</div>

	<!-- Sezione Ordine -->
	<div id="ordine" class="text-center fw-bold h3 d-none mt-5">Gestione
		Ordine</div>
	<div class="container form  my-5 d-none" id="uploadFotoOrdineForm">
		<form action="Admin?action=aggiornaProdottoOrdine"
			enctype="multipart/form-data" method="POST">
			<div class="fw-bold h3">Aggiornamento Alberi</div>
			<hr>
			<div class="row">
				<div class="col-3">
					<h5>Codice:</h5>
				</div>
				<div class="col-9">
					<input type="text" class="form-control"
						placeholder="Inserisci codice" name="codice"
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
					<input type="file" class="form-control"
						placeholder="Carica immagine" id="inputGroupFile02" name="foto">
				</div>
			</div>
			<div class="row justify-content-center mt-4">
				<button type="submit" class="col-3 btn btn-primary">Aggiorna</button>
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
				
			if( y[i].name == "sottotitolo" || y[i].name == "nomeScientifico"){
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
			
			if(y[i].name ==  "salvaguardia" || y[i].name == "ben1"  ||  y[i].name == "ben2"
					||   y[i].name == "ben4"){
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
			
			if(y[i].name ==  "tasse" || y[i].name ==  "co2" ){
				if (validateNumber(y[i])) {
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
					'<td>'+e.utente.email+'</td><td>'+e.totalePagato+'€</td><td>'+e.totaleProdotti+'</td><td>'+e.creatoIl.date.day+'/'+ e.creatoIl.date.month+'/'+e.creatoIl.date.year+'</td>'+
					'<td> <a class="botteneIdOrdine"> <i class="fa-solid fa-eye"></i> </a> '+
					'<a class="vediFotoOrdine"> <i class="fa-solid fa-images"> </i></a> </td> </tr>'); 
		});
	}
	
	
	$(document).ready(function() {
	
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
				$("#uploadFoto").removeClass("d-none");
				$("html, body").animate({
					   scrollTop: $("#uploadFoto").offset().top
					}, 200);
			});
			$(".uploadFoto-2").click(function() {
				var $nomeFoto = $("#fotoCodice2").html().substring(7);
				$("#codiceFotoUpload").val($nomeFoto);
				$("#uploadFoto").removeClass("d-none");
				$("html, body").animate({
					   scrollTop: $("#uploadFoto").offset().top
					}, 200);
			});
			$(".uploadFoto-3").click(function() {
				var $nomeFoto = $("#fotoCodice3").html().substring(7);
				$("#codiceFotoUpload").val($nomeFoto);
				$("#uploadFoto").removeClass("d-none");
				$("html, body").animate({
					   scrollTop: $("#uploadFoto").offset().top
					}, 200);
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

		$("#closeProdottoFotoAlert").click(function() {
			$("#prodottoFotoAlert").addClass("d-none");
		});

		$("#closeOrdineFotoAlert").click(function() {
			$("#ordineFotoAlert").addClass("d-none");
		});

	});
	
	function uploadFotoAlbero(id) {
		$("#ordine").removeClass("d-none");
		$("#uploadFotoOrdineForm").removeClass("d-none");
		$("#codiceProdottoUpload").val(id);
		$("html, body").animate({
			   scrollTop: $("#uploadFotoOrdineForm").offset().top
			}, 200);
	}
	
	function printFotoOrdine(j) {
		var i = 0;
		$("#ordineFotoAlert").removeClass("d-none");
		$("#ordineFotoIdAlert").empty().append("<h4>Foto ordine n." + j.id + "</h4>");
		$("#tableBody").empty();
		j.items.forEach((e) => {
			$("#tableBody").append('<tr> <td class="nrOrder">' + e.id + '</td><td>' + e.nome + '</td>' +
				'<td>' + e.prezzo+'€'+ '</td><td>'  + e.quantità +
				'</td><td>' + e.stato + '</td><td><img src="./ServletResources?codiceAzione=fotoProdottoOrdine&idProdottoOrdine=' + e.id
				+ '" class="img-thumbnail bg-secondary bg-gradient" style="max-width:60px;"></td> <td><a class="aggiornaAlbero" onclick="uploadFotoAlbero(' + e.id + ')"><i class=" text-dark fa-solid fa-pen-to-square"></i></a></td></tr>');
		});
		$("html, body").animate({
			   scrollTop: $("#ordineFotoAlert").offset().top
			}, 200);

	}

	function printDettagliOrdine(json) {
		
		$("#ordineAlert").removeClass("d-none");
		$("#numeroOrdineAlert").empty().append("<h4>Dettaglio ordine n." + json.id + "</h4>");

		$("#prodottiOrdineAlert").empty();
		json.items.forEach((e) => {
			$("#prodottiOrdineAlert").append("<li>" + "<b>Nome:</b> " + e.nome + ", Prezzo: " + e.prezzo + "€, Quantità: "
				+ e.quantità + ", tasse: " + e.tasse + "%, Stato: " + e.stato +
				"</li>");
		});

		$("#dettaglioOrdineAlert").empty().append("<b>N. Prodotti:</b>" + json.totaleProdotti + ", ");
		$("#dettaglioOrdineAlert").append("<b>Totale Ordine:</b>" + json.totalePagato + "€, ");
	
		$("#dettaglioOrdineAlert").empty().append("Ordine effettuato dall'utente: " + json.utente.id + "(" + json.utente.nome + " "
			+ json.utente.cognome + ")" + ". E-mail:" +
			json.utente.email);
		
		$("html, body").animate({
			   scrollTop: $("#ordineAlert").offset().top
			}, 200);
	};

	function printProdotto(j) {
		$("#prodottoAlert").removeClass("d-none");
		$("#prodottoIdAlert").empty().append("<h4>Dettaglio prodotto id." + j.id + "</h4>");

		$("#prodottoDescrizioneAlert").empty().append("<b>Nome Scientifico: </b>" + j.nomeScientifico + ", <b>sottotitolo:</b> " + j.sottotitolo
			+ ", <b>descrizione breve:</b>" + j.descrizioneBreve
			+ " ,<b>descrizione:</b>" + j.descrizione + ""
			+ " <b>paese:</b>" + j.paeseDiOrigine.nome + ",  " + ""
			+ "<b>altezza:</b>" + j.altezza + ", <b> CO<sub>2</sub>:</b>" + j.co2 + ", <b>salvaguardia: </b>" + j.salvaguardia);

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
		$("html, body").animate({
			   scrollTop: $("#prodottoAlert").offset().top
			}, 200);
	}

	function printProdottoFoto(j) {
		var i = 0;
		$("#prodottoFotoAlert").removeClass("d-none");
		

		j.forEach((e) => {
			i++;
			$("#foto" + i).attr("src", "./ServletResources?codiceAzione=fotoProdotto&idFoto=" + e.nomeFoto);
			$("#fotoCodice" + i).empty().append("Foto n." + e.nomeFoto);
			$("#prodottoFotoIdAlert").empty().append("<h4>Foto prodotto: "+ e.idProdotto+ "</h4>");
		});
		
		$("html, body").animate({
			   scrollTop: $("#prodottoFotoAlert").offset().top
			}, 200);
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
		$('input[name="co2"]').val(j.co2);
		$('input[name="tasse"]').val(j.tasse);
		$('select[name="paese"]').val(j.paeseDiOrigine.nome);
		
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

	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".counter").each(function() {
				var count = $(this);
				var countTo = count.attr('data-count');
				$({
					countNum : count.text()
				}).animate({
					countNum : countTo,
				}, {
					duration : 3000,
					easing : 'linear',
					step : function() {
						count.text(Math.floor(this.countNum));
					},
					complete : function() {
						count.text(this.countNum);
					}
				});
			});

			$('.effect').mouseleave(function() {
				$(this).removeClass('effect');
			})
		});
	</script>
</body>
</html>