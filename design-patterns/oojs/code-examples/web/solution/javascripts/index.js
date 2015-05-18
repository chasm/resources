$(document).ready(function() {

  var conway = new Conway(100);
  conway.renderGrid();

  var animate = setInterval(function () {
  	conway.updateNeighborsForAllCells();
  	conway.updateAllCells();  	
  }, 60);

});

