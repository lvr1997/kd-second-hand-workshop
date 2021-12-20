
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
        首页轮播图-编辑
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
    <form class="layui-form">
        <div class="layui-form-item">

            <label for="title" class="layui-form-label">
                <span class="x-red">*</span>标题
            </label>
            <div class="layui-input-inline">
                <input type="text" id="title" name="title" required lay-verify="required"
                       autocomplete="off" class="layui-input title" data-cid="${carouselResult.id}" value="${carouselResult.title}">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="image" class="layui-form-label">
                <span class="x-red">*</span>添加图片</label>
            <div class="layui-input-inline">
                <div class="site-demo-upbar">
                    <input type="file" id="image" name="avatar" class="layui-upload-file change-picture" >
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">图片
            </label>
            <img id="LAY_demo_upload" width="200" src="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/banner/${carouselResult.imgUrl}">
        </div>

        <div class="layui-form-item">
            <label for="link" class="layui-form-label">
                <span class="x-red">*</span>轮播图点击链接
            </label>
            <div class="layui-input-inline">
                <input type="url" id="link" name="link" required lay-verify="required"
                       autocomplete="off" class="layui-input link">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="L_content" class="layui-form-label">
                <span class="x-red">*</span>文字信息
            </label>
            <div class="layui-input-inline">
                        <textarea id="L_content" name="content"
                                  placeholder="简介" class="layui-textarea fly-editor content" style="height: 260px;">${carouselResult.descript}</textarea>
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
            </label>
            <button  id="L_repass" class="layui-btn" lay-filter="add" lay-submit="">
                完成
            </button>
        </div>
    </form>
</div>
<script src="<%=basePath%>css/lib/layui/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/admin/x-layui.js" charset="utf-8"></script>
<script>
    layui.use(['form','layer','upload'], function(){
        $ = layui.jquery;
        var form = layui.form()
            ,layer = layui.layer;


        //图片上传接口
        layui.upload({
            url: '/admin/fileUpload', //上传接口
            elem: '.change-picture', //指定原始元素，默认直接查找class="layui-upload-file"
            method: 'post' //上传接口的http类型
            ,success: function(res){ //上传成功后的回调
                console.log(res);
                $('#LAY_demo_upload').attr('src','<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/banner/'+res.src);
            }
        });


        //监听提交
        form.on('submit(add)', function(){
            //发异步，把数据提交
            $.ajax({
                url:"/admin/save_carousel",
                type:"POST",
                data:{
                    id:$('#title').attr('data-cid'),
                    title:$('.title').val(),
                    imgUrl:$('#LAY_demo_upload').attr('src'),
                    link:$('.link').val(),
                    content:$('.content').val()
                },
                dataType:"json",
                success:function () {

                }
            })
            layer.alert("修改成功", {icon: 6},function () {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
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