<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cn.edu.nju.qcz.controller.respBean.ProcessBean" %>
<%@ page import="java.util.List" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/4/23
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CodeProcess</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <%--<script type="text/javascript" src="../js/jquery.js"></script>--%>
    <%
        ProcessBean processBean = (ProcessBean) request.getAttribute("process");
        List<String> time = processBean.getTime();
        List<String> action = processBean.getActions();
        String codeStartTime = (String) request.getAttribute("codeStartTime");
        String codeEndTime = (String) request.getAttribute("codeEndTime");
    %>
    <style>
        #box{position: relative; width: 1000px; height: 50px; border: 1px solid #6bc30d; margin:  50px auto 0;}
        #bg{height: 30px; margin-top: 19px; border: 1px solid #ddd; border-radius: 5px; overflow: hidden;}
        #bgcolor{background: #5889B2; width: 0; height: 10px; border-radius: 5px;}
        #bt{width: 34px; height: 34px; background: url(http://js.alixixi.com/uploadpic/201809021836014573.png) no-repeat center center; border-radius: 17px; overflow: hidden; position: absolute; left: 0px; margin-left: -17px; top: 8px; cursor: pointer;}
        #text{width: 1000px; margin: 0 auto; font-size: 16px; line-height: 2em;}
        body {
            padding-top: 100px;
            padding-bottom: 40px;
        }
        .timeline {
            list-style: none;
            padding: 20px 0 20px;
            position: relative;
        }
        .timeline:before {
            top: 0;
            bottom: 0;
            position: absolute;
            content: " ";
            width: 3px;
            background-color: #eeeeee;
            left: 50%;
            margin-left: -1.5px;
        }
        .timeline > li {
            margin-bottom: 20px;
            position: relative;
        }
        .timeline > li:before,
        .timeline > li:after {
            content: " ";
            display: table;
        }
        .timeline > li:after {
            clear: both;
        }
        .timeline > li:before,
        .timeline > li:after {
            content: " ";
            display: table;
        }
        .timeline > li:after {
            clear: both;
        }
        .timeline > li > .timeline-panel {
            width: 46%;
            float: left;
            border: 1px solid #d4d4d4;
            border-radius: 2px;
            padding: 20px;
            position: relative;
            -webkit-box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
            box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
        }
        .timeline > li > .timeline-panel:before {
            position: absolute;
            top: 26px;
            right: -15px;
            display: inline-block;
            border-top: 15px solid transparent;
            border-left: 15px solid #ccc;
            border-right: 0 solid #ccc;
            border-bottom: 15px solid transparent;
            content: " ";
        }
        .timeline > li > .timeline-panel:after {
            position: absolute;
            top: 27px;
            right: -14px;
            display: inline-block;
            border-top: 14px solid transparent;
            border-left: 14px solid #fff;
            border-right: 0 solid #fff;
            border-bottom: 14px solid transparent;
            content: " ";
        }
        .timeline > li > .timeline-badge {
            color: #fff;
            width: 50px;
            height: 50px;
            line-height: 50px;
            font-size: 1.4em;
            text-align: center;
            position: absolute;
            top: 16px;
            left: 50%;
            margin-left: -25px;
            background-color: #999999;
            z-index: 100;
            border-top-right-radius: 50%;
            border-top-left-radius: 50%;
            border-bottom-right-radius: 50%;
            border-bottom-left-radius: 50%;
        }
        .timeline > li.timeline-inverted > .timeline-panel {
            float: right;
        }
        .timeline > li.timeline-inverted > .timeline-panel:before {
            border-left-width: 0;
            border-right-width: 15px;
            left: -15px;
            right: auto;
        }
        .timeline > li.timeline-inverted > .timeline-panel:after {
            border-left-width: 0;
            border-right-width: 14px;
            left: -14px;
            right: auto;
        }
        .timeline-badge.primary {
            background-color: #2e6da4 !important;
        }
        .timeline-badge.success {
            background-color: #3f903f !important;
        }
        .timeline-badge.warning {
            background-color: #f0ad4e !important;
        }
        .timeline-badge.danger {
            background-color: #d9534f !important;
        }
        .timeline-badge.info {
            background-color: #5bc0de !important;
        }
        .timeline-title {
            margin-top: 0;
            color: inherit;
        }
        .timeline-body > p,
        .timeline-body > ul {
            margin-bottom: 0;
        }
        .timeline-body > p + p {
            margin-top: 5px;
        }
    </style>
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
                <li class="nav-item active"><a href="#" class="nav-link" onclick="hideNode()">基于任意时间</a></li>
                <li class="nav-item"><a href="#" class="nav-link" onclick="hideTime()">基于时间节点</a></li>
            </ul>
        </div>
    </div>
</nav>
</div>
<div class="container" id="time">

<div id="box">
    <div id="bg">
        <span id="bgcolor"></span>
    </div>
    <div id="bt"></div>
    <p>
        开始：<%=codeStartTime%>
        <span style="text-align: center">
        <span id="current">
        当前时间：<input id="currentTime" type="text" style="width: 150px;" value="<%=codeStartTime%>">
        </span>
  <label for="select">
            间隔时间:<input id="timeSegment" type="text" style="width: 30px;" value="5">
  </label>
  <select id="select" style="width: auto; height: 28px" class="selectpicker show-tick" data-live-search="true">
      <option>min</option>
      <option>s</option>
  </select>
            <input id="checkPrevious" type="button" onclick="previous()" class="btn btn-default" readonly style="text-align: center; height: 30px" value="<">
            <input id="checkCurrent" type="button" onclick="current()" class="btn btn-default" readonly style="text-align: center; height: 30px" value="确认">
            <input id="checkNext" type="button" onclick="next()" class="btn btn-default" readonly style="text-align: center; height: 30px" value=">">
        </span>
        <span style="float: right;">结束：<%=codeEndTime%></span>
    </p>
</div>
</div>
<div class="container" id="node" hidden>
    <div style="overflow-y:auto; overflow-x:auto; height:500px;">
        <div class="page-header">
            <h1 id="timeline">testCpp${param.userId}编程过程</h1>
        </div>
        <ul class="timeline">
            <% for (int i = 0; i < time.size(); i++){
                if ((i + 1)%2 == 0){
            %>
            <li class="timeline-inverted">
            <% } else {%>
            <li>
            <%}
                if (action.get(i).equals("cmdSave")){
            %>
            <div class="timeline-badge"><i class="glyphicon glyphicon-floppy-disk"></i></div>
            <%
                } else {
            %>
            <div class="timeline-badge"><i class="glyphicon glyphicon-check"></i></div>
            <%
                }
            %>
                <div class="timeline-panel">
                    <div class="timeline-heading">
                        <h4 class="timeline-title"><%=action.get(i)%></h4>
                        <p><small class="text-muted"><i class="glyphicon glyphicon-time"></i><%=time.get(i)%></small></p>
                    </div>

                    <div class="timeline-body">
                        <button type="button" onclick="getCodeByDate('<%=time.get(i)%>');" class="btn btn-primary btn-sm">
                            查看代码
                        </button>
                    </div>
                </div>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</div>
<br><br>
<div class="container">
<div>
    <a href="${pageContext.request.contextPath}/codeAnalysis/showUserInfo?examId=${param.examId}">
        <button type="button" class="btn btn-primary">返回</button>
    </a>
</div>
<label id="checkBox" hidden>
    <input id="isChecked"  type="checkbox">
    选中作为比对
</label>
</div>
<div class="container">
    <div id="compareDate" hidden>
        <h5>
            <p style="float:left;">
                时间：<span id="time1"></span>
            </p>

            <p style="float:right;">
                时间：<span id="time2"></span>
            </p>
        </h5>
    </div>
<iframe id="code" name="frame" style="width:100%;height:100%;" hidden></iframe>
</div>

<script>
    function next() {
        var seg = $("#timeSegment").val();
        var current = $("#currentTime").val();
        getCodeBySecondSeg(current, seg, true);
    }
    function previous() {
        var seg = $("#timeSegment").val();
        var current = $("#currentTime").val();
        getCodeBySecondSeg(current, seg, false);
    }

    function current() {
        var current = $("#currentTime").val();
        getCodeBySecondSeg(current, 0, false);
    }
    function hideNode() {
        $("#node").attr("hidden", true);
        $("#time").attr("hidden", false);
        document.getElementById("isChecked").checked = false;
        $("#checkBox").attr("hidden", true);
        $("#code").attr("hidden", true);
        $("#compareDate").attr("hidden", true);
        $("#currentTime").val("<%=codeStartTime%>");
    }

    function hideTime() {
        $("#node").attr("hidden", false);
        $("#time").attr("hidden", true);
        $("#checkBox").attr("hidden", true);
        document.getElementById("isChecked").checked = false;
        $("#code").attr("hidden", true);
        $("#bt").css('left',0);
        $("#bgcolor").width(0);
        $("#currentTime").val('<%=codeStartTime%>');
        $("#compareDate").attr("hidden", true);
    }
    var lastTime;
    var lastSecond = 0;
    var curSecond = 0;
    (function($){
            var $box = $('#box');
            var $bg = $('#bg');
            var $bgcolor = $('#bgcolor');
            var $btn = $('#bt');
            var $text = $('#text');
            var statu = false;
            var ox = 0;
            var lx = 0;
            var left = 0;
            var bgleft = 0;
            $btn.mousedown(function(e){
                lx = $btn.offset().left;
                ox = e.pageX - left;
                statu = true;
            });
            $(document).mouseup(function(){
                statu = false;
            });
            $box.mousemove(function(e){
                if(statu){
                    left = e.pageX - ox;
                    if(left < 0){
                        left = 0;
                    }
                    if(left > 1000){
                        left = 1000;
                    }
                    $btn.css('left',left);
                    $bgcolor.width(left);
                    lastSecond = curSecond;
                    curSecond = left;
                    getCodeBySecond(curSecond);
                }
            });
            $bg.click(function(e){
                if(!statu){
                    bgleft = $bg.offset().left;
                    left = e.pageX - bgleft;
                    if(left < 0){
                        left = 0;
                    }
                    if(left > 1000){
                        left = 1000;
                    }
                    $btn.css('left',left);
                    $bgcolor.stop().animate({width:left},1000);
                    lastSecond = curSecond;
                    curSecond = left;
                    getCodeBySecond(curSecond);
                }
            });
        })(jQuery);

    function getQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    function getCodeBySecondSeg(time, segment, isNext) {
        if (document.getElementById("isChecked").checked) {
            $.post({
                url:"getCodeDiffSecondSeg",
                data:{
                    time1: time,
                    segment: segment,
                    unit: $("#select").find("option:selected").text() === "min",
                    userId: getQueryString("userId"),
                    examId: getQueryString("examId"),
                    isNext: isNext ? 1 :0
                },
                success: function(msg){
                    document.getElementById("code").srcdoc=msg;
                    document.getElementById("code").hidden=false;
                    $("#time1").html($(msg).find("#time1").html());
                    $("#time2").html($(msg).find("#time2").html());
                    $("#currentTime").val($(msg).find("#time2").html());
                    $("#current").attr("hidden", true);
                    $("#compareDate").attr("hidden", false);
                    lastSecond = curSecond;
                    curSecond = Number($(msg).find("#percent").html());
                    $("#bt").css('left', curSecond);
                    $("#bgcolor").width(curSecond);
                }
            });
        } else {
            $("#compareDate").attr("hidden", true);
            $.post({
                url: "getCodeByTimeSeg",
                data: {
                    userId: getQueryString("userId"),
                    examId: getQueryString("examId"),
                    time: time,
                    segment: segment,
                    unit: $("#select").find("option:selected").text() === "min",
                    isNext: isNext ? 1 :0
                },
                success: function (msg) {
                    document.getElementById("code").srcdoc = msg;
                    document.getElementById("code").hidden = false;
                    $("#checkBox").attr("hidden", false);
                    $("#current").attr("hidden", false);
                    $("#currentTime").val($(msg).find("#time").html());
                    lastSecond = curSecond;
                    curSecond = Number($(msg).find("#percent").html());
                    $("#bt").css('left', curSecond);
                    $("#bgcolor").width(curSecond);
                }
            })
        }
    }
    function getCodeBySecond(time){
        if (document.getElementById("isChecked").checked) {
            $.post({
                url:"getCodeDiffSecond",
                data:{
                    time1: Math.round(lastSecond),
                    time2: Math.round(time),
                    userId: getQueryString("userId"),
                    examId: getQueryString("examId"),
                },
                success: function(msg){
                    document.getElementById("code").srcdoc=msg;
                    document.getElementById("code").hidden=false;
                    $("#time1").html($(msg).find("#time1").html());
                    $("#time2").html($(msg).find("#time2").html());
                    $("#compareDate").attr("hidden", false);
                    $("#current").attr("hidden", true);
                }
            });
        } else {
            $("#compareDate").attr("hidden", true);
            $.post({
                url: "getCodeByTime",
                data: {
                    userId: getQueryString("userId"),
                    examId: getQueryString("examId"),
                    time: Math.round(time)
                },
                success: function (msg) {
                    document.getElementById("code").srcdoc = msg;
                    document.getElementById("code").hidden = false;
                    $("#checkBox").attr("hidden", false);
                    $("#currentTime").val($(msg).find("#time").html());
                    $("#current").attr("hidden", false);
                }
            })
        }
    }

    function getCodeDiff(time) {
        $.post({
            url:"getCodeDiff",
            data:{
                time1: lastTime,
                time2: time,
                userId: getQueryString("userId"),
                examId: getQueryString("examId"),
            },
            success: function(msg){
                document.getElementById("code").srcdoc=msg;
                document.getElementById("code").hidden=false;
                $("#time1").html($(msg).find("#time1").html());
                $("#time2").html($(msg).find("#time2").html());
                $("#compareDate").attr("hidden", false);
                $("#current").attr("hidden", true);
            }
        });
    }
    function getCodeByDate(time){
        if (document.getElementById("isChecked").checked){
            getCodeDiff(time);
            lastTime = time;
        } else{
            $("#compareDate").attr("hidden", true);
            lastTime = time;
            $.post({
                url:"getCodeByDate",
                data:{
                    userId: getQueryString("userId"),
                    examId: getQueryString("examId"),
                    date: time
                },
                success: function(msg){
                    document.getElementById("code").srcdoc=msg;
                    document.getElementById("code").hidden=false;
                    $("#checkBox").attr("hidden", false);
                    $("#currentTime").val($(msg).find("#time").html());
                    $("#current").attr("hidden", false);
                }
            })
        }
    }
</script>
</body>
</html>
