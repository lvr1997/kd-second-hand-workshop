$(function(){

    //首次加载图形验证
    Common.getCaptcha()
    //点击刷新图片验证码
    $('.captchaImage').click(function(){
        Common.getCaptcha()
    })

    //验证用户手机是否存在
    $('.phoneNum').blur(function () {
        var phoneReg = /^1[3|4|5|7|8][0-9]\d{8}$/;
        if($('.phoneNum').val() == '' || $('.phoneNum').val() == undefined){
            $('.phoneNum').focus()
            return layer.tips('请输入手机号', '.phoneNum')
        }else if(!phoneReg.test($('.phoneNum').val())){
            $('.phoneNum').focus()
            return layer.tips('手机号格式有误', '.phoneNum')
        }
        $.ajax({
            url:"/user/checkPhone",
            type:"GET",
            data:"phone="+$('.phoneNum').val(),
            success:function (res) {
                return layer.tips(res.message, '.phoneNum')
            }
        })
    })
    //验证验证码
    $('.captchaCode').blur(function () {
        var url = "/user/checkCode"
        var Data = {
            checkcode: $('.captchaCode').val()
        }
        Common.ajax(url,Data,function (data) {
            if(data.success){
                return layer.tips(data.msg, '.captchaCode')
            }else{
                Common.getCaptcha()
                layer.msg(data.msg)
            }
        }, function (err) {
            console.log(err)
        }, function (){}, true, 'POST')
    })

    //检测新密码
    $('.password').blur(function () {
        if($('.password').val() == '' || $('.password').val() == undefined){
            // $('.rePassword').focus()
            return layer.tips('保护您的信息，请输入密码', '.password')
        }else if($('.password').val() < 6){
            return layer.tips('密码长度由6~20位字符组成', '.password')
        }
    })
    //检测确认密码
    $('.repassword').blur(function () {
        if($('.password').val() != $('.repassword').val()){
            // $('.rePassword').focus()
            return layer.tips('两次输入的密码不一致', '.repassword')
        }
    })

    //提交
    $('.register-btn').click(function(){
        var phoneReg = /^1[3|4|5|7|8][0-9]\d{8}$/
        if($('.phoneNum').val() == '' || $('.phoneNum').val() == undefined){
            $('.phoneNum').focus()
            return layer.tips('请输入手机号', '.phoneNum')
        }else if(!phoneReg.test($('.phoneNum').val())){
            $('.phoneNum').focus()
            return layer.tips('手机号格式有误', '.phoneNum')
        }
        //检测图形验证码
        if($('.captchaCode').val() == '' || $('.captchaCode').val() == undefined){
            $('.captchaCode').focus()
            return layer.tips('请输入图形验证码', '.captchaCode')
        }
       /* //检测短信验证码
        if($('.phoneCode').val() == '' || $('.phoneCode').val() == undefined){
            $('.phoneCode').focus()
            return layer.tips('请输入手机验证码', '.phoneCode')
        }*/
        //检测两次输入的密码
        if($('.password').val() == '' || $('.password').val() == undefined){
            $('.password').focus()
            return layer.tips('请输入新密码', '.password')
        }
        if($('.repassword').val() == '' || $('.repassword').val() == undefined){
            $('.repassword').focus()
            return layer.tips('请确认新密码', '.repassword')
        }
        if($('.password').val() != $('.repassword').val()){
            $('.repassword').focus()
            return layer.tips('两次输入的密码不一致', '.repassword')
        }

        var url = '/user/forget'
        var Data = {
            phone_number: $('.phoneNum').val(),
            /*phoneCode: $('.phoneCode').val(),*/
            captchaCode:$('.captchaCode').val(),
            password: $('.password').val(),
        }
        Common.ajax(url, Data, function (data) {
            if(data.success){
                layer.msg(data.msg)
                setTimeout(function(){
                    location.href = '/user/toLogin'
                }, 1500)
            }else{
                layer.msg(data.msg)
            }
        }, function (err) {
            console.log(err)
        }, function (){}, true, 'POST')
    })
})