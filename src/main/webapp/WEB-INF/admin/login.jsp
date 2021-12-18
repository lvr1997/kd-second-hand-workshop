<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>登录-科大二手工坊-后台管理</title>
        <script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
        <script src="<%=basePath%>js/base.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/layui.all.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/layui.js"></script>
        <link type="text/css" id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css">
        <link type="text/css" id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css">
        <link type="text/css" id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css">
        <link type="text/css" rel="stylesheet" href="<%=basePath%>js/css/layui.css">

        <link type="text/css" rel="stylesheet" href="<%=basePath%>css/public.css">
        <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
        <link type="text/css" rel="stylesheet" href="<%=basePath%>css/login.css">

        <script type="text/javascript">
            function check_login() {
                var phoneReg = /^1[3|4|5|7|8][0-9]\d{8}$/;
                if ($('.phoneNum').val() == '' || $('.phoneNum').val() == undefined) {
                    $('.phoneNum').focus()
                    return layer.tips('请输入手机号', '.phoneNum')
                } else if (!phoneReg.test($('.phoneNum').val())) {
                    $('.phoneNum').focus()
                    return layer.tips('手机号格式有误', '.phoneNum')
                }
                if ($('.password').val() == '' || $('.password').val() == undefined) {
                    $('.password').focus();
                    return layer.tips('请输入密码', '.password')
                }
                var url = '/admin/login'
                var Data = {
                    phone: $('.phoneNum').val(),
                    password: $('.password').val()
                }
                Common.ajax(url, Data, function (data) {
                    layer.msg(data.msg)
                    if(data.success){
                        setTimeout(function(){
                            location.href = data.reurl
                        }, 2000)
                    }
                }, function (err) {
                    console.log(err)
                }, function (){}, true, 'POST')
            }
        </script>
    </head>
    <body>
    <div id="header">
        <%--<a href="" class="logo"></a>--%>
    </div>
    <div id="login-main">
        <div class="layui-tab layui-tab-brief reg-left fl">
            <!-- <ul class="layui-tab-title">
                <li class="layui-this">手机号注册</li>
                <li>邮箱注册</li>
            </ul> -->
            <div class="layui-tab-content">
                <form class="layui-tab-item layui-show layui-form" >
                    <div class="layui-form-item">
                        <input type="text" name="phone" autocomplete="off" lay-verify="phone" placeholder="请输入手机号/邮箱" class="layui-input phoneNum">
                    </div>
                    <div class="layui-form-item">
                        <input type="password" name="password" autocomplete="off" lay-verify="password" placeholder="请输入密码" class="layui-input password">
                    </div>
                    <div class="layui-form-item forgetpwd">
                        <a href="/user/forget_password">忘记密码？</a>
                    </div>
                    <a class="layui-btn login-btn" onclick="check_login();" >登 录</a>
                </form>
                <!-- <div class="layui-tab-item">内容2</div> -->
            </div>
        </div>
        <div class="log-right right-box fr">
            <p>没有账号：</p>
            <a href="/user/toRegister">立即注册</a>
        </div>
    </div>
    <script type="text/javascript" src="<%=basePath%>js/jquery.md5.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/login.js"></script>
    </body>
</html>