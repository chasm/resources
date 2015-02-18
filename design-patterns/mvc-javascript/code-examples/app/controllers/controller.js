function Controller() {

	var view = new View();
	var box = new Model();
	var size = 10;

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

	function initialize() {
		view.clearScreen();
	};

	function stopIfDone(interval) {
		if (size > 1500) {
			clearInterval(interval);
		}
	};

}