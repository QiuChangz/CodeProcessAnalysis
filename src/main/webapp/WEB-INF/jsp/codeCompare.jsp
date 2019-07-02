<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/5/10
  Time: 23:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>代码对比查看</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <style>
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
    </style>
</head>
<body>
<div class="container">
    <div>
        <h1>Exam${param.examId}用户抄袭代码展示</h1>
    </div>
    <br><br>
    <div>
        <h2 style="float:left;">抄袭者：${param.userId1}</h2>
        <h2 style="float:right;">被抄袭者：${param.userId2}</h2>
    </div>
    <br><br>
    <div class="row">
        <div class="md-form col col-md">
            <textarea id="code1" readonly class="md-textarea form-control" rows="50">
                ${code1}
            </textarea>
            <label for="code1"></label>
        </div>
        <div class="md-form col-md">
            <textarea id="code2" readonly class="md-textarea form-control" rows="50">
                ${code2}
            </textarea>
            <label for="code2"></label>
        </div>
    </div>


    <div>
        <a href="${pageContext.request.contextPath}/codeAnalysis/getCopyUsers">
            <button type="button" class="btn btn-primary">返回</button>
        </a>
    </div>
</div>
</body>
</html>
