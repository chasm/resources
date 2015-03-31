function Conway (size) {
  this.size = size;
  this.grid = generateGrid(size);
  this.directions = [ [-1,-1], [-1, 0], [-1, 1], [ 0,-1], [ 0, 1], [ 1,-1], [ 1, 0], [ 1, 1] ];

  function generateGrid(size) {
    var grid = [];
    for (var i = 0; i < size; i++) {
      var row = [];
      for (var j = 0; j < size; j++) {
        row.push(new Cell());
      }
      grid.push(row);
    }
    return grid;
  };
}

Conway.prototype.renderGrid = function () {
  for (var i = 0; i < this.size; i++) {
    $('#grid').append(row);
    var row = $("<div class='row'></div>");
    for (var j = 0; j < this.size; j++) {
      row.append(this.grid[i][j].element)
    }
  }
};

Conway.prototype.isUnderpopulated = function (r,c) {
  return this.grid[r][c].neighbors < 2;
};

Conway.prototype.isOverPopulated = function (r,c) {
  return this.grid[r][c].neighbors > 3;
};

Conway.prototype.isRessurrectable = function (r,c) {
  return this.grid[r][c].isAlive() === false && this.grid[r][c].neighbors === 3;
};

Conway.prototype.inBounds = function (r,c) {
  return (r >= 0 && r < this.size) && (c >= 0 && c < this.size);
};

Conway.prototype.tallyNeighborsFor = function (r,c) {
  this.grid[r][c].neighbors = 0;
  for (var i = 0; i < this.directions.length; i++) {
    var y = this.directions[i][0];
    var x = this.directions[i][1];
    if (this.inBounds(r + y, c + x) && this.grid[r + y][c + x].isAlive()) {
      this.grid[r][c].neighbors++;
    }
  }
};

Conway.prototype.tallyNeighbors = function () {
  for (var i = 0; i < this.size; i++) {
    for (var j = 0; j < this.size; j++) {
      this.tallyNeighborsFor(i,j);
    }
  }
};

Conway.prototype.updateCell = function (r,c) {
  if (this.isUnderpopulated(r,c) || this.isOverPopulated(r,c)) {
    this.grid[r][c].kill();
  }
  if (this.isRessurrectable(r,c)) {
    this.grid[r][c].resurrect();
  }
};

Conway.prototype.updateCells = function () {
  for (var i = 0; i < this.size; i++) {
    for (var j = 0; j < this.size; j++) {
      this.updateCell(i,j);
    }
  }
};