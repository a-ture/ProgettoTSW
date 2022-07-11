<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Catalogo</title>
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="../resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="../resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="../resources/css/_bootswatch.scss">

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
	<%@ include file="../fragments/header.jsp" %>
	<br>
	<br>

	<!-- Scritta -->
	<div class="col-md-12 text-center">
		<h1>Scegli e pianta i tuoi alberi</h1>
		<p class="lead">Hai mai pensato di piantare un albero? È un gesto
			semplice, ma con un grande impatto. Porterà benefici all'ambiente e
			alle persone, e diventerà un regalo originale per le persone che ami.
			Pianta un albero, rendi il mondo più verde!</p>
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
					<a class="dropdown-item" href="#">Prezzo più alto</a> <a
						class="dropdown-item" href="#">Prezzo più basso</a>
				</div>
			</div>
		</div>
		<!-- Tipologia prodotti -->
		<div class="btn-group" role="group"
			aria-label="Button group with nested dropdown">
			<button type="button" class="btn btn-primary">Tipologia Prodotti</button>
			<div class="btn-group" role="group">
				<button id="btnGroupDrop1" type="button"
					class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"></button>
				<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
					<a class="dropdown-item" href="#">Tutti</a> 
					<a class="dropdown-item" href="#">Alberi</a>
					<a class="dropdown-item" href="#">Certificati</a>
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
					<a class="dropdown-item" href="#">Paese 1</a> 
					<a class="dropdown-item" href="#">Paese 2</a>
					<a class="dropdown-item" href="#">Paese 3</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Fine Filtri -->

	<!-- Sezione Prodotti -->
	<br>
	<div class="row row-cols-1 row-cols-md-4">
		<!-- Card 1 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Arancia.png" class="card-img-top"
					alt="Palm Springs Road" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content. This content is
						a little bit longer.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 2 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Avocado.png" class="card-img-top"
					alt="Palm Springs Road" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content. This content is
						a little bit longer.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 3 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Caoba.png" class="card-img-top"
					alt="Los Angeles Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 4 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Cedro.png" class="card-img-top"
					alt="Los Angeles Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 5 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Chico-zapote.png"
					class="card-img-top" alt="Los Angeles Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 6 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Forestale.png" class="card-img-top"
					alt="Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content. This content is
						a little bit longer.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 7 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Lime.png" class="card-img-top"
					alt="Los Angeles Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 8 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Melo.png" class="card-img-top"
					alt="Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content. This content is
						a little bit longer.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 9 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Mango_new.png" class="card-img-top"
					alt="Los Angeles Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 10 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Pesco.png" class="card-img-top"
					alt="Los Angeles Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 11 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Pioppo-1.png" class="card-img-top"
					alt="Los Angeles Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Card 12 -->
		<div class="col">
			<div class="card">
				<img src="../resources/img/alberi/Pino-1.png" class="card-img-top"
					alt="Skyscrapers" />
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">This is a longer card with supporting text
						below as a natural lead-in to additional content. This content is
						a little bit longer.</p>
					<div class="text-center">
						<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
							Ora</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Fine Sezione Prodotti -->

	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>