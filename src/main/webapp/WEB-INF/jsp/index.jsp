<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cn.edu.nju.qcz.controller.respBean.InitialBean" %>
<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/4/23
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CodeProcess</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

    <style>
        body {
            padding-top: 100px;
            padding-bottom: 40px;
        }
    </style>
</head>
<body background="https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg">
<%--<iframe src="http://www.matools.com/embed/compare"--%>
        <%--width="100%" height="450px;" scrolling="no" style="border:0px;">--%>
<%--</iframe>--%>
<div class="container">
    <table class="table table-hover">
        <thead>
        <tr>
            <th>EXAM</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${result.getExamInfo()}" var="exam">
            <tr>
                <td>
                    <a href="${pageContext.request.contextPath}/codeAnalysis/showUserInfo?examId=${exam}">exam${exam}</a>
                </td>
            </tr>
        </c:forEach>


        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/codeAnalysis/getCopyUsers">查看抄袭情况</a>
            </td>
        </tr>

        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/codeAnalysis/getStudentsAbility">查看用户信息</a>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
