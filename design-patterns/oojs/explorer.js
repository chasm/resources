function Cell () {
  this.alive = Math.random() > 0.8;
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

Conway.prototype.isOverpopulated = function (r,c) {
  return this.grid[r][c].neighbors > 3;
};

Conway.prototype.isUnderpopulated = function (r,c) {
  return this.grid[r][c].neighbors < 2;
};

Conway.prototype.isSexytime = function (r,c) {
  return this.grid[r][c].neighbors === 3;
};

Conway.prototype.inBounds = function (r,c) {
  return (r > 0 && r < this.size - 1) && (c > 0 && c < this.size - 1);
};

Conway.prototype.isAlive = function(r,c) {
  return this.grid[r][c].alive;
}

Conway.prototype.tallyNeighborsFor = function (r,c) {
  this.grid[r][c].neighbors = 0;
  for (var i = 0; i < this.directions.length; i++) {
    var y = this.directions[i][0];
    var x = this.directions[i][1];
    if (this.inBounds(r + y, c + x) && this.isAlive(r + y, c + x)) {
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
  if (this.isAlive(r,c) && (this.isOverpopulated(r,c) || this.isUnderpopulated(r,c))) {
    this.grid[r][c].alive = false;
  }
  if (!this.isAlive(r,c) && this.isSexytime(r,c)) {
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
conway.show();

var loop = setInterval(function () {
  conway.tallyNeighbors();
  conway.updateCells();
  conway.show();
}, 200);