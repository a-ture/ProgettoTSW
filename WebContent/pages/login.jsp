<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- pagina per la gestione di errori -->
<%@ page errorPage="/error/error404.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,it.unisa.beans.*, java.text.*"%>
<%
Collection<?> errori = (Collection<?>) request.getAttribute("errori");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accedi</title>
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="./resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="./resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="./resources/css/_bootswatch.scss">

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
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="resources/img/logo.png">

</head>
<body>
	<div class="vh-100 bg-dark">
		<div class="container">
			<div
				class="row py-4 d-flex justify-content-center">
				<div class="col-xl-8 ">
					<div class="card" style="border-radius: 1rem;">
						<div class="row g-0">
							<div class="col-md-6 d-none d-md-block">
								<img src="./resources/img/login.jpeg" class="img-fluid"
									style="border-radius: 1rem 0 0 1rem; max-height:641px;" />
							</div>
							<div class="col-md-6">
								<div class="card-body text-black">

									<form method="POST" action="Login?action=login"
										enctype="application/x-www-form-urlencoded">
										<div class="d-flex align-items-center ">
											<img src="./resources/img/logo.png" height="60px"> <span
												class="h3 fw-bold mb-0"> &nbsp WoodLot</span>
										</div>

										<h6 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Entra
											nel tuo account</h6>

										<div class="form-outline mb-4">
											<input type="email" id="email" name="email"
												class="form-control form-control-lg"
												placeholder="la tua e-mail" /> <label class="form-label"
												for="email">Email </label>
										</div>
										<div class="form-outline mb-4">
											<input type="password" id="password"
												class="form-control form-control-lg" name="password"
												placeholder="la tua password" /> <label class="form-label"
												for="password">Password</label>
										</div>
										<div class="pt-1 mb-5 d-flex justify-content-center">
											<button class="btn btn-primary btn-lg btn-block"
												type="submit">Login</button>
										</div>
									</form>

									<form action="Login" method="get">
										<div class="form-group d-flex align-items-end">
											<input type="hidden" name="action" value="registrazione">

											<p>
												Non hai un'account?
												<button type="submit" class="btn btn-success">Registrati
													qui</button>
											</p>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div>
							<%
							if (errori != null && errori.size() != 0) {
								Iterator<?> it = errori.iterator();
								while (it.hasNext()) {
							%>
							<p class="text-center text-danger">
								<%=it.next()%>
							</p>
							<%
							}
							}
							%>

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">Password
						Reset</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form class="form" role="form" autocomplete="off">
						<div class="form-group">
							<label for="inputResetPasswordEmail">Email</label> <input
								type="email" class="form-control" id="inputResetPasswordEmail"
								required> <span id="helpResetPasswordEmail"
								class="form-text small text-muted"> Le istruzioni per il
								reset della password verrano inviata alla mail indicata </span>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Reset</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>