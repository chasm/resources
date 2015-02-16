describe('WaveColumn()', function() {

	beforeAll(function() {
		this.waveColumn = new WaveColumn();
	});

	describe('divArray', function() {
		it('is an Array', function() {
			expect(this.waveColumn.divArray).toEqual(jasmine.any(Array));
		});
		it('is initially empty',function() {
			expect(this.waveColumn.divArray.length).toEqual(0)
		});
	});

	describe('#initializeDivArray()', function() {

		beforeAll(function() {
			this.waveColumn.initializeDivArray();
		});

		it('populates divArray with 255 divs', function() {
			expect(this.waveColumn.divArray.length).toEqual(255);
		});	

		it('each div has class \'line\'', function() {
			expect(this.waveColumn.divArray[184].className).toEqual('line');
		});

		it('each div is red with opacity equal to 1 / 255 of its index in divArray', function() {
			expect(this.waveColumn.divArray[100].style.background).toEqual('rgba(255, 0, 0, 0.392157)');
		});

	});

	describe('#generateRedDiv(opacity)', function() {

		beforeAll(function() {
			this.opacity = 42;
			this.div = this.waveColumn.generateRedDiv(this.opacity)
		});

		it('returns a div', function() {
			expect(this.div.tagName).toEqual('DIV');
		});

		it('the div has a class of \'line\'', function() {
			expect(this.div.className).toEqual('line')
		});

		it('the div is the color red with opacity equal to 1 / 255 of the input parameter \'opacity\'', function() {
			expect(this.div.style.background).toEqual('rgba(255, 0, 0, 0.164706)')
		});

	});

	describe('#rotateDivArray()', function() {
		beforeAll(function() {
			this.div = this.waveColumn.divArray[0]
			this.waveColumn.rotateDivArray();
		});

		it('removes the first div in divArray', function() {
			expect(this.waveColumn.divArray).not.toEqual(this.div);
		});

		it('places the removed div at the back of divArray', function() {
			expect(this.waveColumn.divArray[254]).toEqual(this.div);
		});

	});

	describe('#print()', function() {
		beforeAll(function() {
			this.column = document.createElement('DIV')
			this.column.id = 'column'
			document.body.appendChild(this.column)
			this.waveColumn.print();	
		});

		it('appends every div in divArray to div#column in the html body', function() {
			expect(this.column.childNodes.length).toEqual(255); 
		});

		afterAll(function() {
			document.body.removeChild(this.column)
		});

	});

});