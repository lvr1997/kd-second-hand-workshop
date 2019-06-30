$(function() {

    if (a == 0 || b == 0 || c == 0) {
        layer.open({
            type: 1,
            skin: 'auth-layer', //样式类名
            area: ['500px', '372px'],
            closeBtn: 0, //不显示关闭按钮
            anim: 2,
            shadeClose: true, //开启遮罩关闭
            content: '<div class="auth-body clearfix">' +
                '<div class="auth-show-box">' +
                '<i class="icon">' + (a == 0 ? "&#xe725;" : "&#xe730;") + '</i>' +
                '<p>实名认证</p>' +
                '</div>' +
                '<div class="auth-show-box">' +
                '<i class="icon">' + (b == 0 ? "&#xe725;" : "&#xe730;") + '</i>' +
                '<p>手机认证</p>' +
                '</div>' +
                '<div class="auth-show-box">' +
                '<i class="icon">' + (c == 0 ? "&#xe725;" : "&#xe730;") + '</i>' +
                '<p>邮箱认证</p>' +
                '</div>' +
                '</div>' +
                '<p class="tips">完成以上三项认证，让你的账户更安全！</p>' +
                '<p class="close-btn"><a href="javascript:;">关闭</a></p>'
        });
    }

    layui.use(['layer'], function() {
        var layer = layui.layer

        $('.operate a').click(function() {
            $(this).parents('.auth-line').siblings().stop()
            $(this).parents('.auth-line').stop()

            $(this).parents('.auth-line').siblings().animate({
                height: "80px"
            })
            $(this).parents('.auth-line').animate({
                height: "300px"
            })
            $('.auth-line').find('.input-area').hide()
            $(this).parents('.auth-line').find('.input-area').show()
        })


        //***************提交实名认证
        $('.real-name-submit').click(function() {
            var real_name = $('.real-name').val()
            var id_card = $('.id_card').val()

            //姓名检测
            if (real_name == '' || real_name == undefined) {
                $('.real-name').focus()
                layer.tips('请输入您的姓名！', '.real-name')
                return false
            }

            if (real_name) {
                var reg = /^[\u4E00-\u9FA5]{2,4}$/
                if (!reg.test($('.real-name').val())) {
                    $('.real-name').focus()
                    layer.tips('输入的姓名有误', '.real-name')
                    return false
                }
            }

            //身份证检测
            if (id_card == '' || id_card == undefined) {
                $('.id_card').focus()
                layer.tips('请输入您的身份证号码！', '.id_card')
                return false
            }

            if (id_card) {
                var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                if (reg.test(id_card) === false) {
                    layer.tips('您输入的身份证号码不合法！', '.id_card')
                    return false
                }
            }

            //提交认证
            var url = '/user/auth'
            var Data = {
                type: 1,
                real_name: real_name,
                id_card: id_card
            }
            Common.ajax(url, Data, function(data) {
                layer.msg(data.msg)
                if (data.success) {
                    setTimeout(function() {
                        location.reload()
                    }, 2000)
                }
            }, function(err) {
                console.log(err)
            }, function() {}, true, 'POST')
        })

        //******************手机认证
        //获取验证码
        $('.phone-verify-submit').click(function() {
            var phone_number = $('.phone_number').val()
                //手机号检测
            if (phone_number == '' || phone_number == undefined) {
                $('.phone_number').focus()
                layer.tips('请输入手机号码！', '.phone_number')
                return false
            }
            if (phone_number) {
                var reg = /^1(3|4|5|7|8)\d{9}$/
                if (!reg.test(phone_number)) {
                    layer.tips('手机号码有误！', '.phone_number')
                    return false
                }
            }
            //get yzm
            var url = '/user/get_phone_code'
            var Data = {
                phonenum: phone_number
            }
            Common.ajax(url, Data, function(data) {
                layer.msg(data.msg)
            }, function(err) {
                console.log(err)
            }, function() {}, true, 'POST')
        })

        $('.phone-submit').click(function() {
            var password = $('.pwd').val()
            var phone_number = $('.phone_number').val()
            var verify = $('.verify').val()

            //密码检测
            if (password == '' || password == undefined) {
                $('.pwd').focus()
                layer.tips('请输入登录密码！', '.pwd')
                return false
            }

            //手机号检测
            if (phone_number == '' || phone_number == undefined) {
                $('.phone_number').focus()
                layer.tips('请输入手机号码！', '.phone_number')
                return false
            }
            if (phone_number) {
                var reg = /^1(3|4|5|7|8)\d{9}$/
                if (!reg.test(phone_number)) {
                    layer.tips('手机号码有误！', '.phone_number')
                    return false
                }
            }
            //检测验证码/user/get_phone_code
            if (verify == '' || verify == undefined) {
                $('.verify').focus()
                layer.tips('请输入验证码！', '.verify')
                return false
            }

            //提交认证
            var url = '/user/auth'
            var Data = {
                type: 2,
                password: $.md5(password),
                phone_number: phone_number,
                verify: verify
            }
            Common.ajax(url, Data, function(data) {
                layer.msg(data.msg)
                if (data.success) {
                    setTimeout(function() {
                        location.reload()
                    }, 2000)
                }
            }, function(err) {
                console.log(err)
            }, function() {}, true, 'POST')
        })

        //邮箱绑定
        $('.email-submit').click(function() {
            var email = $('.email').val()
            var password = $('.password').val()

            //密码检测
            if (password == '' || password == undefined) {
                $('.password').focus()
                layer.tips('请输入登录密码！', '.password')
                return false
            }

            //邮箱检测
            if (email == '' || email == undefined) {
                $('.email').focus()
                layer.tips('请输入您的邮箱！', '.email')
                return false
            }
            if (email) {
                var reg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
                if (!reg.test(email)) {
                    layer.tips('您的邮箱有误！', '.email')
                    return false
                }
            }

            //提交认证
            var url = '/user/auth'
            var Data = {
                type: 3,
                password: $.md5(password),
                email: email
            }
            Common.ajax(url, Data, function(data) {
                layer.msg(data.msg)
                if (data.success) {
                    setTimeout(function() {
                        location.reload()
                    }, 2000)
                }
            }, function(err) {
                console.log(err)
            }, function() {}, true, 'POST')
        })

        $('.close-btn a').click(function() {
            layer.closeAll();
        })
    })
})