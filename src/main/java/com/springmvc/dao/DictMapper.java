package com.springmvc.dao;

import java.util.List;

import com.springmvc.pojo.Area;
import com.springmvc.pojo.City;
import com.springmvc.pojo.Province;

public interface DictMapper {

	List<Province> getProvinces();
	List<City> getCities(String provinceCode);
	List<Area> getAreas(String cityCode);
	String  getProvinceByCode(String code);
	String  getCityByCode(String code);
	String  getAreaByCode(String code);
}









