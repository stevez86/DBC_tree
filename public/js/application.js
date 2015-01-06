$(document).ready(function() {

  var filtered_by_tree = false;
  var filtered_by_cohort = false

  $("#your-cohort-link").on("click", function () {
    $(".cohort:has([data-id=50])").show(600, function(){
      setTimeout(function() {
      $.scrollTo(".cohort:has([data-id=50])", {duration:1200, offset:-68, easing:'easeInOutExpo'});
      }, 600);
    });
    $(".cohort:not(:has([data-id=50]))").hide(400);
    $(".cohort:has([data-id=50])").unslick();
    $(".cohort:has([data-id=50])").addClass('cohort-view');
  });

  $("#your-family-link").on("click", function () {
    $(".cohort:has([data-lineage=268])").show(600);
    $(".cohort:not(:has([data-lineage=268]))").hide(400);

    setTimeout(function() {
        centerOnUser("50");
        $(".cohort").slickFilter("[data-lineage=268]");
      }, 600);
  });

  $(".cohort-title").on("click", function () {
    $(".cohort-view").slick({
      arrows: false,
      dots: false,
      speed: 500,
      infinite: true,
      centerMode: true,
      focusOnSelect: true,
      slidesToShow: 15,
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
    $(".cohort-view").removeClass('cohort-view');

    $(this).parent().children(".cohort").toggle(200);
  });

  $('.user').click(function(){
    setUserHighlight($(this).data("id"));
  });

  $('.user').hover(function(){
    $(this).addClass('transition');
  }, function() {
    $(this).removeClass('transition');
  });

  var setUserHighlight = function(userID) {
    console.log("setUserHighlight");
    $('.highlight_user').removeClass('highlight_user');
    $("[data-id="+userID+"]").addClass('highlight_user');

    var lineage = $("[data-id="+userID+"]").data("lineage");
    $('.current_family_user').removeClass('current_family_user');
    $("[data-lineage="+lineage+"]").addClass('current_family_user');
    console.log("lineage",lineage,$("[data-lineage="+lineage+"]"));

    var new_name = $("[data-id="+userID+"] .name")[0].innerHTML;
    var new_image = $("[data-id="+userID+"] img").attr("src");

    $(".sidebar").show("fade");

    $("#highlight_image").fadeOut(300, function() {
      $("#highlight_image").attr("src",new_image);
      $("#highlight_image").fadeIn(300);
    });

    $("#highlight_name").hide(200, function() {
      $(this)[0].innerHTML = new_name;
      $(this).show(300);
    });

    // $("#highlight_email").hide(150);
    // $("#highlight_city").hide(125);
    $("#highlight_mentor").hide(100);


    // $.ajax({
    //   type: 'get',
    //   url: "/users/" + userID,
    //   datatype: "json"
    // }).success( function(user) {
    //   $("#highlight_email").text(user.email);
    //   $("#highlight_city").text(user.city);
    //   $("#highlight_email").show(100);
    //   $("#highlight_city").show(150);
    // })

    $.ajax({
      type: 'get',
      url: "/mentors/" + userID,
      datatype: "json"
    }).success( function(mentor) {
      $("#highlight_mentor").text(mentor.name);
      $("#highlight_mentor").show(100);
    })

  };

  var centerOnUser = function(userID) {
    console.log("centerOnUser");
    $("[data-id="+userID+"]").click();
    $.scrollTo("[data-id="+userID+"]", {duration:1200, offset:-72, easing:'easeInOutExpo'});
  };

  $('.cohort').slick({
    arrows: false,
    dots: false,
    speed: 500,
    infinite: true,
    centerMode: true,
    focusOnSelect: true,
    slidesToShow: 15,
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
