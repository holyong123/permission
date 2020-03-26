package com.asset.model;

public class Fault {
    private Integer id;

    private String faultTitle;

    private int requestType;

    private int faultType;

    private String faultPhenomenon;

    private int status;

    private String faultSolution;

    private String dealingPeople;

    private String faultTime;

    private  String operateTime;

    private String remark;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFaultTitle() {
        return faultTitle;
    }

    public void setFaultTitle(String faultTitle) {
        this.faultTitle = faultTitle == null ? null : faultTitle.trim();
    }

    public int getRequestType() {
        return requestType;
    }

    public void setRequestType(int requestType) {
        this.requestType = requestType;
    }

    public int getFaultType() {
        return faultType;
    }

    public void setFaultType(int faultType) {
        this.faultType = faultType;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getFaultPhenomenon() {
        return faultPhenomenon;
    }

    public void setFaultPhenomenon(String faultPhenomenon) {
        this.faultPhenomenon = faultPhenomenon == null ? null : faultPhenomenon.trim();
    }


    public String getFaultSolution() {
        return faultSolution;
    }

    public void setFaultSolution(String faultSolution) {
        this.faultSolution = faultSolution == null ? null : faultSolution.trim();
    }

    public String getDealingPeople() {
        return dealingPeople;
    }

    public void setDealingPeople(String dealingPeople) {
        this.dealingPeople = dealingPeople == null ? null : dealingPeople.trim();
    }

    public String getFaultTime() {
        return faultTime;
    }

    public void setFaultTime(String faultTime) {
        this.faultTime = faultTime;
    }

    public String getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(String operateTime) {
        this.operateTime = operateTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}