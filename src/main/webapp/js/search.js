$(function(){
	$('.search-page-btn').click(function(){
		location.href = '/user/search?keywords=' + $('.keywords').val()
	})

	/*layui.use(['laypage'], function(){
		var laypage = layui.laypage

		laypage({
            cont: 'page', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
            pages: count, //通过后台拿到的总页数
            curr: Common.getQuery('page') || 1, //当前页
            jump: function(obj, first){ //触发分页后的回调
                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
                    location.href = '/user/search?keywords=' + location.href.split('keywords=')[1].split('&page=')[0] + '&page=' + obj.curr
                }
            }
        })
	})*/
})