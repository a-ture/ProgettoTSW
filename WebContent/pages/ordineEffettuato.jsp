<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- accesso alla sessione -->
<%@ page session="true"%>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*, it.unisa.beans.*,java.text.*"%>
<%
Utente utente = (Utente) request.getSession().getAttribute("utente");
Ordine ordine = (Ordine) request.getSession().getAttribute("ordineUtente");
if (ordine == null) {
	response.sendRedirect("Ordini?action=vista");
	return;
}
DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordine Effettuato</title>
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
</head>
<body>
	<section class="h-100 gradient-custom">
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-lg-10 col-xl-8">
					<div class="card" style="border-radius: 10px;">
						<div class="card-header px-4 py-5">
							<h5 class="text-muted mb-0">
								Grazie per il tuo ordine, <span style="color: #a8729a;">
									<%=utente.getNome()%>
								</span>!
							</h5>
						</div>
						<div class="card-body p-4">
							<div
								class="d-flex justify-content-between align-items-center mb-4">
								<p class="lead fw-normal mb-0" style="color: #a8729a;">Il
									tuo ordine:</p>
								<p class="small text-muted mb-0">
									Numero ordine:
									<%=ordine.getId()%></p>
							</div>
							<%
							Collection<ProdottoOrdine> prodotti = ordine.getItems();
							Iterator<?> it = prodotti.iterator();
							while (it.hasNext()) {
								ProdottoOrdine prodotto = (ProdottoOrdine) it.next();
							%>
							<div class="card shadow-0 border mb-4">
								<div class="card-body">
									<div class="row">

										<div
											class="col-md-2 text-center d-flex justify-content-center align-items-center">
											<p class="text-muted mb-0"><%=prodotto.getNome()%></p>
										</div>
										<div
											class="col-md-2 text-center d-flex justify-content-center align-items-center">
											<p class="text-muted mb-0 small">
												Quantità:
												<%=prodotto.getQuantità()%></p>
										</div>
										<div
											class="col-md-2 text-center d-flex justify-content-center align-items-center">
											<p class="text-muted mb-0 small"><%=dFormat.format(prodotto.getPrezzo())%>
												€
											</p>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							%>
							<div class="d-flex justify-content-between pt-2">
								<p class="fw-bold mb-0">Dettagli ordine</p>
								<p class="text-muted mb-0">
									<span class="fw-bold me-4">Totale</span>
									<%=ordine.getTotalePagato()%>
								</p>
							</div>

							<div class="d-flex justify-content-between pt-2">
								<p class="text-muted mb-0">
									Numero prodotti :
									<%=ordine.getTotaleProdotti()%></p>
								<p class="text-muted mb-0">
									<span class="fw-bold me-4">Discount</span> $19.00
								</p>
							</div>

							<div class="d-flex justify-content-between">
								<p class="text-muted mb-0">
									Effettuato il :
									<%=ordine.getCreatoIl()%></p>
								<p class="text-muted mb-0">
									<span class="fw-bold me-4">GST 18%</span> 123
								</p>
							</div>
						</div>
						<div class="card-footer border-0 px-4 py-5"
							style="background-color: #a8729a; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
							<h5
								class="d-flex align-items-center justify-content-end text-white text-uppercase mb-0">
								Totale: <span class="h2 mb-0 ms-2"><%=dFormat.format(ordine.getTotalePagato())%>€</span>
							</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
		<p class="text-center">
			Torna alla <a href="Home">Home</a>
		</p>
	</section>
</body>
</html>