<%--
  Created by IntelliJ IDEA.
  User: Li
  Date: 2020/6/30
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
    <%
        /*定义项目路径，为以后引用静态资源备用*/
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <jsp:include page="config.jsp"></jsp:include>
</head>
<body>
<div class="container" style="background-image: url('${APP_PATH}/static/xq3.jpg')">
    <div class="row  col-lg-12" style="margin-top:240px">
        <form class="form-horizontal">
            <div class="form-group">
                <label for="userName" class="col-sm-2 control-label">UserName</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control " style="width: 400px" id="userName" placeholder="UserName">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">Password</label>
                <div class="col-sm-5">
                    <input type="password" class="form-control" style="width: 400px" id="password" placeholder="Password">
                </div>
            </div>
            <div class="form-group">
                <label for="code_input" class="col-sm-2 control-label">verify</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" style="width: 220px" id="code_input" placeholder="请输入验证码">
                </div>
                <div id="v_container" class="col-sm-2" style="width: 110px;height: 30px;"></div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox checkbox-inline">
                        <label>
                            <input type="checkbox"> 记住密码
                        </label>
                    </div>
                    <div class="checkbox  checkbox-inline">
                        <label>
                            <input type="checkbox"> 自动登录
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" id="my_button" class="btn btn-default">Sign in</button>
                </div>
            </div>

        </form>
    </div>
</div>
</body>
<script>
    var verifyCode = new GVerify("v_container");
    document.getElementById("my_button").onclick = function(){
        var res = verifyCode.validate(document.getElementById("code_input").value);
        if(!res){
            alert("验证码错误!");
            return false;
        }
    }
</script>
</html>