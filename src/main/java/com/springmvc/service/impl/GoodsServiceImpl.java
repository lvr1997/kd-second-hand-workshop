package com.springmvc.service.impl;

import com.springmvc.dao.GoodsMapper;
import com.springmvc.pojo.Goods;
import com.springmvc.service.GoodsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

    @Resource
    private GoodsMapper goodsMapper;

    /**
     * 通过ID删除闲置
     * @param id 闲置主键
     * @return
     */
    public int deleteByPrimaryKey(Integer id) {
        return goodsMapper.deleteByPrimaryKey(id);
    }

    /**
     * 添加闲置
     * @param record 闲置信息
     * @return
     */
    public int insert(Goods record) {
        return goodsMapper.insert(record);
    }

    /**
     * 通过闲置id查找闲置
     * @param id
     * @return
     */
    public Goods selectByPrimaryKey(Integer id) {
        return goodsMapper.selectByPrimaryKey(id);
    }


    /**
     * 通过闲置id更新闲置信息
     * @param record 闲置信息
     * @return
     */
    public int updateByPrimaryKey(Goods record) {
        return goodsMapper.updateByPrimaryKey(record);
    }

    /**
     * 查找所有闲置
     * @return
     */
    public List<Goods> selectAllGoods() {
        return goodsMapper.selectAllGoods();
    }

    /**
     * 通过名称和描述模糊查询闲置
     * @param name
     * @param describle
     * @return
     */
    public List<Goods> searchGoods(String name, String describle,Byte status) {
        return goodsMapper.searchGoods(name,describle,status);
    }

    /**
     * 通过分类和状态查找闲置
     * @param catelog_id
     * @param status
     * @return
     */
    public List<Goods> selectByCatelogAndStatus(Integer catelog_id,Byte status) {
        return goodsMapper.selectByCatelogAndStatus(catelog_id,status);
    }

    /**
     * 通过分类id查询limit件闲置
     * @param catelogId
     * @param limit
     * @return
     */
    public List<Goods> selectByCatelogOrderByPolishDate(Integer catelogId, Integer limit) {
        return goodsMapper.selectByCatelogOrderByPolishDate(catelogId,limit);
    }

    /**
     * 查询闲置按照擦亮时间排序
     * @param limit
     * @return
     */
    public List<Goods> selectGoodsOrderByDate(Integer limit) {
        return goodsMapper.selectGoodsOrderByDate(limit);
    }

    @Override
    public List<Goods> selectGoodsByCatelogStatus(Integer catelogId) {
        return goodsMapper.selectGoodsByCatelogStatus(catelogId);
    }

    /**
     * 通过用户查找闲置
     * @param user_id
     * @return
     */
    public List<Goods> getGoodsByUserId(Integer user_id) {
        return goodsMapper.getGoodsByUserId(user_id);
    }

    /**
     * 查找所有闲置的id
     * @return
     */
    public List<Goods> selectPrimaryKey() {
        return goodsMapper.selectPrimaryKey();
    }

    /**
     * 通过id更新浏览次数
     * @param id
     * @param viewCount
     * @return
     */
    public int updateViewCountByPrimaryKey(Integer id, Integer viewCount) {
        return goodsMapper.updateViewCountByPrimaryKey(id,viewCount);
    }

    /**
     * 通过状态查找并按浏览次数排序
     * @param status
     * @param limit
     * @return
     */
    public List<Goods> selectGoodsByStatusOrderByViewcountLimit(Byte status,Integer limit) {
        return goodsMapper.selectGoodsByStatusOrderByViewcountLimit(status,limit);
    }

    /**
     * 通过id更新擦亮时间
     * @param gid
     * @param polishTime
     * @return
     */
    @Override
    public int updatePolishTimeByPrimaryKey(Integer gid, String polishTime) {
        return goodsMapper.updatePolishTimeByPrimaryKey(gid,polishTime);
    }

    /**
     * 通过状态查找闲置并按照擦亮时间排序
     * @param status
     * @return
     */
    @Override
    public List<Goods> selectGoodsByStatusOrderByPolishTime(Byte status) {
        return goodsMapper.selectGoodsByStatusOrderByPolishTime(status);
    }

    /**
     * 通过id更新状态
     * @param gid
     * @param status
     * @return
     */
    @Override
    public int updateStatusByPrimaryKey(Integer gid, Byte status) {
        return goodsMapper.updateStatusByPrimaryKey(gid,status);
    }

    @Override
    public int updateEndTimeByPrimaryKey(Integer gid, String endTime) {
        return goodsMapper.updateEndTimeByPrimaryKey(gid,endTime);
    }

    @Override
    public int updateCommentNumByPrimaryKey(Integer gid, Integer commentNum) {
        return goodsMapper.updateCommentNumByPrimaryKey(gid,commentNum);
    }

    @Override
    public List<Goods> searchGoodsByKeyWord(String name, String describle) {
        return goodsMapper.searchGoodsByKeyWord(name,describle);
    }

    @Override
    public Goods searchGoodsByKeyWordAndPrimary(Integer id, String name, String describle) {
        return goodsMapper.searchGoodsByKeyWordAndPrimary(id,name,describle);
    }


}
