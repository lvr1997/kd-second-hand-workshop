package com.springmvc.pojo;

import java.util.List;

public class CatelogExtend {
    private Goods goods;
    private Catelog catelog;
    private User user;
    private List<Image> images;

    public CatelogExtend() {
    }

    public CatelogExtend(Goods goods, Catelog catelog, User user, List<Image> images) {
        this.goods = goods;
        this.catelog = catelog;
        this.user = user;
        this.images = images;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public Catelog getCatelog() {
        return catelog;
    }

    public void setCatelog(Catelog catelog) {
        this.catelog = catelog;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }
}
