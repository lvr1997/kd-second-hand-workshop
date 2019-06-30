package com.springmvc.pojo;

public class WantedExtend {
    private Wanted wanted;
    private GoodsExtend goodsExtend;
    private User user;

    public Wanted getWanted() {
        return wanted;
    }

    public void setWanted(Wanted wanted) {
        this.wanted = wanted;
    }

    public GoodsExtend getGoodsExtend() {
        return goodsExtend;
    }

    public void setGoodsExtend(GoodsExtend goodsExtend) {
        this.goodsExtend = goodsExtend;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
