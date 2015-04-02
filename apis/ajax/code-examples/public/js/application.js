$(document).ready(function() {

  $('#get-cats-button').click(function(e) {
    e.preventDefault();
    $.ajax({
      type : 'GET',
      url : '/cats',
      success : function(res) {
        var cats = JSON.parse(res);
        $('#cat-container').empty();
        for (var i = 0; i < cats.length; i++) {
          var currentCat = cats[i];
          $('#cat-container').append(
            '<li>' +
              '<h2>' + currentCat.name + '</h2>' +
              '<h3>' + currentCat.product + '</h3>' +
            '</li>'
          );
        }
      },
      error : function() {
        console.log("EVERYTHING IS BROKEN AND IM HUNGRY");
      }
    });
  });

  $('#new-cat-form').on('submit', function(e) {
    e.preventDefault();
    $.ajax({
      type: 'POST',
      url: '/cats',
      data: $(this).serialize(),
      success: function() {
        $('#notification').text('CAT ADD SUCCESS ~ ~ ~ OOOOOO')
        $("input[type='text']").val('');
      },
      error: function() {
        $('#notification').html("<img src='http://www.buckybox.com/images/team-joshua-63101086.jpg'> BAD REQUEST");
      }
    });
  });

});