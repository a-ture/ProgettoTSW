<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Conferma Ordine</title>
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
	<div class="container">
		<!-- Coso Superiore -->
		<div class="row text-center">
			<ul class="pagination pagination-lg">

				<li class="page-item active"><a class="page-link" href="#"><i
						class="fa-solid fa-cart-shopping"></i> Carrello</a></li>
				<li class="page-item"><a class="page-link" href="#"><i
						class="fa-solid fa-credit-card"></i> Acquista</a></li>
			</ul>
		</div>

		<div class="row">
			<!-- Il tuo carrello -->
			<div class="col bg-primary">
				<div class="row">
					<a href="catalogo.jsp">Aggiungi altri alberi</a>
				</div>
				<br>
				<div class="row">
					<div class="col">
						<h3>Il tuo carrello</h3>
					</div>
					<div class="col">
						<h5>
							<i class="fa-solid fa-trash"></i> Svuota
						</h5>
					</div>
				</div>

				<!-- Elementi carrello -->

				<div class="row">
					<!-- Foto -->
					<div class="col">
						<img src="../resources/img/alberi/Arancia.png" class="rounded"
							height="80px" width="80px">
					</div>
					<!-- Nome -->
					<div class="col"></div>
					<!-- quantità -->
					<div class="col">
						<div class="input-group">
							<span class="input-group-btn">
								<button type="button" class="btn btn-danger btn-number"
									data-type="minus" data-field="quant[2]">
									<span class="glyphicon glyphicon-minus">-</span>
								</button>
							</span> <input type="text" name="quant[2]"
								class="form-control input-number" value="10" min="1" max="100">
							<span class="input-group-btn">
								<button type="button" class="btn btn-success btn-number"
									data-type="plus" data-field="quant[2]">
									<span class="glyphicon glyphicon-plus">+</span>
								</button>
							</span>
						</div>
					</div>
					<!-- prezzo -->
					<div class="col">
						<h5>Prezzo</h5>
					</div>

				</div>
				<!-- Fine Elementi Carrello -->
				<div class="row">
					<p>Se dopo l’acquisto non ti riterrai soddisfatto del servizio,
						comunicacelo entro 30 giorni per ottenere un rimborso.</p>
				</div>
			</div>
			<div class="col">
				<!-- Totale -->
				<div class="col">
					<h3>Totale: €14,90</h3>
					<button type="button" class="btn btn-primary btn-lg">Procedi
						all'acquisto</button>
				</div>
			</div>
			<div class="w-100"></div>

			<div class="col">
				<!-- Cosa è incluso nel prezzo -->
				<div class="row">
					<h3>Cos'è incluso nel prezzo?</h3>
				</div>
				<div class="row">
					<p>Non dovrai pagare nulla in futuro. Piantare un albero con
						WoodLot significa finanziare un contadino per piantare un albero e
						sostenerlo fino a quando non sarà produttivo. Con WoodLot infatti
						un albero è molto più di un albero. Ecco cosa è incluso nel
						prezzo:</p>
					<ol class="list-group list-group-numbered">
						<li>Avvio del progetto</li>
						<li>Costruzione del vivaio e produzione delle piantine</li>
						<li>Distribuzione delle piante ai contadini</li>
						<li>Messa a dimora della pianta</li>
						<li>Manutenzione della pianta fino al momento in cui non darà
							un reddito al contadino</li>
						<li>Formazione dei contadini sulle migliori pratiche
							agro-forestali, anche con il supporto di università ed enti di
							ricerca locali</li>
						<li>Sostituzione delle fallanze durante i primi anni in cui
							il tasso di mortalità è più elevato</li>
						<li>Piantumazione di un 5% in più di alberi che non vengono
							assegnati agli utenti per coprire le fallanze</li>
						<li>Registrazione delle coordinate GPS dell'albero e
							monitoraggio fotografico</li>
						<li>Controlli annuali a campione sulle aree di progetto per
							verificare la permanenza degli alberi e la loro buona salute</li>
						<li>Approvazione della foto e controllo delle coordinate di
							ogni singolo albero da parte dei nostri agronomi specializzati.</li>
						<li>Aggiornamenti periodici sul progetto, con un focus sui
							benefici ambientali e sociali, pubblicati nel Diario dell’Albero</li>
					</ol>
				</div>
			</div>
			<div class="col">
				<!-- Assistenza clienti -->
				<div class="row">
					<h3>Assistenza clienti</h3>
				</div>
				<div class="row">
					<p>Meglio parlarne a voce? Chiamaci dal lunedì al venerdì dalle
						9:30 - 13:30 (GMT+1)</p>
					<a class="link"><i class="fa-solid fa-phone"></i> +39 345678901</a>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<div class="container">
		<div class="row g-5">
			<div class="col-md-5 col-lg-4 order-md-last">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-primary">Your cart</span> <span
						class="badge bg-primary rounded-pill">3</span>
				</h4>
				<ul class="list-group mb-3">
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Product name</h6>
							<small class="text-muted">Brief description</small>
						</div> <span class="text-muted">$12</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Second product</h6>
							<small class="text-muted">Brief description</small>
						</div> <span class="text-muted">$8</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Third item</h6>
							<small class="text-muted">Brief description</small>
						</div> <span class="text-muted">$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between bg-light">
						<div class="text-success">
							<h6 class="my-0">Promo code</h6>
							<small>EXAMPLECODE</small>
						</div> <span class="text-success">−$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Total
							(USD)</span> <strong>$20</strong></li>
				</ul>

				<form class="card p-2">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Promo code">
						<button type="submit" class="btn btn-secondary">Redeem</button>
					</div>
				</form>
			</div>
			<div class="col-md-7 col-lg-8">
				<h4 class="mb-3">Billing address</h4>
				<form class="needs-validation" novalidate="">
					<div class="row g-3">
						<div class="col-sm-6">
							<label for="firstName" class="form-label">First name</label> <input
								type="text" class="form-control" id="firstName" placeholder=""
								value="" required="">
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>

						<div class="col-sm-6">
							<label for="lastName" class="form-label">Last name</label> <input
								type="text" class="form-control" id="lastName" placeholder=""
								value="" required="">
							<div class="invalid-feedback">Valid last name is required.</div>
						</div>

						<div class="col-12">
							<label for="username" class="form-label">Username</label>
							<div class="input-group has-validation">
								<span class="input-group-text">@</span> <input type="text"
									class="form-control" id="username" placeholder="Username"
									required="">
								<div class="invalid-feedback">Your username is required.</div>
							</div>
						</div>

						<div class="col-12">
							<label for="email" class="form-label">Email <span
								class="text-muted">(Optional)</span></label> <input type="email"
								class="form-control" id="email" placeholder="you@example.com">
							<div class="invalid-feedback">Please enter a valid email
								address for shipping updates.</div>
						</div>

						<div class="col-12">
							<label for="address" class="form-label">Address</label> <input
								type="text" class="form-control" id="address"
								placeholder="1234 Main St" required="">
							<div class="invalid-feedback">Please enter your shipping
								address.</div>
						</div>

						<div class="col-12">
							<label for="address2" class="form-label">Address 2 <span
								class="text-muted">(Optional)</span></label> <input type="text"
								class="form-control" id="address2"
								placeholder="Apartment or suite">
						</div>

						<div class="col-md-5">
							<label for="country" class="form-label">Country</label> <select
								class="form-select" id="country" required="">
								<option value="">Choose...</option>
								<option>United States</option>
							</select>
							<div class="invalid-feedback">Please select a valid
								country.</div>
						</div>

						<div class="col-md-4">
							<label for="state" class="form-label">State</label> <select
								class="form-select" id="state" required="">
								<option value="">Choose...</option>
								<option>California</option>
							</select>
							<div class="invalid-feedback">Please provide a valid state.
							</div>
						</div>

						<div class="col-md-3">
							<label for="zip" class="form-label">Zip</label> <input
								type="text" class="form-control" id="zip" placeholder=""
								required="">
							<div class="invalid-feedback">Zip code required.</div>
						</div>
					</div>

					<hr class="my-4">

					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="same-address">
						<label class="form-check-label" for="same-address">Shipping
							address is the same as my billing address</label>
					</div>

					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="save-info">
						<label class="form-check-label" for="save-info">Save this
							information for next time</label>
					</div>

					<hr class="my-4">

					<h4 class="mb-3">Payment</h4>

					<div class="my-3">
						<div class="form-check">
							<input id="credit" name="paymentMethod" type="radio"
								class="form-check-input" checked="" required=""> <label
								class="form-check-label" for="credit">Credit card</label>
						</div>
						<div class="form-check">
							<input id="debit" name="paymentMethod" type="radio"
								class="form-check-input" required=""> <label
								class="form-check-label" for="debit">Debit card</label>
						</div>
						<div class="form-check">
							<input id="paypal" name="paymentMethod" type="radio"
								class="form-check-input" required=""> <label
								class="form-check-label" for="paypal">PayPal</label>
						</div>
					</div>

					<div class="row gy-3">
						<div class="col-md-6">
							<label for="cc-name" class="form-label">Name on card</label> <input
								type="text" class="form-control" id="cc-name" placeholder=""
								required=""> <small class="text-muted">Full name
								as displayed on card</small>
							<div class="invalid-feedback">Name on card is required</div>
						</div>

						<div class="col-md-6">
							<label for="cc-number" class="form-label">Credit card
								number</label> <input type="text" class="form-control" id="cc-number"
								placeholder="" required="">
							<div class="invalid-feedback">Credit card number is
								required</div>
						</div>

						<div class="col-md-3">
							<label for="cc-expiration" class="form-label">Expiration</label>
							<input type="text" class="form-control" id="cc-expiration"
								placeholder="" required="">
							<div class="invalid-feedback">Expiration date required</div>
						</div>

						<div class="col-md-3">
							<label for="cc-cvv" class="form-label">CVV</label> <input
								type="text" class="form-control" id="cc-cvv" placeholder=""
								required="">
							<div class="invalid-feedback">Security code required</div>
						</div>
					</div>

					<hr class="my-4">

					<button class="w-100 btn btn-primary btn-lg" type="submit">Continue
						to checkout</button>
				</form>
			</div>
		</div>
	</div>
	<script>
$('.btn-number').click(function(e){
    e.preventDefault();
    
    fieldName = $(this).attr('data-field');
    type      = $(this).attr('data-type');
    var input = $("input[name='"+fieldName+"']");
    var currentVal = parseInt(input.val());
    if (!isNaN(currentVal)) {
        if(type == 'minus') {
            
            if(currentVal > input.attr('min')) {
                input.val(currentVal - 1).change();
            } 
            if(parseInt(input.val()) == input.attr('min')) {
                $(this).attr('disabled', true);
            }

        } else if(type == 'plus') {

            if(currentVal < input.attr('max')) {
                input.val(currentVal + 1).change();
            }
            if(parseInt(input.val()) == input.attr('max')) {
                $(this).attr('disabled', true);
            }

        }
    } else {
        input.val(0);
    }
});
$('.input-number').focusin(function(){
   $(this).data('oldValue', $(this).val());
});
$('.input-number').change(function() {
    
    minValue =  parseInt($(this).attr('min'));
    maxValue =  parseInt($(this).attr('max'));
    valueCurrent = parseInt($(this).val());
    
    name = $(this).attr('name');
    if(valueCurrent >= minValue) {
        $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('Sorry, the minimum value was reached');
        $(this).val($(this).data('oldValue'));
    }
    if(valueCurrent <= maxValue) {
        $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('Sorry, the maximum value was reached');
        $(this).val($(this).data('oldValue'));
    }
    
    
});
$(".input-number").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) || 
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
   </script>
</body>
</html>