/**
 * Created by yangyang on 2016/12/14.
 */
/*实现导航固定*/
$(function(){
    var nav=$("#top"); //得到导航对象
    var win=$(window); //得到窗口对象
    var sc=$(document);//得到document文档对象。
    /* win.scroll(function(){
        if(sc.scrollTop()>=60){
            nav.addClass("fixed_nav");
        }
        else{
            nav.removeClass("fixed_nav");
        }
    })
	win.scroll(); */
})
//nav 导航
$('#nav>ul>li').click(function(){
    $(this).children().addClass('activ');
    $(this).siblings().children().removeClass('activ');
})
//手风琴效果
$(function () {
    $(".bellows_item:first-child").addClass("bellows_open");
    $(".bellows_content-wrapper").hide();
    $(".bellows_header").click(function (){
        $(this).next().slideDown()
        $(this).parent(".bellows_item").addClass("bellows_open")
        $(".bellows_header").not(this).next().slideUp()
        $(".bellows_header").not(this).parent(".bellows_item").removeClass("bellows_open")
    });
    $('.bellows_header').on('click', 'h3', function (e) {
        $(e.target).removeClass('active').siblings('.active').addClass('active');
    });
})

//搜索下拉
$('.seek').focus(function(){

    if($(this).hasClass('clickhover')){

        $(this).removeClass('clickhover');
        $(this).find('.seek_content').hide();
        $(this).find('img').attr('src','../images/header/header_normal.png');

    }else{
        $(this).addClass('clickhover');
        $(this).find('.seek_content').show();
        $(this).find('img').attr('src','../images/header/header_true.png');
    }
})
$('.seek_content>div').click(function(){
    $('.seek').removeClass('clickhover');
    var text=$(this).html();
    $('.seek span').html(text);
    $(this).parent().hide();
    $('.seek').find('img').attr('src','../images/header/header_normal.png');
    $('.seek').blur();

})

$('.seek').blur(function(){

    $('.seek').removeClass('clickhover');
    $('.seek_content').hide();

    $('.seek').find('img').attr('src','../images/header/header_normal.png');
    console.log(1);
})

//自动轮播
$(function(){
    $('#banner .indicator li').click(function(){
        $(this).addClass('active').siblings('.active').removeClass('active');
        var i = $('#banner .indicator li').index(this);
        $($('#banner .inner .item')[i]).addClass('active').siblings('.active').removeClass('active');
    });
    //4个div的统一class = 'div'
    var index =0;
    //3秒轮播一次
    var timer = setInterval(function(){
        index = (index == 3) ? 0 : index + 1;
        //某个div显示，其他的隐藏
        $("#banner .indicator li").eq(index).addClass('active').siblings('.active').removeClass('active');
        $(".item").hide().eq(index).show();
    }, 3000);
})

//头部hover
$(".care").hover(function(){
    $(this).attr('src',"../images/header/care1.png");
},function(){
    $(this).attr('src',"../images/header/care.png");
});
$(".order").hover(function(){
    $(this).attr('src',"../images/header/order1.png");
},function(){
    $(this).attr('src',"../images/header/order.png");
});
$(".shopcar").hover(function(){
    $(this).attr('src',"../images/header/shop_car1.png");
},function(){
    $(this).attr('src',"../images/header/shop_car.png");
});
//首页按钮的渐变效果
$("#gourmet .food_detail .food1 a").addClass("gradient_pink");
$("#product_parameters_main .view_details").addClass("gradient_blue");

//$("#product_parameters_vice1 .view_details").addClass("ys");
//类目页按钮的渐变效果
$(".color_2").addClass("gradient_blue");
$(".color_1").addClass("gradient_pink");

//详情页特效
$('.aside_nav>p').click(function(){
    if($(this).hasClass('')){
        $(this).addClass('click has');
        $(this).siblings().removeClass('click');
        var pic=$(this).find('img').attr('src');

        var slicepic=pic.slice(0,-6);
        var newpic=slicepic+'.png';
        $(this).find('img').attr('src',newpic);
        $(this).siblings().each(function(){
            if($(this).hasClass('has')){
                var pic1=$(this).find('img').attr('src');

                var slicepic1=pic1.slice(0,-4);
                var newpic1=slicepic1+'_1.png';
                $(this).find('img').attr('src',newpic1);
                $(this).removeClass('has');
            }
        })
    }


})



	
 

















