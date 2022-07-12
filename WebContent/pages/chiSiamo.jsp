<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi Siamo</title>
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
	<br>
	<br>
	<!-- Chi Siamo Section -->
	<div class="container">
		<h1>Ogni albero nel modo giusto</h1>
		<p>
			<b>Crediamo che gettare 100 semi in un campo, non significhi aver
				piantato 100 alberi.</b>
		</p>
		<p>E crediamo che piantare una sola specie, in modo intensivo, non
			sia una scelta sostenibile e rispettosa della biodiversità.</p>
		<p>
			<b>Crediamo che le comunità di persone che vivono in un luogo
				siano i migliori custodi degli alberi,</b> per questo le sosteniamo
			finanziariamente e le aiutiamo a piantare e far crescere alberi nei
			loro terreni. Gli alberi daranno benefici a loro, al luogo in cui
			vivono e a tutto il pianeta.
		</p>
		<p>
			<b>Crediamo nel legame </b>che, attraverso gli alberi e grazie a
			Treedom, si può creare tra persone lontane.
		</p>
		<p>
			<b>Crediamo che ciascuno di noi debba impegnarsi per ridurre le
				proprie emissioni </b>di CO2 e che nel farlo possa contribuire anche ad
			assorbirne piantando alberi.
		</p>
		<p>
			Crediamo che si possa rendere<b>questo pianeta più verde. E
				vogliamo farlo nel modo giusto</b>
		</p>
	</div>
	<!-- Jumbotron -->
	<div
		class="bg-image p-5 text-center shadow-1-strong rounded mb-5 text-white"
		style="background-color: #93c572;">
		<h1>TANTE FACCE,</h1>
		<h1>DIVERSE MOTIVAZIONI</h1>
		<h1>UN UNICO OBIETTIVO:</h1>
		<h1>Let's green the planet</h1>
		<img src="../resources/img/chiSiamoPage/community.svg" height="300px"
			width="300px">
	</div>
	<div class="row row-cols-1 row-cols-md-4 g-4 text-center">
		<div class="card-group h-100 w-50 text-center">
			<div class="card h-100 w-50">
				<img src="../resources/img/chiSiamoPage/info_users.svg"
					class="card-img-top">
				<div class="card-body">
					<h5 class="card-title">Persone</h5>
					<p class="card-text">0</p>
				</div>
			</div>
			<div class="card h-100 w-50">
				<img src="../resources/img/chiSiamoPage/info_business.svg"
					class="card-img-top">
				<div class="card-body">
					<h5 class="card-title text-center">Aziende</h5>
					<p class="card-text">0</p>
				</div>
			</div>
			<div class="card h-100 w-50">
				<img src="../resources/img/chiSiamoPage/info_projects.svg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<h5 class="card-title">Beneficari</h5>
					<p class="card-text">0</p>

				</div>
			</div>
			<div class="card h-100 w-50">
				<img src="../resources/img/chiSiamoPage/info_trees.svg"
					class="card-img-top">
				<div class="card-body">
					<h5 class="card-title">Alberi</h5>
					<p class="card-text">0</p>

				</div>
			</div>
		</div>
	</div>
	<!-- Mission Section -->
	<div></div>

	<!-- Condividi -->
	<div class="row align-middle" style="background-color: #c4d89d;">
		<div class="col">
			<img src="../resources/img/chiSiamoPage/prefooter.svg" height="300px"
				width="300px">
		</div>
		<div class="col ">
			<h4>Fai crescere la Community, condividi WoodLot!</h4>
			<!-- Section: Social media -->
			<section class="mb-4">
				<!-- Facebook -->
				<a class="btn btn-outline-dark btn-floating m-1"
					href="https://www.facebook.com" role="button"><i
					class="fab fa-facebook-f"></i></a>

				<!-- Twitter -->
				<a class="btn btn-outline-dark btn-floating m-1"
					href="https://twitter.com" role="button"><i
					class="fab fa-twitter"></i></a>

				<!-- Snapchat -->
				<a class="btn btn-outline-dark btn-floating m-1"
					href="https://snapchat.com" role="button"><i
					class="fa-brands fa-snapchat"></i></a>

				<!-- Instagram -->
				<a class="btn btn-outline-dark btn-floating m-1"
					href="https://www.instagram.com" role="button"><i
					class="fab fa-instagram"></i></a>

				<!-- TikTok -->
				<a class="btn btn-outline-dark btn-floating m-1"
					href="https://www.tiktok.com" role="button"><i
					class="fa-brands fa-tiktok"></i></a>

				<!-- Pinterest -->
				<a class="btn btn-outline-dark btn-floating m-1"
					href="https://www.pinterest.com" role="button"><i
					class="fa-brands fa-pinterest"></i></a>
			</section>
			<!-- Section: Social media -->
		</div>
	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>