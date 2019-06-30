package com.springmvc.controller;


import com.springmvc.ex.PhoneNotFoundException;
import com.springmvc.pojo.*;
import com.springmvc.service.*;
import com.springmvc.util.MD5;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

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

    @RequestMapping(value = "/toLogin")
    public String toLogin(HttpSession session){
        session.setAttribute("admin",null);
        return "/admin/login";
    }

    @RequestMapping(value = "/login",method = {RequestMethod.POST , RequestMethod.GET})
    public @ResponseBody Map<String, Object> login(HttpSession session,
                              @RequestParam(value = "phone",required = false)String phone,
                              @RequestParam(value = "password",required = false)String password){

        Map<String, Object> map = new HashMap<String, Object>();
        try{
        User user = userService.getUserByPhone(phone);
            if(user != null) {
                //用户信息存在
                String word = MD5.md5(password);
                if(user.getPassword().equals(word)&&user.getPower()>50) {
                    session.setAttribute("admin",user);
                    map.put("success", true);
                    map.put("reurl","http://localhost:8080/admin/index");
                    map.put("msg", "登录成功");
                }else{
                    //密码不正确
                    map.put("err",true);
                    map.put("msg","登录失败,权限不足");
                }
            }
        }catch (PhoneNotFoundException e){
            //用户不存在
            //返回失败数据
            map.put("success",false);
            map.put("msg",e.getMessage());
            return map;
        }
        return map;
    }


    @RequestMapping(value = "/logout")
    public String logout(HttpSession session){
        session.setAttribute("admin",null);
        return "/admin/login";
    }


    /**
     * 后台管理页面
     * @return
     */
    @RequestMapping(value = "/index")
    public String adminIndex(){
        return "/admin/index";
    }

    /**
     * 添加用户页面
     * @return
     */
    @RequestMapping(value = "/person_add")
    public String adminAddUser(){
        return "/admin/person_add";
    }

    /**
     * 用户管理首页
     * @return
     */
    @RequestMapping(value = "/main")
    public ModelAndView adminMain(){
        List<User> userList= userService.selectAll();
        ModelAndView map = new ModelAndView();
        map.addObject("result",userList);
        map.setViewName("/admin/main");
        return map;
    }

    /**
     * 处理请求查看用户信息页面
     * @param id
     * @return
     */
    @RequestMapping(value = "/person_look/{id}")
    public ModelAndView person_look(@PathVariable("id")Integer id){
        System.out.println(id);
        User user = userService.selectByPrimaryKey(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("user",user);
        modelAndView.setViewName("/admin/person_look");
        return modelAndView;
    }

    /**
     * 处理请求删除用户信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/deleteUser")
    public @ResponseBody Map<String,Object> person_delete(@RequestParam("id")Integer id){
        /*
        删除操作
         */
        Map<String,Object> map = new HashMap<String,Object>();
        try{
            userService.deleteByPrimaryKey(id);
            map.put("success",true);
            map.put("msg","删除成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
            map.put("msg","删除失败");
        }
        return map;
    }

    /**
     * 保存修改用户权限信息
     * @param id 用户Id
     * @param power 新的权限信息
     * @return
     */
    @RequestMapping(value = "/save_user")
    public @ResponseBody Map<String,Object> save_user(Integer id,Integer power){
        System.out.println(id+", power:"+power);
        Map<String,Object> map = new HashMap<String,Object>();
        if(power>=0 && power<=100){
            userService.updatePowerByPrimaryKey(id,power);
            map.put("success",true);
            map.put("msg","修改成功");
        }else{
            map.put("success",false);
            map.put("msg","权限范围不正确");
        }
        return map;
    }

    /**
     * 处理添加用户信息
     * @param username
     * @param password
     * @param phone
     * @param sex
     * @param power
     * @return
     */
    @RequestMapping(value = "/add_user")
    public @ResponseBody Map<String,Object> add_user(String username,String password,String phone,String sex,Byte power){
        System.out.println(username+", "+password+", "+phone+", "+sex+", "+power);
        Map<String,Object> map = new HashMap<String,Object>();
        /*
        添加用户
         */
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setPhone(phone);
        user.setSex(sex);
        user.setPower(power);

        userService.insert(user);

        map.put("success",true);
        map.put("msg","添加成功");
        return map;
    }


    /*首页轮播图*/

    /**
     * 处理轮播图管理页面请求
     * @return
     */
    @RequestMapping("/Home")
    public ModelAndView home(){
        ModelAndView modelAndView = new ModelAndView();
        try{
            List<Carousel> carouselList = carouselService.selectAll();
            modelAndView.addObject("CarouselListResult",carouselList);
            modelAndView.setViewName("/admin/Home");
        }catch (Exception e){
            e.printStackTrace();
        }
        return modelAndView;
    }

    /**
     * 处理添加轮播图页面请求
     * @return
     */
    @RequestMapping("/home_add")
    public String home_add(){
        return "/admin/home_add";
    }

    /**
     * 处理轮播图信息请求
     * @param id
     * @return
     */
    @RequestMapping("/home_edit/{id}")
    public ModelAndView home_edit(@PathVariable("id")Integer id){
        System.out.println("id"+id);

        ModelAndView modelAndView = new ModelAndView();
        Carousel carousel = carouselService.selectByPrimaryKey(id);
        modelAndView.addObject("carouselResult",carousel);
        modelAndView.setViewName("/admin/home_edit");
        return modelAndView;
    }


    /**
     * 处理修改轮播图状态请求
     * @param id 轮播图ID
     * @param status 轮播图状态
     * @return
     */
    @RequestMapping(value = "/changeCarouselStatus")
    public @ResponseBody Map<String,Object> changeCarouselStatus(Integer id,Byte status){

        Map<String,Object> map = new HashMap<String,Object>();
        try{
            carouselService.updateStatusByPrimaryKey(id,status);
            map.put("success",true);
            map.put("msg","修改成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 处理删除轮播图信息
     * @param id
     * @return
     */
    @RequestMapping(value = "deleteCarousel")
    public @ResponseBody Map<String,Object> deleteCarousel(Integer id){

        System.out.println("deleteCarousel：id = "+id);
        try{
            //删除操作
            carouselService.deleteByPrimaryKey(id);
        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        map.put("msg","删除成功");
        return map;
    }

    /**
     * 处理添加轮播图请求
     * @param title 标题
     * @param imgUrl 图片地址
     * @param content 描述内容
     * @param link 点击的链接
     * @return
     */
    @RequestMapping(value = "/insert_carousel")
    public @ResponseBody Map<String,Object> insertCarousel(String title,String imgUrl,String content,String link){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String url = imgUrl.substring("http://localhost:8080/images/web/".length());

        Carousel carousel = new Carousel(1,title,sdf.format(new Date()),(byte)1,content,link,url);

        System.out.println("carousel:"+carousel);

        carouselService.insert(carousel);

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }

    /**
     * 保存修改的轮播图信息
     * @param id 轮播图ID
     * @param title 轮播图标题
     * @param imgUrl 新的图片地址
     * @param content 新的内容
     * @param link 新的链接
     * @return
     */
    @RequestMapping(value = "/save_carousel")
    public @ResponseBody Map<String,Object> saveCarousel(Integer id,String title,String imgUrl,String content,String link){
        String url = imgUrl.substring("http://localhost:8080/images/web/".length());
        Carousel carousel = new Carousel();
        carousel.setId(id);
        carousel.setTitle(title);
        carousel.setImgUrl(url);
        carousel.setDescript(content);
        carousel.setUrl(link);

        carouselService.updateByPrimaryKey(carousel);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }


    /**
     * 处理保存上传的轮播图图片
     * @param session
     * @param fileName
     * @return
     */
    @RequestMapping(value = "/fileUpload")
    public @ResponseBody Map<String,Object> fileUpload(HttpSession session,@RequestParam("avatar") MultipartFile fileName){
        String oldFileName = fileName.getOriginalFilename(); //获取上传文件的原名
        //存储图片的物理路径
        String file_path = session.getServletContext().getRealPath("images");
        Map<String,Object> map = new HashMap<String,Object>();
        //上传图片
        if(fileName != null && oldFileName != null && oldFileName.length()>0) {
            try {
                //新的图片名称
                String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
                //新图片
                File newFile = new File(file_path + "/web/" + newFileName);
                //将内存中的数据写入磁盘
                fileName.transferTo(newFile);
                //返回头像信息保存成功信息
                map.put("success", true);
                map.put("msg", "头像上传成功");
                map.put("src", newFileName);
                return map;
            } catch (Exception e) {
                e.printStackTrace();
                map.put("succcess",false);
                map.put("msg","头像上传失败");
            }
        }
        return map;
    }




    /*闲置管理*/

    /**
     * 处理请求闲置管理页面
     * @return
     */
    @RequestMapping("/good")
    public ModelAndView good(){
        List<CatelogExtend> catelogExtendList = new ArrayList<CatelogExtend>();
        List<Goods> goodsList = goodsService.selectAllGoods();
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
     * 处理请求修改闲置状态
     * @param id
     * @param status
     * @return
     */
    @RequestMapping(value = "/changeGoodsStatus")
    public @ResponseBody Map<String,Object> changeGoodsStatus(Integer id,Byte status){


        goodsService.updateStatusByPrimaryKey(id,status);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        map.put("msg","修改成功");
        return map;
    }

    /**
     * 处理删除闲置
     * @param session
     * @param id 闲置物品ID
     * @return
     */
    @RequestMapping(value = "/deleteGoods")
    public @ResponseBody Map<String,Object> deleteGoods(HttpSession session,Integer id){


        Map<String,Object> map = new HashMap<String,Object>();
        try{
            Goods goods = goodsService.selectByPrimaryKey(id);

            //更新对应的分类闲置数量
            Catelog catelog = catelogService.selectByPrimaryKey(goods.getCatelogId());
            catelogService.updateCatelogNum(goods.getCatelogId(),catelog.getNumber()-1);

            //更新对应的用户闲置数量
            User user = userService.selectByPrimaryKey(goods.getUserId());
            userService.updateGoodsNum(user.getId(),user.getGoodsNum()-1);

            //删除对应的留言数据
            List<Comments> comments = commentsService.selectByGoodsId(goods.getId());
            for(Comments comment:comments){
                commentsService.deleteByPrimaryKey(comment.getId());
            }

            //删除对应的图片数据
            List<Image> images = imageService.selectByGoodsPrimaryKey(goods.getId());
            for(Image image:images){
                String file_path = session.getServletContext().getRealPath("images");
                File file = new File(file_path+"/web/"+image.getImgUrl());
                if (file.exists()) {
                    //删除图片
                    file.delete();
                }
                imageService.deleteByPrimaryKey(image.getId());
            }

            //删除对应的举报信息
            List<Report> reportList = reportService.selectReportByGoodsPrimaryKey(goods.getId());
            for(Report report : reportList){
                reportService.deleteByPrimaryKey(report.getId());
            }

            //删除闲置
            goodsService.deleteByPrimaryKey(id);

            map.put("success",true);
            map.put("msg","删除成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
            map.put("msg","删除失败");
        }

        return map;
    }



    /*分类管理*/

    /**
     * 处理请求分类管理页面
     * @return
     */
    @RequestMapping("/catelog")
    public ModelAndView catelog(){
        List<Catelog> catelogs = catelogService.selectAll();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catelogResult",catelogs);
        modelAndView.setViewName("/admin/catelog");
        return modelAndView;
    }

    /**
     * 处理请求分类管理页面
     */
    @RequestMapping("/catelog_add")
    public String catelog_add(){
        return "/admin/catelog_add";
    }

    /**
     * 处理请求编辑分类页面
     * @param id
     * @return
     */
    @RequestMapping("/catelog_edit/{id}")
    public ModelAndView catelog_edit(@PathVariable("id")Integer id){
        Catelog catelog = catelogService.selectByPrimaryKey(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("editResult",catelog);
        modelAndView.setViewName("/admin/catelog_edit");
        return modelAndView;
    }

    /**
     * 处理请求添加分类
     * @param name
     * @return
     */
    @RequestMapping(value = "/save_add_catelog")
    public @ResponseBody Map<String,Object> save_add_catelog(String name){

        Catelog catelog = new Catelog();
        catelog.setName(name);
        catelog.setNumber(0);
        catelog.setStatus((byte)1);
        catelogService.insert(catelog);

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }

    /**
     * 处理保存修改分类信息请求
     * @param id
     * @param name
     * @return
     */
    @RequestMapping(value = "/save_edit_catelog")
    public @ResponseBody Map<String,Object> save_edit_catelog(Integer id,String name){

        Catelog catelog = catelogService.selectByPrimaryKey(id);
        catelog.setName(name);
        catelogService.updateByPrimaryKey(catelog);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }

    /**
     * 处理保存修改分类状态页面
     * @param id
     * @param status
     * @return
     */
    @RequestMapping(value = "/change_status")
    public @ResponseBody Map<String,Object> change_status(Integer id,Byte status){
        Catelog catelog = catelogService.selectByPrimaryKey(id);
        catelog.setStatus(status);
        catelogService.updateByPrimaryKey(catelog);
        List<Goods> goods = goodsService.selectGoodsByCatelogStatus(catelog.getId());

        for (Goods good:goods) {
            if(good.getStatus().equals((byte)1) || good.getStatus().equals((byte)0)){
                if(status.equals((byte)0)) {
                    goodsService.updateStatusByPrimaryKey(good.getId(),(byte)0);
                }else{
                    goodsService.updateStatusByPrimaryKey(good.getId(),(byte)1);
                }
            }

        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }

    /**
     * 处理删除分类
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete_catelog")
    public @ResponseBody Map<String,Object> delete_catelog(Integer id){
        catelogService.deleteByPrimaryKey(id);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }

    /*举报管理*/

    /**
     * 处理请求举报信息页面
     * @return
     */
    @RequestMapping("/report")
    public ModelAndView report(){
        List<Report> reportList= reportService.selectAll();
        List<ReportExtend> reportExtendList = new ArrayList<ReportExtend>();
        for (Report report:reportList) {
            Goods goods = goodsService.selectByPrimaryKey(report.getGoodId());
            List<Image> images = imageService.selectByGoodsPrimaryKey(goods.getId());
            User user = userService.selectByPrimaryKey(report.getUserId());
            ReportExtend reportExtend = new ReportExtend(report,goods,images,user);
            reportExtendList.add(reportExtend);
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("reportResult",reportExtendList);
        modelAndView.setViewName("/admin/report");
        return modelAndView;
    }

    /**
     * 处理删除举报信息页面
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete_report")
    public @ResponseBody Map<String,Object> delete_report(Integer id){
        reportService.deleteByPrimaryKey(id);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }


    /*留言管理*/


    /**
     * 处理请求留言管理页面
     * @return
     */
    @RequestMapping("/comments")
    public ModelAndView comments(){
        List<Comments> comments = commentsService.selectAll();
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

    /**
     * 处理请求删除留言信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete_comments")
    public @ResponseBody Map<String,Object> delete_comments(Integer id){
        Comments comments = commentsService.selectByPrimaryKey(id);

        Goods goods = goodsService.selectByPrimaryKey(comments.getGoodsId());

        goodsService.updateCommentNumByPrimaryKey(comments.getGoodsId(),goods.getCommetNum()-1);

        commentsService.deleteByPrimaryKey(id);

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        return map;
    }

    /*订单管理*/

    /**
     * 显示订单管理页面
     * @param session
     * @return
     */
    @RequestMapping(value = "/order")
    public ModelAndView order(HttpSession session){
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
