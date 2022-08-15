<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WoodLot</title>
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
	<%@ include file="../fragments/header.jsp"%>

	<!-- Hero Section -->
	<div class="container my-5">
		<div
			class="row p-4 pb-0 pe-lg-0 pt-lg-5 align-items-center rounded-3 border shadow-lg">
			<div class="col-lg-7 p-3 p-lg-5 pt-lg-3">
				<div class="lc-block mb-3">
					<div editable="rich">
						<h2 class="fw-bold display-4">Border hero with cropped image
							and shadows&nbsp;</h2>
					</div>
				</div>

				<div class="lc-block mb-3">
					<div editable="rich">
						<p class="lead">Quickly design and customize responsive
							mobile-first sites with Bootstrap, the world’s most popular
							front-end open source toolkit, featuring Sass variables and
							mixins, responsive grid system, extensive prebuilt components,
							and powerful JavaScript plugins.</p>
					</div>
				</div>

				<div
					class="lc-block d-grid gap-2 d-md-flex justify-content-md-start">
					<a class="btn btn-primary px-4 me-md-2" href="#" role="button">Click
						me, I'm a button</a> <a class="btn btn-outline-secondary px-4"
						href="#" role="button">Click me, I'm a button</a>
				</div>
			</div>
			<div class="col-lg-4 offset-lg-1 p-0 overflow-hidden shadow-lg">
				<div class="lc-block">
					<img class="rounded-start"
						src="https://images.unsplash.com/photo-1493612276216-ee3925520721?crop=entropy&amp;cs=tinysrgb&amp;fit=max&amp;fm=jpg&amp;ixid=MnwzNzg0fDB8MXxzZWFyY2h8M3x8d2Vic2l0ZXxlbnwwfDF8fHwxNjIxNDQ4NTEw&amp;ixlib=rb-1.2.1&amp;q=80&amp;w=1080"
						alt="Photo by Diego PH" width="720">
				</div>
			</div>
		</div>
	</div>

	<!-- Vedere quale preferisce raffy -->
	<div class="container my-5">
		<div
			class="row p-4 pb-0 pe-lg-0 pt-lg-5 align-items-center rounded-3 border shadow-lg">
			<div class="col-lg-7 p-3 p-lg-5 pt-lg-3">
				<h1 class="display-4 fw-bold lh-1">Border hero with cropped
					image and shadows</h1>
				<p class="lead">Quickly design and customize responsive
					mobile-first sites with Bootstrap, the world’s most popular
					front-end open source toolkit, featuring Sass variables and mixins,
					responsive grid system, extensive prebuilt components, and powerful
					JavaScript plugins.</p>
				<div
					class="d-grid gap-2 d-md-flex justify-content-md-start mb-4 mb-lg-3">
					<button type="button"
						class="btn btn-primary btn-lg px-4 me-md-2 fw-bold">Primary</button>
					<button type="button" class="btn btn-outline-secondary btn-lg px-4">Default</button>
				</div>
			</div>
			<div class="col-lg-4 offset-lg-1 p-0 overflow-hidden shadow-lg">
				<img class="rounded-lg-3" src="bootstrap-docs.png" alt=""
					width="720">
			</div>
		</div>
	</div>
	<!-- Jumbotron -->
	<div
		class="bg-image p-5 text-center shadow-1-strong rounded mb-5 text-white"
		style="background-image: url('https://mdbcdn.b-cdn.net/img/new/slides/003.webp');">
		<h1 class="mb-3 h2">Jumbotron</h1>

		<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
			Repellendus praesentium labore accusamus sequi, voluptate debitis
			tenetur in deleniti possimus modi voluptatum neque maiores dolorem
			unde? Aut dolorum quod excepturi fugit.</p>
	</div>
	<!-- Jumbotron -->

	<!-- Fine Hero Section -->

	<!-- Card Section -->
	<br>
	<!-- Scritta -->
	<div class="container">
		<div class="col-md-12 text-center">
			<h1>Scegli il tuo albero</h1>
			<br> <br>
		</div>
		<div class="row row-cols-1 row-cols-md-4">
			<!-- Card 1 -->
			<div class="col">
				<div class="card">
					<img src="../resources/img/alberi/Arancia.png" class="card-img-top"
						alt="Palm Springs Road" />
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
			<!-- Card 2 -->
			<div class="col">
				<div class="card">
					<img src="../resources/img/alberi/Avocado.png" class="card-img-top"
						alt="Palm Springs Road" />
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
			<!-- Card 3 -->
			<div class="col">
				<div class="card">
					<img src="../resources/img/alberi/Caoba.png" class="card-img-top"
						alt="Los Angeles Skyscrapers" />
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<p class="card-text">This is a longer card with supporting
							text below as a natural lead-in to additional content.</p>
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
						<p class="card-text">This is a longer card with supporting
							text below as a natural lead-in to additional content.</p>
						<div class="text-center">
							<a class="btn btn-success" href="paginaProdotto.jsp">Piantalo
								Ora</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Bottone  Vedi Altri -->
	<div class="col-md-12 text-center">
		<a type="button" class="btn btn-primary btn-lg" href="catalogo.jsp">Scopri
			tutti gli alberi!</a>
	</div>
	<br>
	<br>
	<!-- Fine Card Section -->

	<!-- Cosa Puoi Fare -->
	<!-- Scritta -->
	<div class="col-md-12 text-center">
		<h1>Cosa puoi fare</h1>
		<br> <br>
	</div>
	<!-- Cards  <div class="row row-cols-1 row-cols-md-4 g-4 d-flex justify-content-between" >-->
	<div class="container" style="background-color: #93c572;">
		<div
			class="row row-cols-1 row-cols-md-4 g-4 d-flex justify-content-between">
			<div class="col">
				<div
					class="card text-center shadow-lg p-3 mb-5 bg-white rounded h-100"
					style="max-width: 14rem;">
					<img src="./resources/img/cosaPuoiFare/whatucando-gift-icon.png"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Regala</h5>
						<p class="card-text">Un regalo originale per l’ambiente e per
							le persone a cui vuoi bene</p>
						<a class="btn btn-primary" href="Catalogo">Regala</a>
					</div>
				</div>
			</div>
			<div class="col">
				<div
					class="card  text-center shadow-lg p-3 mb-5 bg-white rounded h-100"
					style="max-width: 14rem;">
					<img
						src="./resources/img/cosaPuoiFare/whatucando-discover-icon.png"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Pianta</h5>
						<p class="card-text">Tante specie ognuna con le sue
							caratteristiche ed i suoi poteri</p>
						<a class="btn btn-primary" href="Catalogo">Pianta</a>
					</div>
				</div>
			</div>
			<div class="col">
				<div
					class="card text-center shadow-lg p-3 mb-5 bg-white rounded h-100"
					style="max-width: 14rem;">
					<img
						src="./resources/img/cosaPuoiFare/whatucando-subscription-icon.png"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Abbonati</h5>
						<p class="card-text">Pianta alberi ogni mese e inizia il tuo
							percorso green</p>
						<a class="btn btn-primary" href="#">Abbonati</a>
					</div>
				</div>
			</div>
			<div class="col">
				<div
					class="card text-center shadow-lg p-3 mb-5 bg-white rounded h-100"
					style="max-width: 14rem;">
					<img src="./resources/img/chiSiamoPage/info_trees.svg"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Crea il tuo WoodLot</h5>
						<p class="card-text">Pianta alberi ogni mese e inizia il tuo
							percorso green</p>
						<a class="btn btn-primary" href="#">Crea</a>
					</div>
				</div>
			</div>
		</div>
		<br>
	</div>
	<br>

	<!-- Fine Cosa Puoi Fare -->

	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>