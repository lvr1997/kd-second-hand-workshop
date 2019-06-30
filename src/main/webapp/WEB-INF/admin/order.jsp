
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
        闲置管理
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
              <a><cite>订单管理</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="/admin/order" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <form class="layui-form x-center" action="/search/searchorder" style="width:500px" type="post">
        <div class="layui-form-pane">
            <div class="layui-form-item">
                <div class="layui-input-inline" style="width:400px">
                    <input type="text" name="keyword"  placeholder="搜索订单" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-input-inline" style="width:80px">
                    <input type="submit" lay-submit lay-filter="search" value="搜索" class="layui-input"/>
                </div>
            </div>
        </div>
    </form>
    <div style="height: 30px; background-color: #f2f2f2;line-height: 30px">
        <button class="layui-btn x-right" style="top:3px;" >共有数据：${fn:length(ordersExtends)} 条</button>
    </div>
    <table class="layui-table">
        <thead>
        <tr>
            <th width="7%">序号</th>
            <th width="8%">订单号</th>
            <th width="8%">支付订单号</th>
            <th width="8%">购买用户</th>
            <th width="10%">闲置名称</th>
            <th width="18%">图片</th>
            <th width="10%">创建时间</th>
            <th>发货地址</th>
            <th width="10%">订单状态</th>
            <%--<th width="7%">操作</th>--%>
        </tr>
        </thead>
        <tbody id="x-img">
        <c:forEach var="item" items="${ordersExtends}">
            <tr>
                <td>${item.orders.id}</td>
                <td>${item.orders.orderId}</td>
                <td>${item.orders.payId}</td>
                <td>${item.user.username}</td>
                <td>${item.good.name}</td>
                <td align="left">
                    <c:forEach var="image" items="${item.images}">
                        <img src="<%=basePath%>images/web/${image.imgUrl}" alt="${item.good.name}" width="56" height="56">
                    </c:forEach>
                </td>
                <td >${item.address.recvDistrict}${item.address.recvAddr}</td>
                <td >${item.orders.createAt}</td>
                <td class="td-status">
                    <c:if test="${item.orders.status eq 1}">
                        <span class="layui-btn layui-btn-normal layui-btn-mini">
                            已发货
                        </span>
                    </c:if>
                    <c:if test="${item.orders.status eq 2}">
                        <span class="layui-btn layui-btn-disabled layui-btn-mini">
                            已签收
                        </span>
                    </c:if>
                </td>
                <%--<td class="td-manage">--%>
                    <%--<c:if test="${item.goods.status eq 1}">--%>
                        <%--<a style="text-decoration:none" onclick="goods_stop(this,${item.goods.id})" href="javascript:;" title="下架">--%>
                            <%--<i class="layui-icon">&#xe601;</i>--%>
                        <%--</a>--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${item.goods.status eq 0}">--%>
                        <%--<a style="text-decoration:none" onclick="goods_start(this,${item.goods.id})" href="javascript:;" title="上架">--%>
                            <%--<i class="layui-icon">&#xe62f;</i>--%>
                        <%--</a>--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${item.goods.status eq 2}">--%>
                        <%--<a style="text-decoration:none" href="javascript:;" title="用户已下架,不可修改">--%>
                            <%--<i class="layui-icon">&#xe62f;</i>--%>
                        <%--</a>--%>
                    <%--</c:if>--%>
                    <%--<a title="删除" href="javascript:;" onclick="goods_del(this,${item.goods.id})"--%>
                       <%--style="text-decoration:none">--%>
                        <%--<i class="layui-icon">&#xe640;</i>--%>
                    <%--</a>--%>
                <%--</td>--%>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <%--<div id="page"></div>--%>
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


        /*//以上模块根据需要引入
        laypage({
            cont: 'page'
            ,pages: 100
            ,first: 1
            ,last: 100
            ,prev: '<em><</em>'
            ,next: '<em>></em>'
        });*/

        layer.ready(function(){ //为了layer.ext.js加载完毕再执行
            layer.photos({
                photos: '#x-img'
                //,shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
            });
        });

    });

    /*停用*/
    function goods_stop(obj,id){
        layer.confirm('确认下架吗？',function(index){
            //发异步把用户状态进行更改
            $.ajax({
                url:"/admin/changeGoodsStatus",
                type:"GET",
                data:{
                    id:id,
                    status:0
                },
                dataType:"json",
                success:function () {

                }
            })
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="banner_start(this,id)" href="javascript:;" title="上架"><i class="layui-icon">&#xe62f;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="layui-btn layui-btn-disabled layui-btn-mini">已下架</span>');
            $(obj).remove();
            layer.msg('已下架!',{icon: 5,time:1000});
            location.replace(location.href);
        });
    }

    /*启用*/
    function goods_start(obj,id){
        layer.confirm('确认要上架吗？',function(index){
            //发异步把用户状态进行更改
            $.ajax({
                url:"/admin/changeGoodsStatus",
                type:"GET",
                data:{
                    id:id,
                    status:1
                },
                dataType:"json",
                success:function () {

                }
            })
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="banner_stop(this,id)" href="javascript:;" title="下架"><i class="layui-icon">&#xe601;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="layui-btn layui-btn-normal layui-btn-mini">已上架</span>');
            $(obj).remove();
            layer.msg('已上架!',{icon: 6,time:1000});
            location.replace(location.href);
        });
    }

    /*删除*/
    function goods_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            //发异步删除数据
            $.ajax({
                url:"/admin/deleteGoods",
                type:"GET",
                data:{
                    id:id
                },
                dataType:"json",
                success:function () {

                }
            })
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1500});
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
