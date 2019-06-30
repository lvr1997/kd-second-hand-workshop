$(function(){
    layui.use(['layer', 'laypage'], function(){
        var layer = layui.layer

        /*layui.laypage({
            cont: 'page', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
            pages: count, //通过后台拿到的总页数
            curr: Common.getQuery('page') || 1, //当前页
            jump: function(obj, first){ //触发分页后的回调
                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
                    window.location.href = '/user/index?page=' + obj.curr
                }
            }
        })*/

        //下架
        $('.delete').click(function(){
            var gid = $(this).attr('data-gid')
            var url = '/publish/delete_good'
            var Data = {
                gid: gid
            }
            Common.ajax(url, Data, function (data) {
                if(data.success){
                    layer.msg(data.msg)
                    setTimeout(function(){ location.reload(); }, 1000)
                }else{
                    layer.msg(data.msg)
                }
            }, function (err) {
                console.log(err)
            }, function () {}, true, 'POST')
        })
        //擦亮
        $('.reflash').click(function(){
            var gid = $(this).attr('data-gid')
            var url = '/publish/reflash'
            var Data = {
                gid: gid
            }
            Common.ajax(url, Data, function (data) {
                if(data.success){
                    layer.msg(data.msg)
                    setTimeout(function(){ location.reload(); }, 1000)
                }else{
                    layer.msg(data.msg)
                }
            }, function (err) {
                console.log(err)
            }, function () {}, true, 'POST')
        })
    })
})