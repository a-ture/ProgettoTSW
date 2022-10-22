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
	
<!-- jQuey -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
</head>

<body>
	<nav class="navbar navbar-light navbar-dark bg-primary">
		<div class="container-fluid">
			<div class="navbar" id="header">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link active" href="Home">Home
					</a></li>
					<li class="nav-item"><a class="nav-link" href="Catalogo">Alberi</a></li>
					<li class="nav-item"><a class="nav-link"
						href="ChiSiamoServlet">Chi Siamo</a></li>
					<li class="nav-item"><a class="btn btn-secondary my-2 my-sm-0"
						class="btn btn-primary" href="Regalo"> Hai un Treecode?</a></li>
				</ul>
				<div>
					<ul class="navbar-nav">
						<li class="nav-item"><a
							class="nav-link active" href="Login">Accedi</a></li>
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
	
	<!--  <script type="text/javascript">
	function collapse(){
		setTimeout(
			() => {$('#header').removeClass('show')},320		
		)
		}
	</script>-->
	
</body>

</html>