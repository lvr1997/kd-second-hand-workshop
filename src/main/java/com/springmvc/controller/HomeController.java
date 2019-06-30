package com.springmvc.controller;

import com.springmvc.ex.PageNotFoundException;
import com.springmvc.pojo.*;
import com.springmvc.service.CarouselService;
import com.springmvc.service.CatelogService;
import com.springmvc.service.GoodsService;
import com.springmvc.service.ImageService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/goods")
public class HomeController {

    @Resource
    private GoodsService goodsService;

    @Resource
    private ImageService imageService;

    @Resource
    private CatelogService catelogService;

    @Resource
    private CarouselService carouselService;



    /**
     * 首页显示商品，查询所有的商品，按照商品刷新时间排序
     * 左侧显示浏览量最多的商品数据，按照浏览数排序
     * 首页显示分类数据，放入分类菜单
     * @return
     */
    @RequestMapping(value = "/index")
    public ModelAndView Home(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        try{
            List<GoodsExtend> goodsAndImage = null;
            //浏览量排序的数据
            List<GoodsExtend> goods_intruAndImage = null;

            //获取轮播图数据
            List<Carousel> carouselList = carouselService.selectCarouselByStatus((byte)1);

            //所有没有禁用的分类
            List<Catelog> catelogs = catelogService.getAllCatelogByStatus((byte)1);
            //所有没有被下架的闲置
            List<Goods> goodsList = goodsService.selectGoodsByStatusOrderByPolishTime((byte)1);
            //获取浏览量最多的前十件物品
            Integer limit = Integer.valueOf(10);
            List<Goods> goods_intru = goodsService.selectGoodsByStatusOrderByViewcountLimit((byte)1,limit);
            //把图片和闲置信息绑定在一起
            goodsAndImage = handlerGoodsAndView(goodsList);
            goods_intruAndImage = handlerGoodsAndView(goods_intru);


            modelAndView.addObject("carousel",carouselList);
            modelAndView.addObject("Goods1", goodsAndImage);
            modelAndView.addObject("Catelog1",catelogs);
            modelAndView.addObject("Goods2", goods_intruAndImage);

            modelAndView.setViewName("/index");
            return modelAndView;
        }catch (Exception e){
            modelAndView.setViewName(handException(e,request));
            return modelAndView;
        }


    }

    /**
     * 注意：
     * 在异常处理方法中不能注入modelMap对象
     * 否则不能工作，如果需要向JSP传递数据，
     * 可以利用request的setAttribute方法传输数据
     * @param e
     * @param request
     * @return
     */
    @ExceptionHandler(PageNotFoundException.class)
    private String handException(Exception e,HttpServletRequest request){
        request.setAttribute("errorMessage",e.getMessage());
        return "/error/404";
    }

    /**
     * 处理商品和图片之间的关联
     * @param goodsList 商品图片集合
     * @return  商品图片集合
     */
    public List<GoodsExtend> handlerGoodsAndView(List<Goods> goodsList){
        List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
        for (int i = 0; i < goodsList.size() ; i++) {
            //将闲置信息和image信息封装到GoodsExtend类中s
            GoodsExtend goodsExtend = new GoodsExtend();
            Goods goods = goodsList.get(i);
            List<Image> images = imageService.selectByGoodsPrimaryKey(goods.getId());
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(images);
            goodsAndImage.add(i, goodsExtend);
        }
        return goodsAndImage;
    }

    /**
     * 查询该类商品
     * @param cid
     * 要求该参数不为空
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/catelog/{id}")
    public ModelAndView catelogGoods(HttpServletRequest request, @PathVariable("id") Integer cid) throws Exception {
        List<Goods> goodsList = goodsService.selectByCatelogAndStatus(cid,(byte)1);
        System.out.println(goodsList);
        Catelog catelog = catelogService.selectByPrimaryKey(cid);
        List<Catelog> catelogs = catelogService.getAllCatelogByStatus((byte)1);
        List<GoodsExtend> goodsExtendList = handlerGoodsAndView(goodsList);
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.addObject("goodsExtendList", goodsExtendList);

        modelAndView.addObject("catelog", catelog);

        modelAndView.addObject("catelogs", catelogs);

        modelAndView.setViewName("/category/category_list");
        return modelAndView;
    }

    @RequestMapping(value = "/city")
    public @ResponseBody
    ModelAndView getCity(){
        ModelAndView modelAndView = new ModelAndView();
        Map<String,Object> list = new HashMap<String, Object>();
        list.put("city","全国");
        modelAndView.addObject("success",true);
        modelAndView.addObject("content",list);
        modelAndView.setViewName("/city");
        return modelAndView;
    }
    @RequestMapping(value = "/set_city")
    public @ResponseBody
    Map<String,Object> setCity(){
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("success",true);
        map.put("msg","切换成功");
        return map;
    }


}
