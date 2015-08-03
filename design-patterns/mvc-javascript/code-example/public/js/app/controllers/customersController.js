function CustomersController () {
  this.initialize();
}

CustomersController.prototype.initialize = function () {
  this.customersModel = new CustomersModel();
  this.customersView = new CustomersView();
  this.customersModel.getAll(this.customersView.renderCustomers, this.customersView.renderCustomersError)
  this.bindEventListeners();
};

CustomersController.prototype.bindEventListeners = function () {
  this.customersView.bindDeleteEventListener(this.customersModel.deleteCustomer);
};