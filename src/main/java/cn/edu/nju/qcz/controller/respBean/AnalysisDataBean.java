package cn.edu.nju.qcz.controller.respBean;

import cn.edu.nju.qcz.entity.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AnalysisDataBean {

    private List<User> userList;
    private Map<String, Integer> errors;
    private Map<Integer, Integer> testCases;
    private List<String> easyTestCases;
    private List<String> hardTestCases;

    public Map<Integer, Integer> getTestCases() {
        return testCases;
    }

    public void setTestCases(Map<Integer, Integer> testCases) {
        this.testCases = testCases;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

    public Map<String, Integer> getErrors() {
        return errors;
    }

    public void setErrors(Map<String, Integer> errors) {
        this.errors = errors;
    }

    public List<String> getEasyTestCases() {
        return easyTestCases;
    }

    public void setEasyTestCases(List<String> easyTestCases) {
        this.easyTestCases = easyTestCases;
    }

    public List<String> getHardTestCases() {
        return hardTestCases;
    }

    public void setHardTestCases(List<String> hardTestCases) {
        this.hardTestCases = hardTestCases;
    }

    public void addEasyTestCases(String testCase){
        if (this.easyTestCases == null){
            easyTestCases = new ArrayList<>();
        }
        this.easyTestCases.add(testCase);
    }

    public void addHardTestCases(String testCase){
        if (this.hardTestCases == null){
            hardTestCases = new ArrayList<>();
        }
        this.hardTestCases.add(testCase);
    }
}
