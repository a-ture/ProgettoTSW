<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profilo</title>
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
<!-- jQuey -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
</head>
<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-3">
				<img src="../resources/img/alberi/Arancia.png"
					class="rounded-circle mb-3" style="width: 150px;" alt="Avatar" />
			</div>
			<div class="col-9">
				<div class="row">
					<p>Nome e Cognome</p>
				</div>
				<div class="row">
					<p>Email
					<p>
				</div>
				<div class="row">
					<p>Altre belle informazioni</p>
				</div>
				<div class="row">
					<button type="button" class="btn btn-primary col-3">Modifica Informazioni</button>
				</div>
			</div>
			
		</div>
	</div>
	<hr>


	<div class="container">
		<div class="row g-4">
			<!-- Sidenav START -->
			<div class="col-lg-3">
				<!-- Advanced filter responsive toggler START -->
				<div class="d-flex align-items-center d-lg-none">
					<button class="border-0 bg-transparent" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#offcanvasSideNavbar"
						aria-controls="offcanvasSideNavbar">
						<i class="btn btn-primary fw-bold fa-solid fa-sliders-h"></i> <span
							class="h6 mb-0 fw-bold d-lg-none ms-2">My profile</span>
					</button>
				</div>
				<!-- Advanced filter responsive toggler END -->

				<!-- Navbar START-->
				<nav class="navbar navbar-expand-lg mx-0">
					<div class="offcanvas offcanvas-start" tabindex="-1"
						id="offcanvasSideNavbar">
						<!-- Offcanvas header -->
						<div class="offcanvas-header">
							<button type="button" class="btn-close text-reset ms-auto"
								data-bs-dismiss="offcanvas" aria-label="Close"></button>
						</div>

						<!-- Offcanvas body -->
						<div class="offcanvas-body d-block px-2 px-lg-0">
							<!-- Card START -->
							<div class="card overflow-hidden">
								<!-- Cover image -->
								<div class="h-50px"
									style="background-image: url(assets/images/bg/01.jpg); background-position: center; background-size: cover; background-repeat: no-repeat;"></div>
								<!-- Card body START -->
								<div class="card-body pt-0">
									<!-- Side Nav START -->
									<ul class="nav nav-link-secondary flex-column fw-bold gap-2">

										<li class="nav-item"><a class="nav-link" href="#ordini"
											id="ordiniButton"><i class="fa-solid fa-clipboard-list"></i><span>
													Ordini </span></a></li>

										<li class="nav-item"><a class="nav-link" href="#woodLot"
											id="woodLotButton"> <i class="fa-solid fa-tree"></i><span>Il
													tuo WoodLot </span></a></li>

										<li class="nav-item"><a class="nav-link" href="#badge"
											id="badgeButton"> <i class="fa-solid fa-award"></i><span>
													Badge </span>
										</a></li>
										<li class="nav-item"><a class="nav-link"
											href="events.html"> <img class="me-2 h-20px fa-fw"
												src="assets/images/icon/calendar-outline-filled.svg" alt=""><span>Events
											</span></a></li>
										<li class="nav-item"><a class="nav-link"
											href="groups.html"> <img class="me-2 h-20px fa-fw"
												src="assets/images/icon/chat-outline-filled.svg" alt=""><span>Groups
											</span></a></li>
										<li class="nav-item"><a class="nav-link"
											href="notifications.html"> <img class="me-2 h-20px fa-fw"
												src="assets/images/icon/notification-outlined-filled.svg"
												alt=""><span>Notifications </span></a></li>
										<li class="nav-item"><a class="nav-link"
											href="settings.html"> <i
												class="fa-solid fa-right-from-bracket"></i><span>Logout
											</span></a></li>
									</ul>
									<!-- Side Nav END -->
								</div>
								<!-- Card body END -->
							</div>
							<!-- Card END -->
						</div>
					</div>
				</nav>
				<!-- Navbar END-->
			</div>
			<!-- Sidenav END -->

			<!-- Main content START -->
			<div class="col-md-8 col-lg-6 vstack gap-4">
				<!-- Ordini -->
				<div id="ordini" class="row d-none">
					<h1 class="text-center">I tuoi ordini</h1>
					<p>Qui puoi trovare il riepilogo degli ordini fatti nel nostro
						shop</p>
				</div>
				<!-- WoodLot -->
				<div id="woodLot" class="row d-none">
					<h1 class="text-center">Il tuo WoodLot</h1>
					<p>
						Non hai ancora alberi ...torna al <a href="catalogo.jsp">negozio</a>
					</p>
				</div>
				<!-- Badge -->
				<div class="row d-none" id="badge">
					<h1 class="text-center">I tuoi badge</h1>
					<!-- Astrologo -->
					<div class="row row-cols-1 row-cols-md-3 g-3 text-center">
						<div class="card-group w-100"></div>
						<div class="card">
							<img src="../resources/img/badge/astrologo.png"
								class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">Astrologo</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#astrologoModal">Sblocca</a>
							</div>
						</div>
						<!-- benefattore -->
						<div class="card">
							<img src="../resources/img/badge/benefattore.png"
								class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">Benefattore</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#benefattoreModal">Sblocca</a>
							</div>
						</div>
						<!-- Giramondo -->
						<div class="card">
							<img src="../resources/img/badge/giramondo.png"
								class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">Giramondo</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#giramondoModal">Sblocca</a>
							</div>
						</div>
						<!-- Matricola -->
						<div class="card">
							<img src="../resources/img/badge/matricola.png"
								class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">Matricola</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#matricolaModal">Sblocca</a>
							</div>
						</div>
						<!-- Multitasking -->
						<div class="card">
							<img src="../resources/img/badge/multitasking.png"
								class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">Multitasking</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#multitaskingModal">Sblocca</a>
							</div>
						</div>
						<!-- Tarzan -->
						<div class="card">
							<img src="../resources/img/badge/tarzan.png" class="card-img-top"
								alt="...">
							<div class="card-body">
								<h5 class="card-title">Tarzan</h5>
								<a href="#!" class="btn btn-primary" data-bs-toggle="modal"
									data-bs-target="#tarzanModal">Sblocca</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Row END -->
			</div>
		</div>
	</div>

	<!-- Modal Astrologo -->
	<div class="modal fade" id="astrologoModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Astrologo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Mira alle stelle e pianta l'albero del
					tuo segno zodiacale.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Astrologo -->
	<div class="modal fade" id="astrologoModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Astrologo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Mira alle stelle e pianta l'albero del
					tuo segno zodiacale.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Benefattore -->
	<div class="modal fade" id="benefattoreModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Benefattore</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Sii generoso e regala almeno un
					albero. Otterrai il riconoscimento quando la persona a cui hai
					regalato l'albero, lo riscatterà, diventandone così custode e
					iniziando a seguirne la storia..</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Giramondo -->
	<div class="modal fade" id="giramondoModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Giramondo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Supera i confini e pianta almeno un
					albero in 3 paesi diversi.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Matricola -->
	<div class="modal fade" id="matricolaModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Matricola</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Inizia la tua esperienza e pianta il
					tuo primo albero.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Multitasking -->
	<div class="modal fade" id="multitaskingModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Multitasking</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Gli alberi sanno essere utili in molti
					modi. Pianta alberi che assolvono ad almeno 6 dei loro 8 usi e
					benefici.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Tarzan -->
	<div class="modal fade" id="tarzanModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Tarzan</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Non essere timido e pubblica la tua
					prima foresta.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

	<script>
		$(document).ready(function() {

			$("#ordiniButton").click(function(event) {
				$("#ordini").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#woodLot").addClass("d-none");
			});

			$("#badgeButton").click(function(event) {
				$("#badge").removeClass("d-none");
				$("#ordini").addClass("d-none");
				$("#woodLot").addClass("d-none");
			});

			$("#woodLotButton").click(function(event) {
				$("#woodLot").removeClass("d-none");
				$("#badge").addClass("d-none");
				$("#ordini").addClass("d-none");
			});
		});
	</script>
</body>
</html>