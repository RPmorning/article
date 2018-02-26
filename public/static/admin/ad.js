var adUrl = "/admin/ad/",
    ad = {},
    loadIndex,
    editIndex,
    layerDom,cover = null,
    uploadSrc = $("#cover-src");
layui.use(['form','layedit','upload'], function() {
    var form = layui.form(),
        layedit = layui.layedit;

    // 创建一个上传实例
    uploadCover();

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
        $.getJSON(adUrl + "status", param);
    });

    form.on('select(categoryFilter)', function(data){
        window.location.replace(adUrl + "index/cid/" + data.value);
        return false;
    });

    form.on('submit(save)', function(data){
        data.field.cover = cover ? cover : uploadSrc.attr("data-src");
        $.post(adUrl + "save", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                window.location.replace(result.url);
            });
        });
        return false;
    });

    ad.edit = function (id) {
        $.getJSON(adUrl + "edit/id/" + id, function (result) {
            layer.open({
                type: 1,
                title: result.msg,
                area: ['700px', '600px'],
                shadeClose: false,
                content: result.data,
                success: function(layero, index){
                    layerDom = layero;
                    uploadCover();
                    uploadSrc = $("#edit-cover-src");
                }
            });
            // reload form
            form.render();
        });
    };

    ad.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(adUrl + "delete/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
        });
    };

    // 定义一个封面上传控件
    function uploadCover() {
        layui.upload({
            //指定原始元素，默认直接查找class="layui-upload-file"
            url: adUrl + "cover",
            title: '请上传封面图',
            method: 'post', //上传接口的http类型
            before: function(input){
                //返回的参数item，即为当前的input DOM对象
                loadIndex = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
                console.log('文件上传中');
            },
            success: function(result){
                layer.close(loadIndex);
                if(result.code){
                    layer.msg("上传成功", {time:2000}, function () {
                        cover = result.path;
                        uploadSrc.attr("src", uploadSrc.attr("data-path") + "/" + cover);
                        uploadSrc.fadeIn();
                    });

                }else{
                    layer.msg("上次失败" + result.msg,  {time:2000});
                }
            }
        });
    };

});