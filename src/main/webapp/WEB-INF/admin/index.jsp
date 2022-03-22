
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>
        科大二手工坊-后台数据管理
    </title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/common.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/lib/layui/css/layui.css" media="all">
	<link rel="stylesheet" href="<%=basePath%>css/admin/x-admin.css" media="all">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header header header-demo">
        <div class="layui-main">
            <%--<a class="logo" href="index.jsp">--%>
                <%--<img src="<%=basePath%>images/admin/banner2.png"></img>--%>
            <%--</a>--%>
            <ul class="layui-nav" lay-filter="">
                <li class="layui-nav-item">
                    <img src="<%=basePath%>images/user/${admin.imgUrl}" class="layui-circle" style="border: 2px solid #A9B7B7;" width="35px" alt="">
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">${admin.username}</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="user_look('修改用户信息','/admin/person_look/${admin.id}','${admin.id}','400','400')">个人信息</a></dd>
                        <dd><a href="/admin/toLogin">切换帐号</a></dd>
                        <dd><a href="/admin/logout">退出</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item x-index"><a href="/goods/index">前台首页</a></li>
            </ul>
        </div>
    </div>
    <div class="layui-side layui-bg-black x-side">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree site-demo-nav" lay-filter="side">
                <!--用户管理-->
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="javascript:;" _href="/admin/main">
                        <i class="layui-icon" style="top: 3px;">&#xe62d;</i><cite>用户管理</cite>
                    </a>
                </li>
                <!--网站信息管理-->
                <li class="layui-nav-item">
                    <a class="javascript:;" href="javascript:;">
                        <i class="layui-icon" style="top: 3px;">&#xe629;</i><cite>网站信息管理</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd class="">
                        <dd class="">
                            <a href="javascript:;" _href="/admin/Home">
                                <i class="layui-icon"></i><cite>首页轮播图</cite>
                            </a>
                        </dd>
                        </dd>
                        <dd class="">
                        <dd class="">
                            <a href="javascript:;" _href="/admin/good">
                                <i class="layui-icon"></i><cite>闲置管理</cite>
                            </a>
                        </dd>
                        </dd>
                        <dd class="">
                        <dd class="">
                            <a href="javascript:;" _href="/admin/catelog">
                                <i class="layui-icon"></i><cite>分类管理</cite>
                            </a>
                        </dd>
                        </dd>
                        <dd class="">
                        <dd class="">
                            <a href="javascript:;" _href="/admin/report">
                                <i class="layui-icon"></i><cite>举报管理</cite>
                            </a>
                        </dd>
                        <dd class="">
                            <a href="javascript:;" _href="/admin/comments">
                                <i class="layui-icon"></i><cite>留言管理</cite>
                            </a>
                        </dd>
                        <dd class="">
                            <a href="javascript:;" _href="/admin/order">
                                <i class="layui-icon"></i><cite>订单管理</cite>
                            </a>
                        </dd>
                        </dd>
                    </dl>
                </li>
            </ul>
        </div>

    </div>
    <div class="layui-tab layui-tab-card site-demo-title x-main" lay-filter="x-tab" lay-allowclose="true">
        <div class="x-slide_left"></div>
        <ul class="layui-tab-title">
            <li class="layui-this">用户管理
                <i class="layui-icon layui-unselect layui-tab-close">ဆ</i>
            </li>
        </ul>
        <div class="layui-tab-content site-demo site-demo-body">
            <div class="layui-tab-item layui-show">
                <iframe frameborder="0" src="/admin/main" class="x-iframe"></iframe>
            </div>
        </div>
    </div>
    <div class="site-mobile-shade">
    </div>
</div>
<script src="<%=basePath%>css/lib/layui/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/admin/x-admin.js"></script>
<script src="<%=basePath%>js/admin/x-layui.js" charset="utf-8"></script>
<script>
    //查看
    function user_look (title,url,id,w,h) {
        x_admin_show(title,url,w,h);
    }

</script>
<script>


    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</body>
</html>
