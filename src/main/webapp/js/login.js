$(function(){

	/*layui.use(['element', 'layer'], function(){
	  	var element = layui.element(),
	  		layer = layui.layer;

	  	// var redirectURL =  Common.getQuery('redirectURL');

	  	$('.login-btn').click(function(){
	  		if($('.phoneNum').val() == '' || $('.phoneNum').val() == undefined){
	  			$('.phoneNum').focus();
	  			return layer.tips('请输入手机号或邮箱', '.phoneNum')
	  		}
	  		if($('.password').val() == '' || $('.password').val() == undefined){
	  			$('.password').focus();

	  			return layer.tips('请输入密码', '.password')
	  		}

	  		var url = '/user/login';
			var Data = {
				phone: $('.phoneNum').val(),
				password: $('.password').val()
			}
			Common.ajax(url, Data, function (data) {
			    if(data.success){
			        layer.msg(data.msg);
                    setTimeout(function(){
                        location.href = '/goods/index'
                    }, 1500)
			        /!*if(redirectURL){
			        	setTimeout(function(){
				        	location.href = redirectURL
				        }, 1500)
			        }else{
				        setTimeout(function(){
				        	location.href = '/goods/index'
				        }, 1500)
			        }*!/
			    }else{
			        layer.msg(data.msg)
			    }
			}, function (err) {
			    console.log(err)
			}, function (){}, true, 'POST')
	  	})
	})*/
})