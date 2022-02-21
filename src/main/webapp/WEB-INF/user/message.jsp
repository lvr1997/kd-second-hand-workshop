
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>我的消息-科大二手工坊</title>
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
                <%--<a href="/goods/index" class="logo fl">
                    <img src="" alt="">
                    <h1>科大二手工坊 大学生二手网</h1>
                </a>--%>
                <ul class="nav fl">
                    <li><a href="/goods/index">科大二手工坊</a></li>
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
                        <li><a href="/user/want" class=""><i class="icon"></i>我想要的</a></li>
                        <li><a href="/user/message" class="active"><i class="icon"></i>我的留言</a></li>
                        <li><a href="/user/userinfo" class=""><i class="icon"></i>个人信息</a></li>
                        <li><a href="/user/address" class=""><i class="icon"></i>地址管理</a></li>
                        <li><a href="/user/order" class=""><i class="icon"></i>订单管理</a></li>
                        <%--<li><a href="/user/auth" class=""><i class="icon"></i>实名认证</a></li>--%>
                        <li><a href="/user/help" class=""><i class="icon"></i>意见反馈</a></li>
                    </ul>
                </div>
            </div>
            <div class="user-main message-main fr">
                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                    <ul class="layui-tab-title">
                        <li class="layui-this">收到的留言</li>
                        <li>发布的留言</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <ul class="comment-list">
                               <%-- <c:if test="${empty comments}">
                                     <div class="nodata">您还没有收到过留言</div>
                                </c:if>
                                <c:if test="${!empty comments}">
                                    <c:forEach var="item" items="${comments}">
                                        <li>
                                            <p><b>我</b> 评论 <a href="<%=basePath%>detail/detail/${item.comments.goodsId}" target="_blank" title="${item.goods.name} ">  ${item.goods.name}  </a>：
                                                <span class="fr">发布于： <c:out value="${item.comments.createAt}"></c:out> </span>
                                            </p>
                                            <p>${item.comments.content}</p>
                                        </li>
                                    </c:forEach>
                                </c:if>--%>
                            </ul>
                            <div id="page1"></div>
                        </div>
                        <div class="layui-tab-item">
                            <ul class="published-comment-list">
                               <%-- <c:if test="${empty reply}">
                                    <div class="nodata">您还没有发布过留言</div>
                                </c:if>
                                <c:if test="${!empty reply}">
                                    <c:forEach var="item" items="${reply}">
                                       <li>
                                           <p><b>${item.user.username}</b> 评论 <a href="<%=basePath%>detail/detail/${item.comments.goodsId}" target="_blank" title="${item.goods.name}"> <c:out value="${item.goods.name}"></c:out> </a>：
                                               <span class="fr">发布于： <c:out value="${item.comments.createAt}"></c:out> </span>
                                           </p>
                                           <p> ${item.comments.content} </p>
                                       </li>
                                    </c:forEach>
                                </c:if>--%>
                            </ul>
                            <div id="page2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer">
            <div class="go-to-top" style="display: none; left: 1310px;">
                <a href="/user/message#" title="回顶部" class="icon"></a>
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
        <script src="<%=basePath%>js/message.js"></script>
    </body>
</html>
