function WaveColumn() {
  this.divArray = [];
}

WaveColumn.prototype.initializeDivArray = function() {
  for (var i = 0; i < 255; i++) {
    this.divArray.push(this.generateRedDiv(i));
  }
}

WaveColumn.prototype.generateRedDiv = function (opacity) {
  var $div = $("<div class='line'></div>").css({
    'background' : 'rgba(255,0,0,' + opacity / 255 + ')'
  });
  return $div;
};

WaveColumn.prototype.rotateDivArray = function() {
  var div = this.divArray.shift();
  this.divArray.push(div);
}

WaveColumn.prototype.print = function() {
  var $column = $('#column');
  $column.html('');
  for (var i = 0; i < this.divArray.length; i++) {
    $column.append(this.divArray[i]);
  }
}

/* THE PURE JS WAY
function WaveColumn() {
	this.divArray = [];
}

WaveColumn.prototype.initializeDivArray = function() {
	for (var i = 0; 	i < 255; i++) {
		this.divArray.push(this.generateRedDiv(i));
	}
}

WaveColumn.prototype.generateRedDiv = function(opacity) {
	var div = document.createElement('div');
	div.className = 'line';
	div.style.background = 'rgba(255,0,0,' + opacity / 255 + ')';
	return div;
}

WaveColumn.prototype.rotateDivArray = function() {
	var div = this.divArray.shift();
	this.divArray.push(div);
}

WaveColumn.prototype.print = function() {
	var column = document.getElementById('column');
	column.innerHTML = '';
	for (var i = 0; i < this.divArray.length; i++) {
		column.appendChild(this.divArray[i]);
	}
}
*/