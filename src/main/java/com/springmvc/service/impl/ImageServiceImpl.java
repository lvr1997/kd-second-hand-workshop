package com.springmvc.service.impl;

import com.springmvc.dao.ImageMapper;
import com.springmvc.pojo.Image;
import com.springmvc.service.ImageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("imageService")
public class ImageServiceImpl implements ImageService{

    @Resource
    private ImageMapper imageMapper;

    public int deleteByPrimaryKey(Integer id) {
        return imageMapper.deleteByPrimaryKey(id);
    }

    public int insert(Image record) {
        return imageMapper.insert(record);
    }

    public Image selectByPrimaryKey(Integer id) {
        return imageMapper.selectByPrimaryKey(id);
    }

    public List<Image> selectAll() {
        return imageMapper.selectAll();
    }

    public int updateByPrimaryKey(Image record) {
        return imageMapper.updateByPrimaryKey(record);
    }

    public List<Image> selectByGoodsPrimaryKey(Integer goods_id) {
        return imageMapper.selectByGoodsPrimaryKey(goods_id);
    }

    public int deleteImagesByGoodsPrimaryKey(Integer goods_id) {
        return imageMapper.deleteImagesByGoodsPrimaryKey(goods_id);
    }
}
