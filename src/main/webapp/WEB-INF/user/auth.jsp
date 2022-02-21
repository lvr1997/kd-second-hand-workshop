
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
        <title>实名认证-科大二手工坊</title>
        <script src="<%=basePath%>js/jquery.min.js"></script>
        <script src="<%=basePath%>js/layui.all.js"></script>
        <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
        <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
        <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
        <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

        <link rel="stylesheet" type="text/css" href="<%=basePath%>css/public.css">
        <script src="<%=basePath%>js/common.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>css/user.css">
        <style type="text/css">
        </style>
    </head>
    <body>
        <div id="header">
            <div class="header-wrap">
               <%-- <a href="/" class="logo fl">
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
                    <%--<div class="auth">
                        <a class="realname-auth" href="/user/auth"><i class="icon"  title="未实名认证"></i></a>
                        <a class="phone-auth" href="/user/auth"><i class="icon" style="color:#f40;" title="已绑定手机"></i></a>
                        <a class="email-auth" href="/user/auth"><i class="icon" title="未绑定邮箱"></i></a>
                    </div>--%>
                </div>
                <div class="sider-nav">
                    <ul>
                        <li><a href="/user/index" class=""><i class="icon"></i>我发布的</a></li>
                        <li><a href="/user/want" class=""><i class="icon"></i>我想要的</a></li>
                        <li><a href="/user/message" class=""><i class="icon"></i>我的留言</a></li>
                        <li><a href="/user/userinfo" class=""><i class="icon"></i>个人信息</a></li>
                        <%--<li><a href="/user/auth" class="active"><i class="icon"></i>实名认证</a></li>--%>
                        <li><a href="/user/help" class=""><i class="icon"></i>意见反馈</a></li>
                    </ul>
                </div>
            </div>

            <div class="user-main auth-wrap fr">
                <div class="user-real-name auth-line clearfix">
                    <div class="auth-items parameter">真实姓名</div>
                    <div class="auth-items parameter-values">
                        <i class="layui-icon"></i>
                    </div>
                    <div class="auth-items operate"><a href="javascript:;">认证</a></div>
                    <div class="input-area">

                        <div class="auth-done"><i class="layui-icon"></i>	未认证</div>

                    </div>
                </div>
                <div class="user-real-name auth-line clearfix">
                    <div class="auth-items parameter">手机号</div>
                    <div class="auth-items parameter-values">
                        136****1037<i class="layui-icon"></i>
                    </div>
                    <div class="auth-items operate">
                        <a href="javascript:;">修改</a>

                    </div>
                    <div class="input-area">
                        <div class="layui-form-item">
                            <label class="layui-form-label">登录密码：</label>
                            <div class="layui-input-inline">
                                <input type="password" name="pwd" required="" lay-verify="required" placeholder="请输入登录密码" autocomplete="off" class="layui-input pwd">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">手机号：</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone_number" required="" lay-verify="required" placeholder="请输入手机号" autocomplete="off" class="layui-input phone_number">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">验证码：</label>
                            <div class="layui-input-inline">
                                <input type="text" name="verify" required="" lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input verify">
                            </div>
                            <a href="javascript:;" class="layui-btn layui-btn-normal phone-verify-submit">获取验证码</a>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"></label>
                            <div class="layui-input-inline">
                                <a href="javascript:;" class="layui-btn layui-btn-normal phone-submit">提交</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="user-real-name auth-line clearfix">
                    <div class="auth-items parameter">邮箱</div>
                    <div class="auth-items parameter-values">
                        未绑定
                    </div>
                    <div class="auth-items operate">
                        <a href="javascript:;">绑定</a>

                    </div>
                    <div class="input-area">
                        <div class="layui-form-item">
                            <label class="layui-form-label">登录密码：</label>
                            <div class="layui-input-inline">
                                <input type="password" name="password" required="" lay-verify="required" placeholder="请输入登录密码" autocomplete="off" class="layui-input password">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱：</label>
                            <div class="layui-input-inline">
                                <input type="text" name="email" required="" lay-verify="required" placeholder="请输入邮箱" autocomplete="off" class="layui-input email" value="">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"></label>
                            <div class="layui-input-inline">
                                <a href="javascript:;" class="layui-btn layui-btn-normal email-submit">发送验证邮件</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer">ss
            <div class="go-to-top" style="display: none; left: 1293.5px;">
                <a href="/user/auth#" title="回顶部" class="icon"></a>
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

        <script src="<%=basePath%>js/jquery.md5.js"></script>
        <script>var a = 0,b = 0, c = 0;</script>
        <script type="text/javascript" src="<%=basePath%>js/auth.js"></script>

        <div class="layui-layer-move"></div>
    </body>
</html>
