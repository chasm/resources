function Model() {
}

Model.prototype.generateBox = function (size) {
  var $div = $('<div></div>').css({
    'height' : size + 'px',
    'width' : size + 'px'
  });
  console.log($div)
  return $div;
}

// THE PURE JS WAY
// function Model() {

// 	this.generateBox = function(size) {
// 		var div = document.createElement('DIV');
// 		div.style.height = size + 'px';
// 		div.style.width = size + 'px';
// 		return div;
// 	};

// }