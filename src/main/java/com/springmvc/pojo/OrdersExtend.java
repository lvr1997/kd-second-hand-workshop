package com.springmvc.pojo;

import java.util.List;

public class OrdersExtend {
    private Goods good;
    private Orders orders;
    private List<Image> images;
    private User user;
    private Address address;

    public OrdersExtend() {
    }

    public OrdersExtend(Goods good, Orders order, List<Image> images, User user, Address address) {
        this.good = good;
        this.orders = order;
        this.images = images;
        this.user = user;
        this.address = address;
    }

    @Override
    public String toString() {
        return "OrdersExtend{" +
                "good=" + good +
                ", order=" + orders +
                ", images=" + images +
                ", user=" + user +
                ", address=" + address +
                '}';
    }

    public Goods getGood() {
        return good;
    }

    public void setGood(Goods good) {
        this.good = good;
    }

    public Orders getOrders() {
        return orders;
    }

    public void setOrders(Orders orders) {
        this.orders = orders;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }
}
