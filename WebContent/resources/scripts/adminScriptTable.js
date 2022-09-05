/**
 * 
 */

function myFunctionId(n, idInput, idTable) {
	var input, filter, table, tr, td, i, txtValue;
	input = document.getElementById(idInput);
	filter = input.value.toUpperCase();
	table = document.getElementById(idTable);
	tr = table.getElementsByTagName("tr");
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[n];
		if (td) {
			txtValue = td.textContent || td.innerText;
			if (txtValue.toUpperCase().indexOf(filter) > -1) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		}
	}
}

function sortTableNumb(id, n) {
	var table, rows, switching, i, x, y, shouldSwitch;
	table = document.getElementById(id);
	switching = true;
	while (switching) {
		switching = false;
		rows = table.rows;
		for (i = 1; i < (rows.length - 1); i++) {
			shouldSwitch = false;
			x = rows[i].getElementsByTagName("td")[n];
			y = rows[i + 1].getElementsByTagName("td")[n];
			if (Number(x.innerHTML) > Number(y.innerHTML)) {
				shouldSwitch = true;
				break;
			}
		}
		if (shouldSwitch) {
			rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
			switching = true;
		}
	}
}

function sortTableAlf(n, idTable) {
	var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
	table = document.getElementById(idTable);
	switching = true;
	dir = "asc";
	while (switching) {
		switching = false;
		rows = table.rows;
		for (i = 1; i < (rows.length - 1); i++) {
			shouldSwitch = false;
			x = rows[i].getElementsByTagName("TD")[n];
			y = rows[i + 1].getElementsByTagName("TD")[n];
			if (dir == "asc") {
				if (x.innerHTML.toLowerCase() > y.innerHTML
					.toLowerCase()) {

					shouldSwitch = true;
					break;
				}
			} else if (dir == "desc") {
				if (x.innerHTML.toLowerCase() < y.innerHTML
					.toLowerCase()) {

					shouldSwitch = true;
					break;
				}
			}
		}
		if (shouldSwitch) {
			rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
			switching = true;

			switchcount++;
		} else {
			if (switchcount == 0 && dir == "asc") {
				dir = "desc";
				switching = true;
			}
		}
	}
}