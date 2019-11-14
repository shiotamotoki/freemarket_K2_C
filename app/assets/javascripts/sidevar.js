$(document).on('turbolinks:load', function() { 
  var controller = $('body').data('controller');
  var action = $('body').data('action');
  console.log(controller);
  console.log(action);
  if (controller == "mypages") {
    switch (action) {
      case "index":
        $('.my-col__list__item[data-mypage="index"]').addClass('active');
        break;
      case "myitem":
        $('.my-col__list__item[data-mypage="myitem"]').addClass('active');
        break;
      case "profile":
        $('.my-col__list__item[data-mypage="profile"]').addClass('active');
        break;
      case "credit":
        $('.my-col__list__item[data-mypage="credit"]').addClass('active');
        break;
      case "identification":
        $('.my-col__list__item[data-mypage="identification"]').addClass('active');
        break;
      case "logout":
        $('.my-col__list__item[data-mypage="logout"]').addClass('active');
        break;
      default:
        break;
    }
  }
});