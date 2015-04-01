$(document).ready(function () {
  $('body').on('keyup', function(e) {
    var controller = new Controller();
    if (e.keyCode === 13) {
      controller.partyTime();
    }
  });
});

// THE PURE JS WAY
// function bindListeners() {
// 	document.body.onkeyup = function(e) {
// 		var controller = new Controller();
// 		if(e.keyCode == 13) {
// 			controller.partyTime();
// 		}
// 	}
// }

// function ready(fn) {
//   if (document.readyState != 'loading'){
//     fn();
//   } else {
//     document.addEventListener('DOMContentLoaded', fn);
//   }
// };

// ready(bindListeners);