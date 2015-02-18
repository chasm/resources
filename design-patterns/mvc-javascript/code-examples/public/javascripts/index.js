function bindListeners() {
	var controller = new Controller();
	document.body.onkeyup = function(e) {
		if(e.keyCode == 13) {
			controller.partyTime();
		}
	}	
}

function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
};

ready(bindListeners);