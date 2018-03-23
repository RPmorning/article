$(function(){

   var  moduleListTemplate= Handlebars.compile($("#moduleList-template").html());
   var  friendLinkTemplate= Handlebars.compile($("#friendLink-template").html());
   var  switchTabTemplate= Handlebars.compile($("#switchTab-template").html());
   var  policeNewsTemplate= Handlebars.compile($("#policeNews-template").html());   
   var  wallTemplate = Handlebars.compile($("#wall-template").html());   
   var  rankTemplate = Handlebars.compile($("#rank-template").html());
   //保存栏目id
   var channel = {}
   //ie8手动打开cors请求
   jQuery.support.cors = true;

//    jQuery(".news").slide({mainCell:".bd ul",autoPlay:true});
    //   jQuery(".switchTab").slide();
//    jQuery(".picScroll").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"left",autoPlay:true,vis:5,trigger:"click"});
   $('.wall_content_item').hover(
       function(){
            $(this).find('.shadow').css('display','block')
       },
       function(){
            $(this).find('.shadow').css('display','none')
       }
   );

   $('.nav_top_li').hover(
        function(){
            $(this).find('.nav_top_item_sub').css('display','block')
        },
        function(){
            $(this).find('.nav_top_item_sub').css('display','none')
        }
    );

    //注册helper只遍历三次
    Handlebars.registerHelper('three', function(context, options){
        var ret = "";
        for(var i=0; i < 3; i++) {
            ret = ret + options.fn(context[i]);
        }
        return ret;
    })

    //搜素
    $('#search').click(function(e){
        e.stopPropagation();
        var value = $('#search_input').val().replace(/^[\s]*/gi,"").replace(/[\s]*$/gi,"");
        if(value){
            document.location.href = '/front/search.html?keyword='+ value + '&page=1';
        }else {
          alert('输入内容不能为空！');
        }
    })

    //获取部门评分
    $.ajax({
        type : 'GET',
        url : '/api/article/countScore',
        cache:false,
        success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#rank').html(rankTemplate(tplData));
            }
        }
    })

    //会议通知
    var meeting = function(){
      var category_id = channel['会议通知'];
      $.ajax({
          type : 'GET',
          url : '/api/article/getArticleByTypeList',
          data : { category_id  : category_id},
          cache:false,
          success : function(message){
             if(message.status == 200){
               var tplData = message.data;
               $('#meeting').html(moduleListTemplate(tplData));
               
             }else {
               console.log('会议通知获取数据失败')
             }

          }
      })
    }

    //网络公安形象墙
    var wall = function(){
        var category_id = channel['网络公安形象墙'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticleByTypeList',
            data : { category_id  : category_id},
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#wall').html(wallTemplate(tplData));
                jQuery(".picScroll").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"left",autoPlay:true,vis:5,trigger:"click"});
            }else {
                console.log('网络公安形象墙获取数据失败')
            }

            }
        })
    }

    //机关动态
    var office = function(){
      var category_id = channel['机关动态'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticleByTypeList',
            data : { category_id  : category_id},
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#office').html(moduleListTemplate(tplData));
            }else {
                console.log('机关动态获取数据失败')
            }

            }
        })
    }

    //队伍建设
    var build = function(){
        var category_id = channel['队伍建设'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticleByTypeList',
            data : { category_id  : category_id},
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#build').html(moduleListTemplate(tplData));
            }else {
                console.log('队伍建设获取数据失败')
            }

            }
        })
    }

    //公安研究
    var study = function(){
        var category_id = channel['公安研究'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticleByTypeList',
            data : { category_id  : category_id},
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#study').html(moduleListTemplate(tplData));
            }else {
                console.log('公安研究获取数据失败')
            }

            }
        })
    }


    //友情链接
    var friendLink = function(){
      var linkId = channel['友情链接'];
      $.ajax({
          type : 'GET',
          url : '/api/link/getLinks',
          data : { linkId  : linkId},
          cache:false,
          success : function(message){
             if(message.status == 200){
               var tplData = message.data;
               $('#friendLink').html(friendLinkTemplate(tplData));
             }else {
               console.log('友情链接获取数据失败');
             }

          }
      })
    }


    //警营文化
    var culture = function(){
        var category_id = channel['警营文化'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticleByTypeList',
            data : { category_id  : category_id},
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#culture').html(moduleListTemplate(tplData));
            }else {
                console.log('警营文化获取数据失败')
            }

            }
        })
    }

    //市局重要信息&领导讲话
    var important = function(){
        var category_id_1 = channel['市局重要信息'];
        var category_id_2 = channel['领导讲话'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticlesTwo',
            data :  { 
                        category_id_1 : category_id_1,
                        category_id_2 : category_id_2
                    },
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#important').html(switchTabTemplate(tplData));
                jQuery(".switchTab").slide();
            }else {
                console.log('市局重要信息获取数据失败')
            }

            }
        })
    }

    //民警风采
    var mien = function(){
        var category_id = channel['民警风采'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticleByTypeList',
            data : { category_id  : category_id},
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#mien').html(moduleListTemplate(tplData));
            }else {
                console.log('民警风采获取数据失败')
            }

            }
        })
    }

    //各地动态和打击破案
    var state = function(){
        var category_id_1 = channel['各地动态'];
        var category_id_2 = channel['打击破案'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticlesTwo',
            data :  { 
                        category_id_1 : category_id_1,
                        category_id_2 : category_id_2
                    },
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#state').html(switchTabTemplate(tplData));
                jQuery(".switchTab").slide();
            }else {
                console.log('打击破案获取数据失败')
            }

            }
        })
    }

    //重点工作推进和改革创新
    var reform = function(){
        var category_id_1 = channel['重点工作推进'];
        var category_id_2 = channel['改革创新'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticlesTwo',
            data :  { 
                        category_id_1 : category_id_1,
                        category_id_2 : category_id_2
                    },
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#reform').html(switchTabTemplate(tplData));
                jQuery(".switchTab").slide();
            }else {
                console.log('改革创新获取数据失败')
            }

            }
        })
    }

    //情报研判&每日治安动态
    var order = function(){
        var category_id_1 = channel['情报研判'];
        var category_id_2 = channel['每日治安动态'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticlesTwo',
            data :  { 
                        category_id_1 : category_id_1,
                        category_id_2 : category_id_2
                    },
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#order').html(switchTabTemplate(tplData));
                jQuery(".switchTab").slide();
            }else {
                console.log('每日治安动态获取数据失败')
            }

            }
        })
    }

    //光荣榜&曝光台
    var honor = function(){
        var category_id_1 = channel['光荣榜'];
        var category_id_2 = channel['曝光台'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticlesTwo',
            data :  { 
                        category_id_1 : category_id_1,
                        category_id_2 : category_id_2
                    },
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#honor').html(switchTabTemplate(tplData));
                jQuery(".switchTab").slide();
            }else {
                console.log('光荣榜获取数据失败')
            }

            }
        })
    }

    //舆情通报&媒体聚焦
    var media = function(){
        var category_id_1 = channel['舆情通报'];
        var category_id_2 = channel['媒体聚焦'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticlesTwo',
            data :  { 
                        category_id_1 : category_id_1,
                        category_id_2 : category_id_2
                    },
            cache:false,
            success : function(message){
                if(message.status == 200){
                    var tplData = message.data;
                    $('#media').html(switchTabTemplate(tplData));
                    jQuery(".switchTab").slide();
                }else {
                    console.log('媒体聚焦获取数据失败')
                }
            }
        })
    }

    //公安要闻
    var policeNews = function(){
        var category_id = channel['公安要闻'];
        $.ajax({
            type : 'GET',
            url : '/api/article/getArticleByTypeList',
            data : { category_id  : category_id},
            cache:false,
            success : function(message){
            if(message.status == 200){
                var tplData = message.data;
                $('#policeNews').html(policeNewsTemplate(tplData));
                jQuery(".news").slide({mainCell:".bd ul",autoPlay:true});
            }else {
                console.log('公安要闻获取数据失败')
            }

            }
        })
    }


    // $.when(
    //     // 获取栏目对应id
    //     $.ajax({
    //         type : 'GET',
    //         url : '/api/category/getCategorys',
    //         cache:false,
    //         success : function(message){
    //           if(message.status == 200){
    //             for(var i = 0; i < message.data.length; i++){
    //                 channel[message.data[i].name] = message.data[i].id;
    //             }
    //           }
    //         }
    //     })
    // ).done(function(){

    //     meeting();
    //     friendLink();
    //     office();
    //     build();
    //     study();
    //     culture();
    //     mien();
    //     policeNews();
    //     important();
    //     state();
    //     reform();
    //     order();
    //     honor();
    //     media();
    //     wall();
    // }).done(function(){
    //     jQuery(".switchTab").slide();
    // })

    var getDataWithCookie = function(){
        policeNews();
        meeting();
        friendLink();
        office();
        build();
        study();
        culture();
        mien();
        important();
        state();
        reform();
        order();
        honor();
        media();
        wall();
    }

    var getDataWithoutCookie = function(){
        $.ajax({
            type : 'GET',
            url : '/api/category/getCategorys',
            cache:false,
            success : function(message){
              if(message.status == 200){
                for(var i = 0; i < message.data.length; i++){
                    channel[message.data[i].name] = message.data[i].id;
                }
                $.cookie('channelObj',JSON.stringify(channel));
                channel = JSON.parse($.cookie('channelObj'));
              }
            }
        }).done(function(){
            getDataWithCookie();
        }).done(function(){
            jQuery(".switchTab").slide();
        })
    }

	$('.banner').click(function(){
		document.location.href = '/index.html';
    })
    
    if($.cookie('channelObj')){
        var channel = JSON.parse($.cookie('channelObj'));
        getDataWithCookie();
        jQuery(".switchTab").slide();
    }else{
        getDataWithoutCookie()
    }


})
