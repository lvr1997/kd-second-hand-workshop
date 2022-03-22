
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
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>“${keywords}”-搜索结果-科大二手工坊</title>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui.all.js"></script>
    <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
    <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
    <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <script src="<%=basePath%>js/common.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/search.css">
</head>

<body>
<div id="header">
    <div class="header-wrap">
        <%--<a href="http://www.taoertao.com/" class="logo fl">
            <img src="" alt="">
            <h1>科大二手工坊 大学生二手网</h1>
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
                <a href="/user/login" class="log-btn">登录</a>
            </c:if>

        </div>
    </div>
</div>
<div id="header-bottom">
    <div class="header-bottom-wrap clearfix">
        <div class="city fl">
            <a href="javascript:;">全球<i class="icon"></i></a>
        </div>
        <div class="search-wrap fl">
            <div class="search">
                <input type="text" class="keywords" placeholder="请输入关键词" value="${keywords}">
                <a href="javascript:;" class="search-btn search-page-btn">搜索</a>
            </div>
        </div>
        <div class="publish fr">
            <a href="/publish/publish" class="publish-btn"><i class="icon"></i>发布闲置</a>
        </div>
    </div>
</div>
<div id="main" class="clearfix">
    <div class="count">科大二手工坊 为您找到相关结果 ${fn:length(goodsExtendList)} 个</div>
    <ul class="result-list">
        <c:forEach var="item" items="${goodsExtendList}">
            <li>
                <a href="<%=basePath%>detail/detail/${item.goods.id}" class="good-image" target="_blank">
                    <img src="<%=basePath%>images/web/${item.images[0].imgUrl}" alt="<c:out value="${item.goods.name}"></c:out>">
                </a>
                <a href="<%=basePath%>detail/detail/${item.goods.id}" class="good-title" target="_blank"><c:out value="${item.goods.name}"></c:out></a>
                <span class="good-price"><c:out value="${item.goods.price}"></c:out></span>
            </li>
        </c:forEach>
    </ul>
    <%--<div id="page"></div>--%>
</div>
<div id="footer">
    <div class="go-to-top" style="left: 1373px; display: none;">
        <a href="#" title="回顶部" class="icon"></a>
    </div>
    <div class="footer-bottom-wrap">
        <div class="footer-bottom">
            <p class="tips">本站所有信息均为用户自由发布，本站不对信息的真实性负任何责任，交易时请注意识别信息的真假如有网站内容侵害了您的权益请联系我们删除</p>
            <p class="right">
                <span>Copyright © 2017-2018, Taoertao.com, All Rights Reserved</span>　
            </p>
        </div>
    </div>
</div>
<script>
    var count = 1
</script>
<script src="<%=basePath%>js/search.js"></script>


</body></html>
