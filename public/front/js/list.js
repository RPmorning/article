$(function(){

    var listDataTemplate = Handlebars.compile($("#listData-template").html());

    var url = document.location.search;
    var request = {};
    if (url.indexOf("?") != -1){
        var str = url.substr(1);
        strs = str.split("&");
        for(var i = 0; i < strs.length; i++){
          request[strs[i].split("=")[0]] = strs[i].split("=")[1];
        }
    }

    //ie8手动打开cors请求
    jQuery.support.cors = true;

    $('.nav_top_li').hover(
         function(){
             $(this).find('.nav_top_item_sub').css('display','block')
         },
         function(){
             $(this).find('.nav_top_item_sub').css('display','none')
         }
    );

    //获取列表页
    $.ajax({
        type : 'GET',
        url : '/api/article/getArticleByTypeList',
        data : { 
            category_id  : request.category_id,
            page : request.page || 1
        },
        async : false,
        success : function(message){
        if(message.status == 200){
            var tplData = message.data;
            request.pageCount = Math.ceil(tplData.items.total/8);
            request.current = tplData.items.current_page;
            $('#listData').html(listDataTemplate(tplData));
        }else {
            console.log('列表数据获取数据失败')
        }

        }
    })

    $('.article').dotdotdot();
    $(".devidePage").createPage({
        pageCount:request.pageCount,
        current:request.current,
        backFn:function(i){
            document.location.href = '/front/list.html?category_id='+ request.category_id + '&page=' + i;
        }
    });

	$('.banner').click(function(){
		document.location.href = '/index.html';
	})

    

 })
