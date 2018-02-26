var configUrl = "/admin/config/",
    config = {},
    siteLoginBgSrc = $("#site-login-bg-src");
    siteLoginBg = null;

layui.use(['form','layer','upload'], function(){
    var form = layui.form();
        layer=layui.layer;

    // 登录背景图上传
    layui.upload({
        url: configUrl + "uploadSiteLoginBg",
        title: '请上传背景图',
        elem: '#site-login-bg', //指定原始元素，默认直接查找class="layui-upload-file"
        method: 'post', //上传接口的http类型
        before: function(input){
            //返回的参数item，即为当前的input DOM对象
            layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
            console.log('文件上传中');
        },
        success: function(result){
            layer.closeAll();
            if(result.code){
                layer.msg(result.msg, {time:2000}, function () {
                    siteLoginBg = result.path;
                    siteLoginBgSrc.attr("src", siteLoginBgSrc.attr("data-path") + "/" + result.path);
                });
            }else{
                layer.msg(result.msg,  {time:2000});
            }
        }
    });

    form.on('submit(update)', function(data){
        data.field.site_login_bg = siteLoginBg ? siteLoginBg : siteLoginBgSrc.attr("data-name");
        $.post(configUrl + "update", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
               if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });

    form.on('submit(sms)', function(data){
        $.post(configUrl + "updateSms", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });
    form.on('submit(mail)', function(data){
        $.post(configUrl + "updateFile", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });

    form.on('submit(file)', function(data){
        $.post(configUrl + "updateMail", data.field,  function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                if(result.code) window.location.replace(result.url);
            });
        });
        return false;
    });
});