function Cell () {
  this.alive = Math.random() > 0.8;
  this.neighbors = 0;
}

function Conway (size) {
  this.size = size;
  this.grid = this.generateGrid();
  this.directions = [ [-1,-1], [-1, 0], [-1, 1], [ 0,-1], [ 0, 1], [ 1,-1], [ 1, 0], [ 1, 1] ];
}

Conway.prototype.generateGrid = function () {
  var grid = [];
  for (var i = 0; i < this.size; i++) {
    var row = [];
    for (var j = 0; j < this.size; j++) {
      row.push(new Cell());
    }
    grid.push(row);
  }
  return grid;
};

Conway.prototype.show = function () {
  console.log('\033[2J');
  for (var i = 0; i < this.size; i++) {
    var rowString = '|';
    for (var j = 0; j < this.size; j++) {
      if (this.grid[i][j].alive) {
        rowString += 'X|';
      } else {
        rowString += ' |'
      }
    }
    console.log(rowString);
  }
};

Conway.prototype.isUnderpopulated = function (r,c) {
  return this.grid[r][c].alive && this.grid[r][c].neighbors < 2;
};

Conway.prototype.isOverpopulated = function (r,c) {
  return this.grid[r][c].alive && this.grid[r][c].neighbors > 3;
};

Conway.prototype.isResurrectable = function (r,c) {
  return !this.grid[r][c].alive && this.grid[r][c].neighbors === 3;
};

Conway.prototype.updateNeighborsForCell = function (r,c) {
  var currentCell = this.grid[r][c];
  currentCell.neighbors = 0;
  for (var i = 0; i < this.directions.length; i++) {
    var dr = this.directions[i][0];
    var dc = this.directions[i][1];
    if (this.inBounds(r + dr, c + dc)) {
      var neighborCell = this.grid[r + dr][c + dc];
      if (neighborCell.alive) {
        currentCell.neighbors++;
      }
    }
  }
};

Conway.prototype.updateNeighborsForAllCells = function () {
  for (var r = 0; r < this.size; r++) {
    for (var c = 0; c < this.size; c++) {
      this.updateNeighborsForCell(r,c);
    }
  }
};

Conway.prototype.inBounds = function (r,c) {
  return r >= 0 && c >= 0 && r < this.size && c < this.size;
};

Conway.prototype.updateCell = function (r,c) {
  var currentCell = this.grid[r][c]
  if (this.isUnderpopulated(r,c) || this.isOverpopulated(r,c)) {
    currentCell.alive = false;
  } else if (this.isResurrectable(r,c)) {
    currentCell.alive = true;
  }
};

Conway.prototype.updateAllCells = function () {
  for (var r = 0; r < this.size; r++) {
    for (var c = 0; c < this.size; c++) {
      this.updateCell(r,c);
    }
  }
};

var conway = new Conway(50);
var time = setInterval(function () {
  conway.updateNeighborsForAllCells();
  conway.updateAllCells();
  conway.show();
}, 50);