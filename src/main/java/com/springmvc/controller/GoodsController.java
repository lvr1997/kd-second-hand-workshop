package com.springmvc.controller;

import com.springmvc.pojo.*;
import com.springmvc.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/detail")
public class GoodsController {
    @Resource
    private WantedService wantedService;

    @Resource
    private GoodsService goodsService;

    @Resource
    private ImageService imageService;

    @Resource
    private CatelogService catelogService;

    @Resource
    private UserService userService;

    /**
     * 根据商品id查询该商品详细信息
     * @param id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/detail/{id}")
    public ModelAndView getGoodsById(HttpSession session, @PathVariable("id") Integer id, @RequestParam(value = "str",required = false) String str) throws Exception {
        Random random = new Random();
        User user = (User)session.getAttribute("cur_user");
        Wanted wanted = null;
        if(user!=null){
            wanted = wantedService.selectWant(user.getId(),id);
        }


        //五件闲置物品的集合
        List<Goods> commendGoods = new ArrayList<Goods>();
        //找出所有商品的id
        List<Goods> list = goodsService.selectPrimaryKey();

        for(int i=0;i<=5;i++){
            Integer num = random.nextInt(list.size());
            Goods good = goodsService.selectByPrimaryKey(list.get(num).getId());
            commendGoods.add(good);
        }
        List<GoodsExtend> commendExtends = new ArrayList<GoodsExtend>();
        for(Goods good:commendGoods){
            GoodsExtend commendExtend = new GoodsExtend();
            List<Image> imageList = imageService.selectByGoodsPrimaryKey(good.getId());
            commendExtend.setGoods(good);
            commendExtend.setImages(imageList);
            commendExtends.add(commendExtend);
        }

        //找出当前闲置
        Goods goodsFind = goodsService.selectByPrimaryKey(id);
        goodsService.updateViewCountByPrimaryKey(id,goodsFind.getViewcount()+1);
        Goods goods = goodsService.selectByPrimaryKey(id);
        //找出当前商品的用户信息
        User seller = userService.selectByPrimaryKey(goods.getUserId());
        //找出分类信息
        Catelog catelog = catelogService.selectByPrimaryKey(goods.getCatelogId());
        //找到闲置对应的图片信息
        GoodsExtend goodsExtend = new GoodsExtend();
        List<Image> imageList = imageService.selectByGoodsPrimaryKey(id);
        goodsExtend.setGoods(goods);
        goodsExtend.setImages(imageList);
        //返回数据
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("goodsExtend", goodsExtend);
        modelAndView.addObject("want",wanted);
        modelAndView.addObject("seller", seller);
        modelAndView.addObject("search",str);
        modelAndView.addObject("commend", commendExtends);
        modelAndView.addObject("catelog", catelog);
        modelAndView.setViewName("/detail/detail");
        return modelAndView;
    }

}
