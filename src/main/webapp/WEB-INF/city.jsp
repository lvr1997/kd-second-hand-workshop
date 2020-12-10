<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>切换城市</title>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui.all.js"></script>
    <link rel="stylesheet" href="<%=basePath%>js/css/layui.css">

    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <script src="<%=basePath%>js/common.js"></script>
    <style>
        html, body{ background-color: #fff; }
        .header{ text-align: center; font-size: 20px; color: #11cd6e; line-height: 60px; }
        /*ul{ padding: 20px 0; }*/
        ul li{ float: left; margin-left: 20px; margin-bottom: 20px; }
        ul li a{ display: block; width: 98px; height: 48px; border: #dcdcdc solid 2px; line-height: 48px; text-align: center; }
        ul li a:hover{ border-color: #11cd6e; }
    </style>
</head>
<body>
<div class="header">点击切换</div>
<ul>
    <c:forEach var="item" items="content">
        <li>
            <a href="javascript:;" class="citys" data-id="1" style=border-color:#11cd6e;>全国</a>
        </li>
    </c:forEach>
</ul>
<script>
    $(function(){
        $('.citys').click(function(){
            var url = '/goods/set_city'
            var Data = { id: $(this).attr('data-id')}
            Common.ajax(url, Data, function (data) {
                if(data.success){
                    parent.location.reload()
                }else{
                    layer.msg(data.msg);
                }
            }, function (err) {
                console.log(err)
            }, function () {}, true, 'POST')
        })

    })
</script>
</body>
</html>
