
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
        分类管理
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
              <a><cite>分类管理</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="/admin/catelog" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <form class="layui-form x-center" action="/search/searchcatelog" style="width:500px" type="post">
        <div class="layui-form-pane">
            <div class="layui-form-item">
                <div class="layui-input-inline" style="width:400px">
                    <input type="text" name="keyword"  placeholder="搜索分类" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-input-inline" style="width:80px">
                    <input type="submit" lay-submit lay-filter="search" value="搜索" class="layui-input"/>
                </div>
            </div>
        </div>
    </form>
    <xblock><button class="layui-btn" onclick="catelog_add('添加分类','/admin/catelog_add','600','200')"><i class="layui-icon">&#xe608;</i>添加</button>
        <button class="x-right layui-btn" style="line-height:25px">共有数据：${fn:length(catelogResult)} 条</button></xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th width="20%">
                ID
            </th>
            <th width="25%">
                名称
            </th>
            <th width="20%">
                闲置数量
            </th>
            <th width="15%">
                显示状态
            </th>
            <th width="15%">
                操作
            </th>
        </tr>
        </thead>
        <tbody id="x-img">
        <c:forEach var="item" items="${catelogResult}">
            <tr>
                <td>
                    ${item.id}
                </td>
                <td>
                    ${item.name}
                </td>
                <td>
                    ${item.number}
                </td>
                <td class="td-status">
                    <c:if test="${item.status eq 1}">
                        <span class="layui-btn layui-btn-normal layui-btn-mini">
                            已显示
                        </span>
                    </c:if>
                    <c:if test="${item.status eq 0}">
                        <span class="layui-btn layui-btn-disabled layui-btn-mini">
                            不显示
                        </span>
                    </c:if>
                </td>
                <td class="td-manage">
                    <c:if test="${item.status eq 1}">
                        <a style="text-decoration:none" onclick="catelog_stop(this,${item.id})" href="javascript:;" title="不显示">
                            <i class="layui-icon">&#xe601;</i>
                        </a>
                    </c:if>
                    <c:if test="${item.status eq 0}">
                        <a style="text-decoration:none" onclick="catelog_start(this,${item.id})" href="javascript:;" title="显示">
                            <i class="layui-icon">&#xe62f;</i>
                        </a>
                    </c:if>
                    <a title="修改" href="javascript:;" onclick="catelog_edit('修改','/admin/catelog_edit/${item.id}',${item.id},'600','200')"
                       class="ml-5" style="text-decoration:none">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" href="javascript:;" onclick="catelog_del(this,${item.id})"
                       style="text-decoration:none">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div id="page"></div>

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


    /*    //以上模块根据需要引入
        laypage({
            cont: 'page'
            ,pages: 100
            ,first: 1
            ,last: 100
            ,prev: '<em><</em>'
            ,next: '<em>></em>'
        });

        layer.ready(function(){ //为了layer.ext.js加载完毕再执行
            layer.photos({
                photos: '#x-img'
                //,shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
            });
        });*/

    });


    /*添加*/
    function catelog_add(title,url,w,h){
        x_admin_show(title,url,w,h);
    }
    /*停用*/
    function catelog_stop(obj,id){
        layer.confirm('确认不显示吗？',function(index){
            $.ajax({
                url:"/admin/change_status",
                type:"GET",
                data:{
                    id:id,
                    status:0
                },
                dataType:"json",
                success:function () {
                    location.replace(location.href);
                }
            })
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="banner_start(this,id)" href="javascript:;" title="显示"><i class="layui-icon">&#xe62f;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="layui-btn layui-btn-disabled layui-btn-mini">不显示</span>');
            $(obj).remove();
            layer.msg('不显示!',{icon: 5,time:1000});
            location.replace(location.href);
        });
    }

    /*启用*/
    function catelog_start(obj,id){
        layer.confirm('确认要显示吗？',function(index){
            $.ajax({
                url:"/admin/change_status",
                type:"GET",
                data:{
                    id:id,
                    status:1
                },
                dataType:"json",
                success:function () {
                    location.replace(location.href);
                }
            })
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="banner_stop(this,id)" href="javascript:;" title="不显示"><i class="layui-icon">&#xe601;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="layui-btn layui-btn-normal layui-btn-mini">已显示</span>');
            $(obj).remove();
            layer.msg('已显示!',{icon: 6,time:1000});
            location.replace(location.href);
        });
    }
    // 编辑
    function catelog_edit (title,url,id,w,h) {
        x_admin_show(title,url,w,h);
    }
    /*删除*/
    function catelog_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                url:"/admin/delete_catelog",
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
