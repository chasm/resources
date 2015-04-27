$(document).ready(function () {
  var conway = new Conway(100);
  conway.renderGrid();
  var loop = setInterval(function() {
    conway.tallyNeighbors();
    conway.updateCells();
  }, 100);
});

