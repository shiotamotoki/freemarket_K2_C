
window.addEventListener('DOMContentLoaded', function(){
  function buildChildren(child) {
    var html = `<option value="${child.id}">${child.name}</option>`
    return html
  }

  function buildHTML(count) {
    var html = `<div class="main-content__item__body__sell-content-float__form-box__form-group__select-wrap" id=item_contents_${count}_category_id>
    <i class="fa fa-chevron-down arrow-down-icon"></i>
    <select class="main-content__item__body__sell-content-float__form-box__form-group__select-wrap__select-box" name="item[${count}_category_id]" id="item_${count}_category_id"><option value="">---</option></select>
                </div>`
    return html
  }

 
  $(document).on("change", "#item_category_id", function () {
    var parentId = $(this).val();
    if (parentId != "0" && parentId != ""){
      $.ajax({
        url: '/items/child_category',
        type: "GET",
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children) {
        if ($('#item_second_category_id').length == 0) {
          var html = buildHTML('second');
          $('#category-contents').append(html);
        } else {
          $('#item_second_category_id').empty();
          $('#item_second_category_id').append(`<option value="">---</option>`);
        }
        children.forEach(function (child) {
          var html = buildChildren(child);
          $('#item_second_category_id').append(html);
        });
      })
      .fail(function() {
        
      });
    }else
    {
      $('#item_contents_second_category_id').remove();
      $('#item_contents_third_category_id').remove();
    }
  });

  $(document).on("change", "#item_second_category_id", function () {
    var parentId = $('#item_category_id').val();
    var childId = $(this).val();
    $.ajax({
      url: '/items/grandchild_category',
      type: "GET",
      data: { parent_id: parentId, child_id: childId },
      dataType: 'json'
    })
    .done(function(grandchildren) {
      if ($('#item_third_category_id').length == 0) {
        var html = buildHTML('third');
        $('#category-contents').append(html);
      } else {
        $('#item_third_category_id').empty();
        $('#item_third_category_id').append(`<option value="">---</option>`);
      }
      grandchildren.forEach(function (grandchild) {
        var html = buildChildren(grandchild);
        $('#item_third_category_id').append(html);
      });
    })
    .fail(function() {

    });
  });

  $('#price_calc').on('input', function(){
    var data = $('#price_calc').val();
    var profit = Math.round(data * 0.9)
    var fee = (data - profit) 
    $('#fee-area').html(fee)
    $('#fee-area').prepend('¥') 
    $('#profit-area').html(profit)
    $('#profit-area').prepend('¥')
    $('#price').val(profit)
    if(profit == '') {
    $('#profit-area').html('ー');
    $('#fee-area').html('ー');
    }
  })


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
    if ($('#item_category_id').val() == ""){
      $('#category-contents').append(buildErrMsg("入力してください","sell-content-float"));
      errFlg = false;
    }

    //商品の状態の確認
    if ($('#item_condition_id').val() == ""){
      console.log(1);
      $('#item-condition').append(buildErrMsg("入力してください","sell-content-float"));
      errFlg = false;
    }
    
    return errFlg;
      
    }
  );

});