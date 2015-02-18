function Model() {

	this.generateBox = function(size) {
		var div = document.createElement('DIV');
		div.style.height = size + 'px';
		div.style.width = size + 'px';
		return div;
	};

}