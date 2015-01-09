$(document).ready(function() {

  reSlick();
  var currentUser = {};

  $.ajax({
    type: 'get',
    url: "users/current_user",
    datatype: "json"
  }).success( function(current_user) {
    currentUser.id = current_user.id;
    currentUser.lineage_id = current_user.lineage_id;
    scrollToUser(currentUser.id);
  });

  $("#your-link").on("click", function () {
    resetInterface();
    scrollToUser(currentUser.id);
  });

  $("#highlight_mentor").on("click", function() {
    resetInterface();
    scrollToUser($(this).children("a").attr("id"));
  });

  $("#highlight_cohort").on("click", function() {
    resetInterface();
    showUserCohort($(this).children("a").attr("id"));
  });

  $("#highlight_name").on("click", function() {
    resetInterface();
    scrollToUser($(this).children("a").attr("id"));
  });

  $("#your-cohort-link").on("click", function () {
    if ($(this).hasClass("filter-enabled")) {
      $(this).removeClass("filter-enabled");
      resetInterface();
      setTimeout(function() {
        scrollToUser(currentUser.id);
      }, 300);
    } else {
      $(".filter-enabled").removeClass("filter-enabled");
      $(this).addClass("filter-enabled");
      showUserCohort(currentUser.id);
    }
  });

  $("#your-family-link").on("click", function () {
    if ($(this).hasClass("filter-enabled")) {
      $(this).removeClass("filter-enabled");
      resetInterface();
      setTimeout(function() {
        scrollToUser(currentUser.id);
      }, 300);
    } else {
      $(".filter-enabled").removeClass("filter-enabled");
      $(this).addClass("filter-enabled");
      showUserFamily(currentUser.id);
    }
  });

  $('.user').click(function(){
    userID = $(this).data("id");
    selectUser(userID);
    $(".selected_user").removeClass('selected_user');
    $("[data-id="+userID+"]").addClass('selected_user');
  });

  $('.user').hover(function(){
    $(this).addClass('highlight_user');
  }, function() {
    $(this).removeClass('highlight_user');
  });

  $(".cohort-title").on("click", function () {
    $(".filter-enabled").removeClass("filter-enabled");
    $(this).parent().find(".user").css("display","inline-block");
    $(".user").css("display","inline-block");
    // console.log(test);
    reSlick();
    $(this).parent().children(".cohort").toggle(150);
  });

});

function scrollToCohort(userID) {
  $.scrollTo(".cohort:has([data-id="+ userID +"])", {duration: 600, offset:-72, easing:'easeInOutExpo'});
  selectUser(userID);
}

function scrollToUser(userID) {
  scrollToCohort(userID);
  getCohort(userID).slickGoTo(getUserIndex(userID));
  selectUser(userID);
}

function showUserFamily(userID) {
  highlightUserFamily(userID);
  $(".cohort").hide();
  var lineageID = getLineage(userID);
  $(".user:not([data-lineage="+lineageID+"])").hide();
  $(".cohort:has([data-lineage="+lineageID+"])").unslick();
  $(".cohort:has([data-lineage="+lineageID+"])").show(400);
  setTimeout(function() {
    scrollToUser(userID);
  }, 300);
}

function showUserCohort(userID) {
  var cohort = getCohort(userID);
  cohort.unslick();
  $(".cohort").hide();
  cohort.children(".user").css("display","inline-block");
  cohort.show(400);

  setTimeout(function() {
    scrollToCohort(userID);
  }, 400);
}

//sets sidebar and highlights family
function selectUser(userID) {
  highlightUserFamily(userID);
  setSidebar(userID);
}

function setSidebar(userID) {
  var new_name = $("[data-id="+userID+"] .name")[0].innerHTML;
  var new_image = $("[data-id="+userID+"] img").attr("src");

  $(".sidebar:hidden").show(200);

  $("#highlight_image").fadeOut(100, function() {
    $(this).attr("src",new_image);
    $(this).fadeIn(100);
  });

  $("#highlight_name").hide(100, function() {
    $(this).html("<a id="+userID+">"+new_name+"</a>");
    $(this).show(300);
  });

  $("#highlight_mentor").hide(200);
  $("#highlight_cohort").hide(200);
  $("#highlight_headline").hide(200);
  $("#highlight_location").hide(200);
  $("#highlight_hometown").hide(200);

  $.ajax({
    type: 'get',
    url: "users/"+ userID,
    datatype: "json"
  }).success( function(user) {
    if (user !== null) {
      console.log(user);
      $("#highlight_cohort").html("<a id="+userID+">"+user.cohort+"</a>");
      $("#highlight_cohort").show(200);

      $("#highlight_hometown").html(user.hometown);
      $("#highlight_hometown").show(225);

      $("#highlight_mentor").html("Mentor: <a id="+user.mentor_id+">"+user.mentor_name+"</a>");
      $("#highlight_mentor").show(250);

      if (user.headline) {
        $("#highlight_headline").html(user.headline);
        $("#highlight_headline").show(300);

        $("#highlight_location").html(user.location);
        $("#highlight_location").show(350);
      }
    }
  });
}

function highlightUserFamily(userID) {
  $('.current_family_user').removeClass('current_family_user');
  $("[data-lineage="+getLineage(userID)+"]").addClass('current_family_user');
}

function getUserIndex(userID) {
  return $("[data-id="+userID+"].user:not(.slick-cloned)").attr("index");
}

function getLineage(userID) {
  return $("[data-id="+userID+"]").data("lineage");
}

function getCohort(userID) {
  return $(".cohort:has([data-id="+userID +"])");
}

//resets interface to zero and scrolls to current user
function resetInterface() {
  removeTempClasses();
  $(".user:hidden").css("display","inline-block");
  $(".cohort:hidden").show(400);
  reSlick();
  // scrollToUser(currentUser.id);
}

function removeTempClasses() {
  $(".filter-enabled").removeClass("filter-enabled");
}

function reSlick() {
  $(".cohort:not(.slick-initialized)").slick({
    arrows: false,
    dots: false,
    adaptiveHeight: true,
    draggable: false,
    speed: 400,
    infinite: true,
    centerMode: true,
    focusOnSelect: true,
    slidesToShow: 16,
    slidesToScroll: 5,
    autoplay: true,
    autoplaySpeed: 3000,
    easing: "easeOutElastic",
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
