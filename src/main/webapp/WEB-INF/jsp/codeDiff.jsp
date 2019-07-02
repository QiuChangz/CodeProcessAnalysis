<%--
  Created by IntelliJ IDEA.
  User: QiuSama
  Date: 2019/4/24
  Time: 23:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<HTML>

<HEAD>
    <meta charset="UTF-8">
    <TITLE>代码对比情况展示</TITLE>
    <!-- <SCRIPT TYPE="text/javascript" LANGUAGE="JavaScript" SRC="diff_match_patch.js"></SCRIPT> -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.32.0/codemirror.min.js"></script>
    <link rel="stylesheet" media="all" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.32.0/codemirror.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.32.0/addon/search/searchcursor.min.js"></script>
    <script src="../mergely/lib/mergely.js" type="text/javascript"></script>
    <link rel="stylesheet" media="all" href="../mergely/lib/mergely.css" />

    <%
        String code1 = (String) request.getAttribute("code1");
        String code2 = (String) request.getAttribute("code2");
        int percent = request.getAttribute("percent") == null ? 0: (int)request.getAttribute("percent");
    %>
</HEAD>

<BODY>
<div>
    <p id="percent" hidden><%=percent%></p>
    <h2>代码对比情况</h2>
    <div class="mergely-full-screen-8">
        <div class="mergely-resizer">
            <div id="mergely"></div>
        </div>
    </div>
    <textarea readonly id="code1" hidden>
        <%=code1%>
    </textarea>

    <textarea readonly id="code2" hidden>
        <%=code2%>
    </textarea>

    <p id="time1" hidden>${time1}</p>
    <p id="time2" hidden>${time2}</p>
</div>
<script>
    $(document).ready(function() {
        // initialize mergely
        options = { line_numbers: true, editor_height: "400px", autoresize: false, lcs: true }
        $('#mergely').mergely('options', options);

    });

    function func(){
        $('#mergely').mergely({
            line_numbers: true,
            lhs: function(setValue) {
                setValue($('#code1'));
            },
            rhs: function(setValue) {
                setValue($('#code2'));
            }
        });
    }

    function func2(info1, info2){
        $('#mergely').mergely({
            line_numbers: true,
            lhs: function(setValue) {
                setValue(info1);
            },
            rhs: function(setValue) {
                setValue(info2);
            }
        });
    }
    $('#mergely').mergely({
        line_numbers: true,
        lhs: function(setValue) {
            setValue($('#code1').text());
        },
        rhs: function(setValue) {
            setValue($('#code2').text());
        }
    });
</script>
</BODY>

</html>
