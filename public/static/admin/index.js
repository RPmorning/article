/**
 * Created by hujj on 2017/5/11.
 */
var videoUrl = "/index/index/",
    video = {};
layui.use(['form'], function(){
    var form = layui.form(),
        layer = layui.layer;

    form.on('switch(status)', function(data){
        var param = {
            id: $(this).attr("data-id"),
            status: (data.elem.checked) ? data.value : 0
        }
        $.getJSON(videoUrl + "status", param, function (result) {
            layer.msg(result.msg, {time:2000}, function () {
                window.location.reload();
            });
        });
    });



    // video Option
    video.play = function (id,vid) {
        if(id === "") id = 0;
        var param = {
            id : id,
            vid : vid
        };

        $.getJSON(videoUrl + "video", param, function (result) {
            layer.open({
                type: 1,
                title: result.msg,
                anim: 1,
                area: ['600px', '400px'],
                shade: 0.8,
                resize: true,
                closeBtn: 1,
                maxmin : true,
                shadeClose: true,
                content:  result.data
            });
            // reload form
            form.render();
        });
    };


});



