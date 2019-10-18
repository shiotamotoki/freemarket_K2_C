$(function(){
  $('#file-upload').change(function(){
    var file = $(this).prop('files')[0];
    if(!file.type.match('image.jpeg|image.png')){
      return;
    }

    console.log(file);
  });
});