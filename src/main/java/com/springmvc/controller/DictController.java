package com.springmvc.controller;

import java.util.List;

import javax.annotation.Resource;

import com.springmvc.pojo.Area;
import com.springmvc.pojo.City;
import com.springmvc.pojo.Province;
import com.springmvc.pojo.ResponseResult;
import com.springmvc.service.DictService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/dict")
public class DictController {
	@Resource
	private DictService dictService;

	@RequestMapping("/showProvince")
	@ResponseBody
	public ResponseResult<List<Province>>
		showProvince(){
		ResponseResult<List<Province>> rr;
		List<Province> listp = 
				dictService.getProvinces();
		rr = new ResponseResult<List<Province>>();
		rr.setState(1);
		rr.setMessage("获取数据成功");
		rr.setData(listp);
		return rr;
	}
	
	@RequestMapping("/showCity")
	@ResponseBody
	public ResponseResult<List<City>> showCity(@RequestParam("provinceCode") String provinceCode){
		ResponseResult<List<City>> rr;
		List<City> listC = dictService.getCities(provinceCode);
		rr = new ResponseResult<List<City>>();
		rr.setState(1);
		rr.setMessage("获取数据成功");
		rr.setData(listC);
		return rr;
	}
	@RequestMapping("/showArea")
	@ResponseBody
	public ResponseResult<List<Area>> showArea(@RequestParam("cityCode")  String cityCode){
		ResponseResult<List<Area>> rr;
		List<Area> listA = dictService.getAreas(cityCode);
		
		rr = new ResponseResult<List<Area>>();
		rr.setData(listA);
		rr.setState(1);
		rr.setMessage("获取数据成功");
		return rr;
	}
	

}









