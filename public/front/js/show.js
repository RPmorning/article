$(function(){
    var $el = $('.dialog');
    $el.hDialog();
    var checkTableTemplate= Handlebars.compile($("#checkTable-template").html());
    var articleTemplate= Handlebars.compile($("#article-template").html());

      $('.check_link').hDialog({
        box : '#model',
        title: '签收',
        width: 330,
        height:240,
        positions : 'center'
    });

    //ie8手动打开cors请求
    jQuery.support.cors = true;

    var url = document.location.search;
    var request = {};
    if (url.indexOf("?") != -1){
        var str = url.substr(1);
        strs = str.split("&");
        for(var i = 0; i < strs.length; i++){
          request[strs[i].split("=")[0]] = strs[i].split("=")[1];
        }
    }
  
    $('.nav_top_li').hover(
         function(){
             $(this).find('.nav_top_item_sub').css('display','block')
         },
         function(){
             $(this).find('.nav_top_item_sub').css('display','none')
         }
    );

    var article_sign = function () {
      //获取签收列表
      $.ajax({
        type: 'GET',
        url: 　'/api/article_sign/index',
        data: {
          articleId: request.articleId
        },
        dataType: 'json',
        async: false,
        cache: false,
        success: function (message) {
          if (message.status == 200) {
            var tplData = message.data;
            $('#checkTable').html(checkTableTemplate(tplData));
            $('#check_title').click(
              function () {
                $('.check_data').toggle();
                $('.check_table_data .arrowIcon').toggleClass('toBottom')
              }
            );
  
          } else {
            console.log('获取签收列表数据失败！');
          }
        }
      })
    }

    $('.banner').click(function(){
      document.location.href = '/front/index.html';
    })

    $('.submitBtn').click(function(e) {
        e.stopPropagation();
      var $name = $('.name');
      var $password = $('.password');
      var name = $name.val();
      var password = $password.val();

      if($name.val() == ''){
              $.tooltip('用户名不能为空！');
              $name.focus();
              return;
      }else if($password.val() == ''){
              $.tooltip('密码不能为空');
              $password.focus();
              return;
      }

      //签收功能
      $.ajax({
        type : 'POST',
        url : '/api/article_sign/save',
        data : {
          articleId : request.articleId,
          username : name,
          password : password
        },
        success : function(message){
          if(message.status == 200){
            $.tooltip('签收成功，2秒后将关闭窗口',2000,true);
            article_sign();
            setTimeout(function(){
              $el.hDialog('close',{box:'#model'});
            },2000);
          }else if(message.status == 500){
            $.tooltip('用户名或密码错误！');
          }else {
            $.tooltip('签收失败！');
          }
        }
      })

    });

    //获取文章数据
    $.ajax({
      type : 'GET',
      url :　'/api/article/getArticleById',
      data : {
        id : request.articleId
      },
      dataType : 'json',
      async : false,
      cache:false,
      success : function(message){
         if(message.status == 200){
           var tplData = message.data;
           $('#article').html(articleTemplate(tplData));
           if(tplData.departments){
              article_sign();
              $('.checkBtn').show();
           }else{
           	 $('.article').css('border','none');
           }

         }else {
           console.log('获取签收列表数据失败！');
         }
      }
    })
   
    //增加浏览次数
    $.ajax({
      type : 'GET',
      url :　'/api/article/saveView',
      data : {
        articleId : request.articleId
      },
      dataType : 'json',
      async : false,
      cache:false,
      success : function(message){
         if(message.status == 200){
           console.log('增加浏览次数成功！')
         }else {
           console.log('增加浏览次数失败！');
         }
      }
    })

	


 })
