<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- pagina per la gestione di errori -->
<%@ page errorPage="../error/error404.jsp"%>

<!-- import di classi Java -->
<%@ page import="it.unisa.model.Carrello"%>
<%@ page import="it.unisa.beans.ProdottoCarrello"%>
<%@ page import="it.unisa.beans.Prodotto"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrello</title>
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
	<section class="h-100" style="background-color: #d2c9ff;">
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-12">
					<div class="card card-registration card-registration-2"
						style="border-radius: 15px;">
						<div class="card-body p-0">
							<div class="row g-0">
								<div class="col-lg-8">
									<div class="p-5">
										<div
											class="d-flex justify-content-between align-items-center mb-5">
											<h1 class="fw-bold mb-0 text-black">Carrello</h1>
											<h6 class="mb-0 text-muted">3 Alberi</h6>
										</div>
										<hr class="my-4">
										<div
											class="row mb-4 d-flex justify-content-between align-items-center">
											<div class="col-md-2 col-lg-2 col-xl-2">
												<img
													src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img5.webp"
													class="img-fluid rounded-3" alt="Cotton T-shirt">
											</div>
											<div class="col-md-3 col-lg-3 col-xl-3">
												<h6 class="text-muted">Shirt</h6>
												<h6 class="text-black mb-0">Cotton T-shirt</h6>
											</div>
											<div class="col-md-3 col-lg-3 col-xl-2 d-flex">
												<button class="btn btn-link px-2"
													onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
													<i class="fas fa-minus"></i>
												</button>

												<input id="form1" min="0" name="quantity" value="1"
													type="number" class="form-control form-control-sm" />

												<button class="btn btn-link px-2"
													onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
													<i class="fas fa-plus"></i>
												</button>
											</div>
											<div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
												<h6 class="mb-0">€ 44.00</h6>
											</div>
											<div class="col-md-1 col-lg-1 col-xl-1 text-end">
												<a href="#!" class="text-muted"><i class="fas fa-times"></i></a>
											</div>
										</div>
										<hr class="my-4">
										<div
											class="row mb-4 d-flex justify-content-between align-items-center">
											<div class="col-md-2 col-lg-2 col-xl-2">
												<img
													src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img6.webp"
													class="img-fluid rounded-3" alt="Cotton T-shirt">
											</div>
											<div class="col-md-3 col-lg-3 col-xl-3">
												<h6 class="text-muted">Shirt</h6>
												<h6 class="text-black mb-0">Cotton T-shirt</h6>
											</div>
											<div class="col-md-3 col-lg-3 col-xl-2 d-flex">
												<button class="btn btn-link px-2"
													onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
													<i class="fas fa-minus"></i>
												</button>

												<input id="form1" min="0" name="quantity" value="1"
													type="number" class="form-control form-control-sm" />

												<button class="btn btn-link px-2"
													onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
													<i class="fas fa-plus"></i>
												</button>
											</div>
											<div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
												<h6 class="mb-0">€ 44.00</h6>
											</div>
											<div class="col-md-1 col-lg-1 col-xl-1 text-end">
												<a href="#!" class="text-muted"><i class="fas fa-times"></i></a>
											</div>
										</div>

										<hr class="my-4">

										<div
											class="row mb-4 d-flex justify-content-between align-items-center">
											<div class="col-md-2 col-lg-2 col-xl-2">
												<img
													src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img7.webp"
													class="img-fluid rounded-3" alt="Cotton T-shirt">
											</div>
											<div class="col-md-3 col-lg-3 col-xl-3">
												<h6 class="text-muted">Shirt</h6>
												<h6 class="text-black mb-0">Cotton T-shirt</h6>
											</div>
											<div class="col-md-3 col-lg-3 col-xl-2 d-flex">
												<button class="btn btn-link px-2"
													onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
													<i class="fas fa-minus"></i>
												</button>

												<input id="form1" min="0" name="quantity" value="1"
													type="number" class="form-control form-control-sm" />

												<button class="btn btn-link px-2"
													onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
													<i class="fas fa-plus"></i>
												</button>
											</div>
											<div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
												<h6 class="mb-0">€ 44.00</h6>
											</div>
											<div class="col-md-1 col-lg-1 col-xl-1 text-end">
												<a href="#!" class="text-muted"><i class="fas fa-times"></i></a>
											</div>
										</div>

										<hr class="my-4">

										<div class="pt-5">
											<h6 class="mb-0">
												<a href="catalogo.jsp" class="text-body"><i
													class="fas fa-long-arrow-alt-left me-2"></i>Continua con lo
													shopping</a>
											</h6>
										</div>
									</div>
								</div>
								<div class="col-lg-4 bg-light">
									<div class="p-5">
										<h3 class="fw-bold mb-5 mt-2 pt-1">Riepilogo</h3>
										<hr class="my-4">
										<h5 class="text-uppercase mb-3">Spedizione</h5>
										<div class="mb-4 pb-2">
											<select class="form-select">
												<option value="1">Standard-Delivery- €5.00</option>
												<option value="2">Two</option>
												<option value="3">Three</option>
												<option value="4">Four</option>
											</select>
										</div>
										<hr class="my-4">
										<div class="d-flex justify-content-between">
											<p class="mb-2">Totale del carrello (IVA esclusa)</p>
											<p class="mb-2">$4798.00</p>
										</div>

										<div class="d-flex justify-content-between">
											<p class="mb-2">Spese di spedizioni</p>
											<p class="mb-2">$20.00</p>
										</div>

										<div class="d-flex justify-content-between mb-4">
											<p class="mb-2">Totale(IVA inclusa)</p>
											<p class="mb-2">$4818.00</p>
										</div>

										<button type="button" class="btn btn-dark btn-block btn-lg">
											<div class="d-flex justify-content-between">
												<span>$4818.00</span> <a href="checkout.jsp">Checkout <i
													class="fas fa-long-arrow-alt-right ms-2"></i></a>
											</div>
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>