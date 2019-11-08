$(document).on('turbolinks:load', function() { 
  function buildOptions(input){
    var options = (function() {
      if(input == "1") return `<option value="0">---</option>
                                      <option value="1">未定</option>
                                      <option value="2">らくらくメルカリ便</option>
                                      <option value="3">ゆうメール</option>
                                      <option value="4">レターパック</option>
                                      <option value="5">普通郵便（定形、定形外）</option>
                                      <option value="6">クロネコヤマト</option>
                                      <option value="7">ゆうパック</option>
                                      <option value="8">クリックポスト</option>
                                      <option value="9">ゆうパケット</option>`;
                                      
                              return `<option value="0">---</option>
                                      <option value="1">未定</option>
                                      <option value="6">クロネコヤマト</option>
                                      <option value="7">ゆうパック</option>
                                      <option value="3">ゆうメール</option>`;
    })();
    return options
  }


  function buildHTML(input) {
    var options = buildOptions(input)

    var html = `<div class="main-content__item__body__sell-content-float__form-box__form-group" id="postage-content">
    <label for="item_配送料の方法">配送料の方法</label>
    <span class="main-content__item__body__sell-content-float__form-box__form-group__require">
    必須
    </span>
    <div class="main-content__item__body__sell-content-float__form-box__form-group__select-wrap">
    <i class="fa fa-chevron-down arrow-down-icon"></i>
    <select class="main-content__item__body__sell-content-float__form-box__form-group__select-wrap__select-box" name="item[shipping_method_id]" id ="shipping_method_id">
    ${options}</select>
    </div>
    </div>`
    return html;
  }

  $(document).on("change", "#item_postage_id", function () {
    var input = $(this).val();
    console.log(input);
    if (input == "0") {
      $('#shipping_method-content').remove();
    }else
    {
     options =buildHTML(input) ;
      $('#shipping_method-content').empty();
      $('#shipping_method-content').append(options);
    }
  });


});
