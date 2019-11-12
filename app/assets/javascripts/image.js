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
      </li>`;
    return html;
  }
  function buildUL(){
    var html =
      `<div class="main-content__item__body__image-upload__clearfix__container__images have-item-0" data-preview="2">
        <ul class="main-content__item__body__image-upload__clearfix__container__images__ul"></ul>
      </div>`;
    return html;
  }
  var preview = 1;
  var images = [];
  var loadData = 0;
  var loadPreview = 1;
  $('#item_file-upload').change(function(){
    // console.log($(this).prop('name'));
    // console.log($(this).prop('files'));
    $('.main-content__item__body__image-upload__error-text').children().remove();
    var file = $(this).prop('files');
    var have = $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"]`).prop('class').replace(/[^0-9]/g, '');
    have = Number(have);
    //アップロードされる画像に異常があるか(枚数や拡張子)
    var errorFlg = false;
    if ((preview == 2 && (have+file.length) > 5) || (preview == 1 && (have+file.length) > 10)) {
      var errorText = `<li>アップロードできる画像は10枚までです</li>`;
      $('.main-content__item__body__image-upload__error-text').append(errorText);
      errorFlg = true;
    }
    for (var i = 0; i < file.length; i++){
      if(!file[i].type.match('image.jpg|image.jpeg|image.png')){
        var errorText = `<li>ファイル形式はjpeg、またはpngが使用できます</li>`;
        $('.main-content__item__body__image-upload__error-text').append(errorText);
        errorFlg = true;
        break;
      }
    }
    if (errorFlg) {
      return;
    }
    for (var i = 0; i < file.length; i++){
      console.log("0");
      if (have == 5) {//ここの判定はpreview=2の時には上のバリデーションで弾かれるため通ることはない
        preview = 2;//haveが5になったらプレビューを2段目に
        have = 0;
        $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="1"]`).removeClass(function(index, className){
          var matchClass = className.match(/\bhave-item-\d/g);
          if(matchClass == null){
            return "";
          } else {
            return matchClass.join(' ');
          }
        });
        $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="1"]`).addClass("have-item-5");
        var viewUl = buildUL;
        $('.main-content__item__body__image-upload__clearfix__container').append(viewUl);
      }
      console.log("0.1");
      var reader = new FileReader()
      console.log("1");
      reader.onload = function(e){
        var imageView = buildHTML(e.target.result);
        if (loadData < 5) {
          loadPreview = 1;
        } else {
          loadPreview = 2;
        }
        $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${loadPreview}"] .main-content__item__body__image-upload__clearfix__container__images__ul`).append(imageView);
        loadData++;
      }
      console.log("2");
      reader.readAsDataURL(file[i]);
      console.log("4");
      images.push(file[i]); //images配列にfileを追加
      have++;
      console.log("5");
      // console.log(file[i]);
      // console.log(preview);
      // console.log(have);
    }
    console.log("6");
    $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"], .main-content__item__body__image-upload__clearfix__dropbox`).removeClass(function(index, className){
      var matchClass = className.match(/\bhave-item-\d/g);
      if(matchClass == null){
        return "";
      } else {
        return matchClass.join(' ');
      }
    });
    //haveが5の場合はinput:fileのhave-itemを0に戻す
    if (have == 5) {
      if (preview == 2) {
        $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"]`).addClass("have-item-"+have);
        $(".main-content__item__body__image-upload__clearfix__dropbox").addClass("have-item-"+have);
        $(".main-content__item__body__image-upload__clearfix__dropbox").addClass("none");
      } else {
        $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"]`).addClass("have-item-"+have);
        $(".main-content__item__body__image-upload__clearfix__dropbox").addClass("have-item-0");
      }
    } else {
      $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"], .main-content__item__body__image-upload__clearfix__dropbox`).addClass("have-item-"+have);
    }
    var count = $(".main-content__item__body__image-upload__clearfix__dropbox").prop('class').match(/5/g);
    //console.log(count.length);
    console.log("7");
  });

  $(document).on("click", ".main-content__item__body__image-upload__clearfix__container__images__ul__image__btn__delete", function(){
    console.log($(".main-content__item__body__image-upload__clearfix__container__images__ul__image__btn__delete").index(this));
    $('.main-content__item__body__image-upload__error-text').children().remove();
    $(this).parent().parent().remove();
    var have = $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"]`).prop('class').replace(/[^0-9]/g, '');
    have--;
    loadData--;
    if (preview == 2 && have == 0) {
      $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"]`).remove();
      preview = 1;
      have = 5;
      $(`.main-content__item__body__image-upload__clearfix__dropbox`).removeClass(function(index, className){
        var matchClass = className.match(/\bhave-item-\d/g);
        if(matchClass == null){
          return "";
        } else {
          return matchClass.join(' ');
        }
      });
      $(".main-content__item__body__image-upload__clearfix__dropbox").addClass("have-item-0");
    } else {
      if (preview == 2 && have ==4) {
        $(`.main-content__item__body__image-upload__clearfix__dropbox`).removeClass(function(index, className){
          return "none";
        });
      }
      $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"], .main-content__item__body__image-upload__clearfix__dropbox`).removeClass(function(index, className){
        var matchClass = className.match(/\bhave-item-\d/g);
        if(matchClass == null){
          return "";
        } else {
          return matchClass.join(' ');
        }
      });
      $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${preview}"], .main-content__item__body__image-upload__clearfix__dropbox`).addClass("have-item-"+have);
    }
  });
});