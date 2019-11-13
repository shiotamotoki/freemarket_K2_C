$(document).on('turbolinks:load', function() { 
  // 利益・手数料の計算
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
});