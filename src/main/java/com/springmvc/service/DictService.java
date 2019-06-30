package com.springmvc.service;

import java.util.List;

import com.springmvc.pojo.Area;
import com.springmvc.pojo.City;
import com.springmvc.pojo.Province;

public interface DictService {
	List<Province> getProvinces();
	List<City> getCities(String provinceCode);
	List<Area> getAreas(String cityCode);

}







