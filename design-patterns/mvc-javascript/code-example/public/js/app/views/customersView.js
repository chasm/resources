function CustomersView () {
  this.$customersContainer = $('<ul id="customers-container"></ul>');
  $('#crm').append(this.$customersContainer);
}

CustomersView.prototype.renderCustomers = function (customers) {
  $.each(customers, function (index, customer) {
    var $customersContainer = $('#customers-container');
    $customersContainer.append(
      "<li id=" + customer.id + ">" + 
        "<h2>" + customer.name + "</h2>" + 
        "<p>" + customer.email + "</p>" + 
        "<p>" + customer.phone_number + "</p>" + 
        "<a class='delete-customer-button' href='/customers/" + customer.id + "'>delete</a>" +
      "</li>"
    );
  });
};

CustomersView.prototype.renderCustomersError = function () {
  alert('could not render customers');
};

CustomersView.prototype.bindDeleteEventListener = function (deleteCustomerFxn) {
  var self = this;
  $(document).on('click', '.delete-customer-button', function (e) {
    e.preventDefault();
    var $customerListItem = $(e.target).parent();
    deleteCustomerFxn($customerListItem, self.removeCustomerFromDOM, self.removeCustomerFromDOMError);
  });
};

CustomersView.prototype.removeCustomerFromDOM = function ($customerListItem) {
  $customerListItem.remove();
};

CustomersView.prototype.removeCustomerFromDOMError = function () {
  alert('could not delete customer');
};