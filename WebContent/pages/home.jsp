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

	<!-- Hero Section -->
	<div class="container my-5">
		<div
			class="row p-4 pb-0 pe-lg-0 pt-lg-5 align-items-center rounded-3 border shadow-lg">
			<div class="col-lg-7 p-3 p-lg-5 pt-lg-3">
				<h1 class="display-4 fw-bold lh-1">Border hero with cropped
					image and shadows</h1>
				<p class="lead">Quickly design and customize responsive
					mobile-first sites with Bootstrap, the world’s most popular
					front-end open source toolkit, featuring Sass variables and mixins,
					responsive grid system, extensive prebuilt components, and powerful
					JavaScript plugins.</p>
				<div
					class="d-grid gap-2 d-md-flex justify-content-md-start mb-4 mb-lg-3">
					<button type="button"
						class="btn btn-primary btn-lg px-4 me-md-2 fw-bold">Primary</button>
					<button type="button" class="btn btn-outline-secondary btn-lg px-4">Default</button>
				</div>
			</div>
			<div class="col-lg-3 p-0 ">
				<div id="wrapper">

					<svg class="Banner2" height="220" width="450"> 

       <polygon class="BorderAnimationEx2 BannerBorderEx2"
							stroke-miterlimit="10" points="30 5, 20 200, 440 170, 440 55"
							style="fill:none; stroke:#000; stroke-width:5" />  

       <polygon class="BannerHolderEx2"
							points="5 31, 5 185, 410 205, 430 10"
							style="opacity:0.2;fill:#000;" />
       <polygon class="BannerHolderEx2"
							points="5 31, 5 180, 410 200, 430 10"
							style="opacity:1;fill:#0ADBB3;" />  
    
       <text class="SalesEx2" font-family="Viga" font-size="65">
         <tspan fill="#000" opacity="0.8" x="43" y="120"
							font-family="Viga" font-size="65" opacity="1">OFFER</tspan>
         <tspan x="43" y="117" font-family="Viga" font-size="65"
							opacity="1" fill="#fff">OFFER</tspan>
       </text>

     <text class="Mega" font-weight="300" font-family="Josefin Sans"
							font-size="23" fill="#000">
         <tspan font-weight="700" x="280" y="60">MEGA</tspan>
         <tspan x="280" y="97">SALES</tspan>
         <tspan font-weight="700" x="270" y="136">LIMITED</tspan>
         <tspan x="260" y="175">QUANTITY</tspan>
       </text>


       <text class="ShopNowEx2" font-family="Josefin Sans"
							font-weight="700" font-size="20" fill="#fff">
         <tspan fill="#000" x="65" y="157">S H O P&nbsp; &nbsp;N O W</tspan>
       <tspan x="65" y="155">S H O P&nbsp; &nbsp;N O W</tspan>
           
           </text>

       <polyline class="BorderAnimationEx2 BannerBorderLineEx2"
							points="30 3, 20 200"
							style="fill:none; stroke:#000; stroke-width:4.5;" /> 


  Sorry, your browser does not support inline SVG.
</svg>

				</div>
			</div>
		</div>
	</div>
	<div class="b-example-divider"></div>
	<section class="py-5 text-center container">
		<div class="row py-lg-5">
			<div class="col-lg-6 col-md-8 mx-auto">
				<h1 class="fw-light">Album example</h1>
				<p class="lead text-muted">Something short and leading about the
					collection below—its contents, the creator, etc. Make it short and
					sweet, but not too short so folks don’t simply skip over it
					entirely.</p>
				<p>
					<a href="#" class="btn btn-primary my-2">Main call to action</a> <a
						href="#" class="btn btn-secondary my-2">Secondary action</a>
				</p>
			</div>
		</div>
	</section>
	<br>
	<br>
	<!-- Fine Card Section -->
	<div class="b-example-divider"></div>
	<!-- Cosa Puoi Fare -->
	<!-- Scritta -->

	<!-- Cards  Cosa puoi fare-->
	<div class="container text-center" id="cosaPuoiFare">
		<div class="col-md-12  pt-5">
			<h1>Cosa puoi fare</h1>
			<br> <br>
		</div>
		<div
			class="row row-cols-1 row-cols-sm-1 row-cols-md-2 row-cols-lg-4 g-4 d-flex align-items-center p-5">
			<div class="col">
				<div class="card text-center shadow-lg bg-white rounded h-100 "
					>
					<img src="./resources/img/cosaPuoiFare/whatucando-gift-icon.png"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Regala</h5>
						<p class="card-text">Un regalo originale per l’ambiente e per
							le persone a cui vuoi bene</p>
						<a class="btn btn-primary" href="Catalogo#regali">Regala</a>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card text-center shadow-lg bg-white rounded h-100">
					<img
						src="./resources/img/cosaPuoiFare/whatucando-discover-icon.png"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Pianta</h5>
						<p class="card-text">Tante specie ognuna con le sue
							caratteristiche ed i suoi poteri</p>
						<a class="btn btn-primary" href="Catalogo">Pianta</a>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card text-center shadow-lg bg-white rounded h-100">
					<img src="./resources/img/chiSiamoPage/info_trees.svg"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Crea il tuo WoodLot</h5>
						<p class="card-text">Pianta alberi ogni mese e inizia il tuo
							percorso green</p>
						<a class="btn btn-primary" href="#">Crea</a>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card text-center shadow-lg bg-white rounded h-100">
					<img
						src="./resources/img/cosaPuoiFare/whatucando-horoscope-icon-2.png"
						class="card-img-top" width="206px" height="206px">
					<div class="card-body">
						<h5 class="card-title fw-bold">Scopri</h5>
						<p class="card-text">Ogni segno zodiacale ha il proprio
							albero, tu di che segno sei?</p>
						<a class="btn btn-primary" href="Catalogo#zodiaco">Scopri</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="b-example-divider"></div>
	<div class="container px-4 py-5" id="hanging-icons">
		<h2 class="pb-2 border-bottom">Come Funziona?</h2>
		<div class="row g-4 py-5 row-cols-1 row-cols-lg-4">
			<div class="col d-flex align-items-start">
				<div class="icon-square bg-light text-dark flex-shrink-0 me-3">
					<svg class="bi text-success" xmlns="http://www.w3.org/2000/svg"
						id="fir" width="1em" height="1em" viewBox="0 0 91.378 121.841">
						<path class="a"
							d="M1467.421,812.41h7.288a5.407,5.407,0,0,0,4.945-3.108,5.247,5.247,0,0,0-.78-5.723l-18.592-21.628h6.874a5.392,5.392,0,0,0,4.964-3.239,5.293,5.293,0,0,0-1.009-5.73l-26.24-27.956a3.919,3.919,0,0,0-5.549,0l-26.243,27.956a5.3,5.3,0,0,0-1.009,5.73,5.4,5.4,0,0,0,4.967,3.239h6.874l-18.594,21.633a5.254,5.254,0,0,0-.778,5.72,5.406,5.406,0,0,0,4.945,3.106h7.289l-19.011,21.533a5.259,5.259,0,0,0-.847,5.773,5.517,5.517,0,0,0,5,3.153h32.568v5.818l-7.208,11.517a3.809,3.809,0,0,0,3.4,5.512h22.835a3.809,3.809,0,0,0,3.4-5.512l-7.208-11.517v-5.818h32.57a5.518,5.518,0,0,0,5-3.153,5.26,5.26,0,0,0-.847-5.773Z"
							transform="translate(-1396.409 -743.875)"></path></svg>
				</div>
				<div>
					<h3>Scegli un albero</h3>
					<p>Scegli quale albero adottare virtualmente tra quelli che
						trovi nel nostro shop!.</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<div class="icon-square bg-light text-dark flex-shrink-0 me-3">
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
						a una famiglia contadina che se ne occupa..</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<div class="icon-square bg-light text-dark flex-shrink-0 me-3">
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
					<p>La famiglia contadina raccogliendo la frutta prodotta,
						riceverà sicurezza alimentare e una nuova fonte di guadagno..</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<div class="icon-square bg-light text-dark flex-shrink-0 me-3">
					<i class="icon awesome fas fa-qrcode bi text-info"
						aria-hidden="true"></i>
				</div>
				<div>
					<h3>Tu lo vedi crescere</h3>
					<p>Ricevi aggiornamenti fotografici periodici dal tuo albero.
						Potrai monitorarlo grazie a Chloe..</p>
				</div>
			</div>
		</div>
	</div>
	<!-- Card Section -->
	<br>
	<div class="b-example-divider"></div>
	<!-- Scritta -->
	<div class="container">
		<div class="col-md-12 text-center mt-5">
			<h1>Scegli il tuo albero</h1>
			<p>Puoi farlo per i benefici che è in grado di apportare, per la
				CO2 che può assorbire o per fare un regalo originale. Un contadino
				lo pianterà nella sua terra. Il tuo albero sarà fotografato,
				geolocalizzato ed avrà la sua pagina online dove seguirai la storia
				del progetto di cui farà parte.</p>
			<br> <br>
		</div>

		<div class="row row-cols-1 row-cols-md-2 row-cols-lg-4" id="scegliIlTuoAlbero">
			<%
			if (prodotti != null && prodotti.size() != 0) {
				Iterator<?> it = prodotti.iterator();
				Iterator<?> it1 = foto.iterator();
				for (int i = 0; i < 4; i++) {
					Albero bean = (Albero) it.next();
					FotoProdotto bean1 = (FotoProdotto) it1.next();
			%>
			<div class="col">
				<div class="card h-100">
					<img
						src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=bean1.getNomeFoto()%>"
						class="card-img-top"
						onerror="this.src='./resources//img/error.jpg'" />
					<div class="card-body">
						<h5 class="card-title"><%=bean.getNome()%>
							<%
							if (bean.getOnSale() != 0) {
							%><span class="badge mx-2 bg-secondary">In Saldo</span>
							<%
							}
							%>
						</h5>
						<p class="card-text"><%=bean.getDescrizioneBreve()%></p>
						<p class="card-text text-center"><%=dFormat.format(bean.getPrezzo())%>
							€
						</p>
						<div class="text-center">
							<a class="btn btn-success position-relative"
								href="Prodotto?action=leggiProdotto&id=<%=bean.getId()%>">Piantalo
								Ora <%
							if (bean.getOnSale() != 0) {
							%><span
								class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">
									<span class="visually-hidden">In Saldo</span>
							</span> <%
 }
 %>
							</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>

	<br>
	<br>
	<!-- Bottone  Vedi Altri -->
	<div class="col-md-12 text-center mb-5">
		<a type="button" class="btn btn-primary btn-lg" href="Catalogo">Scopri
			tutti gli alberi!</a>
	</div>
	<div class="b-example-divider"></div>
	<div class="container px-4 py-5" id="icon-grid">
		<h2 class="pb-2 border-bottom">Tutto molto trasparente</h2>

		<div
			class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 g-4 py-5">
			<div class="col d-flex align-items-start">
				<i
					class="fs-1 fa-solid fa-money-bill-wave bi  flex-shrink-0 me-3 text-success"></i>
				<div>
					<h4 class="fw-bold mb-0">Sì, lo paghi una volta sola</h4>
					<p>Non ti chiediamo ulteriori pagamenti, ci serve solo un primo
						contributo per poterlo piantare!</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<i
					class="fa-solid fa-house-chimney flex-shrink-0 me-3 bi fs-1 text-warning"></i>
				<div>
					<h4 class="fw-bold mb-0">No, non ti arriva a casa l’albero</h4>
					<p>Il germoglio crescerà nel vivaio e poi verrà donato a una
						famiglia di contad</p>
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
					<p>E puoi vederlo da subito, dai primi giorni che trascorre nel
						nostro vivaio</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<i
					class="fa-solid fa-seedling flex-shrink-0 me-3 bi fs-1 text-primary"></i>
				<div>
					<h4 class="fw-bold mb-0">Sì, lo vedrai crescere online</h4>
					<p>Potrai monitorarlo tramite il nostro sistema esclusivo di
						tracciabilità, CHLOE!</p>
				</div>
			</div>
			<div class="col d-flex align-items-start">
				<i class="fa-solid fa-envelope-open-text flex-shrink-0 me-3 bi fs-1"
					style="color: #6f42c1"></i>
				<div>
					<h4 class="fw-bold mb-0">Sì, ricevi un certificato PDF</h4>
					<p>Al momento dell’acquisto riceverai un attestato che attesta
						la proprietà del tuo albero.</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>
	
	<script>
/* Ex2 */
$(".Banner2").delay(6000).fadeIn(500);
$(".BannerHolderEx2").delay(6500).fadeIn(500);
$(".BannerBorderEx2,.BannerBorderLineEx2").delay(7000).fadeIn(500);
$(".SalesEx2").delay(7300).fadeIn(500);
$(".Mega").delay(8500).fadeIn(500);
$(".ShopNowEx2").delay(9000).fadeIn(500);
/* Ex2 */
$( ".Banner2" ).click(function() {
$(".BannerHolderEx2,.BannerBorderEx2,.BannerBorderLineEx2,.SalesEx2,.Mega,.ShopNowEx2").delay(0).fadeOut(500);  
$(".Banner2").delay(1000).fadeIn(500);
$(".BannerHolderEx2").delay(1500).fadeIn(500);
$(".BannerBorderEx2,.BannerBorderLineEx2").delay(2000).fadeIn(500);
$(".SalesEx2").delay(2300).fadeIn(500);
$(".Mega").delay(3500).fadeIn(500);
$(".ShopNowEx2").delay(4000).fadeIn(500);
});
</script>
</body>