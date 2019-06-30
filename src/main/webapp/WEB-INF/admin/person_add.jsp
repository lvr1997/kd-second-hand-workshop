
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
        添加用户
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
<div class="x-body">
    <form class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <label for="name" class="layui-form-label">
                用户名
            </label>
            <div class="layui-input-block">
                <input type="text" id="name" name="title" required lay-verify="title"
                       autocomplete="off" class="layui-input username">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="password" class="layui-form-label">
                密码
            </label>
            <div class="layui-input-block">
                <input type="text" id="password" name="title" required lay-verify="title"
                       autocomplete="off" class="layui-input password">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">
                手机
            </label>
            <div class="layui-input-block">
                <input type="text" id="phone" name="title" required lay-verify="title"
                       autocomplete="off" class="layui-input phone">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sex" class="layui-form-label">
                性别
            </label>
            <div class="layui-input-block">
                <input type="text" id="sex" name="title" required lay-verify="title"
                       autocomplete="off" class="layui-input sex">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="power" class="layui-form-label">
                权限
            </label>
            <div class="layui-input-block">
                <input type="text" id="power" name="title" required lay-verify="title"
                       autocomplete="off" class="layui-input power">
            </div>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn" lay-filter="add" lay-submit>
                添加用户
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


        layedit.set({
            uploadImage: {
                url: "./upimg.json" //接口url
                ,type: 'post' //默认post
            }
        })

        //创建一个编辑器
        editIndex = layedit.build('L_content');



        //监听提交
        form.on('submit(add)', function(data){
            console.log(data);
            var username = $('.username').val()
            var password = $('.password').val()
            var phone = $('.phone').val()
            var sex = $('.sex').val()
            var power = $('.power').val()
            $.ajax({
                url:"/admin/add_user",
                type:"GET",
                data:{
                    username:username,
                    password:password,
                    phone:phone,
                    sex:sex,
                    power:power
                },
                dataType:"json",
                success:function () {
                    layer.alert("添加成功", {icon: 6},function () {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                    });
                }
            })
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
