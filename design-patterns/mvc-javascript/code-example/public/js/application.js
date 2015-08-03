$(document).ready(function() {

  var $customersContainer = $('<ul id="customers-container"></ul>');
  $('#crm').append($customersContainer);

  $.ajax({
    type: 'GET',
    url: '/customers'
  }).done(function (customers) {
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
  }).fail(function () {
    alert('could not render customers');
  });

  $(document).on('click', '.delete-customer-button', function (e) {
    e.preventDefault();
    var $deleteButton = $(e.target);
    var $customerDiv = $deleteButton.parent();

    $.ajax({
      type: "DELETE",
      url: $deleteButton.attr('href')
    }).done(function () {
      $customerDiv.remove();
    }).fail(function () {
      alert('could not delete customer');
    });
    
  })

});