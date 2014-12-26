$(document).ready(function() {

  $('.row').slick({
    dots: false,
    infinite: true,
    centerMode: true,
    slidesToScroll: 5,
    focusOnSelect: true,
    slidesToShow: 11,
    centerPadding: '10px'
  });

  var centerOnUser = function(userID) {
    cohort_id =

    $.scrollTo(".r9", {duration:1200, offset:-80, easing:'easeInOutExpo', onAfter: function() {
        setTimeout(function() {
          centerUser(userID);
        }, 0);
      }
    });
  };


  var goToRow = function(rowID) {
    $.scrollTo(".r"+ rowID, {duration:400, offset:-80, easing:'easeInOutExpo'});
  }

  var centerUser = function(userID) {
    $("#" + userID).children().click()
  }

  $("#cohort").on("click", function () {
    centerOnUser("101")
  });



});
