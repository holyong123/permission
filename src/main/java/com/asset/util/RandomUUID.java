package com.asset.util;

import java.security.SecureRandom;

public class RandomUUID {

    /*根据指定长度生成字母和数字的随机数
     *0~9的ASCII为48~57
     *A~Z的ASCII为65~90
     *a~z的ASCII为97~122
     */
    /**
     * @param length
     * @return
     */
    public static String getUUID(int length){
        StringBuilder sb = new StringBuilder();
        SecureRandom random = new SecureRandom();
        SecureRandom randomData = new SecureRandom();
        int data;
        for(int i=0;i<length;i++){
            int index = random.nextInt(3);
            //目的是随机选择生成数字，大小写字母
            switch (index){
                case 0:
                    data = randomData.nextInt(10);//仅仅会生成0~9
                    sb.append(data);
                    break;
                case 1:
                    data = randomData.nextInt(26)+65;//保证只会产生65~90之间的整数
                    sb.append((char) data);
                    break;
                case 2:
                    data = randomData.nextInt(26)+97;//保证只会产生97~122之间的整数
                    sb.append((char) data);
                    break;
                default:
                    break;
            }
        }
        return sb.toString();

    }

}
