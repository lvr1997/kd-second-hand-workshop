
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${goodsExtend.goods.name}-科大二手工坊-大学生二手网</title>
        <script src="<%=basePath%>js/jquery.min.js"></script>
        <script src="<%=basePath%>js/layui.all.js"></script>
        <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
        <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
        <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
        <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

        <link rel="stylesheet" href="<%=basePath%>css/public.css">
        <script src="<%=basePath%>js/common.js"></script>
        <link rel="stylesheet" href="<%=basePath%>css/detail.css">
    </head>

    <body>
        <div id="header">
            <div class="header-wrap">
                <%--<a href="/goods/index" class="logo fl">
                    <img src="" alt="">
                    <h1></h1>
                </a>--%>
                <ul class="nav fl">
                    <li><a href="/goods/index">科大二手工坊</a></li>
                </ul>
                <div class="nav-right fr">
                    <c:if test="${!empty cur_user}">
                        <a href="/user/index" class="log-btn">
                            <img src="<%=basePath%>images/user/${cur_user.imgUrl}" class="user-header-image">${cur_user.username}</a>
                        <a href="/user/logout" class="log-btn">退出</a>
                    </c:if>
                    <c:if test="${empty cur_user}">
                        <a href="/user/toRegister" class="log-btn">注册</a>
                        <a href="/user/toLogin" class="log-btn">登录</a>
                    </c:if>
                </div>
            </div>
        </div>
        <div id="header-bottom">
            <div class="header-bottom-wrap clearfix">
                <%--<div class="city fl">
                    <a href="javascript:;">全球<i class="icon"></i></a>
                </div>--%>
                <div class="search-wrap fl">
                    <div class="search">
                        <input type="text" class="keywords" placeholder="请输入关键词">
                        <a href="javascript:;" class="search-btn search-normal-btn">搜索</a>
                    </div>
                </div>
                <div class="publish fr">
                    <a href="/publish/publish" class="publish-btn"><i class="icon"></i>发布 闲置</a>
                </div>
            </div>
        </div>
        <div id="main" class="clearfix">
            <div class="detail fl clearfix">

                <div class="title">
                    <!-- <h2> 闲置标题 闲置标题</h2> -->
                    <span class="publish-time fl">更新于：${goodsExtend.goods.polishTime}</span>
                    <span class="view-number fl">${goodsExtend.goods.viewcount}次浏览</span>

                    <a href="javascript:;" class="report fr">举报</a>
                </div>
                <div id="MagnifierWrap2" class="fl">
                    <div class="MagnifierMain">

                        <img class="MagTargetImg" src="<%=basePath%>images/web/${goodsExtend.images[0].imgUrl}">

                    </div>
                        <span class="spe_leftBtn">&lt;</span>
                    <c:if test="${fn:length(goodsExtend.images)>=5}">
                        <span class="spe_rightBtn on">&gt;</span>
                    </c:if>
                    <c:if test="${fn:length(goodsExtend.images)<5}">
                        <span class="spe_rightBtn">&gt;</span>
                    </c:if>
                    <div class="spec-items">
                        <ul>
                            <c:forEach var="item" items="${goodsExtend.images}">
                                <li class="">
                                    <img src=<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/images/web/${item.imgUrl} />
<%--                                    <img src="<%=basePath%>images/web/${item.imgUrl}">--%>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="good-info fr">
                    <h2>${goodsExtend.goods.name}</h2>
                    <div class="info-line">
                        <span class="param-name">价格</span>
                        <span class="param-value good-price">${goodsExtend.goods.price}</span>
                    </div>
                    <div class="info-line">
                        <span class="param-name">原价</span>
                        <span class="param-value good-old-price">${goodsExtend.goods.realPrice}</span>

                    </div>
                    <c:if test="${!empty goodsExtend.goods.goodAddress}">
                        <div class="info-line">
                            <span class="param-name">交易地址</span>
                            <span class="param-value address">${goodsExtend.goods.goodAddress}</span>
                        </div>
                    </c:if>

                    <div class="info-line">
                        <span class="param-name">卖家</span>
                        <span class="param-value">${seller.username}</span>
                    </div>

                    <div class="info-line">
                        <span class="param-name">交易方式</span>
                        <c:if test="${goodsExtend.goods.goodBuyMethod eq 0 || goodsExtend.goods.goodBuyMethod eq 1}">
                            <span class="param-value">在线交易</span>
                        </c:if>
                        <c:if test="${goodsExtend.goods.goodBuyMethod eq 2}">
                            <span class="param-value">线下交易</span>
                        </c:if>
                        <c:if test="${goodsExtend.goods.goodBuyMethod eq 3}">
                            <span class="param-value">在线交易 / 线下交易</span>
                        </c:if>
                    </div>
                    <div class="info-line btns">
                        <a href="javascript:;" class="info-btn contect-seller">联系卖家</a>
                        <c:if test="${empty want}">
                            <a href="javascript:;" data-id="${goodsExtend.goods.id}" class="info-btn want"><i class="icon "></i>想要</a>
                        </c:if>
                        <c:if test="${!empty want}">
                            <a href="javascript:;" data-id="${goodsExtend.goods.id}" class="info-btn want"><i class="icon wanted"></i>想要</a>
                        </c:if>
                        <c:if test="${goodsExtend.goods.goodBuyMethod ne 2}">
                            <a href="javascript:;" data-id="${goodsExtend.goods.id}" class="info-btn buy-shop-btn" style="background-color: #11cd6e">购买闲置</a>
                        </c:if>
                    </div>
                </div>
                <div class="good-description">
                    <div class="description-title"><span> 闲置描述</span></div>
                    <div class="description-body">
                        <p>
                            ${goodsExtend.goods.describle}
                        </p>
                    </div>
                </div>
                <div class="good-description">
                    <div class="description-title"><span> 闲置留言</span></div>
                    <div class="description-body">
                        <div class="comment-list">
                            <ul>

                            </ul>
                        </div>
                        <!--已登陆-->
                        <c:if test="${!empty cur_user}">
                            <textarea name="" required lay-verify="required" placeholder="请输入留言内容" class="layui-textarea comments"></textarea>
                            <div class="comment-btns">
                            <button class="layui-btn comment-submit">提交</button>
                            <span class="comments-words">0/100</span>
                            </div>
                        </c:if>
                        <!--没有登录-->
                        <c:if test="${empty cur_user}">
                            <div class="user-not-login">
                                <p>
                                    <a class="lgbtn" href="/user/toLogin">登录</a>
                                    <a class="lgbtn" href="/user/toRegister" target="_blank">注册</a>
                                </p>
                            </div>
                        </c:if>

                    </div>
                </div>

            </div>
            <div class="detail-sidebar fr">
                <div class="sidebar-header">推荐闲置</div>
                <ul class="sidebar-list">
                    <c:forEach var="item" items="${commend}">
                        <li>
                            <a href="<%=basePath%>detail/detail/${item.goods.id}" class="sidebar clearfix">
                                <img class="sidebar-image fl" src="<%=basePath%>images/web/${item.images[0].imgUrl}" alt="<c:out value="${item.goods.name}"></c:out>">
                                <p class="sidebar-title"><c:out value="${item.goods.name}"></c:out></p>
                                <p class="sidebar-price">￥<c:out value="${item.goods.price}"></c:out></p>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="user-contect get-contect" style="display: none;">
            <div class="contect-header">联系方式</div>

            <c:if test="${!empty cur_user}">
                <p>手机号：${seller.phone}</p>
                <c:if test="${!empty goodsExtend.goods.qqNumber}">
                    <p>QQ：${goodsExtend.goods.qqNumber}</p>
                </c:if>
                <c:if test="${!empty goodsExtend.goods.wxNumber}">
                    <p>微信：${goodsExtend.goods.wxNumber}</p>
                </c:if>
            </c:if>
            <c:if test="${empty cur_user}">
                <p>
                    <a href="/user/toLogin">请先登录</a>
                </p>
            </c:if>

        </div>
        <div class="goods-buy user-contect" style="display: none;">
            <div class="contect-header">购买闲置</div>
            <c:if test="${!empty cur_user && cur_user.id ne goodsExtend.goods.userId}">
                <p><a href="/user/buy-good/${goodsExtend.goods.id}">确定购买</a></p>
            </c:if>
            <c:if test="${empty cur_user}">
                <p>
                    <a href="/user/toLogin">请先登录</a>
                </p>
            </c:if>
            <c:if test="${cur_user.id eq goodsExtend.goods.userId}">
                <p><a href="#">不可购买自己的闲置</a></p>
            </c:if>
        </div>
        <div id="footer">
            <!-- <div class="footer-top-wrap">
                <div class="footer-top"></div>
            </div> -->
            <div class="go-to-top" style="display: none; left: 1515px;">
                <a href="/detail/detail/${goodsExtend.goods.id}#" title="回顶部" class="icon"></a>
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
        <script src="<%=basePath%>js/MagnifierF.js"></script>
        <script src="<%=basePath%>js/detail.js"></script>
    </body>
</html>
