$(document).ready(function () {
  var conway = new Conway(100);
  conway.renderGrid();
  var loop = setInterval(function() {
    var turns = parseInt($('#turns').text()) + 1;
    $('#turns').text(turns);
    conway.tallyNeighbors();
    conway.updateCells();
  }, 200);
});

