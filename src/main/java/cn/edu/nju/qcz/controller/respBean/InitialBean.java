package cn.edu.nju.qcz.controller.respBean;

import cn.edu.nju.qcz.entity.User;

import java.util.ArrayList;
import java.util.List;

public class InitialBean {

    private List<String> examInfo;
    private List<String> userInfo;

    public List<String> getExamInfo() {
        return examInfo;
    }

    public void setExamInfo(List<String> examInfo) {
        this.examInfo = examInfo;
    }

    public List<String> getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(List<String> userInfo) {
        this.userInfo = userInfo;
    }
}
