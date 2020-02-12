const showMenuItem = function(icon) {
  icon.addClass("menu-icon-rotated");
  $(".menu-item").show();
};
const hideMenuItem = function(icon) {
  icon.removeClass("menu-icon-rotated");
  $(".menu-item").hide();
  $(".menu-item-current").css("display", "inline-block");
};

const toggleItemMenu = function(icon) {
  showMenuItem(icon);
  setTimeout(function() {
    hideMenuItem(icon);
  }, 4000);
};
$(".menu-icon,.menu-list").hover(function() {
  toggleItemMenu($(".menu-icon"));
});
$(".menu-icon").click(function() {
  toggleItemMenu($(".menu-icon"));
});
$(".input-container").click(function() {
  $(this)
    .children("input")
    .prop("checked", true)
    .change();
});

$(window).scroll(function() {
  if ($(window).scrollTop() === 0) {
    $(".header-top").animate(
      {
        opacity: 1
      },
      200
    );
    $("#logo-star").addClass("logo");
    $("#logo-star").removeClass("etere-top-left");
  } else {
    $(".header-top")
      .stop()
      .animate(
        {
          opacity: 0
        },
        200
      );
    $("#logo-star").removeClass("logo");
    $("#logo-star").addClass("etere-top-left");
  }
});

//for cart checkout

$('.checkout-step.-reachable.-complete > .content').hide();

$(".js-current-step> .content").show();

$(".cart-step-header").click(function() {
  $(this)
    .parent()
    .children(".content")
    .fadeIn("slow");
});


//for auth collapse

$(
  ".auth-pane.auth-signup-user > .auth-content,.auth-pane.auth-signup-dealer > .auth-content"
).hide();


$(
  ".auth-pane.auth-signup-user > .auth-title,.auth-pane.auth-signup-dealer > .auth-title"
).click(function () {
  $(this)
    .parent()
    .children(".auth-content")
    .fadeIn("slow");
});