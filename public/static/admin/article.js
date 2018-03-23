var articleUrl = "/admin/article/",
    article = {},
    loadIndex,
    editIndex,
    layerDom,cover = null,
    uploadSrc = $("#cover-src");
layui.use(['form','element','upload'], function() {
    var form = layui.form(),
        element = layui.element();

    // 创建一个上传实例
    uploadCover();

    // 创建一个编辑器
    UE.getEditor("container", {
        authHeight: false
    });

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
        $.getJSON(articleUrl + "status", param);
    });

    form.on('select(categoryFilter)', function(data){
        window.location.replace(articleUrl + "index/cid/" + data.value);
        return false;
    });

    form.on('radio(sign)', function (data) {
        if(data.value == '1'){
            $('#signDepartment').removeClass('hide');

        }else {
            $('#signDepartment').addClass('hide');
        }

    });

    form.on('radio(sign_1)', function (data) {
        if(data.value == '1'){
            $('.signDepartment_1').removeClass('hide');
        }else {

            $('.signDepartment_1').addClass('hide');
        }

    });

    form.on('submit(save)', function(data){
        if (data.field.name == '' || data.field.name == '请输入标题') {
            layer.msg('请输入标题', {time:1500}, function () {
            });
            return false;
        }
        if (data.field.desc == '' || data.field.desc == '请输入摘要') {
            layer.msg('请输入摘要', {time:1500}, function () {
            });
            return false;
        }
        data.field.cover = cover ? cover : uploadSrc.attr("data-src");

        var departments = [];
        $("input[name='department']").each(function(i){
            if($(this).is(':checked')) {
                departments.push($(this).val());
            }
        });

        if($(".signDepartment_1").hasClass('hide')){
            var param = {
                data : data.field,
                departments : ''
            }
        }else {
            var param = {
                data : data.field,
                departments : departments.join(',')
            }
        }
        $.post(articleUrl + "save", param,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });
    article.edit = function (id) {
        var check_status = $('#check_status option:selected') .val(),
            category_id = $('#caterory_id option:selected') .val();
        $.getJSON(articleUrl + "edit/id/" + id+'/category_id/'+category_id+'/check_status/'+check_status, function (result) {
            if(result.code) {
                UE.delEditor('edit-container-'+id);
                var edit = $(".layui-tab-title").children("li:eq(2)");
                if(edit){
                    layid = edit.attr("lay-id");
                    element.tabDelete('article', layid);
                };
                element.tabAdd('article',{
                    title: '编辑作品',
                    content: result.data,
                    id: id
                });
                element.tabChange('article', id);
                // reload form
                uploadCover();
                uploadSrc = $("#edit-cover-src");
                form.render();
            }else{
                layer.msg(result.msg, {time:2000});
            }
        });
    };

    article.check = function (id) {
        var index = layer.confirm('确认发布？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(articleUrl + "check/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.code) window.location.replace(result.url);
                });
            });
        }, function(){
            layer.close(index);
        });
    };

    article.delete = function (id) {
        var index = layer.confirm('确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON(articleUrl + "delete/id/" + id, function (result) {
                layer.msg(result.msg, {time:2000}, function () {
                    if(result.msg=='删除成功'){
                        $('.essaylist').find('#'+id).fadeOut();
                    }
                   // if(result.code) window.location.replace(result.url);
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
            url: articleUrl + "cover",
            title: '请上传封面图(3:2)',
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
    }

    article.search = function () {
       var check_status = $('#check_status option:selected') .val(),
           category_id = $('#caterory_id option:selected') .val();

        // var param = {
        //     check_status: check_status,
        //     category_id: category_id
        // }

        window.location.replace(articleUrl + "search/check_status/"+check_status +"/category_id/"+category_id);

        // $.post(articleUrl + "search", param,  function (result) {
        //     layer.msg(result.msg, {time:2000}, function () {
        //         window.location.replace(result.url);
        //     });
        // });
        // return false;
    }
});
