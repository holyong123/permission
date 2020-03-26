package com.asset.common;

public class Const {


    public interface  roleUser{
        String godownKeeper ="仓库管理员";
        String RightsAdministrator ="权限管理员";
        String ApprovalAdministrator ="审批管理员";
        String Buyer="采购管理员";
        String User ="使用者";
        String faultAdministrator ="故障管理员";

    }

    public interface  approvalStatus{
        int approvale = 1;   //审批中
        Integer Disagreement = 2; //不同意
        int buy =3 ;   //采购
        int warehousing =4; //入库
        int alreadyurchased = 0;  //已购买

    }

    public interface  faultStatus{
        int infault = 1;   //处理中
        int faulted = 2;   //已处理
        int waitfault = 0;   //待处理


    }

    public interface  faultRequestType{
        String RequestType_01 = "故障";   //故障1
        String RequestType_02 = "业务变动";   //业务变动 2
//        String RequestType_03 = "0";   //......  3 ...


    }

    public interface  faultType{
        String faultType_01 = "系统";   //系统1
        String faultType_02 = "网络";   //网络2
//        String faultType_03 = 0;   //......


    }

}
