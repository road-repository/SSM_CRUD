<%--
  Created by IntelliJ IDEA.
  User: Li
  Date: 2020/6/30
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>老铁来注册啦！</title>
    <%
        /*定义项目路径，为以后引用静态资源备用*/
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/static/fj.ico" rel="shortcut icon" type="image/x-icon"/>
    <jsp:include page="config.jsp"></jsp:include>
    <script type="text/javascript" language="javascript" src="${APP_PATH}/static/js/check.js" charset="UTF-8"></script>
    <style>
        .red{
            color: red;
        }
        .container {
            margin-top: 10%;
            width: 40%;
            margin-left: 30%;
        }

        /* 需要在一行的元素 */
        .inline-style {
            display: inline-block;
        }

        /* 文字需要靠右 */
        .font-position-right {
            text-align: right;
        }

        /* 注册按钮 */
        .register-btn {
            margin-left: 10%;
        }


    </style>
    <script type="text/javascript">
        function addDeptOption(check) {

            $.ajax({
                url: "${APP_PATH}/depts",
                method: "GET",
                success: function (data) {
                    //成功之后调用添加select表单内容
                    var dept = data.content.depts;
                    $.each(dept, function (index, deptItem) {
                        var optionName = deptItem.deptName;
                        var option = $("<option></option>").attr("value", deptItem.deptId).append(optionName);
                        $("#" + check).append(option);
                    })
                }
            })


        }

        $(function () {
            addDeptOption("deptSelect");
        })
    </script>
</head>
<body>
<div class="container">
    <form class="form-horizontal" action="${APP_PATH}/regins" method="post">
        <div class="form-group">
            <%--            <h2 class="form-signin-heading">欢迎注册</h2>--%>
            <!-- class="sr-only"将label标签隐藏 -->
            <label for="userName"
                   class="col-sm-offset-2 col-sm-2 control-label inline-style font-position-right">用户名</label>
            <div class="col-sm-5 inline-style ">
                <input type="text" class="form-control" name="userName" id="userName" placeholder="用户名">
            </div>
            <div  class="red" id="DivAcn"></div>
        </div>
        <div class="form-group">
            <!--<h2 class="form-signin-heading">注册</h2>-->
            <label for="password"
                   class="col-sm-offset-2 col-sm-2 control-label  inline-style font-position-right">密&nbsp;&nbsp;&nbsp;码</label>
            <div class="col-sm-5 inline-style">
                <input type="password" class="form-control" name="userPassword" id="userPassword" placeholder="密码">
            </div>
            <div  class="red" id="DivPwd"></div>
        </div>
        <div class="form-group">
            <label for="email"
                   class="col-sm-offset-2 col-sm-2 control-label  inline-style font-position-right">邮&nbsp;&nbsp;&nbsp;箱</label>
            <div class="col-sm-5  inline-style">
                <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="邮箱">
            </div>
            <div  class="red" id="DivEmail"></div>
        </div>
        <div class="form-group">
            <label for="phone"
                   class=" col-sm-offset-2 col-sm-2 control-label   inline-style font-position-right">手&nbsp;&nbsp;&nbsp;机</label>
            <div class="col-sm-5  inline-style">
                <input type="tel" class="form-control" id="userPhone" name="userPhone" placeholder="手机">
            </div>
            <div  class="red" id="DivPhone"></div>
        </div>

        <div class="form-group">
            <label class=" col-sm-offset-2 col-sm-2 control-label  inline-style font-position-right">部&nbsp;&nbsp;&nbsp;门</label>
            <div class="col-sm-5  inline-style">
                <select class="form-control" id="deptSelect" name="deptId"></select>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-4 col-sm-4">
                <button class="btn btn-lg btn-primary btn-block register-btn" type="submit">注册</button>
            </div>
        </div>
    </form>

</div>

</body>
</html>
