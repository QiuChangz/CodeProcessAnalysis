<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/5/9
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>信息主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
    <%
        int examTimes = (int) request.getAttribute("examTimes");
        int userId = (int) request.getAttribute("userId");
        List<Integer> scoreList = (List<Integer>) request.getAttribute("scoreList");
    %>
</head>
<body background="https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg">
<div class="container">

    <nav class="navbar navbar-expand-lg navbar-light bg-faded" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">查看方式</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="nav-item active"><a href="#" class="nav-link" onclick="hideSingle()">总成绩变化</a></li>
                    <li class="nav-item"><a href="#" class="nav-link" onclick="hideTotal()">单场考试成绩变化</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <fieldset>
        <legend>用户信息</legend>
        用户名：<%=userId%>
        参与考试数：<%=examTimes%>
    </fieldset>

    <fieldset>
        <legend>考试信息展示</legend>
        <canvas id="score">成绩波动展示</canvas>
        <canvas id="examScore">单场考试成绩波动</canvas>
    </fieldset>
</div>
<script>
    function hideTotal() {
        $("#score").attr("hidden", true);
        $("#examScore").attr("hidden", false);
    }

    function hideSingle() {
        $("#score").attr("hidden", true);
        $("#examScore").attr("hidden", false);
    }
    var ctx = $("#score");
    var score = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [
                <%for (int i = 0; i < examTimes; i++){%>
                'exam<%=i + 1%>',
                <% }%>
            ],
            datasets: [{
                label: '成绩',
                data: [
                    <%for (int i = 0; i < examTimes; i++){%>
                    <%=scoreList.get(i)%>,
                    <% }%>
                ],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    var ctx2 = $("#examScore");
    var score = new Chart(ctx2, {
        type: 'line',
        data: {
            labels: [
                <%for (int i = 0; i < examTimes; i++){%>
                'exam<%=i + 1%>',
                <% }%>
            ],
            datasets: [{
                label: '成绩',
                data: [
                    <%for (int i = 0; i < examTimes; i++){%>
                    <%=scoreList.get(i)%>,
                    <% }%>
                ],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    })
</script>
</body>
</html>
