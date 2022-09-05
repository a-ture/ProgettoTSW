/**
 * 
 */

$(document).ready(function() {

	$("#ordiniButton").click(function() {
		$("#ordini").removeClass("d-none");
		$("#badge").addClass("d-none");
		$("#woodLot").addClass("d-none");
		$("#news").addClass("d-none");
		$("#indirizzo").addClass("d-none");
		$("#logout").addClass("d-none");
		$("#modificaInformazioni").addClass("d-none");
		$("#regali").addClass("d-none");
	});

	$("#badgeButton").click(function() {
		$("#badge").removeClass("d-none");
		$("#ordini").addClass("d-none");
		$("#woodLot").addClass("d-none");
		$("#news").addClass("d-none");
		$("#indirizzo").addClass("d-none");
		$("#logout").addClass("d-none");
		$("#modificaInformazioni").addClass("d-none");
		$("#regali").addClass("d-none");
	});

	$("#woodLotButton").click(function() {
		$("#woodLot").removeClass("d-none");
		$("#badge").addClass("d-none");
		$("#ordini").addClass("d-none");
		$("#news").addClass("d-none");
		$("#indirizzo").addClass("d-none");
		$("#logout").addClass("d-none");
		$("#modificaInformazioni").addClass("d-none");
		$("#regali").addClass("d-none");
	});

	$("#newsButton").click(function() {
		$("#news").removeClass("d-none");
		$("#badge").addClass("d-none");
		$("#ordini").addClass("d-none");
		$("#woodLot").addClass("d-none");
		$("#indirizzo").addClass("d-none");
		$("#logout").addClass("d-none");
		$("#modificaInformazioni").addClass("d-none");
		$("#regali").addClass("d-none");
	});

	$("#indirizzoButton").click(function() {
		$("#indirizzo").removeClass("d-none");
		$("#badge").addClass("d-none");
		$("#ordini").addClass("d-none");
		$("#woodLot").addClass("d-none");
		$("#news").addClass("d-none");
		$("#logout").addClass("d-none");
		$("#modificaInformazioni").addClass("d-none");
		$("#regali").addClass("d-none");
	});

	$("#modificaInformazioniButton").click(function() {
		$("#modificaInformazioni").removeClass("d-none");
		$("#badge").addClass("d-none");
		$("#ordini").addClass("d-none");
		$("#woodLot").addClass("d-none");
		$("#news").addClass("d-none");
		$("#indirizzo").addClass("d-none");
		$("#logout").addClass("d-none");
		$("#regali").addClass("d-none");
	});

	$("#logoutButton").click(function() {
		$("#logout").removeClass("d-none");
		$("#badge").addClass("d-none");
		$("#ordini").addClass("d-none");
		$("#woodLot").addClass("d-none");
		$("#news").addClass("d-none");
		$("#indirizzo").addClass("d-none");
		$("#modificaInformazioni").addClass("d-none");
		$("#regali").addClass("d-none");
	});

	$("#regaliButton").click(function() {
		$("#regali").removeClass("d-none");
		$("#badge").addClass("d-none");
		$("#ordini").addClass("d-none");
		$("#woodLot").addClass("d-none");
		$("#news").addClass("d-none");
		$("#indirizzo").addClass("d-none");
		$("#modificaInformazioni").addClass("d-none");
		$("#logout").addClass("d-none");
	});

	$(".botteneIdOrdine").click(function() {
		var $row = $(this).closest("tr");
		var $codice = $row.find(".nr").text();
		$.get('OrdineJSON?codice=' + $codice, function(resp) {
			printDettagliOrdine(resp);
		}).fail(function() {
			alert("Request failed.");
		});
	});
	$("#closeOrdineAlert").click(function() {
		$("#ordineAlert").addClass("d-none");
	});

});


function printDettagliOrdine(json) {
	$("#ordineAlert").removeClass("d-none");
	$("#numeroOrdineAlert").empty().append("<h4>Dettaglio ordine n." + json.id + "</h4>");

	$("#prodottiOrdineAlert").empty();
	json.items.forEach((e) => {
		$("#prodottiOrdineAlert").append("<li>" + "<b>Nome:</b> " + e.nome + ", Prezzo: " + e.prezzo + ", Quantità: "
			+ e.quantità + ", Saldo: " + e.saldo + "%, tasse: " + e.tasse + "%, Stato: " + e.stato +
			"</li>");
	});

	$("#dettaglioOrdineAlert").empty().append("<b>N. Prodotti:</b>" + json.totaleProdotti + ", ");
	$("#dettaglioOrdineAlert").append("<b>Totale Ordine:</b>" + json.totalePagato + ", ");
	$("#dettaglioOrdineAlert").append("<b>Regalo?:</b>" + json.regalo+", ");
	$("#dettaglioOrdineAlert").append("<b>Messaggio Regalo</b>" + json.messaggioRegalo + ", ");
	$("#dettaglioOrdineAlert").append("<b>Destinatario Regalo</b>" + json.destinatarioRegalo + ", ");
};