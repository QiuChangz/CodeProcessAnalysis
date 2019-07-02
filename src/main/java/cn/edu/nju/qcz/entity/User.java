package cn.edu.nju.qcz.entity;

import java.util.List;
import java.util.Map;

public class User {
    private Integer userId;
    private Integer examId;
    private Integer finalScore;
    private long codeTime;
    private long debugTime;
    private String codeStartTime;
    private String codeEndTime;
    private Map<String, Score> testInfo;
    private List<String> easyTest;
    private List<String> hardTest;

    public User(String userId){
        this.userId = Integer.parseInt(userId);
        finalScore = 0;
    }

    public List<String> getEasyTest() {
        return easyTest;
    }

    public void setEasyTest(List<String> easyTest) {
        this.easyTest = easyTest;
    }

    public List<String> getHardTest() {
        return hardTest;
    }

    public void setHardTest(List<String> hardTest) {
        this.hardTest = hardTest;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getExamId() {
        return examId;
    }

    public void setExamId(int examId) {
        this.examId = examId;
    }

    public int getFinalScore() {
        return finalScore;
    }

    public void setFinalScore(int finalScore) {
        this.finalScore = finalScore*10;
    }

    public long getCodeTime() {
        return codeTime;
    }

    public void setCodeTime(long codeTime) {
        this.codeTime = codeTime;
    }

    public long getDebugTime() {
        return debugTime;
    }

    public void setDebugTime(long debugTime) {
        this.debugTime = debugTime;
    }

    public String getCodeStartTime() {
        return codeStartTime;
    }

    public void setCodeStartTime(String codeStartTime) {
        this.codeStartTime = codeStartTime;
    }

    public String getCodeEndTime() {
        return codeEndTime;
    }

    public void setCodeEndTime(String codeEndTime) {
        this.codeEndTime = codeEndTime;
    }

    public Map<String, Score> getTestInfo() {
        return testInfo;
    }

    public void setTestInfo(Map<String, Score> testInfo) {
        this.testInfo = testInfo;
    }

}
