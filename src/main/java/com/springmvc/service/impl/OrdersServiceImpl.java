package com.springmvc.service.impl;

import com.springmvc.dao.OrdersMapper;
import com.springmvc.pojo.Orders;
import com.springmvc.service.OrdersService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service("ordersService")
public class OrdersServiceImpl implements OrdersService {

    @Resource
    private OrdersMapper ordersMapper;

    @Override
    public int insert(Orders record) {
        return ordersMapper.insert(record);
    }

    @Override
    public List<Orders> selectAll() {
        return ordersMapper.selectAll();
    }

    @Override
    public List<Orders> selectOrdersByUserId(Integer userId) {
        return ordersMapper.selectOrdersByUserId(userId);
    }

    @Override
    public Orders selectOrdersByGoodId(Integer goodId) {
        return ordersMapper.selectOrdersByGoodId(goodId);
    }

    @Override
    public Double getSpendByUserId(Integer userId) {
        return ordersMapper.getSpendByUserId(userId);
    }

    @Override
    public Double getIncomeByUserId(Integer userId) {
        return ordersMapper.getIncomeByUserId(userId);
    }
}
