package com.asset.model;

public class FaultUser {


    private Integer typeId;

    private Integer userId;

    private Integer faultTypeId;

    private String username;


    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getFaultTypeId() {
        return faultTypeId;
    }

    public void setFaultTypeId(Integer faultTypeId) {
        this.faultTypeId = faultTypeId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
