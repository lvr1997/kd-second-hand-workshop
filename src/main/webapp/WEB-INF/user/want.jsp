
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>我想要的-二手 闲置-科大二手工坊</title>
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
    <div class="header-wrap">
       <%-- <a href="/goods/index" class="logo fl">
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
        </div>
        <div class="sider-nav">
            <ul>
                <li><a href="/user/index" class=""><i class="icon"></i>我发布的</a></li>
                <li><a href="/user/want" class="active"><i class="icon"></i>我想要的</a></li>
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
            <c:if test="${empty wantedList}">
                <div class="no-data">
                    <p>您没有收藏任何 闲置哦~</p>
                </div>
            </c:if>
            <c:if test="${!empty wantedList}">
                <c:forEach var="item" items="${wantedList}">
                    <li>
                        <div class="list-header">
                        <span>时间：${item.wanted.createAt}</span>
                    </div>
                        <div class="list-main clearfix">
                            <a href="" class="goods-images fl"><img src="<%=basePath%>images/web/${item.goodsExtend.images[0].imgUrl}" ></a>
                            <div class="good-info fl">
                                <a href="<%=basePath%>detail/detail/${item.goodsExtend.goods.id}" class="goods-title"><c:out value="${item.goodsExtend.goods.name}"></c:out></a>
                                <p class="goods-price">￥<span><c:out value="${item.goodsExtend.goods.price}"></c:out></span></p>
                            </div>
                            <div class="operation fr">
                                <a href="<%=basePath%>detail/detail/${item.goodsExtend.goods.id}" class="">查看详情</a>
                                <a href="" data-id="${item.goodsExtend.goods.id}" class="delete-want">移除想要</a>
                            </div>
                        </div>
                    </li>
                </c:forEach>
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
        <a href="/user/want#" title="回顶部" class="icon"></a>
    </div>
    <div class="footer-bottom-wrap">
        <div class="footer-bottom">

            <p class="tips">本站所有信息均为用户自由发布，本站不对信息的真实性负任何责任，交易时请注意识别信息的真假如有网站内容侵害了您的权益请联系我们删除</p>

            <p class="right">
                <span>Copyright © 2018-2019, kdmarcket, All Rights Reserved</span>　
            </p>
        </div>
    </div>
</div>
<!-- <script src="/js/web/detail.js"></script> -->
<script>
    $(function(){
        layui.use(['layer', 'laypage'], function(){
            var layer = layui.layer

            layui.laypage({
                cont: 'page', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                pages: 0, //通过后台拿到的总页数
                curr: Common.getQuery('page') || 1, //当前页
                jump: function(obj, first){ //触发分页后的回调
                    if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
                        window.location.href = '/user/want?page=' + obj.curr
                    }
                }
            })

            $('.delete-want').click(function(){
                var url = '/user/collect_delete'
                var Data = {
                    gid: $('.delete-want').attr('data-id')

                }
                Common.ajax(url, Data, function (data) {
                    if(data.success){
                        layer.msg(data.msg)
                        setTimeout(function(){ location.reload() }, 2000)
                    }
                }, function (err) {
                    console.log(err)
                }, function () {}, true, 'POST')
            })
        })
    })
</script>

</body></html>
