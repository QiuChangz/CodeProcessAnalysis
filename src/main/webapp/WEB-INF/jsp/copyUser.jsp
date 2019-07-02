<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="cn.edu.nju.qcz.entity.Exam" %>
<%@ page import="org.apache.commons.lang3.ArrayUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/4/30
  Time: 0:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>代码抄袭检测</title>


    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-table/1.14.2/bootstrap-table.js"></script>
    <%
        Map<Integer, List<String>> users = (Map<Integer, List<String>>) request.getAttribute("copyUsers");
        List<String> examInfo = (List<String>) request.getAttribute("examInfo");
    %>
</head>
<body background="https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg">
<%--<h3>考试抄袭用户数量占比</h3>--%>
<%--<canvas id="copyUsers" width="1200" height="800">抄袭用户展示</canvas>--%>

<div class="container">

    <fieldset>
        <legend>考试抄袭用户数量占比</legend>
    <table class="table table-hover">
        <thead>
        <tr>
            <th>Exam</th>
            <th>作弊人</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Integer exam: users.keySet()){
        %>
            <tr>
                <td>
                    exam<%=exam%>
                </td>
                <td>
                    <%=ArrayUtils.toString(users.get(exam))%>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    </fieldset>

    <nav class="navbar navbar-expand-lg navbar-light bg-faded" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">考试信息</a>
            </div>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav">
    <%
        for (String exam: examInfo){
    %>
        <li class="nav-item">
            <a class="nav-link" href="#" onclick="getCopyInfo(<%=exam%>)">
                exam<%=exam%>
            </a>
        </li>
    <%
        }
    %>
            </ul>
         </div>
        </div>
    </nav>
    <table class="table table-bordered table-hover table-striped" id="dataTable"></table>


    <div>
        <a href="${pageContext.request.contextPath}/codeAnalysis/show">
            <button type="button" class="btn btn-primary">返回</button>
        </a>
    </div>
</div>
<script>

    var examId = 1;
    $('#dataTable').bootstrapTable({
        method : 'get',
        url : "${pageContext.request.contextPath}/codeAnalysis/getCopyUserInfo?examId=1",//请求路径
        striped : true, //是否显示行间隔色
        pageNumber : 1, //初始化加载第一页
        pagination : true,//是否分页
        sidePagination : 'client',
        pageSize : 10,//单页记录数
        pageList : [10, 20, 50],//可选择单页记录数
        showRefresh : false,//刷新按钮
        search : true,
        columns : [{
            title : '抄袭人',
            field : 'userId',
            sortable : true
        },{
            title : '被抄袭人',
            field : 'compareUserId',
            sortable : true
        },{
            title : '代码相似度',
            field : 'similarity',
            sortable : true
        },{
            title : '操作',
            field : 'examId',
            formatter : formatExamId
        }]
    });
    function getCopyInfo(examId) {
        this.examId = examId;
        var opt = {
            url: "${pageContext.request.contextPath}/codeAnalysis/getCopyUserInfo?examId=" + examId,
            silent: true
        };
        $("#dataTable").bootstrapTable('refresh', opt);
    }

    function formatExamId(value, row, index) {
        return "<a href='${pageContext.request.contextPath}/codeAnalysis/getCodeDiff?examId=" + examId  + "&userId1=" + row.userId + "&userId2=" + row.compareUserId +  "'><img style='height: 20px;' src='../img/eye.svg'>查看</a>"
    }
</script>
</body>
</html>
