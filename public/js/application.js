$(document).ready(function() {

  $('.user').click(function(){

    setUserHighlight($(this).data("id"));
    // console.log($(this).data("id"));
  });

  var setUserHighlight = function(userID) {
    var new_name = $("[data-id="+userID+"] .name")[0].innerHTML;
    var new_image = $("[data-id="+userID+"] img").attr("src");

    $("#highlight_name").hide(50);
    $("#highlight_name")[0].innerHTML = new_name;
    $("#highlight_name").show(400);
    $(".sidebar").show("fade");
    $("#highlight_image").attr("src",new_image);
    $("#highlight_email").hide(400);
    $("#highlight_city").hide(400);

    $.ajax({
      url: 'http://api.randomuser.me/',
      dataType: 'json',
      success: function(data){
        console.log(data.results["email"]);
      }
    });

    $.ajax({
      type: 'get',
      url: "/users/" + userID,
      datatype: "json"
    }).success( function(user) {
      $("#highlight_email").text(user.email);
      $("#highlight_city").text(user.city);
      $("#highlight_email").show(400);
      $("#highlight_city").show(400);
    })
  };

  // var centerOnUser = function(userID) {
  //   cohort_id =

  //   $.scrollTo(".r9", {duration:1200, offset:-80, easing:'easeInOutExpo', onAfter: function() {
  //       setTimeout(function() {
  //         centerUser(userID);
  //       }, 0);
  //     }
  //   });
  // };


  // var goToRow = function(rowID) {
  //   $.scrollTo(".r"+ rowID, {duration:400, offset:-80, easing:'easeInOutExpo'});
  // }

  // var centerUser = function(userID) {
  //   $("#" + userID).children().click()
  // }

  // $("#cohort").on("click", function () {
  //   centerOnUser("101")
  // });

  $('.cohort').slick({
    // accessibility: false,
    arrows: false,
    dots: false,
    speed: 500,
    infinite: true,
    centerMode: true,
    focusOnSelect: true,
    slidesToShow: 15,
    // centerPadding: '30%',
    responsive:
    [
      {
        breakpoint: 1800,
        settings: {
        slidesToShow: 16,
        }
      },
      {
        breakpoint: 1700,
        settings: {
        slidesToShow: 15,
        }
      },
      {
        breakpoint: 1600,
        settings: {
        slidesToShow: 14,
        }
      },
      {
        breakpoint: 1500,
        settings: {
        slidesToShow: 13,
        }
      },
      {
        breakpoint: 1400,
        settings: {
        slidesToShow: 12,
        }
      },
      {
        breakpoint: 1300,
        settings: {
        slidesToShow: 11,
        }
      },
      {
        breakpoint: 1200,
        settings: {
        slidesToShow: 10,
        }
      },
      {
        breakpoint: 1100,
        settings: {
        slidesToShow: 9,
        }
      },
      {
        breakpoint: 1000,
        settings: {
        slidesToShow: 8,
        }
      },
      {
        breakpoint: 900,
        settings: {
        slidesToShow: 7,
        }
      },
      {
        breakpoint: 800,
        settings: {
        slidesToShow: 6,
        }
      },
      {
        breakpoint: 700,
        settings: {
        slidesToShow: 5,
        }
      },
      {
        breakpoint: 600,
        settings: {
        slidesToShow: 4,
        }
      },
      {
        breakpoint: 500,
        settings: {
        slidesToShow: 3,
        }
      },
      {
        breakpoint: 400,
        settings: {
        slidesToShow: 2,
        }
      }
    ]
  });




});
