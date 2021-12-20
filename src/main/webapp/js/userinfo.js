$(function(){

	// console.log(City)
	var p = {},c = {},d = {}
	if($('.area').attr('data-area')){
		var pp = $('.area').attr('data-area').split('-')[0],
			cc = $('.area').attr('data-area').split('-')[1],
			dd = $('.area').attr('data-area').split('-')[2]
		
		City.province.forEach(function(v){
			p[v.name] = v.id
			$('#province').append('<option value="' + v.name + '" data-id="' + v.id + '" ' + (v.name == pp ? 'selected' : '') + '>' + v.name + '</option>')
		})
		City.city[p[$('#province').val()]].forEach(function(v){
			c[v.name] = v.id
			$('#city').append('<option value="' + v.name + '" data-id="' + v.id + '" ' + (v.name == cc ? 'selected' : '') + '>' + v.name + '</option>')
		})
		City.district[c[$('#city').val()]].forEach(function(v){
			d[v.name] = v.id
			$('#county').append('<option value="' + v.name + '" data-id="' + v.id + '" ' + (v.name == dd ? 'selected' : '') + '>' + v.name + '</option>')
		})
	}else{
		City.province.forEach(function(v){
			p[v.name] = v.id
			$('#province').append('<option value="' + v.name + '" data-id="' + v.id + '">' + v.name + '</option>')
		})
	}
	
	layui.use(['form', 'upload', 'laydate'], function(){

		var laydate = layui.laydate
		var form = layui.form()

		function init(){
			$('.layui-input-inline dl dd').click(function(){
				switch($(this).siblings('dd[lay-value=请选择]').html()){
					case '请选择省份':
						$('#city').html('<option value="请选择">请选择城市</option>')
						City.city[p[$('#province').val()]].forEach(function(v){
							c[v.name] = v.id
							$('#city').append('<option value="' + v.name + '" data-id="' + v.id + '" ' + (v.name == cc ? 'selected' : '') + '>' + v.name + '</option>')
						})
						$('#county').html('<option value="请选择">请选择区县</option>')
						form.render()
						init()
						break
					case '请选择城市':
						$('#county').html('<option value="请选择">请选择区县</option>')
						City.district[c[$('#city').val()]].forEach(function(v){
							d[v.name] = v.id
							$('#county').append('<option value="' + v.name + '" data-id="' + v.id + '" ' + (v.name == dd ? 'selected' : '') + '>' + v.name + '</option>')
						})
						form.render()
						init()
						break
					case '请选择区县':
						break
				}
			})
		}
		init()	//初始化

		//头像上传
		layui.upload({
            url: '/user/avatar_upload/' + $('.userinfo').attr('data-uid'),
            elem: '.change-picture', //指定原始元素，默认直接查找class="layui-upload-file"
            method: 'post', //上传接口的http类型
            success: function(data){
                if(data.success){
                    $('.user-info-picture').attr('src', 'http://localhost:8088/images/user/'+data.data.src)
                    // article.image = data.data.src
                    layer.msg('头像上传成功')
                    setTimeout('location.reload()', 800)
                }else{
                    layer.msg('头像上传失败！请重试！')
                }
            }
        })

		//个人信息提交保存
		$('.userinfo-submit').click(function(){
			//昵称检测
			if($('.nick-name').val() == '' || $('.nick-name').val() == undefined){
				$('.nick-name').focus()
	  			return layer.tips('请输入昵称', '.nick-name')
			}else{
				var reg = /^[0-9a-zA-Z\u4e00-\u9fa5_]{3,16}$/
				if(!reg.test($('.nick-name').val())){
					$('.nick-name').focus()
	  				return layer.tips('输入的昵称格式有误', '.nick-name')
				}
			}
			//签名检测
			if($('.signature').val().length > 40){
				$('.signature').focus()
  				return layer.tips('个性签名不得多于40个字！', '.signature')
			}

			//性别检测
			if($('input[name=sex]:checked').length != 1){
				return layer.tips('请选择性别', '.sex-wrap')
			}
			//日期检测
			if($('.birthday').val()){
				var reg = /^(\d{4})\-(\d{2})\-(\d{2})$/
				if(!reg.test($('.birthday').val())){
					$('.birthday').focus()
	  				return layer.tips('输入的日期格式有误', '.birthday')
				}
			}

			var residence = $('.area').attr('data-area')
			if($('#province').val() == '请选择' || $('#city').val() == '请选择' || $('#county').val() == '请选择'){
				residence = $('.area').attr('data-area')
			}else{
				residence = $('#province').val() + '-' + $('#city').val() + '-' + $('#county').val()
			}

			var data = {
				username: $('.nick-name').val(),
				imgUrl: $('.user-info-picture').attr('src'),
				signature: $('.signature').val(),
				// real_name: $('.real-name').val(),
				// email: $('.email').val(),
				sex: $('input[name=sex]:checked').val(),
				birthday: $('.birthday').val(),
				residence: residence,
				id: $('.userinfo').attr('data-uid')
			}

			var url = '/user/save_userinfo'
			Common.ajax(url, data, function (data) {
			    if(data.success){
			        layer.msg(data.msg)
			        setTimeout('location.reload()', 800)
			    }else{
			        layer.msg(data.msg)
			    }
			}, function (err) {
			    console.log(err)
			}, function () {}, true, 'POST')
		})

	})
})