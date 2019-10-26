window.addEventListener('DOMContentLoaded', function(){

  function buildSize(s) {
    var html = `<option value="${s.id}">${s.name}</option>`
    return html
  }

  function sizeHTML() {
    var html = `<label for="item_item_size">サイズ</label>
    <span class="main-content__item__body__sell-content-float__form-box__form-group__require">必須</span><div class="main-content__item__body__sell-content-float__form-box__form-group__select-wrap" id = size-contents>
    <i class="fa fa-chevron-down arrow-down-icon"></i>
    <select class="main-content__item__body__sell-content-float__form-box__form-group__select-wrap__select-box" name="item[size_id]" id="item_size_id"></select></div>`
    return html
  }

  function brandHTML() {
    var html = `<div class="main-content__item__body__sell-content__form-group" id="brand-content">
    <label for="item_ブランド">ブランド</label>
    <span class="main-content__item__body__sell-content__form-group__any">
    任意
    </span>
    <input placeholder="例）シャネル" value="" class="main-content__item__body__sell-content__form-group__input" type="text" name="item[brand_id]" id="item_brand_id">
    </div>`
    return html
  }

  $(document).on("change", "#item_third_category_id", function () {

    if ($('#item_size_id').length == 0) {
      $('#size-content').append(sizeHTML() );
      $('#brand-content').append(brandHTML());
    }

    $.ajax({
      url: '/items/size',
      type: "GET",
      data: { parent_id: 1 },
      dataType: 'json'
    })
    .done(function(size) { 
      size.forEach(function (size) {
        var html = buildSize(size);
        $('#item_size_id').append(html);
      });
    })
    .fail(function() {
      
    });

  });

});
