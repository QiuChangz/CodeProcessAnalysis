package cn.edu.nju.qcz.mapper;

import cn.edu.nju.qcz.entity.Score;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Mapper
public interface ScoreMapper {

    /**
     * 用户单场考试的所有测试成绩
     * @param userId 用户id
     * @param examId 考试id
     * @return 查询结果
     */
    List<Score> getUserScore(@Param("userId") int userId, @Param("examId") int examId);

    /**
     * 单场考试的所有用户成绩
     * @param examId 考试id
     * @return 查询结果
     */
    List<Score> getExamScore(@Param("examId") int examId);

    /**
     * 单场考试的所有用户的最终成绩
     * @param examId 考试id
     * @return 查询结果
     */
    List<Score> getTotalFinalScore(@Param("examId") int examId);

    /**
     * 用户单场考试的最终成绩
     * @param userId 用户id
     * @param examId 考试id
     * @return 查询结果
     */
    Score getFinalScore(@Param("userId") int userId, @Param("examId") int examId);
}
