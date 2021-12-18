package com.springmvc.controller;


import com.springmvc.ex.PhoneNotFoundException;
import com.springmvc.ex.ServiceException;
import com.springmvc.ex.UsernameTakenException;
import com.springmvc.pojo.*;
import com.springmvc.service.*;
import com.springmvc.util.MD5;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private CommentsService commentsService;

    @Resource
    private WantedService wantedService;

    @Resource
    private HomeController homeController;

    @Resource
    private GoodsService goodsService;

    @Resource
    private ImageService imageService;

    @Resource
    private UserService userService;

    @Resource
    private AddressService addressService;

    @Resource
    private OrdersService ordersService;

    //存储上一步浏览的地址
    private String loginReferer;

    /**
     * 处理请求忘记密码页面
     * @return 返回忘记密码页面地址
     */
    @RequestMapping(value = "/forget_password")
    public String forget(){
        return "/user/forget";
    }

    /**
     * 处理提交修改密码
     * @param session 图片验证码信息
     * @param phone_number 要修改的手机号
     * @param password 要修改的手机号的新密码
     * @param captchaCode 图片验证码
     * @return
     */
    @RequestMapping(value = "/forget")
    public @ResponseBody Map<String,Object> forgetPassword(HttpSession session,
            @RequestParam(value = "phone_number",required = false)String phone_number,
            @RequestParam(value = "password",required = false)String password,
            @RequestParam(value = "captchaCode",required = false)String captchaCode){
        System.out.println("phone_number:"+phone_number+", password:"+password+", captchaCode:"+captchaCode);
        String captchaCheckCode = (String)session.getAttribute("number");
        User user = userService.getUserByPhone(phone_number);
        Map<String,Object> map = new HashMap<String,Object>();
        //判断验证码
        if(captchaCheckCode.equals(captchaCode)){
            //判断手机号是否注册
            if(user != null){
                //执行修改手机用户对应的密码
                userService.updatePasswordByPrimaryKey(user.getId(),MD5.md5(password));
                //返回确认码
                map.put("success",true);
                map.put("msg","修改成功");
            }else{
                map.put("success",false);
                map.put("msg","手机号未注册");
            }
        }else{
            map.put("success",false);
            map.put("msg","验证码不正确");
        }
        return map;
    }

    /**
     * 发送手机短信验证码
     * @param session 用户登录信息
     * @param phonenum 需要发送短信的手机号
     * @param captcha 图形验证码
     * @param type 验证类型为登录还是找回密码
     * @return 是否发送
     */
    @RequestMapping(value = "/get_verify_code",method = RequestMethod.POST)
    public @ResponseBody Map<String,Object> getVerifyCode(HttpSession session,
            @RequestParam(value = "phonenum")String phonenum,
            @RequestParam(value = "captcha")String captcha,
            @RequestParam(value = "type")String type){
        String captCode = (String)session.getAttribute("number");
        Map<String,Object> map = new HashMap<String,Object>();
        if(captcha.equals(captcha) && type.equals("1")){
            //查找用户是否存在
            Integer count = userService.checkUserByPhone(phonenum);
            if(count>0){
                System.out.println("phonenum:"+phonenum+", captcha:"+captcha+", type:"+type);

                //发送验证码


                //返回确认信息
                map.put("success",true);
                map.put("msg","发送成功");
            }else{
                map.put("success",false);
                map.put("msg","用户不存在");
            }
        }else{
            //
            map.put("success",false);
            map.put("msg","验证码不正确");
        }
        return map;
    }

    /**
     * 请求登录页面请求
     * @param request 请求信息
     * @return
     */
    @RequestMapping("/toLogin")
    public String toLogin(HttpServletRequest request){
        //获得前一个页面的头地址信息，保存下来
        if("http://localhost:8088/user/forget_password".equals(request.getHeader("Referer"))
                || "http://localhost:8088/user/register".equals(request.getHeader("Referer"))
                || "http://localhost:8088/user/toRegister".equals(request.getHeader("Referer"))){
            loginReferer = "http://localhost:8088/goods/index";
        }else{
            loginReferer = request.getHeader("Referer");
        }
        return "/user/login";
    }

    /**
     * 处理登录请求
     * @param session 用于保存用户信息的session对象
     * @return 登录结果
     */
    @RequestMapping(value = "/login",method = {RequestMethod.POST , RequestMethod.GET})
    public @ResponseBody Map<String, Object> checkLogin(
            HttpSession session,
            @RequestParam(value = "phone",required = false)String phone,
            @RequestParam(value = "password",required = false)String password){
        Map<String, Object> map = new HashMap<String, Object>();
        try{
            //通过手机号查询用户信息
            User cur_user = userService.getUserByPhone(phone);
            //判断用户信息
            if(cur_user != null) {
                //用户信息存在
                String word = MD5.md5(password);
                if(cur_user.getPassword().equals(word)) {
                    //密码正确，并设置登录信息
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    cur_user.setLastLogin(sdf.format(new Date()));
                    userService.updateLastLoginByPrimaryKey(cur_user);
                    //用session保存登录的用户信息
                    session.setAttribute("cur_user",cur_user);
                    //返回信息
                    map.put("success",true);
                    map.put("reurl",loginReferer);
                    map.put("msg","登录成功");
                }else{
                    //密码不正确
                    map.put("err",true);
                    map.put("msg","登录失败,密码错误");
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

    /**
     * 登录和注册时判断手机号是不是存在
     * @param phone 登录和注册时输入的手机号
     * @return  返回查询手机是否存在的信息
     */
    @RequestMapping(value = "/checkPhone")
    public @ResponseBody  Map<String,Object> checkPhone(
            @RequestParam(value = "phone",required = false) String phone){
        Map<String,Object> map = new HashMap<String, Object>();
        try{
            User user = userService.getUserByPhone(phone);
            map.put("message","手机号已注册");
            return map;
        }catch (ServiceException e){
            map.put("message",e.getMessage());
            return map;
        }

    }

    /**
     *
     * @param session 保存了验证码信息的session
     * @param checkcode 接收用户输入的验证码
     * @return 返回判断信息
     */
    @RequestMapping(value = "/checkCode")
    public @ResponseBody ModelMap checkCode(HttpSession session,String checkcode){
        String checkCode = (String)session.getAttribute("number");

        ModelMap map = new ModelMap();
        if(checkCode.equals(checkcode)){
            map.put("success",true);
            map.put("msg","验证码正确");
        }else{
            map.put("success",false);
            map.put("msg","验证码不正确");
        }
        return map;
    }


    /**
     * 处理请求注册界面
     * @return 返回注册页面地址
     */
    @RequestMapping(value = "/toRegister")
    public String register(){
        return "/user/register";
    }

    /**
     * 处理注册信息
     * @param user 用户注册信息
     * @param session session
     * @param checkcode 验证码
     * @return 返回注册结果
     */
    @RequestMapping(value = "/register")
    @ResponseBody
    public ModelMap handleRegister(User user,HttpSession session,String checkcode){

        String checkCode = (String)session.getAttribute("number");
        ModelMap map = new ModelMap();
        //判断验证码
        if(checkCode.equals(checkcode)){
                                         try{
                //设置用户信息初始值
                user.setUsername(user.getPhone());
                user.setPassword(MD5.md5(user.getPassword()));
                //保存用户信息
                userService.insert(user);
                //返回注册结果信息
                map.addAttribute("success",true);
                map.addAttribute("msg","注册成功");
                return map;
            }catch (UsernameTakenException e){
                //处理异常
                map.addAttribute("error",true);
                map.addAttribute("msg",e.getMessage());
                return map;
            }
        }else{
            //验证码不正确，返回信息
            map.addAttribute("error",true);
            map.addAttribute("msg","验证码错误");
            return map;
        }




    }

    /**
     * 处理请求用户个人信息界面
     * @return
     */
    @RequestMapping(value = "/userinfo")
    public String userinfo(){

        return "/user/userinfo";
    }

    /**
     * 处理个人信息的评论和回复
     * @return
     */
    @RequestMapping(value = "/message")
    public ModelAndView message(HttpSession session){
        User user = (User)session.getAttribute("cur_user");
        ModelAndView modelAndView = new ModelAndView();
        if(user==null){
            modelAndView.setViewName("redirect:/user/login");
            return modelAndView;
        }
        modelAndView.setViewName("/user/message");
        return modelAndView;
    }

    /**
     * 处理请求接收的留言
     * @param session
     * @return
     */
    @RequestMapping(value = "received")
    public @ResponseBody Map<String,Object> received(HttpSession session){
        Map<String,Object> map = new HashMap<String,Object>();
        User user = (User)session.getAttribute("cur_user");
        //查找自己 闲置的回复
        List<Goods> goods = goodsService.getGoodsByUserId(user.getId());
        List<Comments> commentsList = new ArrayList<Comments>();
        for(Goods good:goods){
            List<Comments> comments1 = commentsService.selectByGoodsId(good.getId());
            if(comments1!=null){
                commentsList.addAll(comments1);
            }
        }
        //留言对象（留言内容，留言物品）集合
        List<CommentsExtend> commentsExtendList = new ArrayList<CommentsExtend>();
        if(commentsList.size()>0){
            for (Comments comment:commentsList) {
                CommentsExtend commentsExtend = new CommentsExtend();
                User user1 = userService.selectByPrimaryKey(comment.getUserId());
                Goods goods1 = goodsService.selectByPrimaryKey(comment.getGoodsId());
                commentsExtend.setGoods(goods1);
                commentsExtend.setUser(user1);
                commentsExtend.setComments(comment);
                commentsExtendList.add(commentsExtend);
            }
        }
        map.put("success",true);
        map.put("result",commentsExtendList);
        return map;
    }

    /**
     * 处理发布的留言
     * @param session
     * @return
     */
    @RequestMapping("/published")
    public @ResponseBody Map<String,Object> published(HttpSession session){
        User user = (User)session.getAttribute("cur_user");
        Map<String,Object> map = new HashMap<String,Object>();
        //发布留言（发布人，留言物品，留言内容）集合
        List<CommentsExtend> commentsExtends = new ArrayList<CommentsExtend>();
        //留言集合
        List<Comments> comments =  commentsService.selectByUserKeyWithContent(user.getId());
        for(Comments comment:comments){
            //留言扩展类CommentsExtend(包含发布人，留言物品，留言内容)
            CommentsExtend commentsExtend = new CommentsExtend();
            User user1 = userService.selectByPrimaryKey(comment.getUserId());
            Integer goodsId = comment.getGoodsId();
            Goods goods1 = goodsService.selectByPrimaryKey(goodsId);
            commentsExtend.setGoods(goods1);
            commentsExtend.setUser(user1);
            commentsExtend.setComments(comment);
            //把所有的commentsExtend放到List集合
            commentsExtends.add(commentsExtend);
        }
        map.put("success",true);
        map.put("result",commentsExtends);
        return map;
    }


    /**
     * 处理收藏
     * @return
     */
    @RequestMapping(value = "/want")
    public ModelAndView want(HttpSession session){
        User user = (User)session.getAttribute("cur_user");
        List<Wanted> wantedList = wantedService.selectWantByUserId(user.getId());
        List<WantedExtend> wantedExtendList = new ArrayList<WantedExtend>();
        for (Wanted wanted:wantedList) {
            WantedExtend wantedExtend = new WantedExtend();
            GoodsExtend goodsExtend = new GoodsExtend();
            //获取收藏的 闲置信息
            Goods good = goodsService.selectByPrimaryKey(wanted.getGoodId());
            if (good != null) {
                List<Image> images = imageService.selectByGoodsPrimaryKey(good.getId());
                goodsExtend.setImages(images);
                goodsExtend.setGoods(good);
                //将信息包装在一起
                wantedExtend.setGoodsExtend(goodsExtend);
                wantedExtend.setWanted(wanted);
                wantedExtendList.add(wantedExtend);
            }
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("wantedList",wantedExtendList);
        modelAndView.setViewName("/user/want");
        return modelAndView;
    }

    /**
     * 处理请求反馈页面
     * @return 反馈页面
     */
    @RequestMapping(value = "/help")
    public String help(){

        return "/user/help";
    }

    @RequestMapping(value = "/feedback")
    public @ResponseBody Map<String,Object> feedback(HttpSession session,@RequestParam(value = "content")String content){
        System.out.println("content:"+content);
        /*
        处理反馈内容
         */
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("success",true);
        map.put("msg","反馈成功");
        return map;
    }

    /**
     * 处理搜索
     * @param keywords 关键字
     * @return
     */
    @RequestMapping(value = "/search",produces="text/html;charset=UTF-8")
    public ModelAndView search(@RequestParam(value = "keywords",required = false) String keywords){

        //通过闲置名称和闲置描述搜索闲置信息
        List<Goods> goodsList = goodsService.searchGoods(keywords,keywords,(byte)1);

        List<GoodsExtend> goodsExtendList = homeController.handlerGoodsAndView(goodsList);
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.addObject("keywords",keywords);
        modelAndView.addObject("goodsExtendList", goodsExtendList);

        modelAndView.setViewName("/search/search");
        return modelAndView;
    }

    /**
     * 用户退出
     * @param session session信息
     * @return
     */
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        //设置用户最后登录信息
        User user = (User)session.getAttribute("cur_user");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        user.setLastLogin(sdf.format(new Date()));
        userService.updateLastLoginByPrimaryKey(user);
        //清除用户登陆信息
        session.setAttribute("cur_user",null);
        //重定向到首页
        return "redirect:/goods/index";
    }

    /**
     * 处理请求我发布的闲置
     * 查询出所有的用户 闲置以及 闲置对应的图片
     * @return  返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
     */
    @RequestMapping(value = "/index")
    public ModelAndView handleUserGoods(HttpServletRequest request) {
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
        List<GoodsExtend> goodsAndImage = homeController.handlerGoodsAndView(goodsList);

        //计算收入 根据发布的物品id查询
        float income = 0.0f;
        for(int i=0; i<goodsList.size(); i++){
            Orders orders = ordersService.selectOrdersByGoodId(goodsList.get(i).getId());
            if (orders != null){
                Goods goods = goodsService.selectByPrimaryKey(orders.getGoodId());
                income += goods.getPrice();
            }
        }
        //计算支出 根据当前用户id查询
        List<Orders>  orde= ordersService.selectOrdersByUserId(userId);
        float spend = 0.0f;
        for(int i=0;i<orde.size();i++){
            Goods goods = goodsService.selectByPrimaryKey(orde.get(i).getGoodId());
            spend += goods.getPrice();
        }
        ModelAndView mv = new ModelAndView();
        mv.addObject("goodsAndImage",goodsAndImage);
        mv.addObject("income",income);
        mv.addObject("spend",spend);
        mv.setViewName("/user/index");
        return mv;
    }



    /**
     * 处理上传的用户图片
     * @param session session对象
     * @param fileName 文件
     * @param id 用户id
     * @return 返回信息
     * @throws IllegalStateException
     * @throws IOException
     */
    @RequestMapping(value = "/avatar_upload/{id}",method = RequestMethod.POST)
    public @ResponseBody
    Map<String,Object> avatarUpload(HttpSession session, @RequestParam("avatar") MultipartFile fileName, @PathVariable("id") Integer id)throws IllegalStateException, IOException{

        User user = (User)session.getAttribute("cur_user");
        String oldFileName = fileName.getOriginalFilename(); //获取上传文件的原名

        //存储图片的物理路径
        String file_path = session.getServletContext().getRealPath("images");

        //上传图片
        if(fileName!=null && oldFileName!=null && oldFileName.length()>0){
            //新的图片名称
            String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
            //更新用户头像地址
            userService.updateImgUrl(id,newFileName);

            User user_new = userService.selectByPrimaryKey(id);
            //重新设置用户的登录信息
            session.setAttribute("cur_user",user_new);

            if(user_new.getImgUrl()!=null){
                //新图片
                File newFile = new File(file_path+"/web/user/"+newFileName);
                //将内存中的数据写入磁盘
                fileName.transferTo(newFile);
                //将新图片名称返回到前端
                Map<String,Object> map=new HashMap<String,Object>();
                Map<String,Object> data=new HashMap<String,Object>();
                data.put("src",newFileName);
                //返回头像信息保存成功信息
                map.put("success", true);
                map.put("msg", "头像上传成功");
                map.put("data",data);

                return  map;
            }
            //头像信息保存失败
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("error","头像上传失败");
            return map;

        }else{
            //上传的文件不存在
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("error","头像上传失败");
            return map;
        }
    }

    /**
     * 保存修改数据
     * @param session
     * @param user 用户信息
     * @return
     */
    @RequestMapping(value = "/save_userinfo",method = RequestMethod.POST)
    public @ResponseBody Map<String,Object> saveUserInfo(HttpSession session, User user){
        User sessionUser = (User)session.getAttribute("cur_user");
        Map<String,Object> map = new HashMap<String, Object>();
        if(sessionUser!=null){
            try{
                String url = user.getImgUrl();
                //图片名称
                String newUrl = url.substring(url.lastIndexOf("/")+1);
                user.setImgUrl(newUrl);
                user.setId(sessionUser.getId());
                userService.updateByPrimaryKeySelective(user);
                User cur_user = userService.selectByPrimaryKey(sessionUser.getId());
                //更新用户登录信息
                session.setAttribute("cur_user",cur_user);
                //修改成功，返回提示
                map.put("success",true);
                map.put("msg","修改成功");
            }catch (Exception e) {
                map.put("success", false);
                map.put("msg", "系统繁忙，稍后再试");
                return map;
            }
        }else{
            map.put("success", false);
            map.put("msg", "请先登陆");
        }
        return map;
    }


    /**
     * 验证收藏
     * @param session 用户信息
     * @param gid 闲置ID
     * @return
     */
    @RequestMapping(value = "/collect")
    public @ResponseBody
    Map<String,Object> collect(HttpSession session, Integer gid){
        User user = (User)session.getAttribute("cur_user");
        Map<String,Object> map = new HashMap<String, Object>();
        //判断用户是否登陆
        if(user!=null){
            Wanted wanted = wantedService.selectWant(user.getId(),gid);
            System.out.println(wanted);
            if(wanted == null){
                //用户未收藏该闲置，则进行收藏
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Wanted newWanted = new Wanted(1,user.getId(),gid,sdf.format(new Date()));
                wantedService.insert(newWanted);
                map.put("success",true);
                map.put("msg","收藏成功");
            }
        }else{
            //用户未登录
            map.put("err",true);
            map.put("msg","请先登录");
        }
        return map;
    }

    /**
     * 处理移除用户收藏的闲置
     * @param gid 闲置ID
     * @return
     */
    @RequestMapping(value = "/collect_delete")
    public @ResponseBody Map<String,Object> collectDelete(HttpSession session,@RequestParam(value = "gid") Integer gid){
        User user = (User)session.getAttribute("cur_user");
        Map<String,Object> map = new HashMap<String, Object>();
        if(user!=null){
            //通过闲置id删除收藏信息
            wantedService.deleteWantedByGoodsId(gid);
            map.put("success",true);
            map.put("msg","移除成功");
        }
        return map;
    }

    /**
     * 处理用户提交的留言
     * @param session
     * @param gid 闲置的ID信息
     * @param content 提交的里留言内容
     * @return
     */
    @RequestMapping(value = "/comment")
    public @ResponseBody
    Map<String, Object> commentPublish(HttpSession session, Integer gid, String content){
        Map<String, Object> map = new HashMap<String, Object>();
        //获得登录信息
        User user = (User)session.getAttribute("cur_user");
        try{
            //设置留言信息
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Comments comments = new Comments(1,user.getId(),gid,sdf.format(new Date()),content);
            Goods goods = goodsService.selectByPrimaryKey(gid);
            goodsService.updateCommentNumByPrimaryKey(gid,goods.getCommetNum()+1);
            commentsService.insert(comments);
            //返回信息

            map.put("success",true);
            map.put("msg","评论成功");
            return map;
        }catch (Exception e){
            map.put("success",false);
            map.put("msg","登陆信息过期，请登陆");
            return map;
        }

    }

    /**
     * 处理点击购买闲置请求
     * @param id
     * @return
     */
    @RequestMapping(value = "/buy-good/{id}")
    public ModelAndView buyGood( @PathVariable("id") Integer id,HttpSession session){
        Goods goods = goodsService.selectByPrimaryKey(id);
        List<Image> images = imageService.selectByGoodsPrimaryKey(id);
        User user = (User)session.getAttribute("cur_user");
        List<Address> list = addressService.getAllAddressByUid(user.getId());
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("good",goods);
        modelAndView.addObject("image",images);
        modelAndView.addObject("listAddress", list);
        modelAndView.setViewName("/order/orderConfirm");
        return modelAndView;
    }


    /**
     * 请求管理地址页面
     * @param session
     * @return
     */
    @RequestMapping(value = "/address")
    public ModelAndView showAddress(HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        User user = (User)session.getAttribute("cur_user");
        System.out.println("ShowAddress-User:"+user);
        List<Address> list = addressService.getAllAddressByUid(user.getId());
        System.out.println("ShowAddress:"+list);
        modelAndView.addObject("listAddress", list);
        modelAndView.setViewName("/user/address");
        return modelAndView;
    }

    @RequestMapping(value = "/order")
    public ModelAndView order(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/user/order");
        return modelAndView;
    }

    /**
     * 购买的闲置的订单
     * @param session
     * @return
     */
    @RequestMapping(value = "/order_buy")
    public @ResponseBody Map<String,Object> order_buy(HttpSession session){
        Map<String,Object> map = new HashMap<String,Object>();
        List<OrdersExtend> ordersExtends = new ArrayList<OrdersExtend>();
        User user = (User)session.getAttribute("cur_user");
        List<Orders> orders = ordersService.selectOrdersByUserId(user.getId());
        if(orders.size()>0) {
            for (Orders order : orders) {
                if(order!=null){
                    OrdersExtend ordersExtend = new OrdersExtend();
                    Goods good = goodsService.selectByPrimaryKey(order.getGoodId());
                    List<Image> images = imageService.selectByGoodsPrimaryKey(good.getId());
                    Address address = addressService.getAddressById(order.getAddressId());
                    ordersExtend.setGood(good);
                    ordersExtend.setImages(images);
                    ordersExtend.setUser(user);
                    ordersExtend.setAddress(address);
                    ordersExtend.setOrders(order);
                    ordersExtends.add(ordersExtend);
                }
            }
        }


        map.put("success",true);
        map.put("result",ordersExtends);

        return map;
    }


    /**
     * 出售的闲置
     * @param session
     * @return
     */
    @RequestMapping(value = "/published_order")
    public @ResponseBody Map<String,Object> published_order(HttpSession session){
        Map<String,Object> map = new HashMap<String,Object>();

        List<OrdersExtend> ordersExtends = new ArrayList<OrdersExtend>();

        User user = (User)session.getAttribute("cur_user");

        List<Goods> goods = goodsService.getGoodsByUserId(user.getId());

        List<Orders> orders = new ArrayList<Orders>();

        for(Goods good:goods){
            Orders order = ordersService.selectOrdersByGoodId(good.getId());
            orders.add(order);
        }
        if(orders.size()>0){
            for(Orders order:orders){
                if(order!=null){
                    OrdersExtend ordersExtend = new OrdersExtend();
                    Goods good = goodsService.selectByPrimaryKey(order.getGoodId());
                    List<Image> images = imageService.selectByGoodsPrimaryKey(good.getId());
                    Address address = addressService.getAddressById(order.getAddressId());
                    ordersExtend.setGood(good);
                    ordersExtend.setImages(images);
                    ordersExtend.setUser(user);
                    ordersExtend.setAddress(address);
                    ordersExtend.setOrders(order);
                    ordersExtends.add(ordersExtend);
                }

            }
        }


        map.put("success",true);
        map.put("result",ordersExtends);

        return map;
    }

}