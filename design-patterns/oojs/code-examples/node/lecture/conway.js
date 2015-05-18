function Cell () {
}

function Conway (size) {
  this.size = size;
  this.grid = this.generateGrid();
  this.directions = [ [-1,-1], [-1, 0], [-1, 1], [ 0,-1], [ 0, 1], [ 1,-1], [ 1, 0], [ 1, 1] ];
}

Conway.prototype.generateGrid = function () {
};