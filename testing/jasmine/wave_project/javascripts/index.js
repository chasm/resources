var waveColumn = new WaveColumn();
waveColumn.initializeDivArray();

var waves = setInterval(function() {
	waveColumn.rotateDivArray();	
	waveColumn.print();
}, 10);