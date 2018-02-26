var documentUrl = "/admin/document/",
    document = {},
    loadIndex,
    editIndex,
    layerDom,cover = null,
    uploadSrc = $("#cover-src");
layui.use(['form','element', 'upload'], function() {
    var form = layui.form(),
        element = layui.element();

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
        $.getJSON(documentUrl + "status", param);
    });

    form.on('select(categoryFilter)', function(data){
        window.location.replace(documentUrl + "index/cid/" + data.value);
        return false;
    });

    form.on('submit(save)', function(data){
        data.field.cover = cover ? cover : uploadSrc.attr("data-src");
        $.post(documentUrl + "save", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                window.location.replace(result.url);
            });
        });
        return false;
    });

    document.edit = function (id) {
        $.getJSON(documentUrl + "edit/id/" + id, function (result) {
            if(result.code) {
                var edit = $(".layui-tab-title").children("li:eq(2)");
                if(edit){
                    layid = edit.attr("lay-id");
                    element.tabDelete('document', layid);
                };
                element.tabAdd('document',{
                    title: '编辑文档',
                    content: result.data,
                    id: id
                });
                element.tabChange('document', id);

                // reload form
                uploadCover();
                uploadSrc = $("#edit-cover-src");
                form.render();
            }else{
                layer.msg(result.msg, {time:2000});
            }
        });
    };

    document.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(documentUrl + "delete/id/" + id, function (result) {
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
            url: documentUrl + "cover",
            title: '请上传附件',
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
                        uploadSrc.attr("href", uploadSrc.attr("data-path") + "/" + cover);
                        uploadSrc.text(result.name);
                        uploadSrc.fadeIn();
                    });

                }else{
                    layer.msg("上次失败" + result.msg,  {time:2000});
                }
            }
        });
    };

});