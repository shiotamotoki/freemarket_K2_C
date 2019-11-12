$(function() {
    $(".category-js a").on("mouseenter", function() {
      console.log(1)
      $(".category_list").css("visibility", "visible");
      $(".parents_list").css("visibility", "visible");
      $(".category_list").css("z-index", "5000");
      $(".parents_list").css("z-index", "5000");
      $(".children_list").css("z-index", "5000");
      $(".grand_children_list").css("z-index", "5000");
    })

  // 子カテゴリーを追加するための処理です。
    function buildChildHTML(child){
      var html =`<a class="child_category" id="${child.id}" 
                  href="/category/${child.id}">${child.name}</a>`;
      return html;
    }
  
    $(".parent_category").on("mouseenter", function() {
      var parentId = this.id//どのリンクにマウスが乗ってるのか取得します

      $(".now-selected-red").removeClass("now-selected-red")//赤色のcssのためです
      $('#' + parentId).addClass("now-selected-red");//赤色のcssのためです
      $(".child_category").remove();//一旦出ている子カテゴリ消します！
      $(".grand_child_category").remove();//一旦出ている孫カテゴリ消します！
      $(".children_list").css("visibility", "visible");

      $.ajax({
        type: 'GET',
        url: '/items/child_category',//とりあえずここでは、newアクションに飛ばしてます
        data: {parent_id: parentId },//どの親の要素かを送ります　params[:parent_id]で送られる
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {//帰ってきた子カテゴリー（配列）
          var html = buildChildHTML(child);//HTMLにして
          $(".children_list").append(html);//リストに追加します
        })
      });
    });
  
    // 孫カテゴリを追加する処理です　基本的に子要素と同じです！
    function buildGrandChildHTML(child){
      var html =`<a class="grand_child_category" id="${child.id}"
                 href="/category/${child.id}">${child.name}</a>`;
      return html;
    }
  
    $(document).on("mouseenter", ".child_category", function () {//子カテゴリーのリストは動的に追加されたHTMLのため
      var parentId = $(".now-selected-red").attr('id');   
      var childId = this.id
      $(".now-selected-gray").removeClass("now-selected-gray");//灰色のcssのため
      $('#' + childId).addClass("now-selected-gray");//灰色のcssのため
      $(".grand_children_list").css("visibility", "visible");
      $.ajax({
        type: 'GET',
        url: '/items/grandchild_category',
        data: {parent_id: parentId , child_id: childId},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildGrandChildHTML(child);
          $(".grand_children_list").append(html);
        })
        $(document).on("mouseenter", ".child_category", function () {
          $(".grand_child_category").remove();
        });
      });
    });  

    $(document).on("mouseenter", ".grand_child_category", function () {//子カテゴリーのリストは動的に追加されたHTMLのため
      var grand_child= this.id
      $(".now-selected-gray2").removeClass("now-selected-gray2");//灰色のcssのため
      $('#' + grand_child).addClass("now-selected-gray2");//灰色のcssのため
      
        }); 
    $(document).on("mouseleave", ".category-js", function () {
      $(".parents_list").css("visibility", "hidden");
      $(".children_list").css("visibility", "hidden");
      $(".grand_children_list").css("visibility", "hidden");
      $(".category_list").css("z-index", "0");
      $(".parents_list").css("z-index", "0");
      $(".children_list").css("z-index", "0");
      $(".grand_children_list").css("z-index", "0");
        });  
      });
      