var categoryUrl = "/admin/category/",
    category = {},
    level = 1,
    iconIndex,
    layerDom = null;
layui.use(['form','element'], function() {
    var form = layui.form();
    var element = layui.element;

    $("#category-table").treetable({
        expandable : true
    });

    // 验证规则
    form.verify({
        letter:function(value){
            if(!/^[A-Za-z]+.+$/.test(value)){
                return '只能是字母或连接点'
            }
        }
    });

    // Listen In From
    form.on('switch(nav)', function(data){
        var param = {
            id: $(this).attr("data-id"),
            nav: (data.elem.checked) ? data.value : 0
        }
        $.getJSON(categoryUrl + "nav", param);
    });

    form.on('select(type)', function(data){
        var model = $("#model"),
            url  = $("#url");
        changeType(data, model, url);
    });
    form.on('select(editType)', function(data){
        var model = $("#edit-model"),
            url  = $("#edit-url");
        changeType(data, model, url);
    });
    form.on('select(createType)', function(data){
       var model = $("#create-model"),
            url  = $("#create-url");
        changeType(data, model, url);
    });

    form.on('submit(save)', function(data){
        var mix = (data.field.pid).split("|");
        data.field.pid = mix[0];
        data.field.level = mix[1];
        $.post(categoryUrl + "save", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });



    category.createSub = function (id) {
        $.getJSON(categoryUrl + "createSub/id/" + id, function (result) {
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
    category.edit = function (id) {
        $.getJSON(categoryUrl + "edit/id/" + id, function (result) {
            layer.open({
                type: 1,
                title: result.msg,
                area: ['600px', '400px'],
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

    category.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(categoryUrl + "delete/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
        });
    };

    category.sort = function () {
        var trs = $(".category-tr"),
            param = [];
        $.each(trs, function (k, v) {
           var sort = $(this).find(".category-sort").val();
           if(sort != 0){
               param.push({
                   id: $(this).attr("data-tt-id"),
                   sort: sort
               })
           }
        });
        $.post(categoryUrl + "sort", {param:param}, function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
    };

    function changeType(data, model, url) {
        var type = data.value;
        switch (parseInt(type)) {
            case 1 : model.hide(); url.hide();
                break;
            case 2 : url.show(); model.hide();
                break;
            default : model.show(); url.hide();
        };
    }
});