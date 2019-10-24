
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
    console.log($('#third_category_id').val());
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
  // $(function(){

  // })

});