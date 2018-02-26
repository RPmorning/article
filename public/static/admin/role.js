/**
 * Created by Administrator on 2018/2/7-0007.
 */
var authUrl = "/admin/role/",
    auth = {};
layui.use(['form'], function(){
    var form = layui.form(),
        mainMenu = $(".main-menu");


    form.on('switch(status)', function(data){
        var param = {
            id: $(this).attr("data-id"),
            status: (data.elem.checked) ? data.value : 0
        }
        // $.getJSON(departmentUrl + "status", param);
        $.post(authUrl + "status", param,  function (result) {
            layer.msg(result.msg, {time:1500}, function () {
                window.location.replace(result.url);
            });
        });
    });


    form.on('select(roleFilter)', function(data){
        var action = $(data.elem).attr("data-action");
        window.location.replace(authUrl + action + "/id/" + data.value);
        return false;
    });

    form.on('checkbox(menu)', function(data){
        console.log(data);
        var rules = $(this).siblings("ul").find(".rules");
        rules.prop('checked', data.elem.checked);
        // reload form
        form.render("checkbox");
    });

    form.on('checkbox(category)', function(data){
        console.log(data);
        var rules = $(this).siblings("ul").find(".rules");
        rules.prop('checked', data.elem.checked);
        // reload form
        form.render("checkbox");
    });

    form.on('submit(create)', function(data){
        if (data.field.desc === "请输入角色描述") {
            data.field.desc = ''
        }
        if (data.field.name === "请输入角色名称") {
            data.field.name = ''
        }
        var role_category = [];
        $("input[name='category']").each(function(i){
            if($(this).is(':checked')) {
                role_category.push($(this).val());
            }
        });
        var param = {
            data : data.field,
            role_category : role_category.join(',')
        }
        $.post(authUrl + "save", param,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                window.location.replace(result.url);
            });
        });
        return false;
    });

    form.on('submit(update)', function(data){
        if (data.field.desc === "请输入角色描述") {
            layur.msg('请输入角色名称');
            return false;
        }
        if (data.field.name === "请输入角色名称") {
            data.field.name = ''
        }
        var role_category = [];
        $("input[name='category']").each(function(i){
            if($(this).is(':checked')) {
                role_category.push($(this).val());
            }
        });
        var param = {
            data : data.field,
            role_category : role_category.join(',')
        }
        $.post(authUrl + "update", param,  function (result) {
            // console.log(result)
            layer.msg(result.msg, {time:2000}, function () {
                window.location.replace(result.url);
            });
        });
        return false;
    });




    // auth Option
    auth.edit = function (id) {
        $.getJSON(authUrl + "edit/id/" + id, function (result) {
            if(result.code){
                layer.open({
                    type: 1,
                    title: result.msg,
                    area: ['500px', '900px'],
                    shadeClose: true,
                    content: result.data
                });
                // reload form
                form.render();
            }else{
                layer.msg(result.msg, {time:2000});
            }

        });
    };

    auth.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(authUrl + "delete/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
        });
    };

    // menus Option

    auth.menuInit = function () {

    };
    if(mainMenu.length) {
        var rules = $("#menu-tree").data("auth");
        rules = rules.split(",");
        $.each(rules, function (k, v) {
            $("#menu_"+v).prop("checked", true);
        });
        form.render('checkbox');
    };

    form.on('submit(menuUpdate)', function(data){
        var rules = [];
        $('input:checked').each(function (i,v) {
            rules[i] =  $(this).val();
        });
        var param = {
            id : data.field.role_id,
            rules : rules.join(",")
        }
        $.post(authUrl + "updateMenu", param,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });

    // roleMember Option
    auth.createRoleMember = function () {
        var member = $("#member");
        if(member.val()=='')
            return false;
        var params = {
            memberId : member.val(),
            authRoleId : member.attr("data-id")
        };
        $.post(authUrl + "createRoleMember", params, function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        })
    };

    auth.deleteRoleMember = function (memberId, authRoleId) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(authUrl + "deleteRoleMember", {memberId:memberId, authRoleId: authRoleId}, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
        });
    };

});
