$(function() {
    layui.use(['element'], function() {
        var element = layui.element()
    })

    //第一次获取我的订单
    getReceived(1)
    getPublished(1)

    //获取我购买的订单列表
    function getReceived(page) {
        var url = '/user/order_buy'
        var Data = {
            page: page
        }
        Common.ajax(url, Data, function(data) {
            if (data.success) {
                if (data.result.length > 0) {
                    $('.comment-list').html('')
                    data.result.forEach(function(v) {
                        $('.comment-list').append('<li>' +
                            '<p>订单号: <b>' + v.orders.orderId + '</b> 支付订单: <b>' + v.orders.payId + '</b><span class="fr">购买于：' + v.orders.createAt + '</span></p>' +
                            '<p>闲置名称：' + v.good.name + '</a></p>'+
                            '<p>收货地址： ' + v.address.recvDistrict + '<span class="fr">订单状态：' + v.orders.status + '</span></p>' +
                            '</li>')
                    })

                } else {
                    $('.comment-list').html('<div class="nodata">您还没有购买过闲置</div>')
                }

                /*layui.laypage({
                    cont: 'page1',
                    pages: data.num.count,
                    first: 1,
                    curr: page || 1,
                    prev: '<em><</em>',
                    next: '<em>></em>',
                    jump: function(obj, first) {
                        var curr = obj.curr
                        if (!first) {
                            getReceived(curr)
                        }
                    }
                });*/
            } else {
                layer.msg(data.msg)
            }
        }, function(err) {
            console.log(err)
        }, function() {}, true, 'POST')
    }

    //我出售的闲置
    function getPublished(page) {
        var url = '/user/published_order'
        var Data = {
            page: page
        }
        Common.ajax(url, Data, function(data) {
            if (data.success) {
                if (data.result.length > 0) {
                    $('.published-comment-list').html('')
                    data.result.forEach(function(v) {
                        $('.published-comment-list').append('<li><div class="list-header">'+
                            '<p><span><b>出售时间：'+v.orders.createAt+'</b></span><span class="fr"><b>订单号：'+v.orders.orderId+'</b></span></p>'+
                            '</div>'+
                            '<div class="list-main clearfix">'+
                                '<img src="http://localhost:8088/images/web/'+v.images[0].imgUrl+'" >'+
                                '<div class="good-info fl">'+
                            '<p class="goods-price">￥<span>'+v.good.price+'</span></p>'+
                            '<p class="goods-price">收货地址：<span>'+v.address.recvDistrict+'</span></p>'+
                            '</div>'+
                            '<div class="operation fr">'+
                                '<a>已出售</a>'+
                                '</div>'+
                                '</div></li>')
                    })
                } else {
                    $('.published-comment-list').html('<div class="nodata">您还没有出售过闲置</div>')
                }
               /* layui.laypage({
                    cont: 'page2',
                    pages: data.num.count,
                    first: 1,
                    curr: page || 1,
                    prev: '<em><</em>',
                    next: '<em>></em>',
                    jump: function(obj, first) {
                        var curr = obj.curr
                        if (!first) {
                            getPublished(curr)
                        }
                    }
                });*/
            } else {
                layer.msg(data.msg)
            }
        }, function(err) {
            console.log(err)
        }, function() {}, true, 'POST')
    }
})