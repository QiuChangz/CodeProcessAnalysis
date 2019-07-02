package cn.edu.nju.qcz.service;

import cn.edu.nju.qcz.common.GlobalConfig;
import cn.edu.nju.qcz.controller.respBean.AnalysisDataBean;
import cn.edu.nju.qcz.controller.respBean.ProcessBean;
import cn.edu.nju.qcz.entity.*;
import cn.edu.nju.qcz.mapper.ProcessMapper;
import cn.edu.nju.qcz.mapper.ScoreMapper;
import cn.edu.nju.qcz.mapper.UserMapper;
import cn.edu.nju.qcz.util.FileChineseCharsetDetector;
import cn.edu.nju.qcz.util.PropertiesLoaderUtils;
import com.xcelenter.Bussiness.RecurrenceProgramProcess;
import com.xcelenter.Model.CodeFile;
import org.apache.commons.io.FileUtils;
import org.python.core.PyBoolean;
import org.python.core.PyFunction;
import org.python.core.PyInteger;
import org.python.core.PyObject;
import org.python.util.PythonInterpreter;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class BaseService {

    @Resource
    private UserMapper userMapper;
    @Resource
    private ScoreMapper scoreMapper;
    @Resource
    private ProcessMapper processMapper;
    @Resource
    private FileChineseCharsetDetector encoding;

    public Map<String, CodeFile> getCodeByDate(int userId, int examId, String time){
        RecurrenceProgramProcess recurrenceProgramProcess = new RecurrenceProgramProcess();
        String dbFilePath = GlobalConfig.getConfig("dbFilePath", "F:\\DataSource");
        String examInfo = "testCpp" + examId;
        String userInfo = "testCpp" + userId;
        String dbLocation = dbFilePath + "\\" + examInfo + "\\Results\\" + userInfo;
        String tmpPath = GlobalConfig.getConfig("tmpPath", "F:\\tmp\\tmpDir");
        String targetPath = GlobalConfig.getConfig("targetPath", "F:\\tmp\\out");
        time = time.replace("/", "-");
        return recurrenceProgramProcess.reproduceProgramProcess(dbLocation, targetPath, tmpPath, time);
    }

    public AnalysisDataBean getAnalysisData(int examId){
        List<String> users = userMapper.getUserInfo(examId);
        List<Score> finalScore = scoreMapper.getTotalFinalScore(examId);
        List<Score> scores = scoreMapper.getExamScore(examId);
        AnalysisDataBean analysisDataBean = new AnalysisDataBean();
        List<User> data = new ArrayList<>();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        int testCaseNum = Integer.parseInt(GlobalConfig.getConfig("testCase", "10"));
        int testCases[] = new int[testCaseNum];
        String testPrefix = "test_";

        for (String userId: users){
            int userTestCases[] = new int[testCaseNum];
            int sum = 0;
            User user = new User(userId);
            user.setExamId(examId);
            String startTime = getCodeStartTime(user.getUserId(), examId);
            String endTime = getCodeEndTime(user.getUserId(), examId);
            user.setCodeStartTime(startTime);
            user.setCodeEndTime(endTime);
            try {
                user.setCodeTime((dateFormat.parse(endTime).getTime() - dateFormat.parse(startTime).getTime())/1000);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            for (Score score: finalScore){
                if (score.getUserId() == user.getUserId()){
                    user.setFinalScore(score.getScore());
                }
            }

            Map<String, Score> test = new HashMap<>();
            for (Score score: scores){
                if (score.getUserId() != user.getUserId()) {
                    continue;
                }

                test.put(score.getTime(), score);
                String ac = score.getAc();
                if (ac == null || ac.length() == 0 || ac.equals("null")){
                    continue;
                }
                String[] acs = ac.split(",");
                for (String testCase: acs){
                    int testId = Integer.valueOf(testCase.substring(6, testCase.indexOf("[")));
                    userTestCases[testId - 1]++;
                    sum++;
                }
            }
            user.setTestInfo(test);
            data.add(user);
            sum /= testCaseNum;
            List<String> easyTestCases = new ArrayList<>();
            List<String> hardTestCases = new ArrayList<>();
            for (int i = 0; i < userTestCases.length; i++){
                testCases[i] += userTestCases[i];
                if (userTestCases[i] < sum){
                    hardTestCases.add(testPrefix + i);
                } else if (userTestCases[i] > sum){
                    easyTestCases.add(testPrefix + i);
                }
            }
            user.setEasyTest(easyTestCases);
            user.setHardTest(hardTestCases);
        }

        int max = Integer.MIN_VALUE;
        int min = Integer.MAX_VALUE;
        for (int testCase : testCases) {
            if (max < testCase) {
                max = testCase;
            }
            if (min > testCase) {
                min = testCase;
            }
        }
        Map<Integer, Integer> allTestCases = new HashMap<>();
        for (int j = 0; j < testCases.length; j++){
            allTestCases.put(j, testCases[j]);
            if (Math.abs(max - testCases[j]) < 2){
                analysisDataBean.addEasyTestCases(testPrefix + j);
            } else if (Math.abs(min - testCases[j]) < 2){
                analysisDataBean.addHardTestCases(testPrefix + j);
            }
        }
        analysisDataBean.setTestCases(allTestCases);
        analysisDataBean.setUserList(data);
        List<String> errors = processMapper.getError(examId);
        Map<String, Integer> errorList = new HashMap<>();
        String prefix = "[{\\\"ErrorLevel\\\":4,\\\"Description\\\":\\\"";
        for (int i = 0; i < errors.size(); i++){
            if (!errors.get(i).contains(prefix)){
                continue;
            }

            String tmp = errors.get(i).substring(prefix.length());
            tmp = tmp.substring(0, tmp.indexOf(","));
            errorList.put(tmp, errorList.getOrDefault(tmp, 0) + 1);
        }
        analysisDataBean.setErrors(errorList);
        return analysisDataBean;
    }

    public ProcessBean getCodeProcess(int userId, int examId){
        List<Summary> summaryList = userMapper.getSummaryInfo(userId, examId);
        String codeStartTime, codeEndTime;
        Map<String, String> shotTime = new HashMap<>();
        List<String> time = new ArrayList<>();
        List<String> action = new ArrayList<>();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        codeEndTime = "1970/01/01 00:00:00";
        codeStartTime = dateFormat.format(new Date());
        String lastTime = codeEndTime;
        for (Summary summary: summaryList){
            try {
                if (dateFormat.parse(codeEndTime).before(dateFormat.parse(summary.getTime()))){
                    codeEndTime = summary.getTime();
                } else if (dateFormat.parse(codeStartTime).after(dateFormat.parse(summary.getTime()))){
                    codeStartTime = summary.getTime();
                }

                if (summary.getAction().equals("buildProject") || summary.getAction().equals("cmdSave")){
//                    System.out.println(Math.abs(dateFormat.parse(lastTime).getTime() - dateFormat.parse(summary.getTime()).getTime()));
                    if (!lastTime.equals("1970/01/01 00:00:00") && Math.abs(dateFormat.parse(lastTime).getTime() - dateFormat.parse(summary.getTime()).getTime()) < 2000)
                        continue;
                    shotTime.put(summary.getTime(), summary.getAction());
                    time.add(summary.getTime());
                    action.add(summary.getAction());
                    lastTime = summary.getTime();
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        ProcessBean processBean = new ProcessBean(userId, examId);
        processBean.setStartTime(codeStartTime);
        processBean.setEndTime(codeEndTime);
        processBean.setShotTimes(shotTime);
        processBean.setTime(time);
        processBean.setActions(action);
        return processBean;
    }
    public List<String> getUsersInfo(int examId){
        return userMapper.getUserInfo(examId);
    }

    public List<String> getExamInfo(){
        return userMapper.getExamInfo();
    }

    /**
     * 获得用户请求时间在总时间过程的比例
     * @param userId 请求的用户id
     * @param examId 请求的考试id
     * @param time 用户请求的时间
     * @return 请求时间在总时间的比例信息
     */
    public int getCodeTimePercent(int userId, int examId, String time){
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String codeStart = getCodeStartTime(userId, examId);
        String codeEnd = getCodeEndTime(userId, examId);
        int result = 0;
        try {
            long start = dateFormat.parse(codeStart).getTime();
            long end = dateFormat.parse(codeEnd).getTime();
            long current = dateFormat.parse(time).getTime();
            double total = end - start;
            double cur = current - start;
            result = (int) (cur/total * 1000);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return result;
    }
    public String getCodeStartTime(int userId, int examId){
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        List<String> times = userMapper.getCodeTime(userId, examId);
        String startTime = times.get(0);
        for (String time: times){
            try {
                if (dateFormat.parse(time).before(dateFormat.parse(startTime))){
                    startTime = time;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return startTime;
    }

    public String getCodeEndTime(int userId, int examId){
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        List<String> times = userMapper.getCodeTime(userId, examId);
        String endTime = times.get(0);
        for (String time: times){
            try {
                if (dateFormat.parse(time).after(dateFormat.parse(endTime))){
                    endTime = time;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return endTime;
    }

    public List<String> getFinalCopyInfo(int examId){
        int limitSimilarity = Integer.valueOf(GlobalConfig.getConfig("similarity", "90"));
        List<Integer> copyUser = processMapper.getCopyUser(examId, limitSimilarity);
        List<String> result = new ArrayList<>();
        for (int user: copyUser){
            result.add(String.valueOf(user));
        }
        return result;
    }

    public List<Exam> getExamUsersNum(){
        return userMapper.getTestUsersNum();
    }

    public List<CopyRelation> getCopyRelation(int examId, List<String> copyUsers){
        List<CopyRelation> results = new ArrayList<>();
        for (String user: copyUsers){
            int userId = Integer.parseInt(user);
            results.addAll(processMapper.getCopyRelation(examId, userId, Integer.valueOf(GlobalConfig.getConfig("similarity", "90"))));
        }
        return results;
    }

    public String getCodeByNode(int userId, int examId, String time){
        String result = processMapper.getCodeBySave(examId, userId, time);
        if(result == null){
            String buildLocation = GlobalConfig.getConfig("dbFilePath", "F:\\DataSource") + "\\testCpp" + examId;
            String prefix = "\\Results\\testCpp" + userId + "\\File\\build_files";
            buildLocation += prefix;
            File file = new File(buildLocation);
            if (!file.exists()){
                return getContentFromMap(getCodeByDate(userId, examId, time));
            }
            String tmp = time.substring(time.indexOf(" ") + 1).replace(":", "-");
            for (File date: file.listFiles()){
                if (!date.getName().contains(tmp)){
                    continue;
                }
                try {
                    result = getFileContent(date.getAbsolutePath());
                } catch (IOException e) {
                    e.printStackTrace();
                }
                break;
            }
        }
        return result == null ? getContentFromMap(getCodeByDate(userId, examId, time)) : result;
    }

    public String getFinalCode(int examId, int userId){
        String location = GlobalConfig.getConfig("oldExamInfo", "F:\\dataSet");
        location = location + "\\exam" + examId;
        File file = new File(location);
        String code = null;
        for (File cpp: file.listFiles()){
            if (!cpp.getName().endsWith(".cpp"))
                continue;
            String cppName = cpp.getName();
            if (cppName.substring(0, cppName.indexOf("_")).equals(String.valueOf(userId))){
                try {
                    code = FileUtils.readFileToString(cpp, "utf-8");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return code;
    }
    private String getContentFromMap(Map<String, CodeFile> code){
        StringBuilder codeInfo = new StringBuilder();
        for (String name: code.keySet()){
            codeInfo.append("\r\n").append(code.get(name).getContent()).append("\r\n");
        }
        return codeInfo.toString();
    }
    private String getFileContent(String path) throws IOException {
        File file = new File(path);
        if (file.isFile() && (file.getName().endsWith(".cpp") || file.getName().endsWith(".h"))){
            return FileUtils.readFileToString(file, encoding.guessFileEncoding(file));
        }
        StringBuilder result = new StringBuilder();

        if (file.isFile() || file.listFiles() == null){
            return result.toString();
        }
        for (File sub: file.listFiles()){
            result.append("\r\n").append(getFileContent(sub.getAbsolutePath()));
        }
        return result.toString();
    }

    private List<Integer> getCommonUsers(){
        String path = GlobalConfig.getConfig("commonUsers", "F:\\dataSet\\exam1");
        File file = new File(path);
        List<Integer> users = new ArrayList<>();
        for (File user: file.listFiles()){
            if (user.isDirectory())
                continue;
            if (!user.getName().endsWith(".cpp"))
                continue;
            users.add(Integer.valueOf(user.getName().substring(0, user.getName().indexOf("_"))));
        }
        return users;
    }

    public Map<Integer, Integer> getStudentAbility(){
        List<Integer> commonStudents = getCommonUsers();
        Integer[] ids = commonStudents.toArray(new Integer[0]);
        Arrays.sort(ids);
        Map<Integer, Double> userInfo = new HashMap<>();
        Map<Integer, Integer> results = new HashMap<>();
        List<String> exams = userMapper.getExamInfo();
        String finalScorePath = "F:\\dataSet\\finalScore";
        int ave = 0;
        for (int user: commonStudents){
            ave += getFinalScore(user);
        }
        ave = ave/commonStudents.size();
        for (String exam: exams){
            try {
                String content = FileUtils.readFileToString(new File("F:\\feather\\exam" + exam + "_predict.csv"), "utf-8");
                String result[] = content.split(",");
                for (int i = 0; i < result.length; i++){
                    double score = Double.parseDouble(result[i]) / exams.size();
                    userInfo.put(ids[i], userInfo.getOrDefault(ids[i], (double) 0) + score);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        for (int userId: userInfo.keySet()){
            results.put(userId, userInfo.get(userId) > ave ? 1 : 0);
        }
        return results;
    }

    private int getFinalScore(int userId){
        String path = "F:\\dataSet\\finalScore";
        String content = "";
        try {
            content = FileUtils.readFileToString(new File(path), "utf-8");
            String info = "\n" + userId + ",";
            content = content.substring(content.indexOf(info));
            content = content.substring(content.indexOf(",") + 1);
            content = content.substring(0, content.indexOf("\n"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Integer.valueOf(content.trim());
    }

    public int getExamTimes(int userId){
        return userMapper.getExamTimes(userId);
    }

    public List<Integer> getScoreList(int userId){
        List<String> examIds = userMapper.getExamInfo();
        List<Integer> scoreList = new ArrayList<>();
        for (String examId: examIds){
            scoreList.add(scoreMapper.getFinalScore(userId, Integer.valueOf(examId)).getScore());
        }
        return scoreList;
    }

    public Map<Integer, Integer> getExamScore(int examId){
        List<Score> scoreList = scoreMapper.getTotalFinalScore(examId);
        Map<Integer, Integer> result = new HashMap<>();
        for (Score score: scoreList){
            result.put(score.getScore(), result.getOrDefault(score.getScore(), 0) + 1);
        }
        return result;
    }
    public List<Score> getUserScore(int userId, int examId){
        return scoreMapper.getUserScore(userId, examId);
    }
}
