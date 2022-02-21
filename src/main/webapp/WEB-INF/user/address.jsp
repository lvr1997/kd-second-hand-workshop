
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

        <title>地址管理-科大二手工坊</title>
        <script src="<%=basePath%>js/jquery.min.js"></script>
        <script src="<%=basePath%>js/layui.all.js"></script>
        <link id="layuicss-laydatecss" rel="stylesheet" href="<%=basePath%>js/css/modules/laydate/laydate.css" media="all">
        <link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath%>js/css/modules/layer/default/layer.css" media="all">
        <link id="layuicss-skincodecss" rel="stylesheet" href="<%=basePath%>js/css/modules/code.css" media="all">
        <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">
        <link rel="stylesheet" href="<%=basePath%>css/public.css">
        <script src="<%=basePath%>js/common.js"></script>
        <link href="<%=basePath%>css/order/personage.css" rel="Stylesheet"/>
        <link rel="stylesheet" href="<%=basePath%>css/user.css">
    </head>
    <body>
        <div id="header">
            <div class="header-wrap">
                <%--<a href="/goods/index" class="logo fl">
                    <img src="" alt="">
                    <h1> 大学生二手网</h1>
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
                        <li><a href="/user/address" class="active"><i class="icon"></i>地址管理</a></li>
                        <li><a href="/user/order" class=""><i class="icon"></i>订单管理</a></li>
                        <%--<li><a href="/user/auth" class=""><i class="icon"></i>实名认证</a></li>--%>
                        <li><a href="/user/help" class=""><i class="icon"></i>意见反馈</a></li>
                    </ul>
                </div>
            </div>
            <div class="rightsidebar_box fr clearfix user-main">
                <!--标题栏-->
                <div class="rs_header">
                    <span class="address_title">收获地址管理</span>
                </div>
                <!--收货人信息填写栏-->
                <div class="rs_content">
                    <form id="update_form" method="post" action="/address/add">
                        <input type="hidden" name="id" id="id">
                        <!--收货人姓名-->
                        <div class="recipients">
                            <span class="red">*</span><span class="kuan">收货人：</span><input type="text" name="receiverName" id="receiverName"/>
                        </div>
                        <!--收货人所在城市等信息-->
                        <div  class="address_content">
                            <span class="red">*</span><span class="kuan">省&nbsp;&nbsp;份：</span>
                            <select data-province="---- 选择省 ----" id="receiverState" name="receiverState" onchange="getCity(this.value,-1,-1)"></select>
                            城市：<select data-city="---- 选择市 ----" id="receiverCity" name="receiverCity" onchange="getArea(this.value,-1)"></select>
                            区/县：<select data-district="---- 选择区 ----" id="receiverDistrict" name="receiverDistrict"></select>
                        </div>
                        <!--收货人详细地址-->
                        <div class="address_particular">
                            <span class="red">*</span><span class="kuan">详细地址：</span>
                            <textarea name="receiverAddress" id="receiverAddress" cols="60" rows="3" placeholder="建议您如实填写详细收货地址"></textarea>
                        </div>
                        <!--收货人地址-->
                        <div class="address_tel">
                            <span class="red">*</span><span class="kuan">手机号码：</span>
                            <input type="tel" id="receiverMobile" name="receiverMobile"/>固定电话：<input type="text" name="receiverPhone" id="receiverPhone"/>
                        </div>
                        <!--邮政编码-->
                        <div class="address_postcode">
                            <span class="red">&nbsp;</span><span class="kuan">邮政编码：</span>&nbsp;
                            <input type="text" name="receiverZip" id="receiverZip"/>
                        </div>
                        <!--地址名称-->
                        <div class="address_name">
                            <span class="red">&nbsp;</span><span class="kuan">地址名称：</span>&nbsp;
                            <input type="text" id="addressName" name="addressName"/>如：<span class="sp">家</span><span class="sp">公司</span><span class="sp">宿舍</span>
                        </div>
                        <!--保存收货人信息-->
                        <div class="save_recipient">
                            保存收货人信息
                        </div>
                    </form>
                    <!--已有地址栏-->
                    <div class="address_information_manage ">
                        <div class="aim_title">
                            <span class="dzmc dzmc_title">地址名称</span>
                            <span class="dzxm dzxm_title">姓名</span>
                            <span class="dzxq dzxq_title">地址详情</span>
                            <span class="lxdh lxdh_title">联系电话</span>
                            <span class="operation1 operation_title">操作</span>
                        </div>
                        <c:forEach items="${listAddress}" var="address">
                            <c:if test="${address.isDefault==1}">
                                <div class="aim_content_one aim_active">
                                    <span class="dzmc dzmc_active">${address.recvTag}</span>
                                    <span class="dzxm dzxm_normal">${address.recvName}</span>
                                    <span class="dzxq dzxq_normal">${address.recvDistrict}${address.recvAddr}</span>
                                    <span class="lxdh lxdh_normal">${address.recvPhone}</span>
                                    <span class="operation1 operation_normal">
                                        <span class="aco_change">
                                            <a href="#" onclick="getAddress(${address.id})" style="color:#2ea8ee">修改</a>
                                        </span>
                                        |
                                        <span class="aco_delete">
                                            <a href="#" onclick="delAddress(${address.id})" style="color:#2ea8ee">删除</a>
                                        </span>
                                    </span>
                                    <span class="swmr swmr_normal"></span>
                                </div>
                            </c:if>
                            <c:if test="${address.isDefault==0}">
                                <div class="aim_content_two">
                                    <span class="dzmc dzmc_normal">${address.recvTag}</span>
                                    <span class="dzxm dzxm_normal">${address.recvName}</span>
                                    <span class="dzxq dzxq_normal">${address.recvDistrict}${address.recvAddr}</span>
                                    <span class="lxdh lxdh_normal">${address.recvPhone}</span>
                                    <span class="operation1 operation_normal">
                                        <span class="aco_change">
                                            <a href="#" onclick="getAddress(${address.id})" style="color:#2ea8ee">修改</a>
                                        </span>
                                        |
                                        <span class="aco_delete">
                                            <a href="#" onclick="delAddress(${address.id})" style="color:#2ea8ee">删除</a>
                                        </span>
                                    </span>
                                    <span class="swmr swmr_normal">
                                        <a onclick="setDefault1(${address.id})" >设为默认</a>
                                    </span>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer">
            <div class="go-to-top" style="display: none; left: 1310px;">
                <a href="/user/showAddress#" title="回顶部" class="icon"></a>
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
        <script src="<%=basePath%>js/order/jquery.page.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/order/orders.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/order/distpicker.data.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/order/distpicker.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/order/personal.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/allcity.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/userinfo.js"></script>
        <script type="text/javascript">

            //定义函数,删除数据
            function delAddress(id){
                if(confirm("确认要删除吗?")){
                    location="/address/deleteAddress?id="+id;
                }
            }

            //定义函数,显示要修改的数据
            function getAddress(id){
                $.ajax({
                    "url":"/address/getAddress",
                    "data":"id="+id,
                    "type":"GET",
                    "dataType":"json",
                    "success":function(obj){
                        if(obj.state==1){
                            $("#receiverName").val(obj.data.recvName);

                            $("#receiverMobile").val(obj.data.recvPhone);
                            $("#receiverPhone").val(obj.data.recvTel);
                            $("#receiverZip").val(obj.data.recvZip);
                            $("#addressName").val(obj.data.recvTag);
                            $("#receiverAddress").val(obj.data.recvAddr);
                            $("#id").val(obj.data.id);

                            getProvince(obj.data.recvProvince,obj.data.recvCity,obj.data.recvArea);
                            $(".save_recipient").html("修改收货人信息");
                            $("#update_form").attr("action","/address/updateAddress");
                        }
                    }

                });
            }

            //定义函数,出来处理这为默认

            function setDefault1(id){
                location="/address/setDefault?id="+id;
            }

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
    </body>
</html>
