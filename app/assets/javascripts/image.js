$(document).on('turbolinks:load', function() { 
  function buildHTML(result){
    var html = 
      `<li class="main-content__item__body__image-upload__clearfix__container__images__ul__image">
        <figure class="main-content__item__body__image-upload__clearfix__container__images__ul__image__figure">
          <img src="${result}" alt>
        </figure>
        <div class="main-content__item__body__image-upload__clearfix__container__images__ul__image__btn">
          <a class="main-content__item__body__image-upload__clearfix__container__images__ul__image__btn__edit">編集</a>
          <a class="main-content__item__body__image-upload__clearfix__container__images__ul__image__btn__delete">削除</a>
        </div>
      </li>`
    return html;
  }

  $('#item_file-upload').change(function(){
    console.log($(this).prop('name'));
    console.log($(".main-content__item__body__image-upload__clearfix__container__images").prop('class').replace(/[^0-9]/g, ''));
    $(this).prop('files')[0] = $(this).prop('files')[1];
    console.log($(this).prop('files')[0]);
    $('.main-content__item__body__image-upload__error-text').remove();
    var file = $(this).prop('files')[0];
    if(!file.type.match('image.jpg|image.jpeg|image.png')){
      var errorText = `<ul class="main-content__item__body__image-upload__error-text">
                        <li>ファイル形式はjpeg、またはpngが使用できます</li>
                      </ul>`;
      $('.main-content__item__body__image-upload').append(errorText);
      return;
    }
    $('.main-content__item__body__image-upload__clearfix__container__images__ul').empty();
    var reader = new FileReader()
    reader.onload = function(){
      var imageView = buildHTML(reader.result);
      $('.main-content__item__body__image-upload__clearfix__container__images__ul').append(imageView);
    }
    reader.readAsDataURL(file);
    $(".main-content__item__body__image-upload__clearfix__container__images, .main-content__item__body__image-upload__clearfix__dropbox").removeClass(function(index, className){
      var matchClass = className.match(/\bhave-item-\d/g);
      console.log(className);
      if(matchClass == null){
        return "";
      } else {
        return matchClass.join(' ');
      }
    });
    $(".main-content__item__body__image-upload__clearfix__container__images, .main-content__item__body__image-upload__clearfix__dropbox").addClass("have-item-1");
  });

  $(document).on("click", ".main-content__item__body__image-upload__clearfix__container__images__ul__image__btn__delete", function(){
    $('.main-content__item__body__image-upload__error-text').remove();
    $(this).parent().parent().remove();
    $(".main-content__item__body__image-upload__clearfix__container__images, .main-content__item__body__image-upload__clearfix__dropbox").removeClass(function(index, className){
      var matchClass = className.match(/\bhave-item-\d/g);
      if(matchClass == null){
        return "";
      } else {
        return matchClass.join(' ');
      }
    });
    $(".main-content__item__body__image-upload__clearfix__container__images, .main-content__item__body__image-upload__clearfix__dropbox").addClass("have-item-0");
  });
});