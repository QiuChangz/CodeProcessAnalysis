package cn.edu.nju.qcz.controller;

import cn.edu.nju.qcz.controller.respBean.AnalysisDataBean;
import cn.edu.nju.qcz.controller.respBean.InitialBean;
import cn.edu.nju.qcz.controller.respBean.ProcessBean;
import cn.edu.nju.qcz.entity.*;
import cn.edu.nju.qcz.service.BaseService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/codeAnalysis")
public class BaseController {

    @Resource
    private BaseService baseService;

    private static Map<Integer, AnalysisDataBean> analysisDataBeanHashMap = new HashMap<>();

    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String show(HttpServletRequest request){
        InitialBean result = (InitialBean) request.getAttribute("result");
        if (result == null){
            result = new InitialBean();
        }
        result.setExamInfo(baseService.getExamInfo());
        request.setAttribute("result", result);
        return "index";
    }

    @RequestMapping(value = "getUserInfo", method = RequestMethod.GET)
    @ResponseBody
    public List<String> getUserInfo(int examId){
        return baseService.getUsersInfo(examId);
    }

    @RequestMapping(value = "/showUserInfo", method = RequestMethod.GET)
    public String show(HttpServletRequest request, @RequestParam("examId")int examId){
        InitialBean result = (InitialBean) request.getAttribute("result");
        if (result == null){
            result = new InitialBean();
        }
        result.setUserInfo(baseService.getUsersInfo(examId));
        request.setAttribute("result", result);
        request.setAttribute("exam", examId);
        return "userInfo";
    }

    @RequestMapping(value = "/showProcess", method = RequestMethod.GET)
    public String showProcess(HttpServletRequest request, @RequestParam("examId")int examId, @RequestParam("userId") int userId){
        ProcessBean processBean = baseService.getCodeProcess(userId, examId);
        request.setAttribute("process", processBean);
        request.setAttribute("examId", examId);
        request.setAttribute("codeStartTime", baseService.getCodeStartTime(userId, examId));
        request.setAttribute("codeEndTime", baseService.getCodeEndTime(userId, examId));
        return "singleProcess";
    }

    @RequestMapping(value = "getCodeByDate", method = RequestMethod.POST)
    public String getCodeByDate(HttpServletRequest request, @RequestParam("userId") Integer userId, @RequestParam("examId") Integer examId, @RequestParam("date") String date){
        request.setAttribute("codeInfo", baseService.getCodeByDate(userId, examId, date));
        request.setAttribute("time", date);
        return "codeInfo";
    }

    @RequestMapping(value = "getCodeByTime", method = RequestMethod.POST)
    public String getCodeByTime(HttpServletRequest request,
                                @RequestParam("userId") Integer userId,
                                @RequestParam("examId") Integer examId,
                                @RequestParam("time") int time){
        String date = getDateByTime(userId, examId, time);
        request.setAttribute("codeInfo", baseService.getCodeByDate(userId, examId, date));
        request.setAttribute("time", date);
        return "codeInfo";
    }

    @RequestMapping(value = "getCodeByTimeSeg", method = RequestMethod.POST)
    public String getCodeByTime(HttpServletRequest request,
                                @RequestParam("userId") Integer userId,
                                @RequestParam("examId") Integer examId,
                                @RequestParam("unit") boolean isMin,
                                @RequestParam("time") String time,
                                @RequestParam("segment") int segment,
                                @RequestParam("isNext") int isNext){
        DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date current = null;
        if (isMin)
            segment = segment * 60;

        try {
            if (isNext == 1){
                current = new Date(df.parse(time).getTime() + segment*1000);
            } else {
                current = new Date(df.parse(time).getTime() - segment*1000);
            }
            String startTime = baseService.getCodeStartTime(userId, examId);
            String endTime = baseService.getCodeEndTime(userId, examId);
            if (df.parse(startTime).getTime() > current.getTime()){
                current = df.parse(startTime);
            }else if (df.parse(endTime).getTime() < current.getTime()){
                current = df.parse(endTime);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        request.setAttribute("codeInfo", baseService.getCodeByDate(userId, examId, df.format(current)));
        request.setAttribute("time", df.format(current));
        request.setAttribute("percent", baseService.getCodeTimePercent(userId, examId, df.format(current)));
        return "codeInfo";
    }

    @RequestMapping(value = "getAnalysisDataInfo", method = RequestMethod.GET)
    @ResponseBody
    public List<User> getAnalysisData(int examId){
        AnalysisDataBean dataBean;
        if (!(analysisDataBeanHashMap == null
                || analysisDataBeanHashMap.size() == 0
                || analysisDataBeanHashMap.get(examId) == null))
            dataBean = analysisDataBeanHashMap.get(examId);
        else {
            dataBean = baseService.getAnalysisData(examId);
            analysisDataBeanHashMap.put(examId, dataBean);
        }
        return dataBean.getUserList();
    }

    @RequestMapping(value = "getAnalysisData", method = RequestMethod.GET)
    public String getAnalysisData(HttpServletRequest request, int examId){
        AnalysisDataBean dataBean;
        if (!(analysisDataBeanHashMap == null
                || analysisDataBeanHashMap.size() == 0
                || analysisDataBeanHashMap.get(examId) == null))
            dataBean = analysisDataBeanHashMap.get(examId);
        else {
            dataBean = baseService.getAnalysisData(examId);
            analysisDataBeanHashMap.put(examId, dataBean);
        }
        request.setAttribute("scoreList", baseService.getExamScore(examId));
        request.setAttribute("exam", examId);
        request.setAttribute("result", dataBean);
        return "examStatistics";
    }

    @RequestMapping(value = "getCodeDiff", method = RequestMethod.POST)
    public String getCompareFile(HttpServletRequest request,
                                 @RequestParam("time1") String time1,
                                 @RequestParam("time2") String time2,
                                 @RequestParam("userId") int userId,
                                 @RequestParam("examId") int examId){
        String code1 = baseService.getCodeByNode(userId, examId, time1);
        String code2 = baseService.getCodeByNode(userId, examId, time2);
        request.setAttribute("code1", code1);
        request.setAttribute("code2", code2);
        request.setAttribute("time1", time1);
        request.setAttribute("time2", time2);
        return "codeDiff";
    }

    @RequestMapping(value = "getCodeDiff", method = RequestMethod.GET)
    public String getCompareFile(HttpServletRequest request,
                                 @RequestParam("userId1") int userId1,
                                 @RequestParam("userId2") int userId2,
                                 @RequestParam("examId") int examId){
        request.setAttribute("code1", baseService.getFinalCode(examId, userId1));
        request.setAttribute("code2", baseService.getFinalCode(examId, userId2));
        return "codeCompare";
    }

    @RequestMapping(value = "getCodeDiffSecond", method = RequestMethod.POST)
    public String getCompareFile(HttpServletRequest request,
                                 @RequestParam("time1") int second1,
                                 @RequestParam("time2") int second2,
                                 @RequestParam("userId") int userId,
                                 @RequestParam("examId") int examId){
        String time1 = getDateByTime(userId, examId, second1);
        String time2 = getDateByTime(userId, examId, second2);
        return getCompareFile(request, time1, time2, userId, examId);
    }

    @RequestMapping(value = "getCodeDiffSecondSeg", method = RequestMethod.POST)
    public String getCompareFile(HttpServletRequest request,
                                 @RequestParam("time1") String time1,
                                 @RequestParam("segment") int segment,
                                 @RequestParam("unit") boolean isMin,
                                 @RequestParam("userId") int userId,
                                 @RequestParam("examId") int examId,
                                 @RequestParam("isNext") int isNext){
        DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String time2 = null;
        if (isMin)
            segment = segment * 60;

        try {
            if (isNext == 1){
                time2 = df.format(new Date(df.parse(time1).getTime() + segment * 1000));
            } else {
                time2 = df.format(new Date(df.parse(time1).getTime() - segment * 1000));
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        request.setAttribute("percent", baseService.getCodeTimePercent(userId, examId, time2));
        return getCompareFile(request, time1, time2, userId, examId);
    }

    @RequestMapping(value = "getCopyUserInfo", method = RequestMethod.GET)
    @ResponseBody
    public List<CopyRelation> getCopyUserInfo(@RequestParam("examId") int examId){
        List<String> copyUser = baseService.getFinalCopyInfo(examId);
        return baseService.getCopyRelation(examId, copyUser);
    }

    @RequestMapping(value = "getCopyUsers", method = RequestMethod.GET)
    public String getCopyUsers(HttpServletRequest request){
        Map<Integer, List<String>> copyUsers = new HashMap<>();
        List<String> exams = baseService.getExamInfo();
        for (String exam: exams){
            List<String> copyUser = baseService.getFinalCopyInfo(Integer.valueOf(exam));
            copyUsers.put(Integer.valueOf(exam), copyUser);
        }
        List<Exam> examUsersNum = baseService.getExamUsersNum();
        request.setAttribute("copyUsers", copyUsers);
        request.setAttribute("examUsersNum", examUsersNum);
        request.setAttribute("examInfo", baseService.getExamInfo());
        return "copyUser";
    }

//    @RequestMapping(value = "getFinalCodeInfo", method = RequestMethod.GET)
//    @ResponseBody
//    public List<Ability> getFinalCodeInfo(){
//        Map<Integer, Integer> ability = baseService.getStudentAbility();
//        List<Ability> users = new ArrayList<>();
//        for (int userId: ability.keySet()){
//            users.add(new Ability(userId, ability.get(userId)));
//        }
//        return users;
//    }

    @RequestMapping(value = "getStudentsAbilityInfo", method = RequestMethod.GET)
    @ResponseBody
    public List<Ability> getAbility(){
        Map<Integer, Integer> ability = baseService.getStudentAbility();
        List<Ability> users = new ArrayList<>();
        for (int userId: ability.keySet()){
            users.add(new Ability(userId, ability.get(userId)));
        }
        return users;
    }

    @RequestMapping(value = "getStudentsAbility", method = RequestMethod.GET)
    public String getAbility(HttpServletRequest request){
        Map<Integer, Integer> ability = baseService.getStudentAbility();
        Map<Integer, Integer> goodAbility = new HashMap<>();
        Map<Integer, Integer> badAbility = new HashMap<>();

        for (int user: ability.keySet()){
            if (ability.get(user) == 1){
                goodAbility.put(user, ability.get(user));
            } else {
                badAbility.put(user, ability.get(user));
            }
        }
        request.setAttribute("ability", ability);
        request.setAttribute("badAbility", badAbility);
        request.setAttribute("goodAbility", goodAbility);
        return "studentAbility";
    }

    @RequestMapping(value = "profile", method = RequestMethod.GET)
    public String getProfile(HttpServletRequest request, @RequestParam("userId") int userId){
        int examTimes = baseService.getExamTimes(userId);

        List<Integer> scores = baseService.getScoreList(userId);
        request.setAttribute("examTimes", examTimes);
        request.setAttribute("userId", userId);
        request.setAttribute("scoreList", scores);
        return "profile";
    }

    @RequestMapping(value = "getExamScore", method = RequestMethod.GET)
    @ResponseBody
    public List<Score> getExamScore(HttpServletRequest request, @RequestParam("userId") int userId, @RequestParam("examId") int examId){
        return baseService.getUserScore(userId, examId);
    }

    private String getDateByTime(int userId, int examId, int time){
        String startTime = baseService.getCodeStartTime(userId, examId);
        String endTime = baseService.getCodeEndTime(userId, examId);
        DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        long costTime = 0;
        long startSecond = 0;
        String date = null;
        try {
            startSecond = df.parse(startTime).getTime();
            costTime = df.parse(endTime).getTime() - startSecond;
            long current = costTime * time / 1000 + startSecond;
            Date date1 = new Date(current);
            if (df.parse(startTime).getTime() > date1.getTime()){
                date1 = df.parse(startTime);
            }else if (df.parse(endTime).getTime() < date1.getTime()){
                date1 = df.parse(endTime);
            }
            date = df.format(date1);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }
}
