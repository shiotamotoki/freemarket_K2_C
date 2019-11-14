$(document).on('turbolinks:load', function() {
  $('.item-photos__sub-img__sub').hover(function(){
    var subSrc = $(this).prop('src');
    $('.item-photos__main-img img').prop('src', subSrc);
  })
});