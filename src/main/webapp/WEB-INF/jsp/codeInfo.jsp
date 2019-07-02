<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/4/24
  Time: 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CodeInfo</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

    <style type="text/css">
        code {white-space: pre-line;}
    </style>
    <%
        int percent = request.getAttribute("percent") == null ? 0 : (int) request.getAttribute("percent");
    %>
</head>
<body>

<div class="container">
    <p id="percent" hidden><%=percent%></p>
    <p id="time" hidden>${time}</p>
    <c:forEach items="${codeInfo}" var="codeFile">
    <table class="table table-hover">
        <thead>
        <tr>
            <th>${codeFile.key}</th>
        </tr>
        </thead>
        <tbody>

            <tr>
                <td>
                    <textarea readonly class="code" style="width: 100%; height: 1200px">${codeFile.value.content}</textarea>
                </td>
            </tr>
        </tbody>
    </c:forEach>
</div>
</body>
</html>
