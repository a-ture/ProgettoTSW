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
 <!-- Favicon -->
 <link rel="icon" type="image/x-icon" href="resources/img/logo.png">
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
 					id="formPagamento">
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
 									placeholder="Mario" required value="<%=i.getNome()%>" >
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il nome non è valido.</div>
 							</div>
 							<div class="col-sm-6">
 								<label for="cognome" class="form-label">Cognome</label> <input
 									name="cognome" type="text" class="form-control" id="cognome"
 									placeholder="Rossi" value="<%=i.getCognome()%>" required>
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il cognome non è valido.</div>
 							</div>
 							<div class="col-md-5">
 								<label for="via" class="form-label">Via</label> <input
 									name="via" type="text" class="form-control" id="via"
 									placeholder="Via Roma" required value="<%=i.getVia()%>">
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">La via non è corretta.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="civico" class="form-label">Civico</label> <input
 									name="civico" type="text" class="form-control" id="civico"
 									placeholder="100" required value="<%=i.getCivico()%>">
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il civico non è corretto.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="citta" class="form-label">Città</label> <input
 									type="text" class="form-control" id="citta" name="citta"
 									placeholder="Roma" required value="<%=i.getCittà()%>">
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">La città non è corretta.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="provincia" class="form-label">Provincia</label> <input
 									name="provincia" type="text" class="form-control"
 									id="provincia" placeholder="RO" required
 									value="<%=i.getProvincia()%>">
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">La provincia non è
 										corretta.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="cap" class="form-label">CAP</label> <input
 									name="cap" type="text" class="form-control" id="cap"
 									placeholder="00123" required value="<%=i.getCAP()%>">
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il CAP non è corretto.</div>
 							</div>
 						</div>
 						<%} else {%>
 						<h4 class="mb-3">Indirizzo di fatturazione</h4>
 						<div class="row g-3">
 							<div class="col-sm-6">
 								<label for="nome" class="form-label">Nome</label> <input
 									name="nome" type="text" class="form-control" id="nome"
 									placeholder="Mario" required value="">
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il nome non è valido.</div>
 							</div>
 							<div class="col-sm-6">
 								<label for="cognome" class="form-label">Cognome</label> <input
 									name="cognome" type="text" class="form-control" id="cognome"
 									placeholder="Rossi" value="" required>
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il cognome non è valido.</div>
 							</div>
 							<div class="col-md-5">
 								<label for="via" class="form-label">Via</label> <input
 									name="via" type="text" class="form-control" id="via"
 									placeholder="Via Roma" required>
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">La via non è corretta.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="civico" class="form-label">Civico</label> <input
 									name="civico" type="text" class="form-control" id="civico"
 									placeholder="100" required>
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il civico non è corretto.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="citta" class="form-label">Città</label> <input
 									type="text" class="form-control" id="citta" name="citta"
 									placeholder="Roma" required>
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">La città non è corretta.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="provincia" class="form-label">Provincia</label> <input
 									name="provincia" type="text" class="form-control"
 									id="provincia" placeholder="RO" required>
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">La provincia non è
 										corretta.</div>
 							</div>
 							<div class="col-md-3">
 								<label for="cap" class="form-label">CAP</label> <input
 									name="cap" type="text" class="form-control" id="cap"
 									placeholder="00123" required>
 								<div class="valid-feedback">Looks good!</div>
 									<div class="invalid-feedback">Il CAP non è corretto.</div>
 							</div>
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
 									obbligatorio</div>
 							</div>

 							<div class="col-md-6">
 								<label for="cartaCreditoNumero" class="form-label">Numero
 									della carta di credito </label> <input type="text" class="form-control"
 									id="cartaCreditoNumero" placeholder="XXXX-XXXX-XXXX" required
 									name="cartaCreditoNumero">
 								<div class="invalid-feedback">Il numero della carta di
 									credito è obbligatorio</div>
 							</div>

 							<div class="col-md-3">
 								<label for="dataScadenza" class="form-label">Data di
 									Scadenza</label> <input type="text" class="form-control"
 									id="cc-expiration" placeholder="02/2026" required
 									name="dataScadenza">
 								<div class="invalid-feedback">La data di scadenza è
 									obbligatorio</div>
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
 				document.getElementById("formPagamento").submit();
 				return false;
 			}
 			showTab(currentTab);
 		}

 		function validateForm() {
 			var x, y, i, valid = true;
 			x = document.getElementsByClassName("tab");
 			y = x[currentTab].getElementsByTagName("input");

 			for (i = 0; i < y.length; i++) {

 				
 				if (y[i].name == "nome" ) {
 					if (validateNome(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					}	else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 				}else if(y[i].name == "cognome"){
 					if (validateCognome(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					}	else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 				}else if(y[i].name == "citta"){
 					if (validateCitta(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					}	else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 				}else if(y[i].name == "provincia"){
 					if (validateProvincia(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					}	else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "via") {
 					if(validateVia(y[i])){
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					} else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "nomeTitolare") {
 					if (validateNome(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					} else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 					
 				}else if(y[i].name == "cap"){
 					if (validateCAP(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					} else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "civico") {
 					if (validateCivico(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					} else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "dataScadenza") {
 					if (validateData(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					} else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "cvv") {
 					if (validateCvv(y[i])) {
 						y[i].classList.add("is-valid");
 						y[i].classList.remove("is-invalid");
 					} else {
 						y[i].classList.add("is-invalid");
 						y[i].classList.remove("is-valid");
 						valid = false;
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "cartaCreditoNumero") {
 					if (document.getElementById('cc-amex').checked) {
 						if (validateAmerican(y[i])) {
 							y[i].classList.add("is-valid");
 							y[i].classList.remove("is-invalid");
 						} else {
 							y[i].classList.add("is-invalid");
 							y[i].classList.remove("is-valid");
 							valid = false;
 						}
 						y[i].classList.add("was-validated");
 						
 					} else if (document.getElementById('cc-visa').checked) {
 						if (validateVisa(y[i])) {
 							y[i].classList.add("is-valid");
 							y[i].classList.remove("is-invalid");
 						} else {
 							y[i].classList.add("is-invalid");
 							y[i].classList.remove("is-valid");
 							valid = false;
 						}
 						y[i].classList.add("was-validated");
 						
 					} else if (document.getElementById('cc-mastercard').checked) {
 						if (validateMasterCard(y[i])) {
 							y[i].classList.add("is-valid");
 							y[i].classList.remove("is-invalid");
 						} else {
 							y[i].classList.add("is-invalid");
 							y[i].classList.remove("is-valid");
 							valid = false;
 						}
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "mailRegalo") {
 					if (document.getElementById('regalo').checked) {
 						if (validateEmail(y[i])) {
 							y[i].classList.add("is-valid");
 							y[i].classList.remove("is-invalid");
 						} else {
 							y[i].classList.add("is-invalid");
 							y[i].classList.remove("is-valid");
 							valid = false;
 						}
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "messaggioRegalo") {
 					if (document.getElementById('regalo').checked) {
 						if (y[i].value != "") {
 							y[i].classList.add("is-valid");
 							y[i].classList.remove("is-invalid");
 						} else {
 							y[i].classList.add("is-invalid");
 							y[i].classList.remove("is-valid");
 							valid = false;
 						}
 					}
 					y[i].classList.add("was-validated");
 					
 				} else if (y[i].name == "nomeRegalo") {
 					if (document.getElementById('regalo').checked) {
 						if (y[i].value != "") {
 							y[i].classList.add("is-valid");
 							y[i].classList.remove("is-invalid");
 						} else {
 							y[i].classList.add("is-invalid");
 							y[i].classList.remove("is-valid");
 							valid = false;
 						}
 					}
 					y[i].classList.add("was-validated");
 					
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
 		
 		
 		function validateNome(y) {
 			let regex = /^[a-zA-Z]([ a-zA-Z])+$/;
 			let str = y.value;
 			if (regex.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		
 		function validateCognome(y) {
 			let regex = /^[a-zA-Z]([ a-zA-Z]){1,10}$/;
 			let str = y.value;
 			if (regex.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		
 		function validateProvincia(y) {
 			let regex = /^[A-Z]{2}$/;
 			let str = y.value;
 			if (regex.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		
 		function validateCitta(y) {
 			let regex = /^[a-zA-Z]([ a-zA-Z]){1,10}$/;
 			let str = y.value;
 			if (regex.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		
 		function validateVia(y) {
 			let regex = /^[a-zA-Z]([ a-zA-Z])+$/;
 			let str = y.value;
 			if (regex.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		
 		function validateCAP(y) {
 			let regex = /^\d{5}$/;
 			let str = y.value;
 			if (regex.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		
 		function validateCivico(y) {
 			let regex = /^[0-9]+$/;
 			let str = y.value;
 			if (regex.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		
 		function validateData(r) {
 			let regex = /^(0?[1-9]|1[012])[\/\-]\d{4}$/;
 			let str = r.value;
 			if(regex.test(str)){
 				var mese = str.substring(0,2);
 				var anno  = str. substring(3,7);
 				var today = new Date();
 				var someday = new Date();
 				someday.setFullYear(anno, mese, 1);

 				if (someday < today) {
 				   return false;
 				}
 				return true;
 			}else{
 				return false;
 			}
 			
 		}
 		
 		function validateEmail(y) {
 		    let regex = /^([_\-\.a-zA-Z0-9]+)@([_\-\.a-zA-Z0-9]+)\.([a-zA-Z]){2,7}$/;
 		    let str = y.value;
 		    if (regex.test(str)) {
 		       return true;
 		    } else {
 		       return false;
 		    }
 		}
 		
 		function validateMasterCard(y) { //5342987654320009
 			let cardno = /^(?:5[1-5][0-9]{14})$/;
 			let str = y.value;
 			if (cardno.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		function validateVisa(y) { //4000123498760000
 			let cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
 			let str = y.value;
 			if (cardno.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 		function validateAmerican(y) {	//375987654321001
 			let cardno = /^(?:3[47][0-9]{13})$/;
 			let str = y.value;
 			if (cardno.test(str)) {
 				return true;
 			} else {
 				return false;
 			}

 		}
 		function validateCvv(y) {
 			let number = /^[0-9]{3}$/;
 			let str = y.value;
 			if (number.test(str)) {
 				return true;
 			} else {
 				return false;
 			}
 		}
 	</script>
 </body>
