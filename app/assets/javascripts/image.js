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
  function buildErrMsg(msg,contents) {
    var html = `<ul class="main-content__item__body__${contents}__error-text">
                        <li>${msg}</li>
                      </ul>`;
    return html
  }
  var preview = 1;
  var images = [];
  var imageResult = [];
  var loadData = 0;
  var loadPreview = 1;
  $('#item_file-upload').change(function(){
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
      var reader = new FileReader()
      reader.onload = function(e){
        var imageView = buildHTML(e.target.result);
        if (loadData < 5) {
          loadPreview = 1;
        } else {
          loadPreview = 2;
        }
        $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${loadPreview}"] .main-content__item__body__image-upload__clearfix__container__images__ul`).append(imageView);
        loadData++;
        imageResult.push(e.target.result);
      }
      reader.readAsDataURL(file[i]);
      images.push(file[i]); //images配列にfileを追加
      have++;
    }
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
  });

  $(document).on("click", ".main-content__item__body__image-upload__clearfix__container__images__ul__image__btn__delete", function(){
    $('.main-content__item__body__image-upload__error-text').children().remove();
    var imageNumber = $(".main-content__item__body__image-upload__clearfix__container__images__ul__image__btn__delete").index(this);
    images.splice(imageNumber, 1);
    imageResult.splice(imageNumber, 1);
    $(this).parent().parent().remove();//プレビュー削除
    if (preview == 2 && imageNumber < 5) {
      var pre = 2;
      $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${pre}"] ul li:first`).remove();
      var imageView = buildHTML(imageResult[4]);
      pre = 1;
      $(`.main-content__item__body__image-upload__clearfix__container__images[data-preview="${pre}"] ul`).append(imageView);
    }
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

  $(".main-content__item__body").submit(function(){
    var errFlg = true;
    $('.main-content__item__body__sell-content__error-text').remove();
    // 商品名の確認
    if ($('#item_name').val() == ""){
      $('#item-name').append(buildErrMsg("入力してください","sell-content"));
      errFlg = false;
    }
    if ($('#item_name').val().length > 40){
      $('#item-name').append(buildErrMsg("40 文字以下で入力してください","sell-content"));
      errFlg = false;
    }

    // 商品詳細の確認
    if ($('#item_description').val() == ""){
      $('#item-description').append(buildErrMsg("入力してください","sell-content"));
      errFlg = false;
    }
    if ($('#item_description').val().length > 1000){
      $('#item-description').append(buildErrMsg("1000 文字以下で入力してください","sell-content"));
      errFlg = false;
    }

    // カテゴリー/サイズの確認
    $('.main-content__item__body__sell-content-float__error-text').remove();
    if ($('#item_category_id').val() == "" ){
      $('#category-contents').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }

    if ($('#item_second_category_id').val() == "" ){
      $('#category-contents').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }

    if ($('#item_third_category_id').val() == "" ){
      $('#category-contents').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }
    
    if ($('#item_size_id').val() == "0" && $('#item_third_category_id').val() != ""){
      $('#size-content').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }

    //商品の状態の確認
    if ($('#item_condition_id').val() == "0"){
      $('#item-condition').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }
    
    // 配送の負担
    $('.main-content__item__body__sell-content-float__error-text')
    if ($('#item_postage_id').val() == "0"){
      $('#postage-content').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }

    // 配送の地域
    if ($('#item_prefecture_id').val() == "0"){
      $('#area-content').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }

    // 配送の日数
    if ($('#item_shipping_date_id').val() == "0"){
      $('#shipping_date-content').append(buildErrMsg("選択してください","sell-content-float"));
      errFlg = false;
    }

    // 価格
    if (isNaN($('#price_calc').val())||$('#price_calc').val() == "" ||($('#price_calc').val() < 300 && $('#price_calc').val() < 10000000)){
      $('#item-price').append(buildErrMsg("300以上9999999以下で入力してください","sell-content-float"));
      errFlg = false;
    }
    // 画像
    if ($(".main-content__item__body__image-upload__clearfix__container__images").hasClass("have-item-0")) {
      $('.main-content__item__body__image-upload__error-text').remove();
      var errorText = `<ul class="main-content__item__body__image-upload__error-text">
                        <li>画像がありません</li>
                      </ul>`;
      $('.main-content__item__body__image-upload').append(errorText);
      errFlg = false;
    }
    if (errFlg) {
      $.ajax({
        url: '/items/create',
        type: "POST",
        data: { images: images },
        dataType: 'html'
      })
    } else {
      return false;
    }
  });
});