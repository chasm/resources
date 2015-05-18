$(document).ready(function() {
	
	var conway = new Conway(50);
	var time = setInterval(function () {
	  conway.updateNeighborsForAllCells();
	  conway.updateAllCells();
	  conway.show();
	}, 50);

});

