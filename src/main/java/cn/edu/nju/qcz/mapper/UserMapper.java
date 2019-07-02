package cn.edu.nju.qcz.mapper;

import cn.edu.nju.qcz.entity.Exam;
import cn.edu.nju.qcz.entity.Summary;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Mapper
public interface UserMapper {

    List<String> getUserInfo(@Param("examId")int examId);

    List<String> getExamInfo();

    List<Summary> getSummaryInfo(@Param("userId") int userId, @Param("examId") int examId);

    List<String> getCodeTime(@Param("userId") int userId, @Param("examId") int examId);

    List<Exam> getTestUsersNum();

    int getExamTimes(@Param("userId") int userId);

}
