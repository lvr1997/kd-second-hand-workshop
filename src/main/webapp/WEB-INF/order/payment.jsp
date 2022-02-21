<%--
  Created by IntelliJ IDEA.
  User: LR
  Date: 0026 2018 03 26
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
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
<head lang="en">
    <meta charset="UTF-8">
    <title>科大二手工坊——支付页面</title>
    <script type="text/javascript">
        var x = 15,
            interval;
        window.onload = function() {
            var d = new Date("1111/1/1,0:" + x + ":0");
            interval = setInterval(function() {
                var m = d.getMinutes();
                var s = d.getSeconds();
                m = m < 10 ? "0" + m : m;
                s = s < 10 ? "0" + s : s;
                $('.pay_leftTime').html("剩余付款时间:"+'<b> '+m+ ":" +s+' </b>');
                if (m == 0 && s == 0) {
                    clearInterval(interval);
                    $.ajax({
                        url:"/order/pay_fail",
                        type:"POST",
                        data:{
                            orderId:id,
                        },
                        dataType:"json",
                        success:function (data) {

                        }
                    })
                    location.href("");
                }
                d.setSeconds(s - 1);
            }, 1000);
        }
    </script>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui.all.js"></script>
    <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
    <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
    <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <script src="<%=basePath%>js/common.js"></script>
    <script src="<%=basePath%>js/order/distpicker.data.js"></script>
    <script src="<%=basePath%>js/order/distpicker.js"></script>
    <link href="<%=basePath%>css/order/payment.css" rel="Stylesheet" />
    <style>
        .okPay a{
            color: #FFFFFF;
        }
    </style>
</head>
<body>
<!-- 页面顶部-->
<div id="header">
    <div class="header-wrap">
        <%--<a href="/goods/index" class="logo fl">
            <img src="" alt="">
            <h1></h1>
        </a>--%>
        <ul class="nav fl">
            <li><a href="/goods/index">首页</a></li>
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
<div id="navlist" class="clearfix">
    <ul>
        <li class="navlist_gray_left"></li>
        <li class="navlist_gray">确认订单信息</li>
        <li class="navlist_gray_arro"><canvas id="canvas_gray" width="20" height="38"></canvas>
        </li>
        <li class="navlist_blue">支付订单<b></b></li>
        <li class="navlist_blue_arro"><canvas id="canvas_blue" width="20" height="38"></canvas>
        </li>
        <li class="navlist_gray">支付完成<b></b></li>
        <li class="navlist_gray_right"></li>
    </ul>
</div>
<!--订单确认-->
<form action="/order/payresult" method="post" id="pay_form">
    <div id="container" class="clearfix" >
        <!-- 支付订单信息-->
        <div class="pay_info">
            <b>支付金额：<i>${good.price}元</i></b><input type="hidden" name="payment" value="0.01"/>
            <span id="pay-id">支付订单：<b class="payId">${payId}</b> 收款方：${seller.username}</span><input type="hidden" name="orderId" />
        </div>
        <!--支付方式-->
        <div id="pay_type">
            <!-- 支付方式头-->
            <div class="pay_type_title">
                <b>网上银行支付</b>
            </div>
            <div id="dnBank">
                <ul>
                    <li><input type="radio" name="bankId" value="BOC-NET-B2C" id="02zg">
                        <label for="02zg"><img src="<%=basePath%>images/pay/pay_img1.jpg" alt="" /></label>
                    </li>
                    <li><input type="radio" name="bankId" value="ICBC-NET-B2C" id="03gs">
                        <label for="03gs"><img src="<%=basePath%>images/pay/pay_img2.jpg" alt="" /></label>
                    </li>
                    <li><input type="radio" name="bankId" value="CMBCHINA-NET-B2C" id="04zs">
                        <label for="04zs"><img src="<%=basePath%>images/pay/pay_img3.jpg" alt="" /></label>
                    </li>
                    <li><input type="radio" name="bankId" value="CCB-NET-B2C" id="05js">
                        <label for="05js"><img src="<%=basePath%>images/pay/pay_img4.jpg" alt=""/></label>
                    </li>
                    <li><input type="radio" name="bankId" value="ABC-NET-B2C" id="06ny">
                        <label for="06ny"><img src="<%=basePath%>images/pay/pay_img5.jpg" alt=""/></label>
                    </li>
                </ul>
            </div>

        </div>
        <!--结算条-->
        <div id="count_bar">
            <span class="pay_leftTime">
                剩余付款时间:<b> 15:00 </b>
            </span>
            <span class="okPay" onclick="payment(${payId},${good.id},${aid})">确认支付</span>
        </div>
    </div>
</form>
<div id="footer">
    <div class="go-to-top" style="left: 1515px; display: none;">
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

<script src="<%=basePath%>js/jquery.min.js"></script>
<script src="<%=basePath%>js/order/index.js"></script>

<script type="text/javascript">

</script>

<script>
    $("#count_bar .okPay").css("display","none");
    $("#count_bar .okPay").css("display","block");
    // $("#dnBank").on('click', 'img', function(){
    //     $(this).addClass("hover") ;
    //     $(this).parent().parent().siblings().children('label').children('img').removeClass('hover');
    //
    // });
    /* $(":not(#count_bar .okPay)").css("display","none"); */
</script>
<script type="text/javascript">
    function payment() {
        $("#pay_form").submit();
        // document.getElementById('pay_form').submit();
        alert(11);
    }
    $(function(){
        // getProvince(-1,-1,-1);

    });


</script>
<script>
    function payment(payid,gid,aid) {
        location="/order/payresult?gid="+gid+"&aid="+aid+"&payid="+payid;
    }

</script>
<script>
    var canvas=document.getElementById("canvas_gray");
    var cxt=canvas.getContext("2d");
    var gray = cxt.createLinearGradient (10, 0, 10, 38);
    gray.addColorStop(0, '#f5f4f5');
    gray.addColorStop(1, '#e6e6e5');
    cxt.beginPath();
    cxt.fillStyle = gray;
    cxt.moveTo(20,19);
    cxt.lineTo(0,38);
    cxt.lineTo(0,0);
    cxt.fill();
    cxt.closePath();
</script>
<script>
    var canvas=document.getElementById("canvas_blue");
    var cxt=canvas.getContext("2d");
    var blue = cxt.createLinearGradient (10, 0, 10, 38);
    blue.addColorStop(0, '#27b0f6');
    blue.addColorStop(1, '#0aa1ed');
    cxt.beginPath();
    cxt.fillStyle = blue;
    cxt.moveTo(20,19);
    cxt.lineTo(0,38);
    cxt.lineTo(0,0);
    cxt.fill();
    cxt.closePath();
</script>
</body>
</html>


