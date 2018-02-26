/**
 * Created by Administrator on 2018/2/9-0009.
 */
var departmentUrl = "/admin/department/",
    department = {},
    level = 1,
    layerDom = null;
layui.use(['form','element'], function() {
    var form = layui.form();
    var element = layui.element;

    $("#department-table").treetable({
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
    form.on('switch(status)', function(data){
        var param = {
            id: $(this).attr("data-id"),
            status: (data.elem.checked) ? data.value : 0
        }
        // $.getJSON(departmentUrl + "status", param);
        $.post(departmentUrl + "status", param,  function (result) {
            layer.msg(result.msg, {time:1500}, function () {
                window.location.replace(result.url);
            });
        });
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
        $.post(departmentUrl + "save", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });

    form.on('submit(create)', function(data){
        var d_role_id = [];
        $("input[name='roles']").each(function(i){
            if($(this).is(':checked')) {
                d_role_id.push($(this).val());
            }
        });
        var param = {
            data : data.field,
            d_role_id : d_role_id.join(',')
        }
        $.post(departmentUrl + "createDepartment", param,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });

    form.on('submit(update)', function(data){
        var d_role_id = [];
        $("input[name='roles']").each(function(i){
            if($(this).is(':checked')) {
                d_role_id.push($(this).val());
            }
        });
        var param = {
            data : data.field,
            d_role_id : d_role_id.join(',')
        }
        $.post(departmentUrl + "updateDepartment", param,  function (result) {
            // console.log(result);
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });


    department.createSub = function (id) {
        $.getJSON(departmentUrl + "createSub/id/" + id, function (result) {
            layer.open({
                type: 1,
                title: result.msg,
                area: ['700px', '540px'],
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
    department.edit = function (id) {
        $.getJSON(departmentUrl + "edit/id/" + id, function (result) {
            layer.open({
                type: 1,
                title: result.msg,
                area: ['700px', '540px'],
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

    department.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(departmentUrl + "delete/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
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