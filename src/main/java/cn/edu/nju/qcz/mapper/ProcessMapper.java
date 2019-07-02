package cn.edu.nju.qcz.mapper;

import cn.edu.nju.qcz.entity.CopyRelation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Mapper
public interface ProcessMapper {

    List<String> getUserError(@Param("userId") int userId, @Param("examId") int examId);

    List<String> getError(@Param("examId") int examId);

    List<Integer> getCopyUser(@Param("examId") int examId, @Param("similarity") int similarity);

    List<CopyRelation> getCopyRelation(@Param("examId") int examId, @Param("userId") int userId, @Param("similarity") int similarity);

    String getCodeBySave(@Param("examId") int examId, @Param("userId") int userId, @Param("time") String time);
}
