<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page
	import="it.unisa.beans.*, java.text.*,it.unisa.model.Carrello,java.util.*"%>
<%
Indirizzo indirizzo = (Indirizzo) request.getSession().getAttribute("indirizzo");

CodicePromozionale codicePromo = (CodicePromozionale) request.getSession().getAttribute("codice");
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
					<!-- Promo Code -->
					<%
					if (codicePromo != null) {
						double totale = carrello.getPrezzoTotaleProdotti() - codicePromo.getScontoApplicato();
						if (totale < 0)
							totale = 0;
					%>
					<li class="list-group-item d-flex justify-content-between bg-light">
						<div class="text-success">
							<h6 class="my-0">PROMO CODE</h6>
							<small><%=codicePromo.getCodice()%></small>
						</div> <span class="text-success">-<%=dFormat.format(codicePromo.getScontoApplicato())%>€
					</span>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Totale
					</span> <strong><%=dFormat.format(totale)%>€</strong></li>
					<%
					} else {
					%>
					<li class="list-group-item d-flex justify-content-between"><span>Totale

					</span> <strong><%=dFormat.format(carrello.getPrezzoTotaleProdotti())%>€</strong></li>
					<%
					}
					%>
				</ul>

				<form class="card p-2" action="Ordini?action=codicePromozionale"
					method="POST">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Promo code"
							name="promoCode">
						<button type="submit" class="btn btn-secondary">Applica</button>
					</div>
				</form>
			</div>
			<div class="col-md-7 col-lg-8">
				<%
				if (indirizzo == null) {
				%>
				<h4 class="mb-3">Inidirizzo di fatturazione</h4>
				<form class="needs-validation" novalidate autocomplete="off"
					name="checkoutIndirizzo" action="Ordini?action=indirizzo"
					method="POST" id="checkoutIndirizzo">
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
							<label for="via" class="form-label">Via</label> <input name="via"
								type="text" class="form-control" id="via" placeholder="Via Roma"
								required>
							<div class="invalid-feedback">Inserisci un indirizzo valido</div>
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
								name="provincia" type="text" class="form-control" id="provincia"
								placeholder="RO" required>
							<div class="invalid-feedback">Inserisci una provincia
								valida</div>
						</div>
						<div class="col-md-3">
							<label for="cap" class="form-label">CAP</label> <input name="cap"
								type="text" class="form-control" id="cap" placeholder="00123"
								required>
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
					<button class="w-100 btn btn-primary btn-lg mb-5" type="submit"
						id="procedi">Paga</button>
				</form>
				<%
				} else {
				%>
				<h4 class="mb-3">Inidirizzo di fatturazione</h4>
				<p class="mb-3">
					Hai già impostato il tuo indirizzo di fatturazione, per cambiare i
					dati o aggingere un nuovo indirizzo <a href="Utente">vai al tuo
						profilo</a> (sezione: indirizzi)
				</p>

				<div class="card  text-center">
					<div class="row g-3">
						<div class="col-md-3">
							<b>Nome: </b>
							<%=indirizzo.getNome()%>
						</div>
						<div class="col-md-3">
							<b>Cognome: </b>
							<%=indirizzo.getCognome()%>
						</div>
					</div>
					<div class="row g-3">
						<div class="card-text col-md-2">
							<b>Via: </b>
							<%=indirizzo.getVia()%>
						</div>
						<div class="card-text col-md-2">
							<b>Civico:</b>
							<%=indirizzo.getCivico()%>
						</div>
						<div class="card-text col-md-2">
							<b>Città: </b>
							<%=indirizzo.getCittà()%>
						</div>
						<div class="card-text col-md-2">
							<b>Cap: </b>
							<%=indirizzo.getCAP()%>
						</div>
						<div class="card-text col-md-3">
							<b>Provincia:</b>
							<%=indirizzo.getProvincia()%>
						</div>
					</div>
				</div>
				<a class="w-100 btn btn-primary btn-lg my-5"
					id="procediPagamentoButton">Procedi Al Pagamento</a>

				<%
				}
				%>

				<form class="needs-validation d-none" novalidate autocomplete="off"
					name="checkoutOrdine" action="Ordini?action=compra" method="POST"
					id="pagamento">
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
							<input id="cc-visa" name="metodoPagamento" type="radio"
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
					<button class="w-100 btn btn-primary btn-lg" type="submit"
						id="paga">Paga</button>
				</form>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

	<script>
		$(document).ready(function() {
			$("#regalo").click(function(event) {
				$("#giftSection").toggleClass("d-none");
			});
			$("#procediPagamentoButton").click(function(event) {
				$("#pagamento").removeClass("d-none");
			});
		});
	</script>

	<script>
	
			var nome = document.checkoutIndirizzo.nome;
			var cognome = document.checkoutIndirizzo.cognome;
			var form= document.checkoutIndirizzo;
			var cap = document.checkoutIndirizzo.cap;
			
			var nomeTitolare = document.checkoutOrdine.nomeTitolare;
			var cartaCreditoNumero=document.checkoutOrdine.cartaCreditoNumero;
			var cartaMastercard = document.getElementById("cc-mastercard");
			var cartaVisa = document.getElementById("cc-visa");
			var cartaAmericanExpress = document.getElementById("cc-amex");
			var dataScadenza = document.checkoutOrdine.dataScadenza;
			var cvv= document.checkoutOrdine.cvv;
			var nomeRegalo = document.checkoutOrdine.nomeRegalo;
			var mailRegalo = document.checkoutOrdine.mailRegalo;
			
			let validNome = false;
			let validCognome = false;
			let validCap = false; 
			let validNomeTitolare = false; 
			let validCartaCreditoNumero = false; 
			let validDataScadenza = false; 
			let validCvv = false; 
			let validNomeRegalo = false; 
			let validMailRegalo= false; 
			
			nome.addEventListener('blur', () => {
			    let regex = /^[a-zA-Z]([0-9a-zA-Z]){1,10}$/;
			    let str = nome.value;
			    if (regex.test(str)) {
			        nome.classList.add("is-valid");
			        validNome = true;
			    } else {
			        nome.classList.add("is-invalid");
			        validNome = false;
			    }
			    
			    nome.classList.add("was-validated");
			});
			
			cognome.addEventListener('blur', () => {
			    let regex = /^[a-zA-Z]([0-9a-zA-Z]){1,10}$/;
			    let str = cognome.value;
			    if (regex.test(str)) {
			        cognome.classList.add("is-valid"); 
			        validCognome = true;
			    } else {
			        cognome.classList.add("is-invalid");
			        validCognome = false;
			    }
			    
			    cognome.classList.add("was-validated");
			});
						
			mailRegalo.addEventListener('blur', () => {
			    let regex = /^([_\-\.a-zA-Z0-9]+)@([_\-\.a-zA-Z0-9]+)\.([a-zA-Z]){2,7}$/;
			    let str = mailRegalo.value;
			    if (regex.test(str)) {
			    	mailRegalo.classList.add("is-valid");
			        validMailRegalo = true;
			    } else {
			        email.classList.add("is-invalid");
			        validMailRegalo = false;
			    }
			    
			    email.classList.add("was-validated");
			});
			
			if (cartaVisa && cartaVisa.checked){	
				cartaCreditoNumero.addEventListener('blur',() => {
					var cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
					 let str = cartaCreditoNumero.value;
					 if (str.match(cardno)) {
						 cartaCreditoNumero.classList.add("is-valid");
					       validNumeroCarta= true;
					    } else {
					    	cartaCreditoNumero.classList.add("is-invalid");
					        validNumeroCarta = false;
					    }
					 cartaCreditoNumero.classList.add("was-validated");
				});
			} else 	if (cartaMastercard && cartaMastercard.checked){		
				cartaCreditoNumero.addEventListener('blur',()=>{
					var cardno = /^(?:5[1-5][0-9]{14})$/;
					 let str= cartaCreditoNumero.value;
					 if (str.match(cardno)) {
						 cartaCreditoNumero.classList.add("is-valid");
					       validNumeroCarta= true;
					    } else {
					    	cartaCreditoNumero.classList.add("is-invalid");
					        validNumeroCarta = false;
					    }
					 cartaCreditoNumero.classList.add("was-validated");
				});
			} else if (cartaAmericanExpress && cartaAmericanExpress.checked){
				cartaCreditoNumero.addEventListener('blur',()=>{
					var cardno = /^(?:3[47][0-9]{13})$/;
					 let str= cartaCreditoNumero.value;
					 if (str.match(cardno)) {
						 cartaCreditoNumero.classList.add("is-valid");
					       validNumeroCarta= true;
					    } else {
					    	cartaCreditoNumero.classList.add("is-invalid");
					        validNumeroCarta = false;
					    }
					 cartaCreditoNumero.classList.add("was-validated");
				});
			}
			
			cvv.addEventListener('blur',()=>{
				var number = /^[0-9]+$/;
				 let str= cvv.value;
				 if (number.test(str)) {
					 cvv.classList.add("is-valid");
				       validNumeroCarta= true;
				    } else {
				    	cvv.classList.add("is-invalid");
				        validNumeroCarta = false;
				    }
				 cvv.classList.add("was-validated");
			});
			
			
			nomeTitolare.addEventListener('blur',()=>{
				var number = /^[A-Za-z_ ]+$/;
				 let str= nomeTitolare.value;
				 if (number.test(str)) {
					 nomeTitolare.classList.add("is-valid");
				       validNomeTitolare= true;
				    } else {
				    	nomeTitolare.classList.add("is-invalid");
				        validNsomeTitolare = false;
				    }
			nomeTitolare.classList.add("was-validated");
			});
			
			dataScadenza.addEventListener('blur',()=>{
				var date= new Date(dataScadenza.value); 	
				var currentTime = new Date();
							
				var x= date.getTime() ;
				var y= currentTime.getTime();
		
				 if (y>=x) {
					 dataScadenza.classList.add("is-valid");
				       validDataScadenza= true;
				    } else {
				    	dataScadenza.classList.add("is-invalid");
				        validDataScadenza = false;
				    }
				 dataScadenza.classList.add("was-validated");
			});
		
			cap.addEventListener('blur',()=>{
				var number = /^[0-9]+$/;
				 let str= cap.value;
				 if (number.test(str)) {
					 cap.classList.add("is-valid");
				       validCap= true;
				    } else {
				    	cap.classList.add("is-invalid");
				        validCap = false;
				    }
				 cvv.classList.add("was-validated");
			});
			
			let submit = document.getElementById("submit");
			submit.addEventListener("click", (e) => {
			    e.preventDefault();
			    if (validEmail && validNome && validCognome && validPassword1 && validPassword && validCondizioni) {
			        form.classList.add("was-validated");
			        return true ;
			    } else {
			    	form.classList.add("was-validated");
			        return false; 
			    }
			});
	</script>
</body>
</html>