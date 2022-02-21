
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>科大二手工坊——支付页面</title>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui.all.js"></script>
    <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
    <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
    <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <script src="<%=basePath%>js/common.js"></script>
    <script src="<%=basePath%>js/order/distpicker.data.js"></script>
    <script src="<%=basePath%>js/order/distpicker.js"></script>
    <link href="<%=basePath%>css/order/payment.css" rel="Stylesheet" />
</head>
<body>
<!-- 页面顶部-->
<div id="header">
    <div class="header-wrap">
        <%--<a href="/goods/index" class="logo fl">
            <img src="" alt="">
            <h1></h1>
        </a>--%>
        <ul class="nav fl">
            <li><a href="/goods/index">首页</a></li>
        </ul>
        <div class="nav-right fr">
            <c:if test="${!empty cur_user}">
                <a href="/user/index" class="log-btn">
                    <img src="<%=basePath%>images/user/${cur_user.imgUrl}" class="user-header-image">${cur_user.username}</a>
                <a href="/user/logout" class="log-btn">退出</a>
            </c:if>
            <c:if test="${empty cur_user}">
                <a href="/user/toRegister" class="log-btn">注册</a>
                <a href="/user/toLogin" class="log-btn">登录</a>
            </c:if>
        </div>
    </div>
</div>

<div id="navlist">
    <ul>
        <li class="navlist_gray_left"></li>
        <li class="navlist_gray">确认订单信息</li>
        <li class="navlist_gray_arrow"></li>
        <li class="navlist_gray">支付订单<b></b></li>
        <li class="navlist_gray_arrow"></li>
        <li class="navlist_blue">支付结果<b></b></li>
        <li class="navlist_blue_right"></li>
    </ul>
</div>
<div id="container">
    <div>
        <h1><i>支付失败</i>
            <span class="rt">支付订单：123455666677 &nbsp;支付金额：<b>4999.00元</b></span>
        </h1>
    </div>
    <div class="rightsidebar_box rt" >
        <div class="pay_result">
            <img src="<%=basePath%>images/pay/pay_fail.png" alt=""/>
            <p>支付失败</p>
            <span><a href="#">查看订单状态？ </a><b><a href="#">查看订单&gt;&gt;</a></b></span>
            <br/>
            科大二手工坊不会以系统异常、订单升级为由，要求你点击任何链接进行退款操作！
        </div>

    </div>
</div>
<div id="footer">
    <div class="go-to-top" style="left: 1515px; display: none;">
        <a href="#" title="回顶部" class="icon"></a>
    </div>
    <div class="footer-bottom-wrap">
        <div class="footer-bottom">


            <p class="tips">本站所有信息均为用户自由发布，本站不对信息的真实性负任何责任，交易时请注意识别信息的真假如有网站内容侵害了您的权益请联系我们删除</p>
            <p class="right">
                <span>Copyright © 2017-2018,   All Rights Reserved</span>　
            </p>
        </div>
    </div>
</div>

<script src="<%=basePath%>js/jquery.min.js"></script>
<script src="<%=basePath%>js/order/index.js"></script>
</body>
</html>