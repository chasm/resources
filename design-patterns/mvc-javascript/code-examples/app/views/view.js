function View() {

	var seedBox = document.body.children[0];
	var largestBox = seedBox;

	this.clearScreen = function() {
		seedBox.innerHTML = '';
	};

	this.addBox = function(box) {
		largestBox.appendChild(box);
		largestBox = box;
	};

	this.scrollDown = function() {
		window.scrollTo(document.body.scrollHeight,document.body.scrollHeight);
	};
	
}