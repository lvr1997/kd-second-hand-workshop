
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>确认订单</title>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui.all.js"></script>
    <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
    <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
    <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <script src="<%=basePath%>js/common.js"></script>

    <link href="<%=basePath%>css/order/orderConfirm.css" rel="Stylesheet"/>
    <link href="<%=basePath%>css/order/personage.css" rel="Stylesheet"/>

</head>
</head>
<body>
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
            <li class="navlist_blue_left"></li>
            <li class="navlist_blue">确认订单信息</li>
            <li class="navlist_blue_arro"><canvas id="canvas_blue" width="20" height="38"></canvas>
            </li>
            <li class="navlist_gray">支付订单<b></b></li>
            <li class="navlist_gray_arro"><canvas id="canvas_gray" width="20" height="38"></canvas>
            </li>
            <li class="navlist_gray">支付完成<b></b></li>
            <li class="navlist_gray_right"></li>
        </ul>
    </div>
    <!--订单确认-->
    <div id="container" class="clear">
        <!--收货地址-->
        <div class="adress_choice">
            <p>收货人信息</p>
        <c:forEach items="${listAddress}" var="address">
            <c:if test="${listAddress == null}">
                <h4>还没有添加收货地址，先去添加收货地址吧！</h4>
            </c:if>
            <c:if test="${address.isDefault==1}">
                <div id="addresId1" class="base_select" data-aid="${address.id}">
                    <i class="address_name">
                        ${address.recvName} ${address.recvTag}
                    </i>
                    <i class="user_address">
                        ${address.recvDistrict}  ${address.recvAddr} ${address.recvPhone}
                    </i>
                    <i class="user_site rt" onclick="setDefault1(${address.id})">
                        设为默认地址
                    </i>
                </div>
            </c:if>
            <c:if test="${address.isDefault==0}">
                <div id="addresId2" class="base">
                    <i class="address_name">
                        ${address.recvName} ${address.recvTag}
                    </i>
                    <i class="user_address">
                        ${address.recvDistrict}  ${address.recvAddr} ${address.recvPhone}
                    </i>
                    <i class="user_site rt" onclick="setDefault1(${address.id})">
                        设为默认地址
                    </i>
                </div>
            </c:if>
        </c:forEach>
            <a id="more" href="javascript:void(0);">
                更多地址 &gt;&gt;
            </a>
        </div>
        <!--  闲置信息-->
        <form name="" method="post" action="#">
            <div class="product_confirm">
                <p>确认 闲置信息</p>
                <ul class="item_title">
                    <li class="p_info"> 闲置信息</li>
                    <li class="p_price">单价(元)</li>
                    <li class="p_count">数量</li>
                    <li class="p_tPrice">金额</li>
                </ul>
                <ul class="item_detail">
                    <li class="p_info">
                        <b><img style="width: 75px;height: 75px" src="<%=basePath%>images/web/${image[0].imgUrl}"/></b>

                        <b class="product_name lf">
                            ${good.name}
                        </b>
                        <br/>
                        <%--<span class="product_color ">--%>
                       <%--颜色：深空灰--%>
                    <%--</span>--%>
                    </li>
                    <li class="p_price">
                        <span class="pro_price">￥<span class="ppp_price">${good.price}</span></span>
                    </li>
                    <li class="p_count">X<span>1</span></li>
                    <li class="p_tPrice">￥<span>${good.realPrice}</span></li>
                </ul>
            </div>
        </form>
        <!-- 结算条-->
        <div id="count_bar">
            <span class="go_home"><a href="/user/order" >&lt;&lt;查看订单</a></span>
            <span class="count_bar_info">
                已选
                <b  id="count"> 1 </b>
                    件 闲置&nbsp;&nbsp;合计(不含运费):
                <b class="zj"></b>
                <input type="hidden" name="Payment" value="${good.price}"/>元
            </span>
            <span class="go_pay" onclick="payment(${good.id},$('.base_select').attr('data-aid'));">确认并付款</span>
        </div>
    </div>
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
        <script>
            var html=0;
            var total=0;
            $(function(){
                $(".item_detail").each(function() {
                    html+=1;
                    var p=parseFloat($(this).children('.p_price').children('.pro_price').children('.ppp_price').html());
                    console.log(p);
                    var sl=parseFloat($(this).children('.p_count').children('span').html());
                    var xj=parseFloat(p*sl).toFixed(2);
                    console.log("xiaoji"+xj);
                    $(this).children('.p_tPrice').children('span').html(xj);
                    total+=xj-0;
                })
                console.log("zongji"+total);
                $("#count").html(html)-0;
                $('.zj').html(total.toFixed(2))-0;
                var input_zj=parseFloat($('.zj').html()).toFixed(2);
                $('#payment').val(input_zj);
            })
        </script>
        <script>
            function payment(gid,aid){
                if(aid && confirm("确认订单吗?")){
                    location="/order/payment?gid="+gid+"&aid="+aid;
                } else {
                    alert("收货地址为空，先去添加收货地址吧！！！")
                }
            }
        </script>
        <script type="text/javascript">
            //定义函数,处理这为默认
            function setDefault1(id){
                $.ajax({
                    url:"/address/setOrderDefault?id="+id,
                    type:"GET",
                    data:{
                        id:id
                    },
                    dataType:"json",
                    success:function (data) {
                        if(data.state == 1){
                            location.reload();
                        }
                    }
                })

            }
        </script>
        <script type="text/javascript">
            //当城市列表发生变化,调用getArea函数
            function getArea(cityCode,areaCode){
                $.ajax({
                    "url":"/dict/showArea",
                    "data":"cityCode="+cityCode,
                    "type":"GET",
                    "dataType":"json",
                    "success":function(obj){
                        $("#receiverDistrict").html("<option value=0> - - - -选择区- - - - </option>");
                        for(i=0;i<obj.data.length;i++){
                            var str = "<option value="+obj.data[i].areaCode+">"+obj.data[i].areaName+"</option>";
                            $("#receiverDistrict").append(str);
                        }
                        if(areaCode!=-1){
                            $("#receiverDistrict").val(areaCode);
                        }
                    }
                });
            }
            //当省列表发生改变时,调用getCity函数获取城市信息
            function getCity(provinceCode,cityCode,areaCode){
                $.ajax({
                    "url":"/dict/showCity",
                    "data":"provinceCode="+provinceCode,
                    "type":"GET",
                    "dataType":"json",
                    "success":function(obj){
                        $("#receiverCity").html("<option value=0> - - - -选择市- - - - </option>");
                        for(i=0;i<obj.data.length;i++){
                            var str = "<option value="+obj.data[i].cityCode+">"+obj.data[i].cityName+"</option>";
                            $("#receiverCity").append(str);
                        }
                        if(cityCode!=-1){
                            $("#receiverCity").val(cityCode);
                        }
                    }
                });
                getArea(cityCode,areaCode);
            }
            //加载页面完成,就调用../dict/showProvince
            function getProvince(provinceCode,cityCode,areaCode){
                $.ajax({
                    "url":"/dict/showProvince",
                    "data":"",
                    "type":"GET",
                    "dataType":"json",
                    "success":function(obj){
                        $("#receiverState").html("<option value=0> - - - -选择省- - - - </option>");
                        for(var i = 0;i<obj.data.length;i++){
                            var str="<option value="+obj.data[i].provinceCode+">"+obj.data[i].provinceName+"</option>";
                            $("#receiverState").append(str);
                        }
                        if(provinceCode!=-1){
                            $("#receiverState").val(provinceCode);
                        }

                    }

                });
                getCity(provinceCode,cityCode,areaCode);
            }
            //receiverState
            $(function(){
                getProvince(-1,-1,-1);
            });


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
    <script src="<%=basePath%>js/order/distpicker.data.js"></script>
    <script src="<%=basePath%>js/order/distpicker.js"></script>
        <script>
            $("#choose").click(function(){
                $(".modal").show();
            })
            $(".cha").click(function(){
                $(".modal").hide();
            })

            $("#more").click(function(){
                if($(this).hasClass("upup")){
                    $("#addresId2").hide();
                    $("#addresId3").hide();
                    $("#more").html("更多地址>>");
                    $(this).removeClass("upup");
                }else{
                    $("#addresId2").show();
                    $("#addresId3").show();
                    $("#more").html("收起地址>>");
                    $("#more").addClass("upup");
                }
            })
        </script>
        <script>
            $(document).on("mouseover",".base",function(){
                $(this).find("i:eq(2)").show();
            })
            $(document).on("mouseout",".base",function(){
                $(this).find("i:eq(2)").hide();
            })
            $(".user_site").click(function(){
                $(this).parent().attr("class","base_select");
                $(this).parent().siblings().attr("class","base");
                $(this).hide();
            })
        </script>
    </body>
</html>
