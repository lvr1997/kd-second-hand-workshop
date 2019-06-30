
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
        举报管理
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
              <a><cite>举报管理</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <form class="layui-form x-center" action="/search/searchreport" style="width:500px" type="post">
        <div class="layui-form-pane">
            <div class="layui-form-item">
                <div class="layui-input-inline" style="width:400px">
                    <input type="text" name="keyword"  placeholder="搜索举报信息" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-input-inline" style="width:80px">
                    <input type="submit" lay-submit lay-filter="search" value="搜索" class="layui-input"/>
                </div>
            </div>
        </div>
    </form>
    <div style="height: 30px; background-color: #f2f2f2;line-height: 30px">
        <button class="layui-btn x-right" style="top:3px;" >共有数据：${fn:length(reportResult)} 条</button>
    </div>
    <table class="layui-table">
        <thead>
        <tr>
            <th width="15%">
                举报闲置名称
            </th>
            <th width="13%">
                闲置图片
            </th>
            <th>
                举报内容
            </th>
            <th width="13%">
                举报人
            </th>
            <th width="8%">
                操作
            </th>
        </tr>
        </thead>
        <tbody id="x-img">
        <c:forEach var="item" items="${reportResult}">
            <tr>
                <td>
                    ${item.goods.name}
                </td>
                <td align="center">
                    <c:forEach var="image" items="${item.images}">
                        <img src="<%=basePath%>images/web/${image.imgUrl}" width="100" alt="${item.goods.name}">
                    </c:forEach>

                </td>
                <td >${item.report.content}</td>
                <td>
                    ${item.user.username}
                </td>
                <td class="td-manage">
                    <a title="删除" href="javascript:;" onclick="banner_del(this,${item.report.id})"
                       style="text-decoration:none">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

   <%-- <div id="page"></div>--%>

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


       /* //以上模块根据需要引入
        laypage({
            cont: 'page'
            ,pages: 100
            ,first: 1
            ,last: 100
            ,prev: '<em><</em>'
            ,next: '<em>></em>'
        });
*/
        layer.ready(function(){ //为了layer.ext.js加载完毕再执行
            layer.photos({
                photos: '#x-img'
                //,shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
            });
        });

    });

    /*删除*/
    function banner_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                url:"/admin/delete_report",
                type:"GET",
                data:{
                    id:id
                },
                success:function () {

                }
            })
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1500});
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
