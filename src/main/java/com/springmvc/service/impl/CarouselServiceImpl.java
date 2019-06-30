package com.springmvc.service.impl;

import com.springmvc.dao.CarouselMapper;
import com.springmvc.pojo.Carousel;
import com.springmvc.service.CarouselService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("carouselService")
public class CarouselServiceImpl implements CarouselService{

    @Resource
    private CarouselMapper carouselMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return carouselMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Carousel record) {
        return carouselMapper.insert(record);
    }

    @Override
    public Carousel selectByPrimaryKey(Integer id) {
        return carouselMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Carousel> selectAll() {
        return carouselMapper.selectAll();
    }

    @Override
    public int updateByPrimaryKey(Carousel record) {
        return carouselMapper.updateByPrimaryKey(record);
    }

    @Override
    public int updateStatusByPrimaryKey(Integer id, Byte status) {
        return carouselMapper.updateStatusByPrimaryKey(id,status);
    }

    @Override
    public List<Carousel> selectCarouselByStatus(Byte status) {
        return carouselMapper.selectCarouselByStatus(status);
    }

    @Override
    public List<Carousel> searchCarouselByTitleOrDescript(String title, String descript) {
        return carouselMapper.searchCarouselByTitleOrDescript(title,descript);
    }
}
