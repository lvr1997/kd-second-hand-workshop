package com.springmvc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.springmvc.dao.DictMapper;
import com.springmvc.pojo.Area;
import com.springmvc.pojo.City;
import com.springmvc.pojo.Province;
import org.springframework.stereotype.Service;

@Service("dictService")
public class DictServiceImpl implements com.springmvc.service.DictService {

	@Resource
	private DictMapper dictMapper;
	
	public List<Province> getProvinces() {
		return dictMapper.getProvinces();
	}

	public List<City> getCities(String provinceCode) {
		return dictMapper.getCities(provinceCode);
	}

	public List<Area> getAreas(String cityCode) {
		return dictMapper.getAreas(cityCode);
	}

}
