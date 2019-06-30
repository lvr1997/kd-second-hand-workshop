package com.springmvc.service.impl;

import com.springmvc.dao.UserMapper;
import com.springmvc.ex.PhoneNotFoundException;
import com.springmvc.ex.UsernameTakenException;
import com.springmvc.pojo.User;
import com.springmvc.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService{

    @Resource
    private UserMapper userMapper;


    public int deleteByPrimaryKey(Integer id) {
        return userMapper.deleteByPrimaryKey(id);
    }

    public int insert(User record) {
        User user = userMapper.getUserByPhone(record.getPhone());
        if(user == null){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            record.setCreateAt(sdf.format(new Date()));
            record.setGoodsNum(0);
            record.setPower((byte)10);
            record.setSex("男");
            record.setImgUrl("b78c6caa-0175-4610-a591-c6aa2917c3aa.png");
            record.setBirthday(sdf.format(new Date()));
            return userMapper.insert(record);
        }else{
            throw new UsernameTakenException("手机号已注册");
        }
    }

    public User selectByPrimaryKey(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }

    public List<User> selectAll() {
        return userMapper.selectAll();
    }

    public int updateByPrimaryKey(User record) {
        return userMapper.updateByPrimaryKey(record);
    }

    public int updateLastLoginByPrimaryKey(User record) {
        return userMapper.updateLastLoginByPrimaryKey(record);
    }

    public int updateByPrimaryKeySelective(User record) {
        return userMapper.updateByPrimaryKeySelective(record);
    }

    public User getUserByPhone(String phone) {
        User user = userMapper.getUserByPhone(phone);
        if(user == null){
            throw new PhoneNotFoundException("手机号未注册");
        }else{
            return user;
        }
    }

    public List<User> getUserList() {
        return userMapper.getUserList();
    }

    public int updateGoodsNum(Integer id, Integer goodsNum) {
        return userMapper.updateGoodsNum(id,goodsNum);
    }

    public int updateImgUrl(Integer id, String url) {
        return userMapper.updateImgUrl(id,url);
    }

    @Override
    public Integer checkUserByPhone(String phone) {
        return userMapper.checkUserByPhone(phone);
    }

    @Override
    public int updatePasswordByPrimaryKey(Integer uid, String password) {
        return userMapper.updatePasswordByPrimaryKey(uid,password);
    }

    @Override
    public int updatePowerByPrimaryKey(Integer uid, Integer power) {
        return userMapper.updatePowerByPrimaryKey(uid,power);
    }

    @Override
    public List<User> searchUserByNameOrPhone(String name, String phone) {
        return userMapper.searchUserByNameOrPhone(name,phone);
    }
}
