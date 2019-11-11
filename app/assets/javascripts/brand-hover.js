$(function() {
  $(".brand_js").on("mouseenter", function() {
    $(".brands_list").css("visibility", "visible");
  })
  

  $(".brand_category").on("mouseenter", function() {
    var brandId = this.id//どのリンクにマウスが乗ってるのか取得します
    $(".now-selected-red1").removeClass("now-selected-red1")//赤色のcssのためです
    $('#' + brandId).addClass("now-selected-red1");//赤色のcssのためです

    });
  
  
  
  
  $(document).on("mouseleave", ".brand_list", function () {
    $(".brands_list").css("visibility", "hidden");

      });  
    });
    