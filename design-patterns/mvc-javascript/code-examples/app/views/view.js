function View() {
  this.$seedBox = $('#seed');
  this.$largestBox = this.$seedBox;
}

View.prototype.clearScreen = function () {
  this.$seedBox.html('');
};

View.prototype.addBox = function ($box) {
  this.$largestBox.append($box);
  this.$largestBox = $box;
};

View.prototype.scrollDown = function () {
  window.scrollTo(document.body.scrollHeight, document.body.scrollWidth);
};

// THE PURE JS WAY
// function View() {

// 	var seedBox = document.getElementById('seed');
// 	var largestBox = seedBox;

// 	this.clearScreen = function() {
// 		seedBox.innerHTML = '';
// 	};

// 	this.addBox = function(box) {
// 		largestBox.appendChild(box);
// 		largestBox = box;
// 	};

// 	this.scrollDown = function() {
// 		window.scrollTo(document.body.scrollHeight,document.body.scrollHeight);
// 	};

// }