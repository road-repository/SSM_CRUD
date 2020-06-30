package com.road.ssm.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 为了方便返回json的时候方便自定义一个json返回格式
 */
public class JsonMsg {


    //状态码 100代表成功，200失败
    private Integer ResCode;
    //提示信息
    private String message;
    //返回内容
    private Map<String, Object> content = new HashMap<>();


    public static JsonMsg success() {
        JsonMsg msg = new JsonMsg();
        msg.setResCode(100);
        msg.setMessage("处理成功");
        return msg;
    }

    public static JsonMsg fail() {
        JsonMsg msg = new JsonMsg();
        msg.setResCode(200);
        msg.setMessage("处理失败");
        return msg;
    }

    public JsonMsg addData(String key, Object value) {
        this.getContent().put(key, value);
        return this;
    }

    public Integer getResCode() {
        return ResCode;
    }

    public void setResCode(Integer resCode) {
        ResCode = resCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getContent() {
        return content;
    }

    public void setContent(Map<String, Object> content) {
        this.content = content;
    }
}
