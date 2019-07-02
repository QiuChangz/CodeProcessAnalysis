<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/5/4
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-table/1.14.2/bootstrap-table.js"></script>
</head>

<style>
    body {
        padding-top: 100px;
        padding-bottom: 40px;
    }
</style>
<body background="https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg">

<div class="container">

    <div>
        <h2>学生代码能力评价</h2>
    </div>
    <table class="table table-bordered table-hover table-striped" id="dataTable"></table>

    <div>
        <a href="${pageContext.request.contextPath}/codeAnalysis/show">
            <button type="button" class="btn btn-primary">返回</button>
        </a>
    </div>
</div>

<script>
    $('#dataTable').bootstrapTable({
        method : 'get',
        url : "${pageContext.request.contextPath}/codeAnalysis/getStudentsAbilityInfo",//请求路径
        striped : true, //是否显示行间隔色
        pageNumber : 1, //初始化加载第一页
        pagination : true,//是否分页
        sidePagination : 'client',
        pageSize : 10,//单页记录数
        pageList : [10, 20, 50],//可选择单页记录数
        showRefresh : false,//刷新按钮
        search : true,
        columns : [{
            title : '用户id',
            field : 'userId',
            sortable : true
        },{
            title : '用户能力',
            field : 'ability',
            sortable : true,
            formatter : formatAbility
        }]
    });

    function formatAbility(value, row, index) {
        return value === 1? "强":"弱";
    }
</script>
</body>
</html>
