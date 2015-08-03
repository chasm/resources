function CustomersModel () {}

CustomersModel.prototype.getAll = function (success, error) {
  $.ajax({
    type : 'GET',
    url : '/customers'
  }).done(success).fail(error);
};

CustomersModel.prototype.deleteCustomer = function ($customerListItem, success, error) {
  $.ajax({
    type : 'DELETE',
    url : $customerListItem.find('.delete-customer-button').attr('href')
  }).done(function () {
    success($customerListItem);
  }).fail(function () {
    error();
  });
};