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

        <title>首頁-科大二手工坊</title>
        <script src="<%=basePath%>js/jquery.min.js"></script>
        <script src="<%=basePath%>js/layui.all.js"></script>
        <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
        <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
        <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
        <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

        <link rel="stylesheet" href="<%=basePath%>css/public.css">
        <script src="<%=basePath%>js/common.js"></script>
        <link rel="stylesheet" href="<%=basePath%>css/index.css">
    </head>

    <body>
        <div id="header">
            <div class="header-wrap">
                <%--<a href="/goods/index" class="logo fl">
                    <img src="" alt="">
                    <h1></h1>
                </a>--%>
                <ul class="nav fl">
                    <li><a href="/goods/index">科大二手工坊</a></li>
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
        <div id="header-bottom">
            <div class="header-bottom-wrap clearfix">
                <%--<div class="city fl">
                   <a href="javascript">科大二手工坊<i class="icon"></i></a>
                </div>--%>
                <div class="search-wrap fl">
                    <div class="search">
                        <input type="text" class="keywords" placeholder="请输入关键词">
                        <a href="javascript:;" class="search-btn search-normal-btn">搜索</a>
                    </div>
                </div>
                <div class="publish fr">
                    <a href="/publish/publish" class="publish-btn"><i class="icon"></i>发布 闲置</a>
                </div>
            </div>
        </div>
        <div id="main" class="clearfix">
            <div class="category fl" style="">
                <ul>
                    <c:forEach var="item" items="${Catelog1}">
                        <li>
                            <a href="<%=basePath%>goods/catelog/${item.id}"><c:out value="${item.name}"></c:out><i class="icon"></i></a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="main-box fl" style="margin-left: 0px;">
                <div class="banner">
                    <div class="focusMap fl">
                        <span class="prev" style="display: block;"><i class="icon"></i></span>
                        <span class="next" style="display: block;"><i class="icon"></i></span>
                        <ul class="rImg">
                            <c:forEach var="item" items="${carousel}">
                                <li style="display: list-item;">
                                    <a href="${item.url}" target="_blank">
                                        <img src="<%=basePath%>images/banner/${item.imgUrl}" alt="${item.title}" title="${item.title}"></a>
                                </li>
                            </c:forEach>
                        </ul>

                        <ul class="button">
                            <c:if test="${fn:length(carousel)<=1}">
                                <li class="on"></li>
                            </c:if>
                            <c:if test="${fn:length(carousel)>1}">
                                <c:forEach var="item" items="${carousel}">
                                    <li class=""></li>
                                </c:forEach>
                            </c:if>

                        </ul>

                    </div>
                </div>
                <div class="index-list">
                    <div class="list-header">
                        <a href="/goods/index" class="active">最新</a>
                        <%--<a href="/category/?n=true" class="">推荐</a>--%>
                        <a href="/publish/publish" class="fr"><i class="icon"></i>发布信息</a>
                    </div>
                    <div class="list-body">
                        <ul class="clearfix">
                            <c:forEach var="item" items="${Goods1}">
                                <li>
                                    <a href="<%=basePath%>detail/detail/${item.goods.id}" target="_blank" class="good-image">
                                        <img class="image-show-box" src=<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/web/${item.images[0].imgUrl} />
                                        <img class="image-real-box" src=<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/web/${item.images[0].imgUrl} />
<%--                                        <img class="image-show-box" src="<%=basePath%>images/web/${item.images[0].imgUrl}">--%>
<%--                                        <img class="image-real-box" src="<%=basePath%>images/web/${item.images[0].imgUrl}" alt="<c:out value="${item.goods.name}"></c:out>">--%>
                                    </a>
                                    <a href="<%=basePath%>detail/detail/${item.goods.id}" target="_blank" class="good-title">
                                        <c:out value="${item.goods.name}"></c:out>
                                    </a>
                                    <span class="good-price">￥<c:out value="${item.goods.price}"></c:out></span>
                                    <span class="pub-time fr">更新时间 <c:out value="${item.goods.polishTime}"></c:out></span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <%--分页HTML代码--%>
                    <%--<div id="page">--%>
                        <%--<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-0">--%>
                            <%--<span class="layui-laypage-curr">--%>
                                <%--<em class="layui-laypage-em"></em>--%>
                                <%--<em>1</em>--%>
                            <%--</span>--%>
                           <%--&lt;%&ndash; <a href="javascript:;" data-page="2">2</a>--%>
                            <%--<a href="javascript:;" data-page="3">3</a>--%>
                            <%--<a href="javascript:;" data-page="4">4</a>--%>
                            <%--<a href="javascript:;" data-page="5">5</a>--%>
                            <%--<span>…</span>--%>
                            <%--<a href="javascript:;" class="layui-laypage-last" title="尾页" data-page="7">末页</a>--%>
                            <%--<a href="javascript:;" class="layui-laypage-next" data-page="2">--%>
                                <%--<em>&gt;</em>--%>
                            <%--</a>&ndash;%&gt;--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </div>
            </div>
            <div class="sidebar fr">
                <div class="sidebar-main-right">
                    <a class="sidebar-header" <%--href="/category/quan" target="_blank"--%> >浏览量</a>
                    <ul class="jizhuan-list">
                        <c:forEach var="item" items="${Goods2}">
                            <li>
                                <a href="<%=basePath%>detail/detail/${item.goods.id}" class="jizhuan" target="_blank">
                                    <img class="jizhuan-image" src=<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/web/${item.images[0].imgUrl} />
<%--                                    <img class="jizhuan-image" src="<%=basePath%>images/web/${item.images[0].imgUrl}" alt="<c:out value="${item.goods.name}"></c:out>">--%>
                                    <p class="jizhuan-title"><c:out value="${item.goods.name}"></c:out></p>
                                    <p>
                                        <span class="yhq">￥<c:out value="${item.goods.price}"></c:out></span>
                                        <span class="jizhuan-price">￥<c:out value="${item.goods.realPrice}"></c:out></span>
                                    </p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
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
                        <span>Copyright © 2017-2018, kd-second-hand-workshop, All Rights Reserved</span>　
                    </p>
                </div>
            </div>
        </div>
        <script src="<%=basePath%>js/index.js"></script>
        <div class="layui-layer-move"></div>
    </body>
</html>
