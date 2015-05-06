function PirateShipController() {
  this.view  = new PirateShipView()
  this.model = new PirateShip()
}

PirateShipController.prototype = {
  start: function() {
    this.bindListeners()
  },
  bindListeners: function() {
    var button = this.view.getButton()
    button.addEventListener('click', this.moveModel.bind(this))
  },
  moveModel: function() {
    this.model.incrementLocation()
    var newLocation = this.model.location
    this.view.setShipLocation(newLocation)
  }
}
