<%--
  Created by IntelliJ IDEA.
  User: Li
  Date: 2020/6/30
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>老铁来注册啦！</title>
    <jsp:include page="config.jsp"></jsp:include>
    <style>

        .container{
            margin-top:10%;
            width: 40%;
            margin-left: 30%;
        }

        /* 需要在一行的元素 */
        .inline-style {
            display: inline-block;
        }
        /* 文字需要靠右 */
        .font-position-right{
            text-align: right;
        }
        /* 注册按钮 */
        .register-btn{
            margin-left: 10%;
        }


    </style>
</head>
<body>
<div class="container">

    <form class="form-horizontal">
        <div class="form-group">
            <!--<h2 class="form-signin-heading">注册</h2>-->
            <!-- class="sr-only"将label标签隐藏 -->
            <label for="exampleInputUsername1"
                   class="col-sm-offset-2 col-sm-2 control-label inline-style font-position-right">用户名</label>
            <div class="col-sm-5 inline-style ">
                <input type="text" class="form-control" id="exampleInputUsername1" placeholder="用户名">
            </div>
        </div>
        <div class="form-group">
            <!--<h2 class="form-signin-heading">注册</h2>-->
            <label for="exampleInputUsername1"
                   class="col-sm-offset-2 col-sm-2 control-label  inline-style font-position-right">密码</label>
            <div class="col-sm-5 inline-style">
                <input type="password" class="form-control" id="exampleInputPassword1" placeholder="密码">
            </div>
        </div>
        <div class="form-group">
            <label for="exampleInputUsername1"
                   class="col-sm-offset-2 col-sm-2 control-label  inline-style font-position-right">邮箱</label>
            <div class="col-sm-5  inline-style">
                <input type="email" class="form-control" id="exampleInputEmail1" placeholder="邮箱">
            </div>
            <div class="form-group">
            </div>
        </div>
        <div class="form-group">
            <label for="exampleInputUsername1"
                   class=" col-sm-offset-2 col-sm-2 control-label   inline-style font-position-right">手机</label>
            <div class="col-sm-5  inline-style">
                <input type="tel" class="form-control" id="exampleInputPhone1" placeholder="手机">
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
