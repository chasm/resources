# mvc javascript

we'll be working through a small part of your client-side personal project as a way to explore the MVC design pattern with javascript.

your personal project comes with a pre-made api. you can get a quick overview of the api by taking a quick look at the [customers_controller](./code-example/app/controllers/customers_controller.rb) and [notes_controller](./code-example/app/controllers/notes_controller.rb).

## user story: display a list of customers on the page

let's take a basic approach to the first user story (displaying a list of customers on the page):

in application.js:

```javascript
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
  
});
```

when the page loads, we first append an empty customersContainer to the page. then, we make a 'get /customers' request to our server. this request returns an array of customer objects to us. for each customer object, we create an html string with that customer object's name, email, and phone number, and append it to the customersContainer. for each customer, we also add a delete button with href pointing to that customers resource path in our server's api.

now, let's pick apart the above code, and separate it into a model, view, and controller.

---

we can start by pulling all the bits of code interacting with the DOM into a separate view file:

```javascript
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
```

as we can see, when a new CustomersView is created, immediately we assign an empty customersContainer to the view object, and render it to the page.

when #renderCustomers is called with an array of customer objects, it generates an appropriate html string for each one, and appends it to the customersContainer.

when #renderCustomersError is called, it triggers an alert message.

---

now we can pull any code which interfaces with our server via ajax, into a separate model file:

```javascript
// customersModel.js:

function CustomersModel () {}

CustomersModel.prototype.getAll = function (success, error) {
  $.ajax({
    type : 'GET',
    url : '/customers'
  }).done(success).fail(error);
};

```

here, we've created a CustomersModel object constructor function. When #getAll is called on a CustomersModel object, an ajax request is made to our server. if the request is successful, the 'success' callback we passed into the getAll fxn is called. if the request is not successful, the 'error' callback passed into the getAll fxn is called.

---

finally, we create a separate controller file. this controller will be the 'glue' between our model and our view.

```javascript
// customersController.js:

function CustomersController () {
  this.initialize();
}

CustomersController.prototype.initialize = function () {
  this.customersModel = new CustomersModel();
  this.customersView = new CustomersView();
  this.customersModel.getAll(this.customersView.renderCustomers, this.customersView.renderCustomersError)
};
```

when a new CustomersController is created, we immediately create a new CustomersModel and CustomersView and assign them to the CustomersController. then, we call the customersModel's #getAll method, with our customerView's #renderCustomers and #renderCustomersError methods.

isn't that nice?

---

so now in our application.js, all we have to do is create a new CustomersController when the page loads.

```javascript
// application.js

$(document).ready(function() {
  var customersController = new CustomersController();
});
```

---

finally, we remember to include our javascript files in layout.erb, and include them in the right order.

```html
<!-- layout.erb -->

<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="stylesheet" href="/css/normalize.css">
  <link rel="stylesheet" href="/css/application.css">

  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

  <script src="/js/app/views/customersView.js"></script>  
  <script src="/js/app/models/customersModel.js"></script>  
  <script src="/js/app/controllers/customersController.js"></script>  
  <script src="/js/application.js"></script>

  <title></title>
</head>
<body>
  <%= yield %>
</body>
</html>
```

## user story 2: can delete a customer

again, let's take a basic approach to this user story, and later separate our code into our model, view, and controller.

---

our initial solution, in application.js, might look like:

```javascript
$(document).on('click', '.delete-customer-button', function (e) {
  e.preventDefault();
  var $deleteButton = $(e.target);
  var $customerListItem = $deleteButton.parent();

  $.ajax({
    type: "DELETE",
    url: $deleteButton.attr('href')
  }).done(function () {
    $customerListItem.remove();
  }).fail(function () {
    alert('could not delete customer');
  });
  
});
```

we listen for click events on any 'delete-customer-button's. when they happen, we immediately preventDefault on the event. we turn the button into a jQuery object and assign it to var $deleteButton. we also turn the customer list item containing that delete button, turn it into a jQuery object, and assign it to var $customerListItem.

then, we use ajax to make a 'delete /customers/:id' request to our server. we can easily pull the url off of our $deleteButton.

if the request is successful, we remove the $deleteButton's corresponding $customerListItem from the page. if the request is not successful, we trigger an alert.

---

again, we'll take any bits of code which interact with the DOM, and put them in our existing CustomersView object constructor fxn:

```javascript
// customersView.js

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
```

the #bindDeleteEventListener method binds our event listener to any 'delete-customer-button's on the page. the event handler first prevents the default action of our click event and instead turns the customer list item containing the clicked delete-button into a jQuery object and assigns it to var $customerListItem.

it then calls the deleteCustomerFxn callback, passed into the #bindDeleteEventListener method, with three arguments, 1) our $customerListItem, 2) our view's #removeCustomerFromDOM method, and 3) our view's #removeCustomerFromDOMError.

---

now we take any bits of code which interface with our server's api, and add them to our existing CustomersModel

```javascript
// customersModel.js

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
```

here, we've created a #deleteCustomer method which takes a $customerListItem jQuery object, a success callback, and an error callback.

the method makes an ajax call to a url contained in the delete-button inside of the $customerListItem passed in. if the request is successful, the success callback is called with the $customerListItem. if the request is not successful, the error callback is called.

---

now we add code to the controller to glue our new model method to our new view methods.

```javascript
// customersController.js

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
```

now when we initialize a new CustomersController, we call a new #bindEventListeners method. currently, this method calls the controller's customerView's #bindDeleteEventListener method with our controller's customerModel's #deleteCustomer method.

---

a final overview of our code:

```javascript
// application.js

$(document).ready(function() {
  var customersController = new CustomersController();
});
```

```javascript
// customersController.js

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
```

```javascript
// customersView.js

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
```

```javascript
// customersModel.js

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
```

```javascript
// layout.erb

<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="stylesheet" href="/css/normalize.css">
  <link rel="stylesheet" href="/css/application.css">

  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

  <script src="/js/app/views/customersView.js"></script>  
  <script src="/js/app/models/customersModel.js"></script>  
  <script src="/js/app/controllers/customersController.js"></script>  
  <script src="/js/application.js"></script>

  <title></title>
</head>
<body>
  <%= yield %>
</body>
</html>
```