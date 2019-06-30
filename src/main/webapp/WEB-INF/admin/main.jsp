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
            用户管理
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
        <div class="x-nav">
            <span class="layui-breadcrumb">
              <a><cite>用户管理</cite></a>
            </span>
            <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="/admin/main" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
        </div>
        <div class="x-body">
        <form class="layui-form x-center" action="/search/searchuser" style="width:500px" type="post">
                <div class="layui-form-pane">
                  <div class="layui-form-item">
                    <div class="layui-input-inline" style="width:400px">
                      <input type="text" name="username"  placeholder="搜索用户" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline" style="width:80px">
                        <input type="submit" lay-submit lay-filter="search" value="搜索" class="layui-input"/>
                    </div>
                  </div>
                </div> 
            </form>
          <xblock>
            <button class="layui-btn" onclick="user_add('添加用户信息','/admin/person_add','400','400')"><i class="layui-icon">&#xe608;</i>添加</button>
            <button class="x-right layui-btn" style="line-height:10px">共有数据：${fn:length(result)} 条</button>
          </xblock>
            <table class="layui-table">
                <thead>
                    <tr>
	                    <th>
	                        用户名
	                    </th>
	                    <th>
	                        唯一标识
	                    </th>
	                    <th>
	                        手机
	                    </th>
	                    <th>
	                        性别
	                    </th>
	                    <th>
	                        闲置数量
	                    </th>
	                    <th>
	                        创建时间
	                    </th>
	                    <th>
	                        权限
	                    </th>
	                    <th>
	                        最后登录时间
	                    </th>
	                    <th>
	                        操作
	                    </th>
                    </tr>
                </thead>
                <tbody class="user-list">
                    <c:forEach items="${result}" var="item">
                    <tr>
                        <td>
                            ${item.username}
                        </td>
                        <td>
                        <u style="cursor:pointer" onclick="question_show()">
                            ${item.id}
                        </u>
                        </td>
                        <td >
                            ${item.phone}
                        </td>
                        <td >
                            ${item.sex}
                        </td>
                        <td >
                            ${item.goodsNum}
                        </td>
                        <td >
                            ${item.createAt}
                        </td>
                        <td>
                            ${item.power}
                        </td>
                        <td>
                            ${item.lastLogin}
                        </td>
                        <td class="td-manage">
                            <a title="修改权限" href="javascript:;" onclick="user_look('修改权限','/admin/person_look/${item.id}','${item.id}','400','400')"
                               class="ml-5" style="text-decoration:none">
                                <i class="layui-icon"><img src="<%=basePath%>images/admin/look.png" width="15" height="15"></img></i>
                            </a>
                            <a title="删除" href="javascript:;" onclick="user_del(this,${item.id})"
                               style="text-decoration:none">
                                <i class="layui-icon">&#xe640;</i>
                            </a>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <%--<div id="page"></div>--%>
        </div>
        <br /><br /><br />
        <script src="<%=basePath%>css/lib/layui/layui.js" charset="utf-8"></script>
        <script src="<%=basePath%>js/admin/x-layui.js" charset="utf-8"></script>
        <script>
            layui.use(['laydate','element','laypage','layer'], function(){
                $ = layui.jquery;//jquery
                  laydate = layui.laydate;//日期插件
                  lement = layui.element();//面包导航
                  laypage = layui.laypage;//分页
                  layer = layui.layer;//弹出层


              //以上模块根据需要引入
             /* laypage({
                cont: 'page'
                ,pages: 4
                ,first: 1
                ,last: 4
                ,prev: '<em><</em>'
                ,next: '<em>></em>'
              }); */
              
            });


            function question_show (argument) {
            layer.msg('唯一标识',{icon:1,time:1000});
            }
             /*添加*/
            function user_add(title,url,w,h){
                x_admin_show(title,url,w,h);
            }
            //查看
            function user_look (title,url,id,w,h) {
                x_admin_show(title,url,w,h);
            }

            /*删除*/
            function user_del(obj,id){
                layer.confirm('确认要删除吗？',function(index){
                    $.ajax({
                        url:"/admin/deleteUser",
                        data:{
                            id:id
                        },
                        type:"GET",
                        dataType:"json",
                        success:function (data) {

                        }
                    })
                    layer.msg('已删除!',{icon:1,time:1500});
                    $(obj).parents("tr").remove();
                });
            }
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