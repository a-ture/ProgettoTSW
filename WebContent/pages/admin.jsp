<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,it.unisa.beans.*, java.text.*"%>
<%
Collection<?> ordini = (Collection<?>) request.getAttribute("ordini");
Collection<?> utenti = (Collection<?>) request.getAttribute("utenti");
Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");

double totale = (double) request.getAttribute("totaleIncassi");

DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="resources/css/_bootswatch.scss">
<link rel="stylesheet" type="text/css"
	href="resources/css/styleAdmin.css">

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

	<div id="dashboard" class="container">
		<div class="home-content">
			<div class="overview-boxes">
				<div class="box">
					<div class="right-side">
						<div class="box-topic">Totale Ordini</div>
						<div class="number">
							<%=ordini.size()%>
						</div>
					</div>
					<i class='bx bx-cart-alt cart'><i class="fas fa-shopping-cart"></i></i>
				</div>

				<div class="box">
					<div class="right-side">
						<div class="box-topic">Totale Utenti</div>
						<div class="number"><%=utenti.size()%></div>
					</div>
					<i class='bx bxs-cart-add cart two'><i
						class="fas fa-user-circle"> </i></i>
				</div>

				<div class="box">
					<div class="right-side">
						<div class="box-topic">Totale Prodotti</div>
						<div class="number"><%=prodotti.size()%></div>
					</div>
					<i class='bx bx-cart cart three'><i class="fas fa-tshirt">
					</i></i>
				</div>

				<div class="box">
					<div class="right-side">
						<div class="box-topic">Totale Incassi</div>
						<div class="number">
							<%=totale%>
						</div>
					</div>
					<i class='bx bxs-cart-download cart four'><i
						class="fas fa-money-bill-alt"></i></i>
				</div>
			</div>
		</div>

		<div class="row d-flex justify-content-center">
			<div class="tab">
				<div class="row">
					<div class="col">
						<div class="text-center fw-bold h3">Ordini Recenti</div>
					</div>
					<div class="col">
						<button type="button" class="btn btn-dark col">See All</button>
					</div>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Codice</th>
							<th scope="col">Email Utente</th>
							<th scope="col">Totale</th>
							<th scope="col">Creato il</th>
						</tr>
					</thead>
					<%
					if (ordini != null && ordini.size() != 0) {
						Iterator<?> it = ordini.iterator();
						while (it.hasNext()) {
							Ordine bean = (Ordine) it.next();
					%>
					<tbody>
						<tr>
							<th scope="row"><%=bean.getId()%></th>
							<td><%=bean.getUtente()%></td>
							<td><%=bean.getTotalePagato()%></td>
							<td><%=bean.getCreatoIl()%></td>
						</tr>
					</tbody>
					<%
					}
					}
					%>
				</table>
			</div>
		</div>

		<br /> <br />

		<div class="row d-flex justify-content-center">
			<div class="tab">
				<div class="row">
					<div class="col">
						<div class="text-center fw-bold h3">Prodotti Più Venduti</div>
					</div>
					<div class="col">
						<button type="button" class="btn btn-dark">See All</button>
					</div>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Codice</th>
							<th scope="col">Nome</th>
							<th scope="col">Categoria</th>
							<th scope="col">Prezzo</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (prodotti != null && prodotti.size() != 0) {
							Iterator<?> it6 = prodotti.iterator();
							while (it6.hasNext()) {
								Prodotto bean = (Prodotto) it6.next();
						%>
						<tr>
							<th scope="row"><%=bean.getId()%></th>
							<td><%=bean.getNome()%></td>
							<td><%=bean.getCategorie()%></td>
							<td><%=bean.getPrezzo()%> €</td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>

		<br /> <br />

		<div class="row d-flex justify-content-center">
			<div class="tab">
				<div class="row">
					<div class="col">
						<div class="text-center fw-bold h3">Utenti</div>
					</div>
					<div class="col">
						<button type="button" class="btn btn-dark">See All</button>
					</div>
				</div>

				<table class="table">
					<thead>
						<tr>
							<th scope="col">Email</th>
							<th scope="col">Nome</th>
							<th scope="col">Data Iscrizione</th>
							<th scope="col">Telefono</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (utenti != null && utenti.size() != 0) {
							Iterator<?> it7 = utenti.iterator();
							while (it7.hasNext()) {
								Utente bean = (Utente) it7.next();
						%>
						<tr>
							<th scope="row"><%=bean.getEmail()%></th>
							<td><%=bean.getNome()%></td>
							<td><%=bean.getCognome()%></td>
							<td><%=bean.getUsername()%></td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>

		<br /> <br />


	</div>

	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

</body>
</html>