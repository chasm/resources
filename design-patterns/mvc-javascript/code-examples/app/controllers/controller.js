function Controller() {

	var view = new View();
	var box = new Model();
	var size = 10;

	var initialize = function() {
		view.clearScreen();
	};

	var stopIfDone = function(interval) {
		if (size > 1500) {
			clearInterval(interval);
		}
	};

	this.partyTime = function() {
		initialize();
		var cycle = setInterval(function() {
			var newBox = box.generateBox(size);
			view.addBox(newBox);
			view.scrollDown();
			size += 2;
			stopIfDone(cycle);
		},15);
	};

}