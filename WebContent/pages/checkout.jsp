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
		<div class="row g-5">
			<div class="col-md-5 col-lg-4 order-md-last">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-primary">Il tuo carrello</span> <span
						class="badge bg-primary rounded-pill">3</span>
				</h4>
				<ul class="list-group mb-3">
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Nome Prodotto 1</h6>
							<small class="text-muted">Breve descrizione</small>
						</div> <span class="text-muted">$12</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Nome Prodotto 2</h6>
							<small class="text-muted">Breve descrizione</small>
						</div> <span class="text-muted">$8</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Nome Prodotto 3</h6>
							<small class="text-muted">Breve descrizione</small>
						</div> <span class="text-muted">$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between bg-light">
						<div class="text-success">
							<h6 class="my-0">Codice promozionale</h6>
							<small>EXAMPLECODE</small>
						</div> <span class="text-success">−$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Totale
					</span> <strong>$20</strong></li>
				</ul>

				<form class="card p-2">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Promo code">
						<button type="submit" class="btn btn-secondary">Applica</button>
					</div>
				</form>
			</div>
			<div class="col-md-7 col-lg-8">
				<h4 class="mb-3">Inidirizzo di spedizione</h4>
				<form class="needs-validation" novalidate="">
					<div class="row g-3">
						<div class="col-sm-6">
							<label for="firstName" class="form-label">Nome</label> <input
								type="text" class="form-control" id="firstName" placeholder=""
								value="" required="">
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>

						<div class="col-sm-6">
							<label for="lastName" class="form-label">Congnome</label> <input
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
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email"
								placeholder="you@example.com">
							<div class="invalid-feedback">Please enter a valid email
								address for shipping updates.</div>
						</div>

						<div class="col-12">
							<label for="address" class="form-label">Indirizzo</label> <input
								type="text" class="form-control" id="address"
								placeholder="1234 Main St" required="">
							<div class="invalid-feedback">Please enter your shipping
								address.</div>
						</div>

						<div class="col-12">
							<label for="address2" class="form-label">Indirizzo 2 <span
								class="text-muted">(Optional)</span></label> <input type="text"
								class="form-control" id="address2"
								placeholder="Apartment or suite">
						</div>

						<div class="col-md-5">
							<label for="country" class="form-label">Paese</label> <select
								class="form-select" id="country" required="">
								<option value="">Scegli...</option>
								<option>United States</option>
							</select>
							<div class="invalid-feedback">Please select a valid
								country.</div>
						</div>

						<div class="col-md-4">
							<label for="state" class="form-label">Regione</label> <select
								class="form-select" id="state" required="">
								<option value="">Choose...</option>
								<option>California</option>
							</select>
							<div class="invalid-feedback">Please provide a valid state.
							</div>
						</div>

						<div class="col-md-3">
							<label for="zip" class="form-label">CAP</label> <input
								type="text" class="form-control" id="zip" placeholder=""
								required="">
							<div class="invalid-feedback">CAP code required.</div>
						</div>
					</div>

					<hr class="my-4">

					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="same-address">
						<label class="form-check-label" for="same-address">L'indirizzo
							di spedizione coincide con l'indirizzo di fatturazione</label>
					</div>

					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="save-info">
						<label class="form-check-label" for="save-info">Salva
							queste informazioni per la prossima volta</label>
					</div>

					<hr class="my-4">

					<h4 class="mb-3">Pagamento</h4>

					<div class="my-3">
						<div class="form-check">
							<input id="credit" name="paymentMethod" type="radio"
								class="form-check-input" checked="" required=""> <label
								class="form-check-label" for="credit">Carta di credito</label>
						</div>
						<div class="form-check">
							<input id="debit" name="paymentMethod" type="radio"
								class="form-check-input" required=""> <label
								class="form-check-label" for="debit">Carta di debito</label>
						</div>
						<div class="form-check">
							<input id="paypal" name="paymentMethod" type="radio"
								class="form-check-input" required=""> <label
								class="form-check-label" for="paypal">PayPal</label>
						</div>
					</div>

					<div class="row gy-3">
						<div class="col-md-6">
							<label for="cc-name" class="form-label">Nome Titolare</label> <input
								type="text" class="form-control" id="cc-name" placeholder=""
								required=""> <small class="text-muted">Full name
								as displayed on card</small>
							<div class="invalid-feedback">Name on card is required</div>
						</div>

						<div class="col-md-6">
							<label for="cc-number" class="form-label">Numero della
								carta di credito </label> <input type="text" class="form-control"
								id="cc-number" placeholder="" required="">
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
   
$(document).ready(function() {
	$("#flexSwitchCheckDefault").click(function(event) {

		$("#giftSection").toggleClass("d-none");

	});
	
});
</script>
</body>
</html>