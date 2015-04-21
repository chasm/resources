function Cell () {
  this.alive = Math.random() > 0.7;
  this.neighbors = 0;
}

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

Conway.prototype.show = function () {
  process.stdout.write('\033c');
  for (var i = 0; i < this.size; i++) {
    var rowString = "";
    for (var j = 0; j < this.size; j++) {
      if (this.grid[i][j].alive) {
        rowString += "X|";
      } else {
        rowString += " |";
      }
    }
    console.log(rowString);
  }
};

Conway.prototype.isUnderpopulated = function (r,c) {
  return this.grid[r][c].neighbors < 2;
};

Conway.prototype.isOverPopulated = function (r,c) {
  return this.grid[r][c].neighbors > 3;
};

Conway.prototype.isRessurrectable = function (r,c) {
  return this.grid[r][c].alive === false && this.grid[r][c].neighbors === 3;
};

Conway.prototype.inBounds = function (r,c) {
  return (r >= 0 && r < this.size) && (c >= 0 && c < this.size);
};

Conway.prototype.tallyNeighborsFor = function (r,c) {
  this.grid[r][c].neighbors = 0;
  for (var i = 0; i < this.directions.length; i++) {
    var y = this.directions[i][0];
    var x = this.directions[i][1];
    if (this.inBounds(r + y, c + x) && this.grid[r + y][c + x].alive) {
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
    this.grid[r][c].alive = false;
  }
  if (this.isRessurrectable(r,c)) {
    this.grid[r][c].alive = true;
  }
};

Conway.prototype.updateCells = function () {
  for (var i = 0; i < this.size; i++) {
    for (var j = 0; j < this.size; j++) {
      this.updateCell(i,j);
    }
  }
};

var conway = new Conway(50);

var loop = setInterval(function() {
  conway.show();
  conway.tallyNeighbors();
  conway.updateCells();
}, 100);