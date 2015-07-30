$(document).ready(function() {


  // example get request to our server
  $('#get-cats-button').click(function(e) {
    e.preventDefault();
    $.ajax({
      type : 'GET',
      url : '/cats'
    }).done(function (cats) {
      $('#cat-container').empty();
      $.each(cats, function (i, cat) {
        appendCat(cat);
      });
    }).fail(function () {
      console.log("EVERYTHING IS BROKEN AND IM HUNGRY");
    });
  });

  // helper fxn for the above get request example
  function appendCat(cat) {
    $('#cat-container').append(
      '<li>' +
        '<h2>' + cat.name + '</h2>' +
        '<h3>' + cat.product + '</h3>' +
      '</li>'
    );
  }

  // example post request to our server
  $('#new-cat-form').on('submit', function(e) {
    e.preventDefault();
    var $form = $(this);
    $.ajax({
      type: 'POST',
      url: '/cats',
      data: $form.serialize()
    }).done(function (cat) {
        appendCat(cat);
        $('#notification').text('CAT ADD SUCCESS ~ ~ ~ OOOOOO');
        $form[0].reset();
    }).fail(function () {
        $('#notification').html("<img src='http://www.buckybox.com/images/team-joshua-63101086.jpg'> BAD REQUEST");
    });
  });

  // example get request to another server
  $('#magic').on('click', function (e) {
    e.preventDefault();
    $.ajax({
      type: 'GET',
      url: 'http://api.mtgdb.info/cards/random'
    }).done(function (cardObject) {
        alert('check the console!');
        console.log("data on a random magic card from a magic API");
        console.log(cardObject);
    }).fail(function () {
      console.log("EVERYTHING IS BROKEN AND IM HUNGRY");
    });
  });

});