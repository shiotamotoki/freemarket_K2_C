$(document).on('turbolinks:load', function() { 

  function buildErrMsg(msg,contents) {
    var html = `<ul class="main-content__item__body__${contents}__error-text">
                        <li>${msg}</li>
                      </ul>`;
    return html
  }

  $(".main-content__item__body").submit(function(){
    errFlg = true;
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
    if ($('#price_calc').val() == "" ||($('#price_calc').val() < 300 && $('#price_calc').val() < 10000000)){
      $('#item-price').append(buildErrMsg("300以上9999999以下で入力してください","sell-content-float"));
      errFlg = false;
    }

    if ($(".main-content__item__body__image-upload__clearfix__container__images").hasClass("have-item-0")) {
      $('.main-content__item__body__image-upload__error-text').remove();
      var errorText = `<ul class="main-content__item__body__image-upload__error-text">
                        <li>画像がありません</li>
                      </ul>`;
      $('.main-content__item__body__image-upload').append(errorText);
       errFlg = false;
    }

    return errFlg;
      
    }
  );
});