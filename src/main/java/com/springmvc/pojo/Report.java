package com.springmvc.pojo;

public class Report {
    private Integer id;
    private Integer goodId;
    private Integer userId;
    private String content;
    private Byte status;

    public Report() {
    }

    public Report(Integer id, Integer goodId, Integer userId, String content, Byte status) {
        this.id = id;
        this.goodId = goodId;
        this.userId = userId;
        this.content = content;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGoodId() {
        return goodId;
    }

    public void setGoodId(Integer goodId) {
        this.goodId = goodId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();;
    }


}
