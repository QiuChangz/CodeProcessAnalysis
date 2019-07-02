package cn.edu.nju.qcz.controller.respBean;

import java.util.List;
import java.util.Map;

public class ProcessBean {

    private int userId;
    private int examId;
    private String startTime;
    private String endTime;
    private int compileTimes;
    private Map<String, String> shotTimes;
    private Map<String, Integer> testInfo;
    private List<String> time;
    private List<String> actions;

    public ProcessBean(int userId, int examId){
        this.userId = userId;
        this.examId = examId;
    }

    public List<String> getActions() {
        return actions;
    }

    public void setActions(List<String> actions) {
        this.actions = actions;
    }

    public List<String> getTime() {
        return time;
    }

    public void setTime(List<String> time) {
        this.time = time;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public int getCompileTimes() {
        return compileTimes;
    }

    public void setCompileTimes(int compileTimes) {
        this.compileTimes = compileTimes;
    }

    public Map<String, String> getShotTimes() {
        return shotTimes;
    }

    public void setShotTimes(Map<String, String> shotTimes) {
        this.shotTimes = shotTimes;
    }

    public Map<String, Integer> getTestInfo() {
        return testInfo;
    }

    public void setTestInfo(Map<String, Integer> testInfo) {
        this.testInfo = testInfo;
    }
}
