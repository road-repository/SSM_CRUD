package com.road.ssm.service;

import com.road.ssm.bean.User;
import com.road.ssm.dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServeice {

    @Autowired
    UserMapper userMapper;

    /*用来添加管理员账户*/
    public void addUser(User user){
        int insert = userMapper.insert(user);
    }


    /*用来验证登录*/
    public User getUser(String userName,String userPassword){
        User user = userMapper.selectByNamePassword(userName, userPassword);
        return user;
    }
}
