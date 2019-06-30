
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
<html lang="en"><head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>忘记密码-科大二手工坊</title>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui.all.js"></script>
    <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
    <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
    <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <script src="<%=basePath%>js/common.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/login.css">
</head>
<body>
<div id="header">
    <a href="http://www.taoertao.com/" class="logo"></a>
</div>
<div id="register-main" class="clearfix">
    <div class="layui-tab layui-tab-brief reg-left fl">
        <!-- <ul class="layui-tab-title">
            <li class="layui-this">手机号注册</li>
            <li>邮箱注册</li>
        </ul> -->
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show layui-form">
                <div class="layui-form-item">
                    <input name="phoneNum" lay-verify="title" autocomplete="off" placeholder="请输入手机号" class="layui-input phoneNum" type="text">
                </div>
                <div class="layui-form-item captcha">
                    <input name="captchaCode" autocomplete="off" placeholder="请输入图形验证码" class="layui-input captchaCode" type="text">
                    <!-- <a href="javascript:;" class="layui-btn get-captchaCode">获取验证码</a> -->
                    <img class="captchaImage" src="" title="点击刷新">
                </div>
                <%--<div class="layui-form-item phone">
                    <input name="phoneCode" lay-verify="title" autocomplete="off" placeholder="请输入短信验证码" class="layui-input phoneCode" type="text">
                    <a href="javascript:;" class="layui-btn get-phoneCode">获取验证码</a>
                    <span class="showbox"></span>
                </div>--%>
                <div class="layui-form-item">
                    <input name="password" lay-verify="title" autocomplete="off" minlength="6" maxlength="20" placeholder="请输入新密码" class="layui-input password" type="password">
                </div>
                <div class="layui-form-item">
                    <input name="password" lay-verify="title" autocomplete="off" placeholder="请确认新密码" class="layui-input repassword" type="password">
                </div>
                <a href="javascript:;" class="layui-btn register-btn">修改密码</a>
            </div>
            <!-- <div class="layui-tab-item">内容2</div> -->
        </div>
    </div>
    <div class="reg-right right-box fr">
        <p>已有账号：</p>
        <a href="/user/toLogin">立即登录</a>
    </div>
</div>
<script src="<%=basePath%>js/jquery_002.js"></script>
<script src="<%=basePath%>js/forget.js"></script>

</body></html>
