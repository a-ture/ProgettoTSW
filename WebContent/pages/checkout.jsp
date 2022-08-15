<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page
	import="it.unisa.beans.*, java.text.*,it.unisa.model.Carrello,java.util.*"%>
<%
Indirizzo indirizzo = (Indirizzo) request.getSession().getAttribute("indirizzo");

DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Conferma Ordine</title>
<!--CSS-->
<link rel="stylesheet" type="text/css"
	href="./resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="./resources/css/_variables.scss">
<link rel="stylesheet" type="text/css"
	href="./resources/css/_bootswatch.scss">

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
						Prodotto prodotto = prodottoCarrello.getProdotto();
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
					<li
						class="list-group-item d-flex justify-content-between bg-light d-none">
						<div class="text-success">
							<h6 class="my-0">Promo code</h6>
							<small>EXAMPLECODE</small>
						</div> <span class="text-success">-$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Totale
					</span> <strong><%=dFormat.format(carrello.getPrezzoTotaleProdotti())%>€</strong></li>
				</ul>

				<form class="card p-2">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Promo code">
						<button type="submit" class="btn btn-secondary">Applica</button>
					</div>
				</form>
			</div>
			<div class="col-md-7 col-lg-8">
				<h4 class="mb-3">Inidirizzo di fatturazione</h4>
				<form class="needs-validation" novalidate autocomplete="off"
					name="checkout" action="Ordini?action=compra" method="POST">
					<div class="row g-3">
						<div class="col-sm-6">
							<label for="nome" class="form-label">Nome</label> <input
								type="text" class="form-control" id="nome" placeholder="Mario"
								required value="">
							<div class="invalid-feedback">Inserisci il tuo nome.</div>
						</div>
						<div class="col-sm-6">
							<label for="cognome" class="form-label">Cognome</label> <input
								type="text" class="form-control" id="cognome"
								placeholder="Rossi" value="" required>
							<div class="invalid-feedback">Inserisci il tuo cognome.</div>
						</div>

						<div class="col-md-5">
							<label for="via" class="form-label">Via</label> <input
								type="text" class="form-control" id="via" placeholder="Via Roma"
								required>
							<div class="invalid-feedback">Inserisci un indirizzo valido</div>
						</div>
						<div class="col-md-3">
							<label for="via" class="form-label">Civico</label> <input
								type="text" class="form-control" id="via" placeholder="100"
								required>
							<div class="invalid-feedback">Inserisci un civico valido</div>
						</div>
						<div class="col-md-3">
							<label for="città" class="form-label">Città</label> <input
								type="text" class="form-control" id="città" placeholder="Roma"
								required>
							<div class="invalid-feedback">Inserisci una città valida</div>
						</div>
						<div class="col-md-3">
							<label for="provincia" class="form-label">Provincia</label> <input
								type="text" class="form-control" id="provincia" placeholder="RO"
								required>
							<div class="invalid-feedback">Inserisci una provincia
								valida</div>
						</div>
						<div class="col-md-3">
							<label for="cap" class="form-label">CAP</label> <input
								type="text" class="form-control" id="cap" placeholder="00123"
								required>
							<div class="invalid-feedback">Inserisci un CAP valido.</div>
						</div>
					</div>
					<hr class="my-4">
					<div class="form-check">
						<input type="checkbox" class="form-check-input"
							id="preferredAddress"> <label class="form-check-label"
							for="preferredAddress">Salva queste informazioni per la
							prossima volta</label>
					</div>

					<hr class="my-4">
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
								id="nomeTitolare" placeholder="" required> <small
								class="text-muted">Inserisci il nome che apparre sulla
								carta</small>
							<div class="invalid-feedback">Il nome del titolare è
								obbgligatorio</div>
						</div>

						<div class="col-md-6">
							<label for="cartaCreditoNumero" class="form-label">Numero
								della carta di credito </label> <input type="text" class="form-control"
								id="cartaCreditoNumero" placeholder="XXXX-XXXX-XXXX" required>
							<div class="invalid-feedback">Il numero della carta di
								credito è obbgligatorio</div>
						</div>

						<div class="col-md-3">
							<label for="dataScadenza" class="form-label">Data di
								Scadenza</label> <input type="text" class="form-control"
								id="cc-expiration" placeholder="23-02-2026" required>
							<div class="invalid-feedback">La data di scadenza è
								obbgligatoria</div>
						</div>

						<div class="col-md-3">
							<label for="cvv" class="form-label">CVV</label> <input
								type="text" class="form-control" id="cvv" placeholder="XXX"
								required>
							<div class="invalid-feedback">Il cvv è obbligatorio</div>
						</div>
					</div>

					<hr class="my-4">
					<h4 class="mb-3">Regalo</h4>
					<div class="form-check form-switch my-3">
						<input class="form-check-input" type="checkbox" id="regalo">
						<label class="form-check-label" for="regalo"> <i
							class="fa-solid fa-gifts"></i> È un regalo?
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
											for="nomeRegalo">Per chi è?</label> <input
											class="form-control form-control-sm" type="text"
											placeholder="Nome" id="nomeRegalo">
									</div>
								</div>
								<div class="col-6">
									<div class="form-group">
										<label class="col-form-label col-form-label-sm mt-4"
											for="mailRegalo">La sua mail?</label> <input
											class="form-control form-control-sm" type="text"
											placeholder="e-mail" id="mailRegalo">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<label class="col-form-label mt-4" for="messaggioRegalo">Inserisci
										una dedica</label> <input type="text" class="form-control"
										placeholder="Iniserisci una dedica  =)" id="messaggioRegalo">
								</div>
							</div>
						</div>
					</div>
					<button class="w-100 btn btn-primary btn-lg" type="submit">Paga</button>
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
			$("#flexSwitchCheckDefault").click(function(event) {
				$("#giftSection").toggleClass("d-none");
			});

		});
	</script>
	<script type="text/javascript">

			var email = document.checkout.email;
			var nome = document.checkout.nome;
			var cognome = document.checkout.cognome;
			var form= document.checkout;
			var cap = document.checkout.cap;
			var nomeTitolare = document.checkout.nomeTitolare;
			var cartaCreditoNumero=document.checkout.cartaCreditoNumero;
			var cartaMastercard = document.checkout.cc-mastercard;
			var cartaVisa = document.checkout.cc-visa;
			var cartaAmercianExpress = document.checkout.cc-amex;
			var dataScadenza = document.checkout.dataScadenza;
			var cvv= document.checkout.cvv;
			var nomeRegalo = document.checkout.nomeRegalo;
			var mailRegalo = document.checkout.mailRegalo;
			
			let validNome = false;
			let validCognome = false;
			let validEmail = false;
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
			
			email.addEventListener('blur', () => {
			    let regex = /^([_\-\.a-zA-Z0-9]+)@([_\-\.a-zA-Z0-9]+)\.([a-zA-Z]){2,7}$/;
			    let str = email.value;
			    if (regex.test(str)) {
			        email.classList.add("is-valid");
			        validEmail = true;
			    } else {
			        email.classList.add("is-invalid");
			        validEmail = false;
			    }
			    
			    email.classList.add("was-validated");
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
			if (cartaVisa.checked){	
				cartaCreditoNumero.addEVentListener('blur',()=>{
					 let cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
					 ler str = numeroCarta.value;
					 if (cardno.test(str)) {
						 cartaCreditoNumero.classList.add("is-valid");
					       validNumeroCarta= true;
					    } else {
					    	cartaCreditoNumero.classList.add("is-invalid");
					        validNumeroCarta = false;
					    }
				})
				cartaCreditoNumero.classList.add("was-validated");
			}
			
			if (cartaMastercard.checked){
				cartaCreditoNumero.addEVentListener('blur',()=>{
					 let cardno = /^(?:5[1-5][0-9]{14})$/;
					 ler str= cartaCreditoNumero.value;
					 if (cardno.test(str)) {
						 cartaCreditoNumero.classList.add("is-valid");
					       validNumeroCarta= true;
					    } else {
					    	cartaCreditoNumero.classList.add("is-invalid");
					        validNumeroCarta = false;
					    }
				})
				numeroCarta.classList.add("was-validated");
			}
			
			if (cartaAmericanExpress.checked){
				cartaCreditoNumero.addEVentListener('blur',()=>{
					 let cardno = /^(?:3[47][0-9]{13})$/;
					 ler str= numeroCarta.value;
					 if (cardno.test(str)) {
						 cartaCreditoNumero.classList.add("is-valid");
					       validNumeroCarta= true;
					    } else {
					    	cartaCreditoNumero.classList.add("is-invalid");
					        validNumeroCarta = false;
					    }
				})
				numeroCarta.classList.add("was-validated");s
			}
			
			cvv.addEVentListener('blur',()=>{
				var number = /^[0-9]+$/;
				 ler str= numeroCarta.value;
				 if (number.test(str)) {
				       numeroCarta.classList.add("is-valid");
				       validNumeroCarta= true;
				    } else {
				        numeroCarta.classList.add("is-invalid");
				        validNumeroCarta = false;
				    }
			})
			cvv.classList.add("was-validated");
			
			nomeTitolare.addEVentListener('blur',()=>{
				var number = /^[A-Za-z_ ]+$/;
				 ler str= nomeTitolare.value;
				 if (number.test(str)) {
					 nomeTitolare.classList.add("is-valid");
				       validNomeTitolare= true;
				    } else {
				    	nomeTitolare.classList.add("is-invalid");
				        validNsomeTitolare = false;
				    }
			})
			nomeTitolare.classList.add("was-validated");
			
			dataScadenza.addEVentListener('blur',()=>{
				var date= new Date(myDate.value); 	
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
			})
			dataScadenza.classList.add("was-validated");
			
			cap.addEVentListener('blur',()=>{
				var number = /^[0-9]+$/;
				 ler str= numeroCarta.value;
				 if (number.test(str)) {
					 cap.classList.add("is-valid");
				       validCap= true;
				    } else {
				    	cap.classList.add("is-invalid");
				        validCap = false;
				    }
			})
			cvv.classList.add("was-validated");
			
			let submit = document.getElementById("submit");
			submit.addEventListener("click", (e) => {
			    e.preventDefault();
			    if (validEmail && validNome && validCognome) {
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