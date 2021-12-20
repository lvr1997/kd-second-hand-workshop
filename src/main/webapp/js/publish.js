var num = 0

$(function () {
	layui.use(['form', 'upload', 'layer'], function () {
		var form = layui.form(),
			layer = layui.layer

		layui.upload({
			url: '/publish/publish/upload',
			elem: '.info-img-upload', //指定原始元素，默认直接查找class="layui-upload-file"
			method: 'post', //上传接口的http类型
			success: function (data) {
				layer.msg(data.msg)
				if (data.success) {
					$('.layui-upload-button').before('<div class="uploaded">' +
						'<img class="good-image" src="'+'http://localhost:8088/images/web/' + data.data.src + '">' +
						'<i class="icon delete" data-src="' + data.data.src + '" onclick="deleteImage(this);">&#xe6a2;</i>' +
						'</div>')
					num++
					if (num == 5) {
						$('.layui-upload-button').hide()
					}
				}
			}
		})

		//交易方式切换
		$('.layui-form-radio').click(function () {
			if ($('.buyMethod[name=transactionMode]:checked').val() == 1) {
				$('#address').hide()
			} else {
				$('#address').show()
			}
		})

		//原始购物链接切换
		$('.add-original-link').click(function () {
			$('#original-link').show()
			$('.close-original-link').show()
			$(this).hide()
		})
		$('.close-original-link').click(function () {
			$('#original-link').hide()
			$('#original-link input').val('')
			$('.add-original-link').show()
			$(this).hide()
		})
	})

	$('.submit').click(function () {

		//检测是否上传图片
		if ($('.uploaded').length < 1) {
			layer.msg('请先上传图片')
			$("html,body").animate({
				scrollTop: $('.image').offset().top - 5
			}, 500)
			return false
		}

		//检测城市
		if (!$('.city').val()) {
			layer.msg('请选择城市')
			$("html,body").animate({
				scrollTop: $('.city').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.city').parent('.layui-input-inline').find('input').addClass('no-data')
			return false
		}
		$('.city').parent('.layui-input-inline').find('input').removeClass('no-data')

		//检测 闲置名称
		if (!($('.goods-title').val() && $('.goods-title').val().length < 14)) {
			layer.msg('请输入 闲置名称 且 长度不得超过14字')
			$("html,body").animate({
				scrollTop: $('.goods-title').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.goods-title').parent('.layui-input-inline').find('input').addClass('no-data')
			return false
		}
		$('.goods-title').parent('.layui-input-inline').find('input').removeClass('no-data')

		//检测 闲置详情
		if (!($('.goods-des').val() && $('.goods-des').val().length > 10 && $('.goods-des').val().length < 500)) {
			layer.msg('请输入 闲置描述 且 长度必须在 10 - 500 字之间')
			$("html,body").animate({
				scrollTop: $('.goods-des').parent('.layui-input-block').offset().top - 5
			}, 500)
			$('.goods-des').parent('.layui-input-block').find('textarea').addClass('no-data')
			return false
		}
		$('.goods-des').removeClass('no-data')

		//检测价格
		if (!$('.price').val()) {
			layer.msg('请输入 闲置价格')
			$("html,body").animate({
				scrollTop: $('.price').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.price').parent('.layui-input-inline').find('input').addClass('no-data')
			return false
		}
		var priceReg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/
		if (!priceReg.test($('.price').val())) {
			layer.msg('请输入正确的 闲置价格，如：0.00')
			$("html,body").animate({
				scrollTop: $('.price').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.price').addClass('no-data')
			return false
		}
		$('.price').removeClass('no-data')

		//检测原价
		if (!$('.original-price').val()) {
			layer.msg('请输入 闲置价格')
			$("html,body").animate({
				scrollTop: $('.original-price').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.original-price').parent('.layui-input-inline').find('input').addClass('no-data')
			return false
		}
		if (!priceReg.test($('.original-price').val())) {
			layer.msg('请输入正确的 闲置价格，如：0.00')
			$("html,body").animate({
				scrollTop: $('.original-price').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.original-price').addClass('no-data')
			return false
		}
		$('.original-price').removeClass('no-data')

		//检测分类
		if (!$('#categorys').val()) {
			layer.msg('请选择分类')
			$("html,body").animate({
				scrollTop: $('#categorys').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('#categorys').parent('.layui-input-inline').find('input').addClass('no-data')
			return false
		}
		$('#categorys').parent('.layui-input-inline').find('input').removeClass('no-data')

		//检测交易类型
		if ($('.buyMethod[name=transactionMode]:checked').length != 1) {
			layer.msg('请选择交易方式')
			$("html,body").animate({
				scrollTop: $('.buyMethod').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.buyMethod').parent('.layui-input-inline').find('input').addClass('no-data')
			return false
		}
		$('.buyMethod').parent('.layui-input-inline').find('input').removeClass('no-data')

		if ($('.buyMethod[name=transactionMode]:checked').val() != 1 && $('.goods-address').val() == '') {
			layer.msg('请输入交易地址')
			$("html,body").animate({
				scrollTop: $('.goods-address').parent('.layui-input-block').offset().top - 5
			}, 500)
			$('.goods-address').parent('.layui-input-block').find('input').addClass('no-data')
			return false
		}
		$('.goods-address').parent('.layui-input-block').find('input').removeClass('no-data')

		//检测手机号
		if (!$('.phone-number').val()) {
			layer.msg('请输入手机号')
			$("html,body").animate({
				scrollTop: $('.phone-number').parent('.layui-input-inline').offset().top - 5
			}, 500)
			$('.phone-number').parent('.layui-input-inline').find('input').addClass('no-data')
			return false
		}
		$('.phone-number').parent('.layui-input-inline').find('input').removeClass('no-data')

		//检测全部通过
		$('.no-data').removeClass('no-data')

		var good_images = []
		for (var i = 0; i < $('.uploaded').length; i++) {
			good_images.push($('.uploaded').eq(i).find('img').attr('src'))
		}

		var goodinfo = {
			good_images: JSON.stringify(good_images),
			goodCity: $('.city').val(),
			name: $('.goods-title').val(),
            describle: $('.goods-des').val(),
            price: $('.price').val(),
            realPrice: $('.original-price').val(),
			good_original_link: $('.original-link').val(),
            catelogId: $('#categorys').val(),
            goodBuyMethod: $('.buyMethod[name=transactionMode]:checked').val(),
			goodAddress: $('.goods-address').val(),
			phoneNumber: $('.phone-number').val(),
			qqNumber: $('.qq-number').val(),
			wxNumber: $('.wx-number').val()
		}
		var url = '/publish/publish/complete'
		Common.ajax(url, goodinfo, function (data) {
			layer.msg(data.msg)
			if (data.success) {
				// console.log(data)
				setTimeout(function () {
					location.href = '/user/index'
				}, 2000)
			}
		}, function (err) {
			console.log(err)
		}, function () {}, true, 'POST')
	})


})

//删除已上传的图片
function deleteImage(obj) {
	var path = $(obj).attr('data-src')

	var url = '/publish/publish/delete_image'
	var Data = {
		path: path
	}
	Common.ajax(url, Data, function (data) {
		layer.msg(data.msg)
		if (data.success) {
			num--
			if (num < 5) {
				$('.layui-upload-button').show()
			}
			$(obj).parent('.uploaded').remove()
		}
	}, function (err) {
		console.log(err)
	}, function () {}, true, 'POST')
}