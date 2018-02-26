var libraryUrl = "/admin/library/",
    library = {},
    cover, attachment = null;

layui.use(['form','element', 'upload'], function() {
    var form = layui.form(),
        element = layui.element();

    // 验证规则
    form.verify({
        letter:function(value){
            if(!/^[A-Za-z]+.+$/.test(value)){
                return '只能是字母或连接点'
            }
        }
    });

    // Listen In From
    // form.on('switch(status)', function(data){
    //     var param = {
    //         id: $(this).attr("data-id"),
    //         status: (data.elem.checked) ? data.value : 0
    //     }
    //     $.getJSON(libraryUrl + "status", param);
    // });

    form.on('switch(status)', function(data){
        var param = {
            id: $(this).attr("data-id"),
            status: (data.elem.checked) ? data.value : 0
        }
        $.getJSON(libraryUrl + "status", param, function (result) {
            layer.msg(result.msg, {time:1500}, function () {
                window.location.reload();
            });
        });
    });

    form.on('select(categoryFilter)', function(data){
        window.location.replace(libraryUrl + "index/cid/" + data.value);
        return false;
    });

    form.on('submit(save)', function(data){
        // data.field.cover = cover ? cover : uploadSrc.attr("data-src");
        // data.field.attachment = attachment ? attachment : attachmentSrc.attr("data-src");
        $.post(libraryUrl + "save", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                window.location.replace(result.url);
            });
        });
        return false;
    });

    library.edit = function (id) {
        $.getJSON(libraryUrl + "edit/id/" + id, function (result) {
            layer.open({
                type: 1,
                title: result.msg,
                area: ['600px', '440px'],
                shadeClose: true,
                content: result.data,
                success: function(layero, index){
                    layerDom = layero;
                }
            });
            // reload form
            form.render();
        });

    };

    library.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(libraryUrl + "delete/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
        });
    };


});