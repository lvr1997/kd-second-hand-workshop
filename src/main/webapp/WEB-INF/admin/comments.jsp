
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
<head>
    <meta charset="utf-8">
    <title>
        资源下载
    </title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/common.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/admin/x-admin.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>css/lib/layui/css/layui.css" media="all">
</head>
<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
              <a><cite>首页</cite></a>
              <a><cite>网站信息管理</cite></a>
              <a><cite>留言管理</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="/admin/comments" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
        <form class="layui-form x-center" action="/search/searchcomments" style="width:500px" type="post">
            <div class="layui-form-pane">
                <div class="layui-form-item">
                    <div class="layui-input-inline" style="width:400px">
                        <input type="text" name="keyword"  placeholder="搜索内容" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline" style="width:80px">
                        <input type="submit" lay-submit lay-filter="search" value="搜索" class="layui-input"/>
                    </div>
                </div>
            </div>
        </form>

        <div style="height: 30px; background-color: #f2f2f2;line-height: 30px">
            <button class="layui-btn x-right" style="top:3px;" >共有数据：${fn:length(commentsResult)} 条</button>
        </div>
        <table class="layui-table">
            <thead>
            <tr>
                <th width="15%">闲置名称</th>
                <th>用户名</th>
                <th width="10%">发表时间</th>
                <th>留言内容</th>
                <th width="8%">操作</th>
            </tr>
            </thead>
            <tbody id="x-img">
            <c:forEach var="item" items="${commentsResult}">
                <tr>
                    <td>${item.goods.name}</td>
                    <td>${item.user.username}</td>
                    <td>${item.comments.createAt}</td>
                    <td>${item.comments.content}</td>
                    <td class="td-manage">
                        <a title="删除" href="javascript:;" onclick="banner_del(this,${item.comments.id})"
                           style="text-decoration:none">
                            <i class="layui-icon">&#xe640;</i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<br /><br /><br />
<script src="<%=basePath%>css/lib/layui/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/admin/x-layui.js" charset="utf-8"></script>
<script>
    layui.use(['laydate','element','laypage','layer'], function(){
        $ = layui.jquery;//jquery
        laydate = layui.laydate;//日期插件
        lement = layui.element();//面包导航
        laypage = layui.laypage;//分页
        layer = layui.layer;//弹出层


        //以上模块根据需要引入
        /*laypage({
            cont: 'page'
            ,pages: 100
            ,first: 1
            ,last: 100
            ,prev: '<em><</em>'
            ,next: '<em>></em>'
        });*/

    });

    /*删除*/
    function banner_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                url:"/admin/delete_comments",
                type:"GET",
                data:{
                    id:id
                },
                success:function () {

                }
            })
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
            location.replace(location.href);
        });
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
