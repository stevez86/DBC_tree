$(document).ready(function() {

  reSlick();
  var currentUser = {};

  $.ajax({
    type: 'get',
    url: "current_user",
    datatype: "json"
  }).success( function(current_user) {
    currentUser.id = current_user.id;
    currentUser.lineage_id = current_user.lineage_id;
    // console.log("hi",current_user);
  });

  $("#your-link").on("click", function () {
    scrollToUser(currentUser.id);
  });

  $("#your-cohort-link").on("click", function () {
    if ($(this).hasClass("filter-enabled")) {
      unHighlightUserCohort(currentUser.id);
    } else {
      highlightUserCohort(currentUser.id);
    }
  });

  // //TODO
  // $("#your-family-link").on("click", function () {
  //   $(".cohort:has([data-lineage=268])").show(600);
  //   $(".cohort:not(:has([data-lineage=268]))").hide(400);

  //   setTimeout(function() {
  //       scrollToCohort("50");
  //       $(".cohort").slickFilter("[data-lineage=268]");
  //     }, 600);
  // });

  $('.user').click(function(){
    // console.log("user clicked",$(this).data("id"));
    // console.log($(this).data("id"));
    highlightUser($(this).data("id"));
  });

  $('.user').hover(function(){
    $(this).addClass('highlight_user');
  }, function() {
    $(this).removeClass('highlight_user');
  });

  $(".cohort-title").on("click", function () {
    reSlick();
    $(this).parent().children(".cohort").toggle(200);
  });

  function highlightUserCohort(userID) {
    $("#your-cohort-link").addClass("filter-enabled");
    var cohort = getCohort(userID);
    cohort.unslick();
    $(".cohort:not(:has([data-id="+userID+"]))").hide(400);
    cohort.show(400);

    setTimeout(function() {
      scrollToCohort(userID);
    }, 500);
    setTimeout(function() {
      $(".cohort:has([data-id="+userID +"])").parent().effect("highlight",{color: "white"});
      $(".cohort:has([data-id="+userID +"])").parent().children(".cohort-title").effect("highlight",{color: "yellow"});
    }, 900);
  }

  function unHighlightUserCohort() {
    resetInterface();
    scrollToUser(currentUser.id);
  }

  function highlightUserTree(userID) {
    var lineage = $("[data-id="+userID+"]").data("lineage");
    $('.current_family_user').removeClass('current_family_user');
    $("[data-lineage="+lineage+"]").addClass('current_family_user');
  }

  function highlightUser(userID) {
    console.log("highlightUser",userID);
    highlightUserTree(userID);
    setSidebar(userID);
  }

  function setSidebar(userID) {
    var new_name = $("[data-id="+userID+"] .name")[0].innerHTML;
    var new_image = $("[data-id="+userID+"] img").attr("src");

    $(".sidebar").show(600);

    $("#highlight_image").fadeOut(300, function() {
      $("#highlight_image").attr("src",new_image);
      $("#highlight_image").fadeIn(300);
    });

    $("#highlight_name").hide(200, function() {
      $(this)[0].innerHTML = new_name;
      $(this).show(300);
    });

    $("#highlight_mentor").hide(100);

    $.ajax({
      type: 'get',
      url: "users/"+ userID +"/mentor",
      datatype: "json"
    }).success( function(mentor) {
      if (mentor !== null) {
        $("#highlight_mentor").text("Mentor: " + mentor.name);
        $("#highlight_mentor").show(100);
      }
    });
  }

  function scrollToUser(userID) {
    scrollToCohort(userID);
    getCohort(userID).slickGoTo(getUserIndex(userID));
    highlightUser(userID);
  }

  function getUserIndex(userID) {
    return $("[data-id=401].user:not(.slick-cloned)").attr("index");
  }

  function scrollToCohort(userID) {
    // console.log("scrollToCohort");
    $.scrollTo(".cohort:has([data-id="+ userID +"])", {duration: 700, offset:-69, easing:'easeInOutExpo'});
  }

  function getCohort(userID) {
    return $(".cohort:has([data-id="+userID +"])");
  }

  function resetInterface() {
    removeTempClasses();
    reSlick();
    $(".cohort:hidden").show();
  }

  function removeTempClasses() {
    $(".filter-enabled").removeClass("filter-enabled");
  }

  function reSlick() {
    $(".cohort:not(.slick-initialized)").slick({
      arrows: false,
      dots: false,
      adaptiveHeight: true,
      // draggable: false,
      speed: 1000,
      infinite: true,
      centerMode: true,
      focusOnSelect: true,
      slidesToShow: 16,
      slidesToScroll: 5,
      // autoplay: true,
      autoplaySpeed: 2000,
      // easing: "easeOutElastic",
      // swipeToSlide: false,
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
  }
});
