
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${catelog.name}-科大二手工坊-大学生二手网</title>
        <script src="<%=basePath%>js/jquery.min.js"></script>
        <script src="<%=basePath%>js/layui.all.js"></script>
        <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
        <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
        <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
        <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

        <link rel="stylesheet" href="<%=basePath%>css/public.css">
        <script src="<%=basePath%>js/common.js"></script>
        <link rel="stylesheet" href="<%=basePath%>css/category_list.css">
    </head>
    <body>
    <div id="header">
        <div class="header-wrap">
            <%--<a href="#" class="logo fl">
                <img src="" alt="">
                <h1>科大二手工坊 大学生二手网</h1>
            </a>--%>
            <ul class="nav fl">
                <li><a href="<%=basePath%>goods/index">科大二手工坊</a></li>
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
            <div class="city fl">
                <a href="javascript:;">全球<i class="icon"></i></a>
            </div>
            <div class="search-wrap fl">
                <div class="search">
                    <input type="text" class="keywords" placeholder="请输入关键词">
                    <a href="javascript:;" class="search-btn search-normal-btn">搜索</a>
                </div>
            </div>
            <div class="publish fr">
                <a href="/publish/publish" class="publish-btn"><i class="icon"></i>发布闲置</a>
            </div>
        </div>
    </div>
    <div id="main" class="clearfix">
        <div class="cate-name-list">
            <!-- <span>分类：</span> -->
            <%--<a class="" href="/category/category_list/0">全部分类</a>--%>

            <c:forEach var="item" items="${catelogs}">
                <c:if test="${catelog.id eq item.id}">
                    <a class="active" href="<%=basePath%>goods/catelog/${item.id}">${item.name}</a>
                </c:if>
                <c:if test="${item.id ne catelog.id}">
                    <a class="" href="<%=basePath%>goods/catelog/${item.id}">${item.name}</a>
                </c:if>
            </c:forEach>

        </div>
        <div class="list-body">
            <ul class="clearfix">
                <c:forEach var="item" items="${goodsExtendList}">
                    <li>
                        <a href="<%=basePath%>detail/detail/${item.goods.id}" class="good-image" target="_blank">
                            <img src="<%=basePath%>images/web/${item.images[0].imgUrl}" alt="<c:out value="${item.goods.name}"></c:out>">
                        </a>
                        <a href="<%=basePath%>detail/detail/${item.goods.id}" class="good-title" target="_blank"><c:out value="${item.goods.name}"></c:out></a>
                        <span class="good-price">￥<c:out value="${item.goods.price}"></c:out></span>
                    </li>
                </c:forEach>
            </ul>
            <%--<div id="page"><div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-0"><span class="layui-laypage-curr"><em class="layui-laypage-em"></em><em>1</em></span><a href="javascript:;" data-page="2">2</a><a href="javascript:;" class="layui-laypage-next" data-page="2">下一页</a></div></div>--%>
        </div>
    </div>
    <div id="footer">

        <div class="go-to-top" style="display: none; left: 1310px;">
            <a href="#" title="回顶部" class="icon"></a>
        </div>
        <div class="footer-bottom-wrap">
            <div class="footer-bottom">
                <p class="tips">本站所有信息均为用户自由发布，本站不对信息的真实性负任何责任，交易时请注意识别信息的真假如有网站内容侵害了您的权益请联系我们删除</p>
                <p class="right">
                    <span>Copyright © 2017-2018, All Rights Reserved</span>　
                </p>
            </div>
        </div>
    </div>
    <script>
        $(function(){
            layui.use(['layer', 'laypage'], function(){
                var layer = layui.layer
                var idArr = location.pathname.split("/")
                layui.laypage({
                    cont: 'page', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                    pages: 2, //通过后台拿到的总页数
                    curr: Common.getQuery('page') || 1, //当前页
                    jump: function(obj, first){ //触发分页后的回调
                        if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
                            window.location.href = '/categlog/' + idArr[idArr.length - 1] + '?page=' + obj.curr
                        }
                    }
                })
            })
        })
    </script>

    </body>
</html>
