
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--启用el表达式 没有这句代码将不能够使用el表达式--%>
<%@page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>发布-科大二手工坊</title>
        <script src="<%=basePath%>js/jquery.min.js"></script>
        <script src="<%=basePath%>js/layui.all.js"></script>
        <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
        <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
        <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
        <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

        <link rel="stylesheet" href="<%=basePath%>css/public.css">
        <script src="<%=basePath%>js/common.js"></script>
        <link rel="stylesheet" href="<%=basePath%>css/publish.css">
    </head>
    <body>
        <div id="header">
            <div class="header-wrap">
                <a href="/goods/index" class="logo fl">
                    <img src="" alt="">
                    <h1>科大二手工坊 大学生二手网</h1>
                </a>
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
            <h2>发布 闲置</h2>
                <div class="publish-main layui-form layui-form-pane">
                    <div class="input-line image">
                        <div class="layui-box layui-upload-button">
                            <form target="layui-upload-iframe" key="set-mine" enctype="multipart/form-data" >
                                <input type="file" name="info" class="layui-upload-file info-img-upload">
                            </form>
                            <span class="layui-upload-icon"><i class="layui-icon"></i>上传图片</span>
                        </div>
                    </div>
                    <div class="layui-form-item input-line">
                        <label class="layui-form-label">选择学校</label>
                        <div class="layui-input-inline">
                            <select name="city" class="city">
                                <option value="">请选择</option>

                                <option data-cid="1" value="1">黑龙江科技大学</option>

                            </select><div class="layui-unselect layui-form-select"><div class="layui-select-title"><input type="text" placeholder="请选择" value="" readonly="" class="layui-input layui-unselect"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="1" class="">全球</dd></dl></div>
                        </div>
                        <%--<div class="layui-form-mid layui-word-aux">注：没有找到对应学校时，请选择“黑龙江科技大学”</div>--%>
                    </div>
                    <div class="layui-form-item input-line">
                        <label class="layui-form-label"> 闲置名称</label>
                        <div class="layui-input-inline" style="width: 390px;">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入 闲置名称" class="layui-input goods-title">
                        </div>
                        <div class="layui-form-mid layui-word-aux">14个字以内</div>
                    </div>
                    <div class="layui-form-item layui-form-text input-line">
                        <label class="layui-form-label good-description"> 闲置详情</label>
                        <div class="layui-input-block">
                            <textarea placeholder="请输入 闲置详情" class="layui-textarea goods-des"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item input-line" id="price">
                        <label class="layui-form-label">价格</label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入价格" class="layui-input price">
                        </div>
                        <div class="layui-form-mid layui-word-aux">元　　　</div>
                        <label class="layui-form-label">原价</label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入原价" class="layui-input original-price">
                        </div>
                        <div class="layui-form-mid layui-word-aux">元　　　</div>
                        <a href="javascript:;" class="add-original-link layui-btn layui-btn-small"><i class="layui-icon" style="color: #fff;"></i> 添加原购买链接</a>
                        <a href="javascript:;" class="close-original-link layui-btn layui-btn-small layui-btn-danger" style="display: none;">关闭购买链接</a>
                    </div>
                    <div class="layui-form-item input-line" id="original-link" style="display: none;">
                        <label class="layui-form-label">原购买链接</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入原购买链接" class="layui-input original-link">
                        </div>
                    </div>
                    <div class="layui-form-item input-line">
                        <label class="layui-form-label">分类</label>
                        <div class="layui-input-inline">
                            <select name="categorys" id="categorys">
                                <option value="">请选择分类</option>
                                <c:forEach var="item" items="${catelogs}">
                                    <option data-cid="${item.id}" value="${item.id}">${item.name}</option>
                                </c:forEach>
                            </select><div class="layui-unselect layui-form-select"><div class="layui-select-title"><input type="text" placeholder="请选择分类" value="" readonly="" class="layui-input layui-unselect"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit"><dd lay-value="1" class="">手机</dd><dd lay-value="2" class="">电脑</dd><dd lay-value="4" class="">配件</dd><dd lay-value="5" class="">电器</dd><dd lay-value="6" class="">书籍</dd><dd lay-value="7" class="">娱乐</dd><dd lay-value="8" class="">运动</dd><dd lay-value="9" class="">代步</dd></dl></div>
                        </div>
                    </div>
                    <div class="layui-form-item input-line">
                        <label class="layui-form-label">交易方式</label>
                        <div class="layui-input-block">
                            <input type="radio" class="buyMethod" name="transactionMode" value="1" title="在线交易"><div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i><span>在线交易</span></div>
                            <input type="radio" class="buyMethod" name="transactionMode" value="2" title="线下交易"><div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i><span>线下交易</span></div>
                            <input type="radio" class="buyMethod" name="transactionMode" value="3" title="在线交易/线下交易" checked=""><div class="layui-unselect layui-form-radio layui-form-radioed"><i class="layui-anim layui-icon"></i><span>在线交易/线下交易</span></div>
                        </div>
                    </div>
                    <div class="layui-form-item input-line" id="address">
                        <label class="layui-form-label">交易地址</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入交易地址" class="layui-input goods-address">
                        </div>
                    </div>
                    <div class="layui-form-item input-line" id="phoneNumber">
                        <label class="layui-form-label">手机号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入手机号" class="layui-input phone-number" value="${cur_user.phone}">
                        </div>
                        <label class="layui-form-label">QQ号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入QQ号" class="layui-input qq-number">
                        </div>
                        <label class="layui-form-label">微信号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入微信号" class="layui-input wx-number">
                        </div>
                    </div>
                    <div class="publish-submit">
                        <button class="layui-btn submit">确认发布</button>
                    </div>
            </div>
        </div>

        <div id="footer">
            <div class="go-to-top" style="display: none; left: 1310px;">
                <a href="#" title="回顶部" class="icon"></a>
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

        <script src="<%=basePath%>js/publish.js"></script>

    </body>
</html>