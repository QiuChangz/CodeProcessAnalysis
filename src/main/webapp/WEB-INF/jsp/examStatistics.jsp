<%@ page import="cn.edu.nju.qcz.controller.respBean.AnalysisDataBean" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/4/24
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Statistics</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-table/1.14.2/bootstrap-table.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <%
        AnalysisDataBean dataBean = (AnalysisDataBean) request.getAttribute("result");
        Map<String, Integer> errors = dataBean.getErrors();
        Map<Integer, Integer> testCases = dataBean.getTestCases();
        Map<Integer, Integer> scores = (Map<Integer, Integer>) request.getAttribute("scoreList");
    %>
    <style>
        body {
            padding-top: 100px;
            padding-bottom: 40px;
        }
    </style>
</head>
<body background="https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg">
<div class="container">

    <h3>Exam${exam}</h3>
    <a href="../exam/${exam}/question/exam.pdf">查看考试题目</a>

        <nav class="navbar navbar-expand-lg navbar-light bg-faded" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">查看方式</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="nav-item active"><a href="#" class="nav-link" onclick="showCases()">测试用例通过情况</a></li>
                        <li class="nav-item"><a href="#" class="nav-link" onclick="showScores()">查看考试成绩</a></li>
                        <li class="nav-item"><a href="#" class="nav-link" onclick="showErrors()">用户错误类型</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    <canvas id="error" hidden width="1200px" height="400px">用户错误类型展示</canvas>
    <canvas id="testCases" width="600px" height="400px" style="height: 400px; width: 600px;">用户测试用例通过情况展示</canvas>
    <canvas id="score" hidden>成绩波动展示</canvas>
    <table class="table table-hover" id="dataTable">
    </table>

    <div>
        <a href="${pageContext.request.contextPath}/codeAnalysis/showUserInfo?examId=${param.examId}">
            <button type="button" class="btn btn-primary">返回</button>
        </a>
    </div>
</div>
<script type="text/javascript">

    function showScores() {
        $("#score").attr("hidden", false);
        $("#testCases").attr("hidden", true);
        $("#error").attr("hidden", true);
    }

    function showCases() {
        $("#score").attr("hidden", true);
        $("#testCases").attr("hidden", false);
        $("#error").attr("hidden", true);
    }

    function showErrors() {
        $("#score").attr("hidden", true);
        $("#testCases").attr("hidden", true);
        $("#error").attr("hidden", false);
    }
    var ctx = $("#score");
    var score = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                <%for (int i: scores.keySet()){%>
                '<%=i%>',
                <% }%>
            ],
            datasets: [{
                label: '成绩',
                data: [
                    <%for (int i : scores.keySet()){%>
                    <%=scores.get(i)%>,
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

    $('#dataTable').bootstrapTable({
        method : 'get',
        url : "${pageContext.request.contextPath}/codeAnalysis/getAnalysisDataInfo",//请求路径
        striped : true, //是否显示行间隔色
        pageNumber : 1, //初始化加载第一页
        pagination : true,//是否分页
        sidePagination : 'client',
        pageSize : 10,//单页记录数
        pageList : [10, 20, 50],//可选择单页记录数
        showRefresh : false,//刷新按钮
        queryParams : function(params) {//上传服务器的参数
            var temp = {
                examId : ${param.examId}
            };
            return temp;
        },
        columns : [{
            title : '用户名',
            field : 'userId',
            sortable : true,
            formatter : formatUser
        },{
            title : '考试成绩',
            field : 'finalScore',
            sortable : true
        },{
            title : '开始时间',
            field : 'codeStartTime',
            sortable : true
        },{
            title : '结束时间',
            field : 'codeEndTime',
            sortable : true
        },{
            title : '编程时长(单位：s)',
            field : 'codeTime',
            sortable : true
        },{
            title : '易测试用例',
            field : 'easyTest'
        },{
            title : '难测试用例',
            field : 'hardTest'
        }]
    });
    function formatUser(value, row, index) {
        return "<a href='${pageContext.request.contextPath}/codeAnalysis/showProcess?examId=${exam}&userId=" + value + "'>testCpp" + value + "</a>";
    }

    var color = Chart.helpers.color;
    var barChartData = {

        labels : [
            <%
                for (Integer testCase: testCases.keySet()){
            %>
            "test_<%=testCase + 1%>",
            <%
            }
            %>],
        datasets: [{
            label: '人数',
            backgroundColor: '#aaadde',
            borderColor: '#aaadde',
            borderWidth: 1,
            data: [
                <%for (Integer testCase: testCases.keySet()){%>
                <%=testCases.get(testCase)%>,
                <%} %>
            ]
        }]

    };
    window.onload = function(){
        var ctx = document.getElementById("testCases").getContext("2d");
        window.myBar = new Chart(ctx, {
            type: 'bar',
            data: barChartData,
            options: {
                responsive: true,
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '测试用例通过次数展示'
                }
            }
        });
    };


    var drawCircle = function(data, canvas, options){
        var defaultOptions = {
            legend: {
                position: 'right',
                font: {
                    weight: 'bold',
                    size: 20,
                    family: 'Arial'
                }
            },
            title: {
                text: 'Pie Chart',
                font: {
                    weight: 'bold',
                    size: 20,
                    family: 'Arial'
                }
            },
            tooltip: {
                template: '<div>错误种类: {{label}}</div><div>发生次数: {{data}}</div>',
                font: {
                    weight: 'bold',
                    size: 20,
                    family: 'Arial'
                }
            }
        }
        if(canvas.getContext) {
            var ctx = canvas.getContext("2d");
            var width = canvas.width,
                height = canvas.height,
                op = generateOptions(options, defaultOptions),
                title_text = op.title.text, title_height = op.title.font.size,
                title_position = {};
            ctx.font = op.title.font.weight + " " + op.title.font.size+"px " + op.title.font.family;
            title_width = ctx.measureText(title_text).width;
            title_position .x = (width - title_width)/2;
            title_position.y = 20 + op.title.font.size;
            title_width = ctx.measureText(title_text).width;
            title_height = op.title.font.size;
            ctx.fillText(title_text, title_position.x, title_position.y);
            var radius = (height - title_height - title_position.y - 20) / 2 ;
            var center = {
                x: radius + 20,
                y: radius + 30 + title_position.y
            };
            var legend_width = op.legend.font.size * 2.5,
                legend_height = op.legend.font.size * 1.2,
                legend_posX = center.x * 2 +20,
                legend_posY = 80,
                legend_textX = legend_posX + legend_width + 5, legend_textY = legend_posY + op.legend.font.size * 0.9;
            var startAngle = 0, endAngle = 0;
            ctx.strokeStyle = 'grey';
            ctx.lineWidth = 3;
            ctx.strokeRect(0, 0, canvas.width, canvas.height);
            var data_c = calculateData(data);
            var color = ["#5a3921", "#207dff", "grey", "#373a6d", "#ff8246"];
            for(var i=0, len=data_c.length; i<len; i++) {
                endAngle += data_c[i].portion * 2*Math.PI;
                ctx.fillStyle = color[i%color.length];
                ctx.beginPath();
                ctx.moveTo(center.x, center.y);
                ctx.arc(center.x, center.y, radius, startAngle, endAngle, false);
                ctx.closePath();
                ctx.fill();
                startAngle = endAngle;
                ctx.fillRect(legend_posX, legend_posY + (10 + legend_height) * i, legend_width, legend_height);
                ctx.font = 'bold 12px Arial';
                var percent = data_c[i].label + ' : ' + (data_c[i].portion*100).toFixed(2) + '%';
                ctx.fillText(percent, legend_textX, legend_textY + (10 + legend_height) * i);
            }
        }
    };
    function mergeJSON(source1,source2){
        var mergedJSON = JSON.parse(JSON.stringify(source2));
        for (var attrname in source1) {
            if(mergedJSON.hasOwnProperty(attrname)) {
                if ( source1[attrname]!=null && source1[attrname].constructor==Object ) {
                    mergedJSON[attrname] = mergeJSON(source1[attrname], mergedJSON[attrname]);
                }
            } else {
                mergedJSON[attrname] = source1[attrname];
            }
        }
        return mergedJSON;
    }
    function generateOptions(givenOptions, defaultOptions) {
        return mergeJSON(defaultOptions, givenOptions);
    }
    function calculateData(data) {
        if(data instanceof Array) {
            var sum = data.reduce(function(a, b) {
                return a + b.data;
            }, 0);
            var map = data.map(function(a) {
                return {
                    label: a.label,
                    data: a.data,
                    color: a.color,
                    portion: a.data/sum
                }
            });
            return map;
        }
    }
    var init = function(){
        var data = [
            <%
                for (String error: errors.keySet()){
            %>
            { data: <%=errors.get(error)%>, label: '<%=error%>' },
            <%
            }
            %>
        ];
        var options = {
            title: {
                text: '用户错误类型展示',
                font: {
                    size: 30
                }
            },
            tooltip: {
                template: '<div>Year: {{label}}</div><div>Production: {{data}}</div>',
                font: {
                    family: "Arial"
                }
            }
        }
        drawCircle(data, document.getElementById("error"), options);
    };
    init();
</script>
</body>
</html>
