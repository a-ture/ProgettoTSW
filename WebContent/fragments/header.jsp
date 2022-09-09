<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">

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
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container-fluid">
			<button class="btn btn-primary">
				<a class ="nav-link active" href="Home"> <img class="navbar-brand"
					src="./resources/img/logo.png" height="60px"> </a>
			</button>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#header"
				aria-controls="navbarColor01" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="navbar-collapse collapse" id="header">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link active" href="Home">Home
							<span class="visually-hidden">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="Catalogo">Alberi</a></li>
					<li class="nav-item"><a class="nav-link"
						href="ChiSiamoServlet">Chi Siamo</a></li>
					<li class="nav-item"><a class="btn btn-secondary my-2 my-sm-0"
						class="btn btn-primary" href="Regalo"> Hai un Treecode?</a></li>
				</ul>
				<div>
					<ul class="navbar-nav me-auto">
						<li class="nav-item"><a
							class="btn btn-secondary my-2 my-sm-0" href="Login">Accedi</a></li>
						<li class="nav-item"><a
							 href="Prodotto?action=visualizzaCarrello"><img
								class="nav-link img-fluid"
								src="./resources/img/icons8-carriola-50.png" width="40"
								height="40"></a></li>
					</ul>
				</div>
			</div>

		</div>
	</nav>
</body>

</html>