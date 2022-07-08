<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AVOCADO</title>
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
	<%@ include file="header.jsp"%>
	<br>
	<br>

	<!-- Sezione Prodotto -->
	<!-- Nome Prodotto -->

	<br>
	<!-- Foto Prodotto -->
	<div class="row">
		<div class=" col-5">

			<!-- Carousel -->
			<div id="demo" class="carousel slide" data-bs-ride="carousel">

				<!-- Indicators/dots -->
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#demo" data-bs-slide-to="0"
						class="active"></button>
					<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
					<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
				</div>

				<!-- The slideshow/carousel -->
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img src="resources/img/doveVienePiantato/guatemala.png"
							class="d-block w-100">
					</div>
					<div class="carousel-item">
						<img src="resources/img/doveVienePiantato/perù.png"
							class="d-block w-100">
					</div>
					<div class="carousel-item">
						<img src="resources/img/doveVienePiantato/italia.png"
							class="d-block w-100">
					</div>
				</div>

				<!-- Left and right controls/icons -->
				<button class="carousel-control-prev" type="button"
					data-bs-target="#demo" data-bs-slide="prev">
					<span class="carousel-control-prev-icon"></span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#demo" data-bs-slide="next">
					<span class="carousel-control-next-icon"></span>
				</button>
			</div>
		</div>
		<!-- Dettagli Prodotto -->
		<div class="col">
			<div class="row">
				<h1 class="font-monospace">AVOCADO</h1>
			</div>
			<div class="row">
				<div class="col">
					<p>
						<i class="fa-solid fa-tree"></i> Brevissima descrizione albero
					</p>
				</div>
				<div class="col">
					<p>
						<i class="fa-solid fa-location-dot"></i> Guatemala
					</p>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col">
					<!-- Quantità -->
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
				<div class="col">
					<p>
						<i class="fa-solid fa-coins"></i> 19€
					</p>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="form-check form-switch">

					<input class="form-check-input" type="checkbox"
						id="flexSwitchCheckChecked" checked=""> <label
						class="form-check-label" for="flexSwitchCheckChecked"><i
						class="fa-solid fa-gifts"></i> é un regalo?</label>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<br>
					<p>Cosa riceve il destinatario?</p>
					<p>Il destinatario riceverà nella data da te selezionata:</p>
					<ul>
						<li>una mail di benvenuto con i datidell’albero Un PDF
							personalizzato la tua dedica e la tua firma</li>
						<li>7 aggiornamenti fotografici del suo albero in tre anni</li>
						<li>Tu riceverai solo una mail di conferma dell’ordine.</li>
					</ul>
				</div>
				<div class="col">
					<div class="row">
						<div class="col-4">
							<div class="form-group">
								<label class="col-form-label col-form-label-sm mt-4"
									for="inputSmall">Small input</label> <input
									class="form-control form-control-sm" type="text"
									placeholder=".form-control-sm" id="inputSmall">
							</div>
						</div>
						<div class="col-4">
							<div class="form-group">
								<label class="col-form-label col-form-label-sm mt-4"
									for="inputSmall">Small input</label> <input
									class="form-control form-control-sm" type="text"
									placeholder=".form-control-sm" id="inputSmall">
							</div>
						</div>
						<div class="col-4">
							<div class="form-group">
								<label class="col-form-label col-form-label-sm mt-4"
									for="inputSmall">Small input</label> <input
									class="form-control form-control-sm" type="text"
									placeholder=".form-control-sm" id="inputSmall">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label class="col-form-label mt-4" for="inputDefault">Inserisci
								una dedica</label> <input type="text" class="form-control"
								placeholder="Iniserisci una dedica  =)" id="inputDefault">
						</div>


					</div>
				</div>

			</div>
			<hr>
			<div class="text-center">

				<button type="button" class="btn btn-primary">Acquista</button>
			</div>
		</div>
	</div>
	<!-- Fine Sezione Prodotto -->

	<!-- Dettagli Prodotto -->
	<!-- Dove Viene Piantato -->
	<div class="text-center">
		<h3>Dove Viene Piantato?</h3>
		<p class="lead">Piantiamo l’avocado in Guatemala, nella regione
			del Petén in terreni a forte rischio desertificazione. Le piantagioni
			a monocoltura intensive richiedono tanta acqua, fertilizzanti e
			pesticidi chimici. Al contrario, nei nostri sistemi agroforestali
			misti, la varietà di specie assicura la stabilità e la resilienza
			dell’impianto. Un sistema agroforestale stabile infatti, richiede
			meno input, rigenera il suolo e la biodiversità e produce
			costantemente produzioni variegate.</p>
	</div>
	<div class="text-center">
		<img src="resources/img/doveVienePiantato/guatemala.png"
			class="img-fluid" height="626px" width="925px">
	</div>
	<!-- Fine Dettagli Prodotto -->

	<!-- Footer -->
	<%@ include file="footer.jsp"%>
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