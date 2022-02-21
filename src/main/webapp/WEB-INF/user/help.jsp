
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>意见反馈-科大二手工坊</title>
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
            <!--a id="topbanner" href="https://s.click.taobao.com/8gaPEZw" target="_blank">
                <img src="/images/activity/topbanner.png">
            </a-->
            <div class="header-wrap">
                <%--<a href="/goods/index" class="logo fl">
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
                        <li><a href="/user/want" class=""><i class="icon"></i>我想要的</a></li>
                        <li><a href="/user/message" class=""><i class="icon"></i>我的留言</a></li>
                        <li><a href="/user/userinfo" class=""><i class="icon"></i>个人信息</a></li>
                        <li><a href="/user/address" class=""><i class="icon"></i>地址管理</a></li>
                        <li><a href="/user/order" class=""><i class="icon"></i>订单管理</a></li>
                        <%--<li><a href="/user/auth" class=""><i class="icon"></i>实名认证</a></li>--%>
                        <li><a href="/user/help" class="active"><i class="icon"></i>意见反馈</a></li>
                    </ul>
                </div>
            </div>
            <div class="user-main fr">
                <div class="feedback">
                    <h1>意见反馈</h1>
                    <div class="feedback-content">
                        <textarea placeholder="欢迎提出任何疑问与建议"></textarea>
                        <a href="javascript:;" class="layui-btn feedback-submit">提交</a>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer">

            <div class="go-to-top" style="display: none; left: 1310px;">
                <a href="/user/help#" title="回顶部" class="icon"></a>
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
        <script>
            $(function(){
                layui.use(['layer'], function () {
                    var layer = layui.layer
                    $('.feedback-submit').click(function(){
                        if($(".feedback-content textarea").val() == '' || $(".feedback-content textarea").val() == undefined){
                            $(".feedback-content textarea").focus()
                            return layer.msg('请输入反馈内容！')
                        }

                        var url = '/user/feedback'
                        var Data = {
                            content: $(".feedback-content textarea").val()
                        }
                        Common.ajax(url, Data, function (data) {
                            if(data.success){
                                layer.msg(data.msg)
                                setTimeout(function(){
                                    location.reload()
                                }, 1500)
                            }else{
                                layer.msg(data.msg)
                            }
                        }, function (err) {
                            console.log(err)
                        }, function (){}, true, 'POST')
                    })
                })
            })
        </script>

    </body>
</html>
