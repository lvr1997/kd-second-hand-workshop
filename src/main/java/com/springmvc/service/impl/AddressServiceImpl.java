package com.springmvc.service.impl;

import com.springmvc.dao.AddressMapper;
import com.springmvc.dao.DictMapper;
import com.springmvc.pojo.Address;
import com.springmvc.service.AddressService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("addressService")
public class AddressServiceImpl implements AddressService{

    @Resource
    private DictMapper dictMapper;

    @Resource
    private AddressMapper addressMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return addressMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Address selectByPrimaryKey(Integer id) {
        return addressMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Address> selectAll() {
        return addressMapper.selectAll();
    }

    @Override
    public int updateByPrimaryKey(Address record) {
        return addressMapper.updateByPrimaryKey(record);
    }


    public void setDefault(Integer id) {
        addressMapper.setDefault(id);
    }


    public void addAddress(Address address) {
        //1.setDistrict
        String pCode = address.getRecvProvince();
        String cCode = address.getRecvCity();
        String aCode = address.getRecvArea();
        String pName = dictMapper.getProvinceByCode(pCode);
        String cName = dictMapper.getCityByCode(cCode);
        String aName = dictMapper.getAreaByCode(aCode);
        address.setRecvDistrict(pName+cName+aName);
        //2.setIsDefault
        List<Address> listA = addressMapper.getAllAddressByUid(address.getUid());
        int n = listA.size() > 0 ? 0:1;
        address.setIsDefault(n);
        //3.insert();
        addressMapper.insert(address);

    }

    /**
     * 通过uid查询该用户的收件地址,并返回集合
     */
    public List<Address> getAllAddressByUid(Integer uid) {
        return addressMapper.getAllAddressByUid(uid);
    }

    public void setDefault(Integer uid, Integer id) {
        addressMapper.setCancel(uid);
        addressMapper.setDefault(id);

    }
    /**
     * 通过id查询Address信息,并返回该Address信息
     */
    public Address getAddressById(Integer id){
        return addressMapper.getAddressById(id);
    }


//    public void update(Address address) {
//        String pName = dictMapper.getProvinceByCode(
//                address.getRecvProvince());
//        String cName = dictMapper.getCityByCode(
//                address.getRecvCity());
//        String aName = dictMapper.getAreaByCode(
//                address.getRecvArea());
//
//        address.setRecvDistrict(pName+cName+aName);
//        addressMapper.update(address);
//    }




    /**
     * 修改收件人地址
     */
    public void updateAddress(Address address){
        String pName = dictMapper.getProvinceByCode(
                address.getRecvProvince());
        String cName = dictMapper.getCityByCode(
                address.getRecvCity());
        String aName = dictMapper.getAreaByCode(
                address.getRecvArea());

        address.setRecvDistrict(pName+cName+aName);
        addressMapper.update(address);
    }
    /**
     * 删除指定id的address记录
     */
    public void deleteAddress(Integer uid,
                              Integer id){
        Address address =
                addressMapper.getAddressById(id);
        Integer i = addressMapper.delete(id);
        if(i==1){
            if(address.getIsDefault()==1){
                List<Address> list =
                        addressMapper.getAllAddressByUid(uid);
                if(list.size()>0){
                    Address addr = list.get(0);
                    addressMapper.setDefault(
                            addr.getId());
                }else{

                }
            }else{

            }
        }
    }
}
