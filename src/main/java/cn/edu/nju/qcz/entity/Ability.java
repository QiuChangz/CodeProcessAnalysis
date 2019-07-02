package cn.edu.nju.qcz.entity;

public class Ability {
    private Integer userId;
    private Integer ability;

    public Ability(){

    }
    public Ability(Integer userId, Integer ability) {
        this.userId = userId;
        this.ability = ability;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAbility() {
        return ability;
    }

    public void setAbility(Integer ability) {
        this.ability = ability;
    }
}
