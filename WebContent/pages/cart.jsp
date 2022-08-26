<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page
	import="it.unisa.beans.Albero,java.text.*,it.unisa.beans.ProdottoCarrello,it.unisa.model.Carrello,it.unisa.beans.ProdottoCarrello,java.util.*"%>
<%
DecimalFormat dFormat = new DecimalFormat("0.00");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrello</title>
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

<style>
.checked { /*<!-- Per cambiare il colore delle stelline -->*/
	color: orange;
}

#btnCkt {
	transition: all 0.5s;
}

#btnCkt span {
	cursor: pointer;
	display: inline-block;
	position: relative;
	transition: 0.5s;
}

#btnCkt span:after {
	content: '\2192';
	position: absolute;
	opacity: 0;
	top: 0;
	right: -20px;
	transition: 0.5s;
}

#btnCkt:hover span {
	padding-right: 25px;
}

#btnCkt:hover span:after {
	opacity: 1;
	right: 0;
}
</style>
</head>

<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<section class="h-100" style="background-color: #d2c9ff;">
		<div class="container py-5 h-100">

			<jsp:useBean id="carrello" class="it.unisa.model.Carrello"
				scope="session" />
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
											<h6 class="mb-0 text-muted"><%=carrello.getQuantitàTotaleProdotti()%></h6>
										</div>

										<%
										if (carrello.isEmpty()) {
										%>
										<p>OPS! Il tuo carrello è vuoto</p>
										<%
										} else {
										ProdottoCarrello[] prodottiCarrello = carrello.getProdotti().toArray(new ProdottoCarrello[0]);
										for (ProdottoCarrello prodottoCarrello : prodottiCarrello) {
											Albero prodotto = prodottoCarrello.getProdotto();
										%>
										<hr class="my-4">
										<div
											class="row mb-4 d-flex justify-content-between align-items-center">
											<div class="col-md-2 col-lg-2 col-xl-2">
												<img src="" onerror="this.src='./resources//img/error.jpg'"
													class="img-fluid rounded-3" alt="Cotton T-shirt">
											</div>
											<div class="col-md-3 col-lg-3 col-xl-3">
												<h6 class="text-muted"><%=prodotto.getNome()%></h6>
												<h6 class="text-black mb-0"><%=dFormat.format(prodotto.getPrezzo())%>
													€ al pezzo
												</h6>
											</div>
											<div class="col-md-3 col-lg-3 col-xl-2 d-flex">
												<a class="btn btn-link "
													href="Prodotto?action=aggiornaQuantitàProdotto&quantità=<%=prodottoCarrello.getQuantità()%>&azione=meno&id=<%=prodotto.getId()%>">
													<i class="fas fa-minus"></i>
												</a>
												<p class="form-control form-control"><%=prodottoCarrello.getQuantità()%></p>
												<a class="btn btn-link"
													href="Prodotto?action=aggiornaQuantitàProdotto&quantità=<%=prodottoCarrello.getQuantità()%>&azione=più&id=<%=prodotto.getId()%>">
													<i class="fas fa-plus"></i>
												</a>
											</div>

											<div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
												<h6 class="mb-0"><%=dFormat.format(prodottoCarrello.getPrezzoTotale())%>€
												</h6>
											</div>
											<div class="col-md-1 col-lg-1 col-xl-1 text-end">
												<a
													href="Prodotto?action=eliminaProdottoCarrello&id=<%=prodotto.getId()%>"
													class="text-muted"><i class="fas fa-times"></i></a>
											</div>
										</div>
										<hr class="my-4">
										<%
										}
										}
										%>
										<div
											class="d-flex justify-content-between align-items-center mb-5">
											<h6 class="mb-0">
												<a href="Catalogo" class="text-body"><i
													class="fas fa-long-arrow-alt-left me-2"></i>Continua con lo
													shopping</a>
											</h6>
											<h6 class="mb-0">
												<a href="Prodotto?action=svuotaCarrello" class="text-body"><i
													class="fa-solid fa-trash-can"></i> Svuota il carrello</a>
											</h6>
										</div>
									</div>
								</div>
								<div class="col-lg-4 bg-light">
									<div class="p-5">
										<h3 class="fw-bold mb-5 mt-2 pt-1">Riepilogo</h3>
										<hr class="my-4">
										<div class="d-flex justify-content-between">
											<p class="mb-2">Totale del carrello (IVA esclusa)</p>
											<p class="mb-2"><%=dFormat.format(carrello.getPrezzoTotaleProdotti())%>
												€
											</p>
										</div>
										<div class="d-flex justify-content-between mb-4">
											<p class="mb-2">Totale(IVA inclusa)</p>
											<p class="mb-2"><%=dFormat.format(carrello.getPrezzoTotaleProdotti())%>
												€
											</p>
										</div>
										<div class="d-flex justify-content-between">
											<a href="Login?action=checkout"
												class="btn btn-dark btn-block btn-lg" id="btnCkt"><span>Checkout</span>
											</a>
										</div>
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