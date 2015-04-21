function Cell () {
}

function Conway (size) {
  this.size = size;
  this.grid = this.generateGrid(size);
  this.directions = [ [-1,-1], [-1, 0], [-1, 1], [ 0,-1], [ 0, 1], [ 1,-1], [ 1, 0], [ 1, 1] ];
}