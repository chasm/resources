function Controller() {

	var view = new View();
	var box = new Box();
	var count = 10;

	var initialize = function() {
		view.clearScreen();
	};

	var stopIfDone = function(interval) {
		if (count > 1500) {
			clearInterval(interval);
		}
	};

	this.partyTime = function() {
		initialize();
		var cycle = setInterval(function() {
			var newBox = box.generate(count);
			view.addBox(newBox);
			view.scrollDown();
			count += 2;
			stopIfDone(cycle);
		},15);
	};

}