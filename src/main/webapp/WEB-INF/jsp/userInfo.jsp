<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/4/23
  Time: 21:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>userInfo</title>

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


<div class="container">
    <table class="table table-hover">
        <thead>
        <tr>
            <th>用户id</th>
            <th>
                操作
            </th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${result.getUserInfo()}" var="user">
            <tr>
                <td>
                    testCpp${user}
                </td>

                <td>
                    <a href="${pageContext.request.contextPath}/codeAnalysis/showProcess?examId=${exam}&userId=${user}">查看编码过程</a>
                    <%--<a href="${pageContext.request.contextPath}/codeAnalysis/profile?userId=${user}">用户主页</a>--%>
                </td>
            </tr>
        </c:forEach>


        <tr>
            <td>
                统计信息
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/codeAnalysis/getAnalysisData?examId=${exam}">查看</a>
            </td>
        </tr>
        </tbody>
    </table>
    <div>
        <a href="${pageContext.request.contextPath}/codeAnalysis/show">
            <button type="button" class="btn btn-primary">返回</button>
        </a>
    </div>
</div>

</body>
</html>
