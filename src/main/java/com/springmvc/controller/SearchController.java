package com.springmvc.controller;

import com.springmvc.pojo.*;
import com.springmvc.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;


/**
 * 搜索请求的控制器
 */
@Controller
@RequestMapping("/search")
public class SearchController {
    @Resource
    private UserService userService;

    @Resource
    private ReportService reportService;

    @Resource
    private GoodsService goodsService;

    @Resource
    private ImageService imageService;

    @Resource
    private CommentsService commentsService;

    @Resource
    private CatelogService catelogService;

    @Resource
    private CarouselService carouselService;

    @Resource
    private OrdersService ordersService;

    @Resource
    private AddressService addressService;

    /**
     * 搜索用户
     * @param username
     * @return
     */
    @RequestMapping(value = "/searchuser")
    public ModelAndView searchUser(String username){
        List<User> userList= userService.searchUserByNameOrPhone(username,username);
        ModelAndView map = new ModelAndView();
        map.addObject("result",userList);
        map.setViewName("/admin/main");
        return map;
    }

    /**
     * 搜索轮播图
     * @param keyword
     * @return
     */
    @RequestMapping(value="/searchhome")
    public ModelAndView searchHome(String keyword){
        ModelAndView modelAndView = new ModelAndView();
        List<Carousel> carouselList = carouselService.searchCarouselByTitleOrDescript(keyword,keyword);
        modelAndView.addObject("CarouselListResult",carouselList);
        modelAndView.setViewName("/admin/Home");
        return modelAndView;
    }

    /**
     * 搜索闲置
     * @param keyword
     * @return
     */
    @RequestMapping(value = "/searchgood")
    public ModelAndView searchGood(String keyword){
        List<CatelogExtend> catelogExtendList = new ArrayList<CatelogExtend>();
        List<Goods> goodsList = goodsService.searchGoodsByKeyWord(keyword,keyword);
        for (Goods goods:goodsList) {
            Catelog catelog = catelogService.selectByPrimaryKey(goods.getCatelogId());
            User user = userService.selectByPrimaryKey(goods.getUserId());
            List<Image> images = imageService.selectByGoodsPrimaryKey(goods.getId());
            CatelogExtend catelogExtend = new CatelogExtend(goods,catelog,user,images);
            catelogExtendList.add(catelogExtend);
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("GoodsResult",catelogExtendList);
        modelAndView.setViewName("/admin/good");
        return modelAndView;
    }

    /**
     * 搜索分类
     * @param keyword
     * @return
     */
    @RequestMapping("/searchcatelog")
    public ModelAndView searchCatelog(String keyword){
        System.out.println("keyword: "+keyword);
        List<Catelog> catelogs = catelogService.searchCatelogByName(keyword);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catelogResult",catelogs);
        modelAndView.setViewName("/admin/catelog");
        return modelAndView;
    }

    /**
     * 搜索举报物品信息
     * @param keyword
     * @return
     */
    @RequestMapping("/searchreport")
    public ModelAndView searchReport(String keyword){
        List<Report> reportList= reportService.selectAll();
        List<ReportExtend> reportExtendList = new ArrayList<ReportExtend>();
        for (Report report:reportList) {
            Goods goods = goodsService.searchGoodsByKeyWordAndPrimary(report.getGoodId(),keyword,keyword);
            if(goods!=null){
                List<Image> images = imageService.selectByGoodsPrimaryKey(goods.getId());
                User user = userService.selectByPrimaryKey(report.getUserId());
                ReportExtend reportExtend = new ReportExtend(report,goods,images,user);
                reportExtendList.add(reportExtend);
            }
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("reportResult",reportExtendList);
        modelAndView.setViewName("/admin/report");
        return modelAndView;
    }

    @RequestMapping("/searchcomments")
    public ModelAndView searchComments(String keyword){
        List<Comments> comments = commentsService.searchCommentsByContent(keyword);
        List<CommentsExtend> commentsExtendList = new ArrayList<CommentsExtend>();
        for(Comments comment:comments){
            CommentsExtend commentsExtend = new CommentsExtend();
            Goods goods = goodsService.selectByPrimaryKey(comment.getGoodsId());
            User user = userService.selectByPrimaryKey(comment.getUserId());
            commentsExtend.setUser(user);
            commentsExtend.setGoods(goods);
            commentsExtend.setComments(comment);
            commentsExtendList.add(commentsExtend);
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("commentsResult",commentsExtendList);
        modelAndView.setViewName("/admin/comments");
        return modelAndView;
    }


    @RequestMapping(value = "/searchorder")
    public ModelAndView order(HttpSession session,String keyword){
        System.out.println("keyWord: "+keyword);
        List<OrdersExtend> ordersExtends = new ArrayList<OrdersExtend>();
        List<Orders> orders = ordersService.selectAll();
        for(Orders order: orders){
            OrdersExtend ordersExtend = new OrdersExtend();
            Goods goods = goodsService.selectByPrimaryKey(order.getGoodId());
            Address address = addressService.selectByPrimaryKey(order.getAddressId());
            List<Image> images = imageService.selectByGoodsPrimaryKey(goods.getId());
            User user = userService.selectByPrimaryKey(order.getUserId());
            ordersExtend.setUser(user);
            ordersExtend.setOrders(order);
            ordersExtend.setImages(images);
            ordersExtend.setAddress(address);
            ordersExtend.setGood(goods);
            ordersExtends.add(ordersExtend);
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("ordersExtends",ordersExtends);
        return modelAndView;
    }

}
