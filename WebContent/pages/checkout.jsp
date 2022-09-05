<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page
	import="it.unisa.beans.*, java.text.*,it.unisa.model.Carrello,java.util.*"%>
<%
Indirizzo indirizzo = (Indirizzo) request.getSession().getAttribute("indirizzo");

Utente utente = (Utente) request.getSession().getAttribute("utente");

if (indirizzo == null) {
	indirizzo = utente.getPreferredAddress();
}

DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Conferma Ordine</title>
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
<!-- MyScript -->
<script src="resources/scripts/checkoutScript.js"></script>
<style>
input.invalid {
	background-color: #ffdddd;
}
/* Hide all steps by default: */
.tab {
	display: none;
}
/* Make circles that indicate the steps of the form: */
.step {
	height: 15px;
	width: 15px;
	margin: 0 2px;
	background-color: #bbbbbb;
	border: none;
	border-radius: 50%;
	display: inline-block;
	opacity: 0.5;
}

/* Mark the active step: */
.step.active {
	opacity: 1;
}

/* Mark the steps that are finished and valid: */
.step.finish {
	background-color: #04AA6D;
}
</style>
</head>

<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<br>

	<jsp:useBean id="carrello" class="it.unisa.model.Carrello"
		scope="session" />

	<div class="container">
		<div class="row g-5">
			<div class="col-md-5 col-lg-4 order-md-last">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-primary">Il tuo carrello</span> <span
						class="badge bg-primary rounded-pill"><%=carrello.getQuantitàTotaleProdotti()%></span>
				</h4>
				<ul class="list-group mb-3">
					<%
					ProdottoCarrello[] prodottiCarrello = carrello.getProdotti().toArray(new ProdottoCarrello[0]);
					for (ProdottoCarrello prodottoCarrello : prodottiCarrello) {
						Albero prodotto = prodottoCarrello.getProdotto();
					%>
					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0"><%=prodotto.getNome()%></h6>
							<small class="text-muted"><%=dFormat.format(prodotto.getPrezzo())%>€
								al pezzo / Hai selezionato: <%=prodottoCarrello.getQuantità()%></small>
						</div> <span class="text-muted"><%=dFormat.format(prodottoCarrello.getPrezzoTotale())%>€</span>
					</li>
					<%}%>
					<li class="list-group-item d-flex justify-content-between"><span>Totale
					</span> <strong><%=dFormat.format(carrello.getPrezzoTotaleProdotti())%>€</strong></li>

				</ul>
			</div>
			<div class="col-md-7 col-lg-8">

				<form class="needs-validation" novalidate autocomplete="off"
					name="pagamento" action="Ordini?action=compra" method="POST"
					id="pagamento">
					<div class="tab">
						<%
						Indirizzo i = utente.getPreferredAddress();
						if (i != null) {
						%>
						<h4 class="mb-3">Inidirizzo di fatturazione</h4>
						<div class="row g-3">
							<div class="col-sm-6">
								<label for="nome" class="form-label">Nome</label> <input
									name="nome" type="text" class="form-control" id="nome"
									placeholder="Mario" required value="<%=i.getNome()%>">
								<div class="invalid-feedback">Inserisci il tuo nome.</div>
							</div>
							<div class="col-sm-6">
								<label for="cognome" class="form-label">Cognome</label> <input
									name="cognome" type="text" class="form-control" id="cognome"
									placeholder="Rossi" value="<%=i.getCognome()%>" required>
								<div class="invalid-feedback">Inserisci il tuo cognome.</div>
							</div>
							<div class="col-md-5">
								<label for="via" class="form-label">Via</label> <input
									name="via" type="text" class="form-control" id="via"
									placeholder="Via Roma" required value="<%=i.getVia()%>">
								<div class="invalid-feedback">Inserisci un indirizzo
									valido</div>
							</div>
							<div class="col-md-3">
								<label for="civico" class="form-label">Civico</label> <input
									name="civico" type="text" class="form-control" id="civico"
									placeholder="100" required value="<%=i.getCivico()%>">
								<div class="invalid-feedback">Inserisci un civico valido</div>
							</div>
							<div class="col-md-3">
								<label for="citta" class="form-label">Città</label> <input
									type="text" class="form-control" id="citta" name="citta"
									placeholder="Roma" required value="<%=i.getCittà()%>">
								<div class="invalid-feedback">Inserisci una città valida</div>
							</div>
							<div class="col-md-3">
								<label for="provincia" class="form-label">Provincia</label> <input
									name="provincia" type="text" class="form-control"
									id="provincia" placeholder="RO" required
									value="<%=i.getProvincia()%>">
								<div class="invalid-feedback">Inserisci una provincia
									valida</div>
							</div>
							<div class="col-md-3">
								<label for="cap" class="form-label">CAP</label> <input
									name="cap" type="text" class="form-control" id="cap"
									placeholder="00123" required value="<%=i.getCAP()%>">
								<div class="invalid-feedback">Inserisci un CAP valido.</div>
							</div>
						</div>
						<%} else {%>
						<h4 class="mb-3">Inidirizzo di fatturazione</h4>
						<div class="row g-3">
							<div class="col-sm-6">
								<label for="nome" class="form-label">Nome</label> <input
									name="nome" type="text" class="form-control" id="nome"
									placeholder="Mario" required value="">
								<div class="invalid-feedback">Inserisci il tuo nome.</div>
							</div>
							<div class="col-sm-6">
								<label for="cognome" class="form-label">Cognome</label> <input
									name="cognome" type="text" class="form-control" id="cognome"
									placeholder="Rossi" value="" required>
								<div class="invalid-feedback">Inserisci il tuo cognome.</div>
							</div>
							<div class="col-md-5">
								<label for="via" class="form-label">Via</label> <input
									name="via" type="text" class="form-control" id="via"
									placeholder="Via Roma" required>
								<div class="invalid-feedback">Inserisci un indirizzo
									valido</div>
							</div>
							<div class="col-md-3">
								<label for="civico" class="form-label">Civico</label> <input
									name="civico" type="text" class="form-control" id="civico"
									placeholder="100" required>
								<div class="invalid-feedback">Inserisci un civico valido</div>
							</div>
							<div class="col-md-3">
								<label for="citta" class="form-label">Città</label> <input
									type="text" class="form-control" id="citta" name="citta"
									placeholder="Roma" required>
								<div class="invalid-feedback">Inserisci una città valida</div>
							</div>
							<div class="col-md-3">
								<label for="provincia" class="form-label">Provincia</label> <input
									name="provincia" type="text" class="form-control"
									id="provincia" placeholder="RO" required>
								<div class="invalid-feedback">Inserisci una provincia
									valida</div>
							</div>
							<div class="col-md-3">
								<label for="cap" class="form-label">CAP</label> <input
									name="cap" type="text" class="form-control" id="cap"
									placeholder="00123" required>
								<div class="invalid-feedback">Inserisci un CAP valido.</div>
							</div>
						</div>
						<hr class="my-4">
						<div class="form-check mb-2">
							<input type="checkbox" class="form-check-input"
								id="preferredAddress" name="preferredAddress"> <label
								class="form-check-label" for="preferredAddress">Salva
								queste informazioni per la prossima volta</label>
						</div>
						<%
						}
						%>
					</div>
					<div class="tab">
						<h4 class="mb-3">Pagamento</h4>
						<div class="my-3">
							<div class="form-check">
								<input id="cc-amex" name="metodoPagamento" type="radio"
									class="form-check-input" checked required> <label
									class="form-check-label" for="cc-amex"><i
									class="fa-brands fa-cc-amex"></i> American Express </label>
							</div>
							<div class="form-check">
								<input id="cc-visa" name="metodoPagamento" type="radio"
									class="form-check-input" required> <label
									class="form-check-label" for="cc-visa"> <i
									class="fa-brands fa-cc-visa"></i> Carta Visa
								</label>
							</div>
							<div class="form-check">
								<input id="cc-mastercard" name="metodoPagamento" type="radio"
									class="form-check-input" required> <label
									class="form-check-label" for="cc-mastercard"> <i
									class="fa-brands fa-cc-mastercard"></i> Carta Mastercard
								</label>
							</div>
						</div>

						<div class="row gy-3">
							<div class="col-md-6">
								<label for="nomeTitolare" class="form-label">Nome
									Titolare</label> <input type="text" class="form-control"
									id="nomeTitolare" placeholder="Mario Rossi" required
									name="nomeTitolare"> <small class="text-muted">Inserisci
									il nome che apparre sulla carta</small>
								<div class="invalid-feedback">Il nome del titolare è
									obbgligatorio</div>
							</div>

							<div class="col-md-6">
								<label for="cartaCreditoNumero" class="form-label">Numero
									della carta di credito </label> <input type="text" class="form-control"
									id="cartaCreditoNumero" placeholder="XXXX-XXXX-XXXX" required
									name="cartaCreditoNumero">
								<div class="invalid-feedback">Il numero della carta di
									credito è obbgligatorio</div>
							</div>

							<div class="col-md-3">
								<label for="dataScadenza" class="form-label">Data di
									Scadenza</label> <input type="text" class="form-control"
									id="cc-expiration" placeholder="23-02-2026" required
									name="dataScadenza">
								<div class="invalid-feedback">La data di scadenza è
									obbgligatoria</div>
							</div>

							<div class="col-md-3">
								<label for="cvv" class="form-label">CVV</label> <input
									type="text" class="form-control" id="cvv" placeholder="XXX"
									required name="cvv">
								<div class="invalid-feedback">Il cvv è obbligatorio</div>
							</div>
						</div>

						<hr class="my-4">
						<h4 class="mb-3">Regalo</h4>
						<div class="form-check form-switch my-3">
							<input class="form-check-input" type="checkbox" id="regalo"
								name="regalo"> <label class="form-check-label"
								for="regalo"> <i class="fa-solid fa-gifts"></i> È un
								regalo?
							</label>
						</div>
						<div id="giftSection" class="row d-none my-3">
							<div class="col-5">
								<br>
								<p>Cosa riceve il destinatario?</p>
								<p>Il destinatario riceverà nella data da te selezionata:</p>
								<ul>
									<li>una mail di benvenuto con i datidell’albero</li>
									<li>Un PDF personalizzato la tua dedica e la tua firma</li>
									<li>7 aggiornamenti fotografici del suo albero in tre anni</li>
								</ul>
								<strong>Tu riceverai solo una mail di conferma
									dell’ordine.</strong>
							</div>
							<div class="col">
								<div class="row">
									<div class="col-6">
										<div class="form-group">
											<label class="col-form-label col-form-label-sm mt-4"
												for="nomeRegalo">Per chi è?</label> <input name="nomeRegalo"
												class="form-control form-control-sm" type="text"
												placeholder="Nome" id="nomeRegalo">
										</div>
									</div>
									<div class="col-6">
										<div class="form-group">
											<label class="col-form-label col-form-label-sm mt-4"
												for="mailRegalo">La sua mail?</label> <input
												name="mailRegalo" class="form-control form-control-sm"
												type="text" placeholder="e-mail" id="mailRegalo">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-form-label mt-4" for="messaggioRegalo">Inserisci
											una dedica</label> <input name="messaggioRegalo" type="text"
											class="form-control" placeholder="Iniserisci una dedica  =)"
											id="messaggioRegalo">
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<div class="container-fluid mt-5">
					<div style="overflow: auto;">
						<div style="float: right;">
							<button class="btn btn-dark" type="button" id="prevBtn"
								onclick="nextPrev(-1)">Previous</button>
							<button class="btn btn-dark" type="button" id="nextBtn"
								onclick="nextPrev(1)">Next</button>
						</div>
					</div>
					<!-- Circles which indicates the steps of the form: -->
					<div style="text-align: center; margin-top: 40px;">
						<span class="step"></span> <span class="step"></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#regalo").click(function() {
				$("#giftSection").toggleClass("d-none");
			});
		});
	</script>
	<script>
		// per il form
		var currentTab = 0;
		showTab(currentTab);

		function showTab(n) {
			var x = document.getElementsByClassName("tab");
			x[n].style.display = "block";
			if (n == 0) {
				document.getElementById("prevBtn").style.display = "none";
			} else {
				document.getElementById("prevBtn").style.display = "inline";
			}
			if (n == (x.length - 1)) {
				document.getElementById("nextBtn").innerHTML = "Paga";
			} else {
				document.getElementById("nextBtn").innerHTML = "Next";
			}
			fixStepIndicator(n)
		}

		function nextPrev(n) {
			var x = document.getElementsByClassName("tab");
			if (n == 1 && !validateForm())
				return false;
			x[currentTab].style.display = "none";
			currentTab = currentTab + n;

			if (currentTab >= x.length) {
				document.getElementById("pagamento").submit();
				return false;
			}
			showTab(currentTab);
		}

		function validateForm() {
			var x, y, i, valid = true;
			x = document.getElementsByClassName("tab");
			y = x[currentTab].getElementsByTagName("input");

			for (i = 0; i < y.length; i++) {

				if (y[i].name == "nome" || y[i].name == "cognome"
						|| y[i].name == "citta" || y[i].name == "provincia") {
					if (validateText(y[i])) {
						y[i].classList.add("was-validated");
						y[i].classList.add("is-valid");
					}

					else {
						y[i].classList.add("is-invalid");
						valid = false;
					}

				} else if (y[i].name == "via") {
					if (y[i].value == "") {
						y[i].classList.add("is-invalid");
						valid = false;
					} else {
						y[i].classList.add("is-valid");
						y[i].classList.add("was-validated");
					}
				} else if (y[i].name == "nomeTitolare") {
					if (validateNome(y[i])) {
						y[i].classList.add("was-validated");
						y[i].classList.add("is-valid");
					} else {
						y[i].classList.add("is-invalid");
						valid = false;
					}
				} else if (y[i].name == "civico" || y[i].name == "cap") {
					if (validateNumber(y[i])) {
						y[i].classList.add("was-validated");
						y[i].classList.add("is-valid");
					} else {
						y[i].classList.add("is-invalid");
						valid = false;
					}
				} else if (y[i].name == "dataScadenza") {
					if (validateData(y[i])) {
						y[i].classList.add("was-validated");
						y[i].classList.add("is-valid");
					} else {
						y[i].classList.add("is-invalid");
						valid = false;
					}
				} else if (y[i].name == "cvv") {
					if (validateCvv(y[i])) {
						y[i].classList.add("was-validated");
						y[i].classList.add("is-valid");
					} else {
						y[i].classList.add("is-invalid");
						valid = false;
					}
				} else if (y[i].name == "cartaCreditoNumero") {
					if (document.getElementById('cc-amex').checked) {
						if (validateAmerican(y[i])) {
							y[i].classList.add("was-validated");
							y[i].classList.add("is-valid");
						} else {
							y[i].classList.add("is-invalid");
							valid = false;
						}
					} else if (document.getElementById('cc-visa').checked) {
						if (validateVisa(y[i])) {
							y[i].classList.add("was-validated");
							y[i].classList.add("is-valid");
						} else {
							y[i].classList.add("is-invalid");
							valid = false;
						}
					} else if (document.getElementById('cc-mastercard').checked) {
						if (validateMasterCard(y[i])) {
							y[i].classList.add("was-validated");
							y[i].classList.add("is-valid");
						} else {
							y[i].classList.add("is-invalid");
							valid = false;
						}
					}
				} else if (y[i].name == "mailRegalo") {
					if (document.getElementById('regalo').checked) {
						if (validateMail(y[i])) {
							y[i].classList.add("was-validated");
							y[i].classList.add("is-valid");
						} else {
							y[i].classList.add("is-invalid");
							valid = false;
						}
					}
				} else if (y[i].name == "messaggioRegalo") {
					if (document.getElementById('regalo').checked) {
						if (y[i].value == "") {
							y[i].classList.add("is-invalid");
							valid = false;
						} else {
							y[i].classList.add("is-valid");
							y[i].classList.add("was-validated");
						}
					}
				} else if (y[i].name == "nomeRegalo") {
					if (document.getElementById('regalo').checked) {
						if (y[i].value == "") {
							y[i].classList.add("is-invalid");
							valid = false;
						} else {
							y[i].classList.add("is-valid");
							y[i].classList.add("was-validated");
						}
					}
				}
			}
			if (valid) {
				document.getElementsByClassName("step")[currentTab].className += " finish";
			}
			return valid;

		}

		function fixStepIndicator(n) {
			var i, x = document.getElementsByClassName("step");
			for (i = 0; i < x.length; i++) {
				x[i].className = x[i].className.replace(" active", "");
			}
			x[n].className += " active";
		}

		function validateText(y) {
			let regex = /^[a-zA-Z]([0-9a-zA-Z]){1,10}$/;
			let str = y.value;
			if (regex.test(str)) {
				return true;
			} else {
				return false;
			}
		}
		function validateNome(y) {
			let regex = /^[A-Za-z_ ]+$/;
			let str = y.value;
			if (str.match(regex)) {
				return true;
			} else {
				return false;
			}
		}
		function validateData(r) {
			var date = new Date(r.value);
			var currentTime = new Date();

			var x = date.getTime();
			var y = currentTime.getTime();

			if (x <= y) {
				return false;
			} else {
				return true;
			}
		}
		function validateNumber(y) {
			let regex = /^[0-9]+$/;
			let str = y.value;
			if (str.match(regex)) {
				return true;
			} else {
				return false;
			}
		}
		function validateMail(y) {
			let regex = /^([_\-\.a-zA-Z0-9]+)@([_\-\.a-zA-Z0-9]+)\.([a-zA-Z]){2,7}$/;
			let str = y.value;
			if (str.match(regex)) {
				return true;
			} else {
				return false;
			}
		}

		function validateMasterCard(y) {
			let cardno = /^(?:5[1-5][0-9]{14})$/;
			let str = y.value;
			if (str.match(cardno)) {
				return true;
			} else {
				return false;
			}
		}
		function validateVisa(y) {
			let cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
			let str = y.value;
			if (str.match(cardno)) {
				return true;
			} else {
				return false;
			}
		}
		function validateAmerican(y) {
			let cardno = /^(?:3[47][0-9]{13})$/;
			let str = y.value;
			if (str.match(cardno)) {
				return true;
			} else {
				return false;
			}

		}
		function validateCvv(y) {
			let number = /^[0-9]+$/;
			let str = y.value;
			if (str.match(number)) {
				return true;
			} else {
				return false;
			}
		}
	</script>
</body>
</html>