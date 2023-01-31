<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,it.unisa.beans.*, java.text.*"%>
<%
Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> foto = (Collection<?>) request.getAttribute("fotoProdotti");

if (prodotti == null || foto == null) {
	response.sendRedirect("./Home");
	return;
}

DecimalFormat dFormat = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WoodLot</title>
<link rel="stylesheet" type="text/css" href="resources/css/style.css">

</head>

<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>

	<div class="p-5 text-center bg-image"
		style="background-image: url('./resources/img/home/intestazione.jpeg'); height: 600px;">
		<div class="mask" style="background-color: rgba(0, 0, 0, 0.6);">
			<div class="mask h-100">
				<div class="d-flex my-5 py-5 align-items-middle h-100">
					<div>
						<h1 class="mb-3 text-white">Pianta un albero!</h1>
						<h4 class="m-3 text-white">Siamo il primo sito che ti
							permette di piantare un albero a distanza e seguire online la
							storia del progetto che contribuirà a realizzare. Piantando i
							tuoi alberi sosterrai comunità di contadini locali e renderai più
							verde il nostro pianeta.</h4>
						<a class="btn btn-outline-light btn-lg" href="Catalogo"
							role="button"> Scegli</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container px-4 py-5" id="hanging-icons">
		<h2 class="pb-2">Come Funziona?</h2>
		<div class="row g-4 py-5 row-cols-1 row-cols-lg-4">
			<div class="col d-flex align-items-start">
				<div class="icon-square  text-dark flex-shrink-0 me-3">
					<svg class="bi text-success" xmlns="http://www.w3.org/2000/svg"
						id="fir" width="1em" height="1em" viewBox="0 0 91.378 121.841">
						<path class="a"
							d="M1467.421,812.41h7.288a5.407,5.407,0,0,0,4.945-3.108,5.247,5.247,0,0,0-.78-5.723l-18.592-21.628h6.874a5.392,5.392,0,0,0,4.964-3.239,5.293,5.293,0,0,0-1.009-5.73l-26.24-27.956a3.919,3.919,0,0,0-5.549,0l-26.243,27.956a5.3,5.3,0,0,0-1.009,5.73,5.4,5.4,0,0,0,4.967,3.239h6.874l-18.594,21.633a5.254,5.254,0,0,0-.778,5.72,5.406,5.406,0,0,0,4.945,3.106h7.289l-19.011,21.533a5.259,5.259,0,0,0-.847,5.773,5.517,5.517,0,0,0,5,3.153h32.568v5.818l-7.208,11.517a3.809,3.809,0,0,0,3.4,5.512h22.835a3.809,3.809,0,0,0,3.4-5.512l-7.208-11.517v-5.818h32.57a5.518,5.518,0,0,0,5-3.153,5.26,5.26,0,0,0-.847-5.773Z"
							transform="translate(-1396.409 -743.875)"></path></svg>
				</div>
				<div>
					<h3>Scegli un albero</h3>
					<p>Scegli quale albero adottare virtualmente tra quelli che
						trovi nel nostro shop!</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<div class="icon-square text-dark flex-shrink-0 me-3">
					<svg class="bi text-warning" id="farmer"
						xmlns="http://www.w3.org/2000/svg" width="1em" height="1em"
						viewBox="0 0 93.873 129.498">
						<g transform="translate(-740.832 -408.461)">
						<path class="a"
							d="M787.762,446.318c-9.98.04-16.575-6.647-16.494-16.733a16.582,16.582,0,0,1,15.992-16.621A17.224,17.224,0,0,1,804.6,429.458,16.8,16.8,0,0,1,787.762,446.318Z"></path>
						<path class="a"
							d="M802.112,416.756c0-3.767-3.054-8.3-6.822-8.3H780.311c-3.765,0-6.822,4.345-6.822,8.113v-1.293a6.823,6.823,0,0,0,6.822,6.825H795.29a6.824,6.824,0,0,0,6.822-6.825Z"></path>
						<path class="a"
							d="M761.622,422.709h52.357c3.872,0,3.872-6.006,0-6.006H761.622c-3.876,0-3.876,6.006,0,6.006Z"></path>
						<path class="a"
							d="M832.413,430.732a7.823,7.823,0,0,0-11.062,0L800.173,451.91H775.364l-21.178-21.178A7.823,7.823,0,0,0,743.124,441.8l23.133,23.132v65.207a7.822,7.822,0,0,0,7.82,7.823h3.91a7.823,7.823,0,0,0,7.823-7.823h0V502.758h3.91v27.378a7.822,7.822,0,0,0,7.822,7.823h3.915a7.822,7.822,0,0,0,7.823-7.823h0V464.929L832.413,441.8a7.823,7.823,0,0,0,0-11.063Z"></path></g></svg>
				</div>
				<div>
					<h3>Lo piantiamo e lo doniamo ad un contadino</h3>
					<p>L’albero nasce e cresce in vivaio. Dopo un anno viene donato
						a una famiglia di contadini che se ne occupa.</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<div class="icon-square  text-dark flex-shrink-0 me-3">
					<svg class="bi text-danger" xmlns="http://www.w3.org/2000/svg"
						id="orange" width="1em" height="1em" viewBox="0 0 84.039 109.034">
						<g transform="translate(-106.631 -2042.16)">
						<path class="a"
							d="M186.888,2042.16a17.125,17.125,0,0,1-7.05,22.548,15.96,15.96,0,0,1-2.36,1.07c-3.026,1.057-6.077,2.057-9.109,3.1-.141.048-.288.076-.5.134a21.555,21.555,0,0,1-1.673-6.709,17,17,0,0,1,11.384-17.039c2.89-.995,5.786-1.963,8.682-2.939C186.471,2042.257,186.694,2042.209,186.888,2042.16Z"></path>
						<ellipse class="a" cx="42.02" cy="40.619" rx="42.02" ry="40.619"
							transform="translate(106.631 2069.956)"></ellipse></g></svg>
				</div>
				<div>
					<h3>Il contadino ne trae beneficio</h3>
					<p>La famiglia di contadini raccogliendo la frutta prodotta,
						riceverà sicurezza alimentare e una nuova fonte di guadagno.</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<div class="icon-square text-dark flex-shrink-0 me-3">
					<i class="icon awesome fas fa-qrcode bi text-info"
						aria-hidden="true"></i>
				</div>
				<div>
					<h3>Tu lo vedi crescere</h3>
					<p>Ricevi aggiornamenti fotografici periodici dal tuo albero.
						Potrai monitorarlo.</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Cards  Cosa puoi fare-->
	<div class="text-center my-5" id="cosaPuoiFare">
		<h1 class="my-5">Cosa puoi fare</h1>
		<div class="row mx-5 d-flex justify-content-center">
			<div class="row mx-5 d-flex justify-content-center">
				<div
					class="card text-center col-md-4 col-sm-12 col-xs-12 mx-auto d-flex justify-content-center mb-5"
					style="width: 15rem; background-color: white; border-radius: 30px;">
					<img src="./resources/img/cosaPuoiFare/13.png" class="card-img"
						width="206px" height="206px" />
					<div class="card-body">
						<p class="card-title fw-bold">Regala</p>
						<p>Un regalo originale per l’ambiente e per le persone a cui
							vuoi bene</p>
						<a class="btn btn-rounded" href="Catalogo"
							style="background-color: #5E7250; color: white">Regala</a>
					</div>
				</div>

				<div
					class="card text-center  col-md-4 col-sm-12 col-xs-12 mx-auto d-flex justify-content-center mb-5"
					style="width: 15rem; background-color: white; border-radius: 30px;">
					<img src="./resources/img/cosaPuoiFare/12.png" class="card-img"
						width="206px" height="206px" />
					<div class="card-body">
						<p class="card-title fw-bold">Pianta</p>
						<p>Tante specie ognuna con le sue caratteristiche ed i suoi
							poteri</p>
						<a class="btn btn-rounded" href="Catalogo"
							style="background-color: #5E7250; color: white">Pianta</a>
					</div>
				</div>
				<div
					class="card text-center col-md-4 col-sm-12 col-xs-12 mx-auto d-flex justify-content-center mb-5"
					style="width: 15rem; background-color: white; border-radius: 30px;">
					<img src="./resources/img/cosaPuoiFare/11.svg" class="card-img"
						width="206px" height="206px" />
					<div class="card-body">
						<p class="card-title fw-bold">Crea il tuo WoodLot</p>
						<p>Pianta alberi e crea il tuo bosco virtuale e segui la loro
							storia</p>
						<a class="btn btn-rounded" href="Utente"
							style="background-color: #5E7250; color: white">Crea</a>
					</div>
				</div>
			</div>
		</div>
		<br>
	</div>

	<!-- Card Section -->
	<br>

	<!-- Scritta -->
	<div class="container">
		<div class="col-md-12 text-center mt-5">
			<h1>Scegli il tuo albero</h1>
			<p>
				Puoi sceglierlo per i benefici che è in grado di apportare, per la
				CO<sub>2</sub> che può assorbire o per fare un regalo originale. Un
				contadino lo pianterà nella sua terra. Il tuo albero sarà
				fotografato ed avrà la sua pagina online dove seguirai la storia del
				progetto di cui farà parte.
			</p>
			<br> <br>
		</div>

		<div class="row text-center mx-5 g-3" id="scegliIlTuoAlbero">
			<%
			if (prodotti != null && prodotti.size() != 0) {
				Iterator<?> it = prodotti.iterator();
				Iterator<?> it1 = foto.iterator();
				for (int i = 0; i < 4; i++) {
					Albero bean = (Albero) it.next();
					FotoProdotto bean1 = (FotoProdotto) it1.next();
			%>
			<div
				class="col-lg-3 col-md-6 col-xs-12 col-sm-6
                            col-xs-12 d-flex justify-content-center">

				<div class="col card text-center"
					style="max-width: 18rem; border-radius: 25px;">
					<img
						src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=bean1.getNomeFoto()%>"
						onerror="this.src='./resources//img/error.jpg'"
						class="card-img-top" />
					<div class="card-body">
						<h5 class="card-title"><%=bean.getNome()%></h5>
						<p class="card-text">
							<strong>CO<sub>2</sub></strong>: -<%=bean.getCo2()%>
							kg
						</p>
					</div>
					<ul class="list-group list-group-light list-group-small">
						<li class="list-group-item px-4"><strong>Prezzo:</strong> <%=dFormat.format(bean.getPrezzo())%>
							€</li>
					</ul>
					<div class="card-body">
						<a href="Prodotto?action=leggiProdotto&id=<%=bean.getId()%>"
							class="btn btn-rounded"
							style="background-color: #5E7250; color: white">Scopri di
							più!</a>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>


		<br> <br>
		<!-- Bottone  Vedi Altri -->
		<div class="col-md-12 text-center mb-5">
			<a type="button" class="btn btn-primary btn-lg" href="Catalogo">Scopri
				tutti gli alberi!</a>
		</div>

		<div class="container px-4 py-5" id="icon-grid">
			<h2 class="pb-2">Tutto molto trasparente</h2>

			<div
				class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 g-4 py-5">
				<div class="col d-flex align-items-start">
					<i
						class="fs-1 fa-solid fa-money-bill-wave bi  flex-shrink-0 me-3 text-success"></i>
					<div>
						<h4 class="fw-bold mb-0">Sì, lo paghi una volta sola</h4>
						<p>Non ti chiediamo ulteriori pagamenti, ci serve solo un
							primo contributo per poterlo piantare!</p>
					</div>
				</div>
				<div class="col d-flex align-items-start">
					<i
						class="fa-solid fa-house-chimney flex-shrink-0 me-3 bi fs-1 text-warning"></i>
					<div>
						<h4 class="fw-bold mb-0">No, non ti arriva a casa l’albero</h4>
						<p>Il germoglio crescerà nel vivaio e poi verrà donato a una
							famiglia di contadini</p>
					</div>
				</div>
				<div class="col d-flex align-items-start">
					<i
						class="fa-solid fa-apple-whole flex-shrink-0 me-3 bi fs-1 text-danger"></i>
					<div>
						<h4 class="fw-bold mb-0">No, non ti arriva a casa la frutta</h4>
						<p>Saranno di sostentamento alle famiglie che si prendono cura
							dell’albero</p>
					</div>
				</div>
				<div class="col d-flex align-items-start">
					<i
						class="fa-solid fa-hand-holding-droplet flex-shrink-0 me-3 bi fs-1 text-info"></i>
					<div>
						<h4 class="fw-bold mb-0">Sì, lo piantiamo davvero</h4>
						<p>E puoi vederlo da subito, dai primi giorni che trascorre
							nel nostro vivaio</p>
					</div>
				</div>
				<div class="col d-flex align-items-start">
					<i
						class="fa-solid fa-seedling flex-shrink-0 me-3 bi fs-1 text-primary"></i>
					<div>
						<h4 class="fw-bold mb-0">Sì, lo vedrai crescere online</h4>
						<p>Potrai monitorarlo accedendo alla tua pagina personale!</p>
					</div>
				</div>
				<div class="col d-flex align-items-start">
					<i
						class="fa-solid fa-envelope-open-text flex-shrink-0 me-3 bi fs-1"
						style="color: #6f42c1"></i>
					<div>
						<h4 class="fw-bold mb-0">Sì, ricevi una foto</h4>
						<p>Al momento della piantumazione riceverai una foto del tuo
							albero.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

	<!-- Animare le img al passare del mouse (consiglio alberi)-->
	<script>
		$(document).ready(function() {
			$('.card-img-top').hover(function() {
				$(this).animate({
					width : '+=20%',
					'margin-left' : '-=10%'
				}, 500);
			}, function() {
				$(this).animate({
					width : '100%',
					'margin-left' : '0'
				}, 500);
			});
		});
	</script>
</body>