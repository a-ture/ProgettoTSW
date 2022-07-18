<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WoodLot-404</title>
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/_bootswatch.scss">

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
	<div class="container">
		<div class="row text-center">
		<br>
			<p>
				Torna alla <a href="home.jsp">home</a>
			</p>
		</div>
		<div class="row">
			<img src="<%=request.getContextPath()%>/resources/img/error/404.jpg"
				height="800px" width="800px" class="img-fluid">
		</div>

	</div>
</body>
</html>