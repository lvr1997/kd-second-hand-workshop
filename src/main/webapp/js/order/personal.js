
/*****************************************************地址管理页面js********************************************************/
/**
 * 地址页面添加名称至输入框
 */
$(".sp").click(function(){
	var value = $(this).html();
	$("#addressName").val(value);
})

/**
 * 手机号码中间4位以*号代替转换
 * @param {Object} phone
 */
function changePhone(phone){
	var dh=phone.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2');
	return dh;
}
/**
 * 校验手机号码格式是否正确
 */
$("#receiverMobile").blur(function(){
	
	var regex = /^1[3|4|5|8][0-9]\d{4,8}$/; 
	var value = $(this).val();
	console.log(value);
	if(!regex.test(value)){
		console.log("格式不对")
	}
})

/**
 * 提交表单时，校验必填项是否填写完整
 */
$(".save_recipient").click(function(){
	var receiverName = $("#receiverName").val();// 收件人
	var receiverState = $("#receiverState").val();// 省
	var receiverCity = $("#receiverCity").val();// 市
	var receiverDistrict = $("#receiverDistrict").val();// 区/县
	var receiverAddress = $("#receiverAddress").val();// 
	var receiverMobile = $("#receiverMobile").val();
	if(receiverName && receiverState && receiverCity && receiverDistrict && receiverAddress && receiverMobile){
		$("form").submit();
	}else{
		alert("请将必填信息填写完整");
	}
})

/**
 * 地址设为默认点击事件
 */
$(function(){
	$(".swmr_normal").click(function(){
		setDefault(this);
	})
})

/**
 * 设置默认方法
 * @param {Object} e
 */
function setDefault(e){
	var parent = $(e).parent();
	if($(parent).siblings().hasClass("aim_active")){
		$(parent).siblings().removeClass("aim_active");
		$(parent).siblings().children(".dzmc_active").removeClass("dzmc_active").addClass("dzmc_normal");
		$(parent).siblings().children(".swmr_normal").html("设为默认")
	}
	$(parent).addClass("aim_active");
	$(parent).children(".dzmc_normal").removeClass("dzmc_normal").addClass("dzmc_active");
	$(e).html("");
}


$(function(){
	$(".aco_delete").click(function(){
		if(confirm("确定删除吗？")){
			var url = "";
			var param = "";
			$.post(url,{data:param},function(data){
				
			},"json");
		}
		
	})
})


/*****************************************************个人信息管理页面js********************************************************/

/**
 * 这是个人信息页面js
 */
// 跳页面
function toPage(page){
	window.location.href=page;
}


/**
 * 性别选择男
 */
$(".man").click(function(){
	if(!$(".man").hasClass("selected")){
		$(".man").addClass("selected");
		$(".man img").attr("src","../images/personage/select.png");
		$(".women").removeClass("selected");
		$(".women img").attr("src","../images/personage/un_select.png");
	}
})

/**
 * 性别选择女
 */
$(".women").click(function(){
	if(!$(".women").hasClass("selected")){
		$(".women").addClass("selected");
		$(".women img").attr("src","../images/personage/select.png");
		$(".man").removeClass("selected");
		$(".man img").attr("src","../images/personage/un_select.png");
	}
})
/**
 * 更改用户名，变成可编辑状态
 */
$(".change_username").click(function(){
	var parent = $(".change_username").parent();
	$(parent).children(".rs_username").hide();
	var name = $(parent).children(".rs_username").html();
	$(parent).children(".ed_username").val(name);
	$(parent).children(".ed_username").show();
})

/**
 * 更改邮箱，变成可编辑状态
 */
$(".change_mail").click(function(){
	var parent = $(".change_mail").parent();
	$(parent).children(".rs_mail").hide();
	var email = $(parent).children(".rs_mail").html();
	console.log(email)
	$(parent).children(".ed_email").val(email);
	$(parent).children(".ed_email").show();
})
