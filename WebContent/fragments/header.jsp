<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*, it.unisa.beans.*"%>

<%
Utente utenteHeader = (Utente) request.getSession().getAttribute("utente");
%>
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

<!-- jQuey -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
.btn-secondary {
	background-color: #C4D89F;
	border-color: #C4D89F;
}

.btn-secondary:hover {
	background-color: #93C572;
	border-color: #93C572;
}

.navbar-light .navbar-nav .show>.nav-link, .navbar-light .navbar-nav .nav-link.active
	{
	color: #94AD6E;
}

.navbar-light .navbar-nav .nav-link {
	color: #94AD6E;
}


.navbar-toggler {
	background-color: #C4D89F;
}

.navbar-light .navbar-toggler {
	color: #C4D89F;
	border-color: #C4D89F;
}
</style>
</head>

<header>
	<nav class="navbar navbar-expand-lg navbar-light  bg-white">
		<div class="container-fluid">
			<button class="btn btn-white">
				<a class="nav-link active" href="Home"> <img
					class="navbar-brand" src="./resources/img/logo.png"
					height="60px">
				</a>
			</button>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#header"
				aria-controls="navbarColor01" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="navbar-collapse collapse " id="header">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link active" href="Home">Home
							<span class="visually-hidden">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="Catalogo">Alberi</a></li>
					<li class="nav-item"><a class="nav-link"
						href="ChiSiamoServlet">Chi Siamo</a></li>


					<li class="nav-item"><a
						class="btn btn-secondary my-2 my-lg-0 my-md-2"
						class="btn btn-primary" href="Regalo"> Hai un Treecode?</a></li>
				</ul>
				<div>
					<ul class="navbar-nav me-auto">
						<li class="nav-item">
							<%
							if (utenteHeader == null) {
							%><a class="btn btn-secondary  my-2 my-lg-0 my-md-2" href="Login">Accedi</a>
							<%
							} else {
							%><a class="btn btn-secondary  my-2 my-lg-0 my-md-2"
							href="Utente">Profilo</a> <%}%>
						</li>
						<li class="nav-item"><a
							href="Prodotto?action=visualizzaCarrello"><img
								class="nav-link img-fluid"
								src="./resources/img/header/carriola.svg" width="60" height="40"></a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>


</header>

</html>