<%--
  Created by IntelliJ IDEA.
  User: LR
  Date: 0008 2018 03 08
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
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

    <title>个人中心-科大二手工坊-大学生二手网</title>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui.all.js"></script>
    <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
    <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
    <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <script src="<%=basePath%>js/common.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/user.css">
</head>
<body>
<div id="header">
    <!--a id="topbanner" href="https://s.click.taobao.com/8gaPEZw" target="_blank">
        <img src="/images/activity/topbanner.png">
    </a-->
    <div class="header-wrap">
        <%--<a href="/goods/index" class="logo fl">
            <img src="" alt="">
            <h1>科大二手工坊 大学生二手网</h1>
        </a>--%>
        <ul class="nav fl">
            <li><a href="/goods/index">首页</a></li>
        </ul>
        <div class="nav-right fr">
            <c:if test="${!empty cur_user}">
                <a href="/user/index" class="log-btn"><img src="<%=basePath%>images/user/${cur_user.imgUrl}" class="user-header-image">${cur_user.username}</a>
                <a href="/user/logout" class="log-btn">退出</a>
            </c:if>
        </div>
    </div>
</div>
<div id="main" class="clearfix">
    <div class="user-sider fl">
        <div class="user-info">
            <img src="<%=basePath%>images/user/${cur_user.imgUrl}" class="user-header">
            <a href="/user/userinfo" class="username">${cur_user.username}</a>
            <%--<div class="auth">--%>
                <%--<a class="realname-auth" href="/user/auth"><i class="icon" title="未实名认证"></i></a>--%>
                <%--<a class="phone-auth" href="/user/auth"><i class="icon" style="color:#f40;" title="已绑定手机"></i></a>--%>
                <%--<a class="email-auth" href="/user/auth"><i class="icon" title="未绑定邮箱"></i></a>--%>
            <%--</div>--%>
            <span>累计收入：<c:out value="${income}"></c:out></span><br>
            <span>累计支出：<c:out value="${spend}"></c:out></span>
        </div>
        <div class="sider-nav">
            <ul>
                <li><a href="/user/index" class="active"><i class="icon"></i>我发布的</a></li>
                <li><a href="/user/want" class=""><i class="icon"></i>我想要的</a></li>
                <li><a href="/user/message" class=""><i class="icon"></i>我的留言</a></li>
                <li><a href="/user/userinfo" class=""><i class="icon"></i>个人信息</a></li>
                <li><a href="/user/address" class=""><i class="icon"></i>地址管理</a></li>
                <li><a href="/user/order" class=""><i class="icon"></i>订单管理</a></li>
                <%--<li><a href="/user/auth" class=""><i class="icon"></i>实名认证</a></li>--%>
                <li><a href="/user/help" class=""><i class="icon"></i>意见反馈</a></li>
            </ul>
        </div>
    </div>
    <div class="user-main fr">
        <ul>
            <c:if test="${fn:length(goodsAndImage)>=1}">
                <c:forEach var="item" items="${goodsAndImage}">
                    <li>
                        <div class="list-header">
                            <span>发布时间：<c:out value="${item.goods.startTime}"></c:out></span>
                        </div>
                        <div class="list-main clearfix">
                            <a href="#" class="goods-images fl">
                                <img src=<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>/images/web/${item.images[0].imgUrl} />
                            </a>
                            <div class="good-info fl">
                                <p href="#" class="goods-title"><c:out value="${item.goods.name}"></c:out></p>
                                <p class="goods-price">￥<span><c:out value="${item.goods.price}"></c:out></span></p>
                            </div>
                            <div class="operation fr">
                                <a class="reflash" data-gid="${item.goods.id}">擦亮</a>
                                <c:if test="${item.goods.status==1}">
                                    <a class="delete" data-gid="${item.goods.id}">下架</a>
                                </c:if>
                                <c:if test="${item.goods.status==2}">
                                    <a>已下架</a>
                                </c:if>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </c:if>
            <c:if test="${fn:length(goodsAndImage)<1}">
                <div class="no-data">
                    <p>您没有发布任何物品哦~</p>
                </div>
            </c:if>

        </ul>
        <div id="page"></div>
    </div>
</div>
<div id="footer">
    <!-- <div class="footer-top-wrap">
        <div class="footer-top"></div>
    </div> -->
    <div class="go-to-top" style="display: none; left: 1310px;">
        <a href="/user/index#" title="回顶部" class="icon"></a>
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
<script src="<%=basePath%>js/user_index.js"></script>

</body></html>