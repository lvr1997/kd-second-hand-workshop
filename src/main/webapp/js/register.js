$(function(){
    //首次加载图形验证
    Common.getCaptcha()
    //点击刷新图片验证码
    $('.captchaImage').click(function(){
        Common.getCaptcha()
    })

	
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


    $('.password').blur(function () {
        if($('.password').val() == '' || $('.password').val() == undefined){
            // $('.rePassword').focus()
            return layer.tips('保护您的信息，请输入密码', '.password')
        }else if($('.password').val() < 6){
            return layer.tips('密码长度由6~20位字符组成', '.password')
		}
    })

    $('.rePassword').blur(function () {
		if($('.password').val() != $('.rePassword').val()){
			// $('.rePassword').focus()
            return layer.tips('两次输入的密码不一致', '.rePassword')
		}
    })


	//检测图形验证码
	$('.captchaCode').blur(function () {
        if($('.captchaCode').val() == '' || $('.captchaCode').val() == undefined){
            // $('.captchaCode').focus()
            return layer.tips('请输入图形验证码', '.captchaCode')
        }
        var url = '/user/checkCode'
        var Data = {
            checkcode:$('.captchaCode').val()
        }
        Common.ajax(url, Data, function (data) {
            if(data.success){
                return layer.tips(data.msg, '.captchaCode')
            }else{
            	$('.captchaCode').focus()
                return layer.tips(data.msg, '.captchaCode')
            }
        }, function (err) {
            console.log(err)
        }, function (){}, true, 'POST')
    })

	$('.password').blur(function () {

    })

  	//注册
  	$('.register-btn').click(function(){
  		//检测手机号
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
  		}else if($('.checkbox[name=checkbox]:checked').length != 1){
            return layer.tips('请同意《科大二手工坊用户协议》', '.checkbox')
		}

  		var url = '/user/register'
		var Data = {
			phone: $('.phoneNum').val(),
			password: $('.password').val(),
			checkcode:$('.captchaCode').val()
		}
		Common.ajax(url, Data, function (data) {
		    if(data.success){
		        layer.msg(data.msg)
		        setTimeout(function(){
		        	location.href = '/user/toLogin'
		        }, 2000)
		    }else{
		        layer.msg(data.msg)
		    }
		}, function (err) {
		    console.log(err)
		}, function (){}, true, 'POST')
  	})
})