
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
        用户权限修改
    </title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/admin/x-admin.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>css/lib/layui/css/layui.css" media="all">
</head>

<body>
<div class="x-body">
    <form class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <label for="L_title" class="layui-form-label1">
                <span style="font-size: 24px; color: #00F; text-align:center">修改用户权限</span>
            </label>

        </div>

        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                用户名
            </label>
            <div class="layui-input-block">
                <input type="text" id="username" name="usernmae" readonly required lay-verify="title" value="${user.username}"
                       autocomplete="off" class="layui-input username">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="uid" class="layui-form-label">
               唯一标识
            </label>
            <div class="layui-input-block">
                <input type="text" id="uid" name="uid" readonly required lay-verify="title" value=" ${user.id}"
                       autocomplete="off" class="layui-input uid">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">
                手机号
            </label>
            <div class="layui-input-block">
                <input type="text" id="phone" name="phone" readonly required lay-verify="title" value="${user.phone}"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="power" class="layui-form-label">
                权限
            </label>
            <div class="layui-input-block">
                <input type="number" id="power" name="power" min="0" max="100" required lay-verify="title" value="${user.power}"
                       autocomplete="off" class="layui-input power">
            </div>
        </div>

        <div class="layui-form-item">
            <button class="layui-btn" lay-filter="add" lay-submit>
                保存
            </button>
        </div>
    </form>
</div>
<script src="<%=basePath%>css/lib/layui/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/admin/x-layui.js" charset="utf-8"></script>
<script>
    layui.use(['form','layer','layedit'], function(){
        $ = layui.jquery;
        var form = layui.form()
            ,layer = layui.layer
            ,layedit = layui.layedit;

        //监听提交
        form.on('submit(add)', function(data){
            console.log(data);
            var id = $('.uid').val()
            var power = $('.power').val()
            $.ajax({
                url:"/admin/save_user",
                type:"GET",
                data:{
                    id:id,
                    power:power
                },
                dataType:"json",
                success:function (data) {
                }
            })
            layer.alert("保存成功", {icon: 6},function () {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
                //刷新父页面
                parent.location.reload();
            });
            return false;
        });


    });
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
