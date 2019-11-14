$(function() {
  $(".brand_js a").on("mouseenter", function() {
    $(".brands_list").css("visibility", "visible");
    $(".brands_list").css("z-index", "5000");
    $(".brand_list").css("z-index", "5000");
    
  })
  

  $(".brand_category").on("mouseenter", function() {
    var brandId = this.id//どのリンクにマウスが乗ってるのか取得します
    $(".now-selected-red1").removeClass("now-selected-red1")//赤色のcssのためです
    $('#' + brandId).addClass("now-selected-red1");//赤色のcssのためです

    });
  
  
  
  
  $(document).on("mouseleave", ".brand_js", function () {
    $(".brands_list").css("visibility", "hidden");
    $(".brands_list").css("z-index", "0");
    $(".brand_list").css("z-index", "0");

      });  
    });
    