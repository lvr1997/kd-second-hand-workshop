package com.springmvc.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.springmvc.pojo.Address;
import com.springmvc.pojo.ResponseResult;
import com.springmvc.pojo.User;
import com.springmvc.service.AddressService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/address")
public class AddressController{
	@Resource
	private AddressService addressService;

	
	@RequestMapping("/add")
	public String add(HttpSession session,
			@RequestParam("receiverName")String recvName,
			@RequestParam("receiverState")String recvProvince,
			@RequestParam("receiverCity")String recvCity,
			@RequestParam("receiverDistrict")String recvArea,
			@RequestParam("receiverAddress")String recvAddr,
			@RequestParam("receiverMobile")String recvPhone,
			@RequestParam("receiverPhone")String recvTel,
			@RequestParam("receiverZip")String recvZip,
			@RequestParam("addressName")String recvTag){
		User user = (User)session.getAttribute("cur_user");
		Address address = new Address();
		address.setUid(user.getId());
		address.setRecvName(recvName);
		address.setRecvProvince(recvProvince);
		address.setRecvCity(recvCity);
		address.setRecvArea(recvArea);
		address.setRecvAddr(recvAddr);
		address.setRecvPhone(recvPhone);
		address.setRecvTel(recvTel);
		address.setRecvZip(recvZip);
		address.setRecvTag(recvTag);
		addressService.addAddress(address);
		
		return "redirect:/user/address";
		
	}
	@RequestMapping("/setDefault")
	public String setDefault(Integer id,HttpSession session){
		User user = (User)session.getAttribute("cur_user");
		addressService.setDefault(user.getId(), id);
		return "redirect:/user/address";
	}

	@RequestMapping("/setOrderDefault")
	@ResponseBody
	public ResponseResult<Void> setOrderDefault(Integer id,HttpSession session){
		User user = (User)session.getAttribute("cur_user");
		System.out.println("setOrderDefault--id："+id);
		addressService.setDefault(user.getId(), id);
		ResponseResult<Void> rr = new ResponseResult<Void>(1,"更改成功");
		return rr;
	}


	@RequestMapping("/getAddress")
	@ResponseBody
	public ResponseResult<Address> getAddress(Integer id){
		Address address = addressService.getAddressById(id);
		ResponseResult<Address> rr ;
		rr = new ResponseResult<Address>(1,"获取数据成功");
		rr.setData(address);
		return rr;
	}
	@RequestMapping("/updateAddress")
	public String updateAddress(Integer id,@RequestParam("receiverName")String recvName,
			@RequestParam("receiverState")String recvProvince,
			@RequestParam("receiverCity")String recvCity,
			@RequestParam("receiverDistrict")String recvArea,
			@RequestParam("receiverAddress")String recvAddr,
			@RequestParam("receiverMobile")String recvPhone,
			@RequestParam("receiverPhone")String recvTel,
			@RequestParam("receiverZip")String recvZip,
			@RequestParam("addressName")String recvTag){
		Address address = new Address();
		address.setId(id);
		address.setRecvName(recvName);
		address.setRecvProvince(recvProvince);
		address.setRecvCity(recvCity);
		address.setRecvArea(recvArea);
		address.setRecvAddr(recvAddr);
		address.setRecvPhone(recvPhone);
		address.setRecvTel(recvTel);
		address.setRecvZip(recvZip);
		address.setRecvTag(recvTag);

		addressService.updateAddress(address);

		return "redirect:/user/address";
	}
	
	@RequestMapping("/deleteAddress")
	public String deleteAddress(Integer id,
			HttpSession session){
		User user = (User)session.getAttribute("cur_user");
		Integer uid = user.getId();
		addressService.deleteAddress(uid, id);
	return "redirect:/user/address";
	}
	
}













