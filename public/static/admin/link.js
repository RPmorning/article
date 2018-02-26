var linkUrl = "/admin/link/",
    link = {},
    loadLinkIndex,
    editIndex,
    layerDom,cover = null,
    uploadLinkSrc = $("#cover-src");
layui.use(['form','layedit','upload'], function() {
    var form = layui.form(),
        layedit = layui.layedit;

    // 创建一个上传实例
    uploadLinkCover();

    // 验证规则
    form.verify({
        letter:function(value){
            if(!/^[A-Za-z]+.+$/.test(value)){
                return '只能是字母或连接点'
            }
        },
        content: function(value){
            layedit.sync(editIndex);
        }
    });

    // Listen In From
    form.on('switch(status)', function(data){
        var param = {
            id: $(this).attr("data-id"),
            status: (data.elem.checked) ? data.value : 0
        }
        $.getJSON(linkUrl + "status", param);
    });

    form.on('select(categoryFilter)', function(data){
        window.location.replace(linkUrl + "index/cid/" + data.value);
        return false;
    });

    form.on('submit(save)', function(data){
        data.field.cover = cover ? cover : uploadLinkSrc.attr("data-src");
        $.post(linkUrl + "save", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                window.location.replace(result.url);
            });
        });
        return false;
    });

    link.edit = function (id) {
        $.getJSON(linkUrl + "edit/id/" + id, function (result) {
            layer.open({
                type: 1,
                title: result.msg,
                area: ['700px', '400px'],
                shlinkeClose: false,
                content: result.data,
                success: function(layero, index){
                    layerDom = layero;
                    uploadLinkCover();
                    uploadLinkSrc = $("#edit-cover-src");
                }
            });
            // relolink form
            form.render();
        });
    };

    link.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(linkUrl + "delete/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
        });
    };

    // 定义一个封面上传控件
    function uploadLinkCover() {
        layui.upload({
            //指定原始元素，默认直接查找class="layui-uplolink-file"
            url: linkUrl + "cover",
            title: '请上传封面图',
            method: 'post', //上传接口的http类型
            before: function(input){
                //返回的参数item，即为当前的input DOM对象
                loadLinkIndex = layer.lolink(0, {shlinke: false}); //0代表加载的风格，支持0-2
                console.log('文件上传中');
            },
            success: function(result){
                layer.close(loadLinkIndex);
                if(result.code){
                    layer.msg("上传成功", {time:2000}, function () {
                        cover = result.path;
                        uploadLinkSrc.attr("src", uplolinkSrc.attr("data-path") + "/" + cover);
                        uploadLinkSrc.fadeIn();
                    });

                }else{
                    layer.msg("上次失败" + result.msg,  {time:2000});
                }
            }
        });
    };

});