
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*, it.unisa.beans.*, it.unisa.model.Carrello, java.text.*"%>
<%
Albero prodotto = (Albero) request.getAttribute("prodotto");
Collection<?> usiLocaliAll = (Collection<?>) request.getAttribute("usiLocali");
Collection<?> categorieAll = (Collection<?>) request.getAttribute("categorie");

FotoProdotto[] foto = (FotoProdotto[]) request.getSession().getAttribute("prodottoFoto");

Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
Collection<?> fotoProdotti = (Collection<?>) request.getAttribute("fotoProdotti");

if (prodotto == null || foto == null || fotoProdotti == null || prodotti == null) {
	response.sendRedirect("./Prodotto");
	return;
}

DecimalFormat dFormat = new DecimalFormat("0.00");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=prodotto.getNome()%></title>
<!--CSS-->

</head>
<body>
	<!-- Header -->
	<%@ include file="../fragments/header.jsp"%>
	<br>
	<br>

	<!-- Sezione Prodotto -->
	<div class="container-fluid">
		<!-- Foto Prodotto -->
		<div class="row">
			<div class="col-lg-5 col-sm-12 col-md-7">
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

							<img
								src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[0].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">

						</div>
						<div class="carousel-item">
							<img
								src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[1].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources/img/error.jpg'">
						</div>
						<div class="carousel-item">
							<img
								src="./ServletResources?codiceAzione=fotoProdotto&idFoto=<%=foto[2].getNomeFoto()%>"
								class="d-block w-100 img-fluid"
								onerror="this.src='./resources//img/error.jpg'">
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
					<h1 class="font-monospace"><%=prodotto.getNome()%>

					</h1>
				</div>
				<div class="row">
					<div class="col">
						<p>
							<i class="fa-solid fa-tree"></i>
							<%=prodotto.getSottotitolo()%>
						</p>
					</div>
					<div class="col">
						<a class="card-link" data-bs-toggle="modal"
							data-bs-target="#prezzo">Cos'è incluso nel prezzo?</a>
					</div>
				</div>

				<hr>
				<div class="row">
					<div class="col">
						<p>
							<i class="fa-solid fa-coins"></i> <strong>Prezzo: </strong>
							<%=dFormat.format(prodotto.getPrezzo())%>€
						</p>
					</div>
					<div class="col">
						<p>
							<i class="fa-solid fa-location-dot"></i><strong> Paese:
							</strong>
							<%=prodotto.getPaeseDiOrigine().getNome()%>
						</p>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-6">
						<p class="card-text">
							<i class="fa-solid fa-seedling"></i><strong> Nome
								Scientifico: </strong>
							<%=prodotto.getNomeScientifico()%></p>
					</div>
					<div class="col-6">
						<p class="card-text">
							<i class="fa-solid fa-arrow-up-long"></i> <strong>
								Altezza media: </strong>
							<%=prodotto.getAltezza()%>
							metri
						</p>
					</div>
				</div>
				<hr>
				<p>
					<i class="fa-solid fa-circle-question"></i> <b>Che albero è?</b>
				</p>
				<p><%=prodotto.getDescrizioneBreve()%>
				<hr>

				<div class="text-center">
					<a type="button" class="btn btn-primary mb-3"
						href="Prodotto?action=aggiungiCarrello&id=<%=prodotto.getId()%>"
						id="btnCart"><span>Acquista</span></a>
				</div>
			</div>
		</div>
		<!-- Dettagli Prodotto -->
		<!-- Breve Descrizione  -->
		<div
			class="row row-cols-1 row-cols-lg-1 row-cols-xl-2 text-center  g-4">
			<div class="col">
				<div class="card" style="background: #c4d89d;">
					<div class="card-body">
						<h4 class="card-title">Descrizione Breve</h4>
						<p class="card-text"><%=prodotto.getDescrizione()%></p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="col">
					<div class="card" style="background: #c4d89d;">
						<div class="card-body">
							<h4 class="card-title">I miei superpoteri</h4>
							<div class="row">
								<div class="col">
									<p class="card-text fs-5">
										<i class="fa-solid fa-cloud"></i> CO<sub>2</sub> Assorbita

									</p>
								</div>

								<div class="col">
									<%
									int stelleColorateCo2 = prodotto.getCo2() % 7;
									int stelleNonColorateCo2 = 5 - stelleColorateCo2;
									for (int i = 0; i < stelleColorateCo2; i++) {
									%>
									<span><img class="mx-1"
										src="./resources/img/rating/Star1.svg"></span>
									<%
									}
									for (int i = stelleNonColorateCo2; i > 0; i--) {
									%>
									<span><img class="mx-1"
										src="./resources/img/rating/Star5.svg"></span>
									<%
									}
									%>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<p class="card-text fs-5">
										<i class="fa-solid fa-seedling"></i>Salvaguardia Ambientale
									</p>
								</div>
								<!-- Stelle -->
								<div class="col">
									<%
									int stelleColorate = prodotto.getSalvaguardia();
									int stelleNonColorate = 5 - stelleColorate;
									for (int i = 0; i < stelleColorate; i++) {
									%>
									<span><img class="mx-1"
										src="./resources/img/rating/Star1.svg"></span>
									<%
									}
									for (int i = stelleNonColorate; i > 0; i--) {
									%>
									<span><img class="mx-1"
										src="./resources/img/rating/Star5.svg"></span>
									<%
									}
									%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card d-flex justify-content-center"
					style="background: #c4d89d;">
					<div class="card-body">
						<h4 class="card-title">
							Usi Locali<a class="card-link" data-bs-toggle="modal"
								data-bs-target="#informazioniUsiLocali"><i
								class="fa-solid fa-circle-info text-end p-2"></i></a>
						</h4>
						<ul class="list-group list-group-horizontal text-center d-flex align-items-center justify-content-center  m-3">
							<%
							Collection<UsoLocale> usiLocali = prodotto.getUsiLocali();
							if (usiLocali != null && usiLocali.size() != 0) {
								Iterator<UsoLocale> it = usiLocali.iterator();
								while (it.hasNext()) {
									UsoLocale uso = (UsoLocale) it.next();
							%>
							<li class="d-flex gap-4 list-group-item">
								<div>
									<img class="bi text-muted flex-shrink-0 rounded-circle"
										width="98" height="98"
										onerror="this.src='./resources//img/error.jpg'"
										src="./ServletResources?codiceAzione=fotoUsoLocale&idUsoLocale=<%=uso.getId()%>">

									<h5 class="mb-0"><%=uso.getNome()%></h5>
									</div>
							</li>
					
					<%
					}
					}
					%>
					</ul>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card d-flex align-items-center justify-content-center"
				style="background: #c4d89d;">
				<div class="card-body">
					<h4 class="card-title">
						Benefici <a class="card-link" data-bs-toggle="modal"
							data-bs-target="#informazioniBenefici"><i
							class="fa-solid fa-circle-info text-end p-2"></i></a>
					</h4>

					<ul
						class="list-group list-group-horizontal text-center d-flex align-items-center justify-content-center">
						<%
						Collection<Beneficio> benefici = prodotto.getBenefici();
						if (benefici != null && benefici.size() != 0) {
							Iterator<?> it2 = benefici.iterator();

							while (it2.hasNext()) {
								Beneficio cat = (Beneficio) it2.next();
						%>
						<li class="list-group-item" style="max-width: 10rem;">
							<div class="years-<%=(int) cat.getPercentuale()%> m-2">
								<img onerror="this.src='./resources//img/error.jpg'"
									src="./ServletResources?codiceAzione=fotoBeneficio&idBeneficio=<%=cat.getId()%>"
									class="avatar">
							</div>

							<h5><%=cat.getNome()%></h5>
							<p><%=cat.getPercentuale()%>/5
							</p>
						</li>
						<%
						}
						}
						%>

					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- Dove Viene Piantato -->
	<div class="text-center m-4">
		<br> <br>
		<h3>Dove Viene Piantato?</h3>
		<p class="lead"><%=prodotto.getPaeseDiOrigine().getDescrizione()%></p>
	</div>
	<div class="text-center">
		<div class="magnifier d-none d-sm-block">
			<div class="large"
				style="background: url('./ServletResources?codiceAzione=fotoPaeseDiOrigine&idPaese=<%=prodotto.getPaeseDiOrigine()%>') no-repeat;"></div>

			<img
				src="./ServletResources?codiceAzione=fotoPaeseDiOrigine&idPaese=<%=prodotto.getPaeseDiOrigine()%>"
				class="img-fluid small" height="626px" width="925px"
				onerror="this.src='./resources//img/error.jpg'">
		</div>
	</div>
	<!-- Categorie -->
	<%Collection<Categoria> cat = prodotto.getCategorie();
if (cat != null && cat.size() != 0) {
	Iterator<Categoria> it = cat.iterator();
	while (it.hasNext()) {
		Categoria c = it.next();%>

	<div id="categorie">
		<div class="box">
			<h1 class="text-center">
				Perchè
				<%=c.getNome()%>?
			</h1><%=c.getDescrizione()%></div>
		<div class="cardCategoriaImage">
			<div id="imageCategorie">
				<img id="<%=c.getId()%>" class="img-fluid rounded" height="600px"
					width="600px" onerror="this.src='./resources//img/error.jpg'"
					src="./ServletResources?codiceAzione=fotoCategoria&idCategoria=<%=c.getId()%>"
					alt="img-200-300">
			</div>
		</div>
	</div>
	<%}
}%>
	<div class="m-5"></div>
	<div class="row b-example-divider"></div>
	<!-- Cosa Vuol Dire Piantare Un albero con WoodLot -->
	<br>
	<br>
	<h2 class="text-center">Cosa vuol dire piantare un albero con
		WoodLot</h2>
	<div class="row row-cols-1 row-cols-md-3 row-cols-lg-3 text-center m-5">
		<div class="col">
			<h1>
				<i class="fa-solid fa-location-dot text-info"></i>
			</h1>
			<h4>Trasparenza e tracciabilità</h4>
			<p>Tutti gli Alberi sono geolocalizzati e fotografati quando
				vengono piantati. Dal momento dell'acquisto è necessario attendere
				da alcune settimane a qualche mese prima che un albero sia pronto
				per essere piantato.</p>
		</div>
		<div class="col">
			<h1>
				<i class="fa-solid fa-book text-warning"></i>
			</h1>
			<h4>Un racconto che dura nel tempo</h4>
			<p>Ogni albero ha il proprio Diario, una pagina online dove
				scoprirai le sue caratteristiche e seguirai la storia del progetto
				di cui fa parte.</p>
		</div>
		<div class="col">
			<h1>
				<i class="fa-solid fa-gift text-danger"></i>
			</h1>
			<h4>Un regalo originale</h4>
			<p>Regalare un albero è semplicissimo. Puoi farlo durante la
				procedura d'acquisto o in qualunque momento dal tuo profilo,
				scegliendo la modalità che preferisci (via mail, messaggio o
				stampando un biglietto da consegnare a mano).</p>
		</div>
	</div>

	<div class="row b-example-divider"></div>
	<!-- Prodotti Consigliati  -->
	<h1 class="m-3 text-center">Pianta altri alberi</h1>
	<div class="row d-flex justify-content-center gb-3 ">
		<%
		if (prodotti != null && prodotti.size() != 0) {
			Iterator<?> it = prodotti.iterator();
			Iterator<?> it1 = fotoProdotti.iterator();
			for (int i = 0; i < 4; i++) {
				Albero bean = (Albero) it.next();
				FotoProdotto bean1 = (FotoProdotto) it1.next();
		%>
		<div
			class="col-lg-3 col-md-6 col-xs-12 col-sm-6
                            col-xs-12 d-flex justify-content-center mb-3">

			<div class="card text-center"
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
						style="background-color: #5E7250; color: white">Scopri di più!</a>
				</div>
			</div>
		</div>
		<%}
}%>
	</div>
	<div class="col-md-12 text-center">
		<a class="btn btn-primary m-3" href="Catalogo" role="button">Vedi
			tutti gli alberi</a>
	</div>
	</div>
	<!-- Modal Informazioni Usi Locali -->
	<div class="modal fade" id="informazioniUsiLocali" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Usi Locali</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<%
						if (usiLocaliAll != null && usiLocaliAll.size() != 0) {
							Iterator<?> it = usiLocaliAll.iterator();
							while (it.hasNext()) {
								UsoLocale uso = (UsoLocale) it.next();
						%>
						<li class="d-flex gap-4"><img
							class="bi text-muted flex-shrink-0" width="98" height="98"
							onerror="this.src='./resources//img/error.jpg'"
							src="./ServletResources?codiceAzione=fotoUsoLocale&idUsoLocale=<%=uso.getId()%>">
							<div>
								<h5 class="mb-0"><%=uso.getNome()%></h5>
								<%=uso.getDescrizione()%>
							</div></li>
						<%}
}%>
					</ul>
					<button type="button" class="btn btn-lg btn-primary mt-5 w-100"
						data-bs-dismiss="modal">Ho capito!</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Informazioni Benefici -->
	<div class="modal fade" id="informazioniBenefici" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0">Benefici</h2>
					<ul class="d-grid gap-4 my-5 list-unstyled">
						<%
						Collection<Beneficio> beneficiAll = prodotto.getBenefici();
						if (beneficiAll != null && beneficiAll.size() != 0) {
							Iterator<?> it = beneficiAll.iterator();
							while (it.hasNext()) {
								Beneficio ben = (Beneficio) it.next();
						%>
						<li class="d-flex gap-4"><img
							class="bi text-muted flex-shrink-0" width="48" height="48"
							onerror="this.src='./resources//img/error.jpg'"
							src="./ServletResources?codiceAzione=fotoBeneficio&idBeneficio=<%=ben.getId()%>">
							<div>
								<h5 class="mb-0"><%=ben.getNome()%></h5>
								<%=ben.getDescrizione()%>
							</div></li>
						<%}
}%>
					</ul>
					<button type="button" class="btn btn-lg btn-primary mt-5 w-100"
						data-bs-dismiss="modal">Ho capito!</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Prezzo -->
	<div class="modal fade" id="prezzo" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-3">Cos'è incluso nel prezzo?</h2>
					<img class="mx-5 my-1" src="resources/img/treedom-about-price.png"
						width="350px">
					<p class="m-1">Piantare un albero con WoodLot significa
						finanziare un contadino per piantare un albero e sostenerlo fino a
						quando non sarà produttivo. Con WoodLot infatti un albero è molto
						più di un albero. Ecco cosa è incluso nel prezzo:</p>
					<ol class="d-grid gap-4 my-2 list-group list-group-numbered">
						<li class="d-flex">Avvio del progetto</li>
						<li class="d-flex ">Costruzione del vivaio e produzione delle
							piantine</li>
						<li class="d-flex ">Distribuzione delle piante ai contadini</li>
						<li class="d-flex ">Messa a dimora della pianta</li>
						<li class="d-flex">Manutenzione della pianta fino al momento
							in cui non darà un reddito al contadino</li>
						<li class="d-flex ">Formazione dei contadini sulle migliori
							pratiche agro-forestali, anche con il supporto di università ed
							enti di ricerca locali</li>
						<li class="d-flex">Sostituzione delle fallanze durante i
							primi anni in cui il tasso di mortalità è più elevato</li>
						<li class="d-flex">Piantumazione di un 5% in più di alberi
							che non vengono assegnati agli utenti per coprire le fallanze</li>
						<li class="d-flex">Registrazione delle coordinate GPS
							dell'albero e monitoraggio fotografico</li>
						<li class="d-flex">Controlli annuali a campione sulle aree di
							progetto per verificare la permanenza degli alberi e la loro
							buona salute</li>
						<li class="d-flex">Approvazione della foto e controllo delle
							coordinate di ogni singolo albero da parte dei nostri agronomi
							specializzati.</li>
						<li class="d-flex">Assegnazione all’albero di un ID univoco e
							inserimento dell’albero <a
							href="ChiSiamoServlet#registroDegliAlberi" class="card-link">nel
								registro pubblico</a>
						</li>
						<li class="d-flex">Aggiornamenti periodici sul progetto, con
							un focus sui benefici ambientali e sociali, pubblicati nel Diario
							dell’Albero</li>
					</ol>
					<button type="button" class="btn btn-lg btn-primary mt-5 w-100"
						data-bs-dismiss="modal">Ho capito!</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<%@ include file="../fragments/footer.jsp"%>

	<!-- Script per animare le img della categoria -->
	<script type="text/javascript">
		//Creates an event that fires every time the mouse moves over any div with the class of "img".
		$(".img").mousemove(
				function(event) {

					//Both the x and y value are calculated by taking the mouse x,y position on the page and subtracting it from the x,y position of the image on the page. "this" is the hovered element with the class of "img"
					var mousex = event.pageX - $(this).offset().left;
					var mousey = event.pageY - $(this).offset().top;

					//If you just used the mouse position values the translation effect will only go up and to the right, by subtracting half of the length / width of the imagevfrom the values  we get either a positive or negitive number so that the image will move in any direction.

					//The 40 controls the amount of "movement" that will happen by giving us a smaller number, feel free to change it to get the effect that you want.
					var imgx = (mousex - 300) / 40;
					var imgy = (mousey - 200) / 40;

					//Adds a translation css styles to the image element
					$(this).css("transform",
							"translate(" + imgx + "px," + imgy + "px)");
				});

		//This function will fire every time the user mouses off of the image. It resets the translation back to 0.
		$(".img").mouseout(function() {
			$(this).css("transform", "translate(0px,0px)");
		});
	</script>
	<!-- Script per animare le img di dove viene piantato  -->
	<script type="text/javascript">
	$(document).ready(function() {
		  var native_width = 0;
		  var native_height = 0;
		  $(".magnifier").mousemove(function(e) {
		    if (!native_width && !native_height) {
		      var image_object = new Image();
		      image_object.src = $(".small").attr("src");
		      native_width = image_object.width;
		      native_height = image_object.height;
		    } else {
		      var magnify_offset = $(this).offset();
		      var mx = e.pageX - magnify_offset.left;
		      var my = e.pageY - magnify_offset.top;

		      if (mx < $(this).width() && my < $(this).height() && mx > 0 && my > 0) {
		        $(".large").fadeIn(100);
		      } else {
		        $(".large").fadeOut(100);
		      }
		      if ($(".large").is(":visible")) {
		        var rx =
		          Math.round(
		            mx / $(".small").width() * native_width - $(".large").width() / 2
		          ) * -1;
		        var ry =
		          Math.round(
		            my / $(".small").height() * native_height - $(".large").height() / 2
		          ) * -1;
		        var bgp = rx + "px " + ry + "px";

		        var px = mx - $(".large").width() / 2;
		        var py = my - $(".large").height() / 2;
		        $(".large").css({ left: px, top: py, backgroundPosition: bgp });
		      }
		    }
		  });
		});
	</script>
</body>
</html>