package cn.edu.nju.qcz.entity;

public class CopyRelation {

    private int userId;
    private int examId;
    private int compareUserId;
    private String similarity;

    public String getSimilarity() {
        return similarity;
    }

    public void setSimilarity(String similarity) {
        this.similarity = similarity;
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

    public int getCompareUserId() {
        return compareUserId;
    }

    public void setCompareUserId(int compareUserId) {
        this.compareUserId = compareUserId;
    }
}
