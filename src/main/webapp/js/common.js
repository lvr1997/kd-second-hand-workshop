var Common = {}

/*AJAX接口调用函数开始
 * sCallback ：获取数据成功时执行的回调函数
 * eCallback ：获取数据失败时执行的回调函数
 * bCallback ：数据发送前执行的回调函数，一般用户显示"菊花"
 * async : true:异步  false：同步
 */
Common.ajax = function (url, data, sCallback, eCallback, bCallback, async, method) {

    var isAsync = true
    if (!async) {
        isAsync = false
    }
    jQuery.support.cors = true;
    $.ajax({
        type: method,
        url: url,
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        //contentType: "application/json",
        data: data,
        //dataType: "json",
        async: isAsync,
        beforeSend: function () {
            bCallback()
        },
        success: function (data) {
            layer.closeAll();
            sCallback(data)
        },
        error: function (data) {
            layer.closeAll();
            eCallback(data)
        }
    })
}
//var url = ''
//var Data = {}
//Common.ajax(url, Data, function (data) {
//     if(data.success){
//         
//     }else{
//         layer.msg(data.msg)
//     }
//}, function (err) {
//     console.log(err)
//}, function () {}, true, 'POST')

//获取url get参数值
Common.getQuery = function (par) {
    if (par) {
        var req = new Object()
        req = GetRequest();
        if (req[par] != '' && req[par] != undefined) {
            return req[par];
        };
    } else {
        console.log('getUrlVal()未传参数')
    }

    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串   
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
}

//进入任何页面执行
$(function () {
    layui.use('layer', function () {
        var layer = layui.layer

        if ($('.city a').length == 1) {

            $('.city a').click(function () {
                layer.open({
                    type: 2,
                    title: '切换城市',
                    skin: 'layui-layer-rim', //加上边框
                    area: ['500px', '480px'], //宽高
                    content: '/goods/city'
                })
            })
        }
        //搜索按钮
        $('.search-normal-btn').click(function () {
            if ($('.keywords').val()) {
                window.open('/user/search?keywords=' + $('.keywords').val())
            } else {
                layer.msg('请输入关键词！')
            }
        })

        //回顶部

        initToTop();
        $(window).resize(function () {
            initToTop();
        });
        $(window).scroll(function () {
            initToTop();
        });

        function initToTop() {
            var width = $(window).width();
            if ($(window).scrollTop() == 0) {
                // if(!$("#goTop").is(":hidden")){
                $(".go-to-top").hide();
                // }
            } else {
                // if($("#goTop").is(":hidden")){
                $(".go-to-top").show();
                // }
            }
            $(".go-to-top").css({
                "left": (width - 1100) / 2 + 1110
            });
        }
    })


})

//90秒倒计时
var wait = 90
Common.time = function () {
    if (wait == 0) {
        $('.showbox').hide()
        $('.get-phoneCode').attr('style', 'display: inline-block')
        wait = 90
    } else {
        $('.showbox').html(wait + "s后重新发送")
        wait--
        setTimeout(function () {
            Common.time()
        }, 1000)
    }
}


//获取图片验证码
Common.getCaptcha = function () {
    var url = '/captcha/captcha'
    var Data = {}
    Common.ajax(url, Data, function (data) {
        if (data.success) {
            $('.captchaImage').attr('src', data.image)
            // $('.captchaImage').attr('data-id', data.image.id)
        } else {
            layer.msg(data.msg)
        }
    }, function (err) {
        console.log(err)
    }, function () {}, true, 'POST')
}