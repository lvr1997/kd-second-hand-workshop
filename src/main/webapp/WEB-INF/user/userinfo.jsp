
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>个人资料-科大二手工坊</title>
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
                        <a href="/user/index" class="log-btn">
                            <img src="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/user/${cur_user.imgUrl}" class="user-header-image">
                                ${cur_user.username}</a>
                        <a href="/user/logout" class="log-btn">退出</a>
                    </c:if>
                </div>
            </div>
        </div>
        <div id="main" class="clearfix">
            <div class="user-sider fl">
                <div class="user-info">
                    <img src="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/user/${cur_user.imgUrl}" class="user-header">
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
                        <li><a href="/user/userinfo" class="active"><i class="icon"></i>个人信息</a></li>
                        <li><a href="/user/address" class=""><i class="icon"></i>地址管理</a></li>
                        <li><a href="/user/order" class=""><i class="icon"></i>订单管理</a></li>
                        <%--<li><a href="/user/auth" class=""><i class="icon"></i>实名认证</a></li>--%>
                        <li><a href="/user/help" class=""><i class="icon"></i>意见反馈</a></li>
                    </ul>
                </div>
            </div>
            <div class="user-main userinfo fr" data-uid="${cur_user.id}">
                <div class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label picture-para">头像</label>
                        <div class="layui-input-block">
                            <img src="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/user/${cur_user.imgUrl}" class="user-info-picture">
                            <div class="layui-box layui-upload-button">
                                <form target="layui-upload-iframe"  key="set-mine" enctype="multipart/form-data">
                                    <input type="file" name="avatar" lay-type="images" class="change-picture" value="修改头像">
                                </form>
                                <span class="layui-upload-icon"><i class="layui-icon"></i>上传图片</span>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><em>*</em>  昵称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="nick-name" autocomplete="off" class="layui-input nick-name" value="${cur_user.username}">
                        </div>
                        <div class="layui-form-mid layui-word-aux">3-16位 汉字、数字、字母（大小写）、下划线组成</div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">个性签名</label>
                        <div class="layui-input-block">
                            <input type="text" name="signature" autocomplete="off" class="layui-input signature" value="${cur_user.signature}" style="width: 79%;">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><em>*</em>　性别</label>
                        <div class="layui-input-inline sex-wrap">
                            <input type="radio" name="sex" value="男" <c:if test="${cur_user.sex eq '男'}">checked="checked"</c:if> title="男"><div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i><span>男</span></div>
                            <input type="radio" name="sex" value="女" <c:if test="${cur_user.sex eq '女'}">checked="checked"</c:if> title="女"><div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i><span>女</span></div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">生日</label>
                        <div class="layui-input-inline">
                            <input class="layui-input birthday" placeholder="${cur_user.birthday}" onclick="layui.laydate({elem: this})" value="">
                        </div>
                        <div class="layui-form-mid layui-word-aux">（该信息其他人不可见）</div>
                    </div>
                    <div class="layui-form-item area" data-area="">
                        <label class="layui-form-label">所在地区</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" value="${cur_user.residence}" type="text" readonly>
                        </div>
                        <div class="layui-input-inline">
                            <select id="province" name="province">
                                <option value="请选择">请选择省份</option>
                                <option value="北京" data-id="110000">北京</option><option value="天津" data-id="120000">天津</option><option value="河北" data-id="130000">河北</option><option value="山西" data-id="140000">山西</option><option value="内蒙古" data-id="150000">内蒙古</option><option value="辽宁" data-id="210000">辽宁</option><option value="吉林" data-id="220000">吉林</option><option value="黑龙江" data-id="230000">黑龙江</option><option value="上海" data-id="310000">上海</option><option value="江苏" data-id="320000">江苏</option><option value="浙江" data-id="330000">浙江</option><option value="安徽" data-id="340000">安徽</option><option value="福建" data-id="350000">福建</option><option value="江西" data-id="360000">江西</option><option value="山东" data-id="370000">山东</option><option value="河南" data-id="410000">河南</option><option value="湖北" data-id="420000">湖北</option><option value="湖南" data-id="430000">湖南</option><option value="广东" data-id="440000">广东</option><option value="广西" data-id="450000">广西</option><option value="海南" data-id="460000">海南</option><option value="重庆" data-id="500000">重庆</option><option value="四川" data-id="510000">四川</option><option value="贵州" data-id="520000">贵州</option><option value="云南" data-id="530000">云南</option><option value="西藏" data-id="540000">西藏</option><option value="陕西" data-id="610000">陕西</option><option value="甘肃" data-id="620000">甘肃</option><option value="青海" data-id="630000">青海</option><option value="宁夏" data-id="640000">宁夏</option><option value="新疆" data-id="650000">新疆</option></select><div class="layui-unselect layui-form-select"><div class="layui-select-title"><input type="text" placeholder="请选择省份" value="请选择省份" readonly="" class="layui-input layui-unselect"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="请选择" class="layui-this">请选择省份</dd><dd lay-value="北京" class="">北京</dd><dd lay-value="天津" class="">天津</dd><dd lay-value="河北" class="">河北</dd><dd lay-value="山西" class="">山西</dd><dd lay-value="内蒙古" class="">内蒙古</dd><dd lay-value="辽宁" class="">辽宁</dd><dd lay-value="吉林" class="">吉林</dd><dd lay-value="黑龙江" class="">黑龙江</dd><dd lay-value="上海" class="">上海</dd><dd lay-value="江苏" class="">江苏</dd><dd lay-value="浙江" class="">浙江</dd><dd lay-value="安徽" class="">安徽</dd><dd lay-value="福建" class="">福建</dd><dd lay-value="江西" class="">江西</dd><dd lay-value="山东" class="">山东</dd><dd lay-value="河南" class="">河南</dd><dd lay-value="湖北" class="">湖北</dd><dd lay-value="湖南" class="">湖南</dd><dd lay-value="广东" class="">广东</dd><dd lay-value="广西" class="">广西</dd><dd lay-value="海南" class="">海南</dd><dd lay-value="重庆" class="">重庆</dd><dd lay-value="四川" class="">四川</dd><dd lay-value="贵州" class="">贵州</dd><dd lay-value="云南" class="">云南</dd><dd lay-value="西藏" class="">西藏</dd><dd lay-value="陕西" class="">陕西</dd><dd lay-value="甘肃" class="">甘肃</dd><dd lay-value="青海" class="">青海</dd><dd lay-value="宁夏" class="">宁夏</dd><dd lay-value="新疆" class="">新疆</dd></dl></div>
                        </div>
                        <div class="layui-input-inline">
                            <select id="city" name="city">
                                <option value="请选择">请选择城市</option>
                            </select><div class="layui-unselect layui-form-select"><div class="layui-select-title"><input type="text" placeholder="请选择城市" value="请选择城市" readonly="" class="layui-input layui-unselect"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="请选择" class="layui-this">请选择城市</dd></dl></div>
                        </div>
                        <div class="layui-input-inline">
                            <select id="county" name="county">
                                <option value="请选择">请选择区县</option>
                            </select><div class="layui-unselect layui-form-select"><div class="layui-select-title"><input type="text" placeholder="请选择区县" value="请选择区县" readonly="" class="layui-input layui-unselect"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="请选择" class="layui-this">请选择区县</dd></dl></div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"></label>
                        <div class="layui-input-inline">
                            <a href="javascript:;" class="userinfo-submit layui-btn">保存修改</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer">
            <div class="go-to-top" style="display: none; left: 1310px;">
                <a href="/user/userinfo#" title="回顶部" class="icon"></a>
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

        <script type="text/javascript" src="<%=basePath%>js/allcity.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/userinfo.js"></script>
    </body>
</html>
