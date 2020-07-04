<%--
  Created by IntelliJ IDEA.
  User: Li
  Date: 2020/7/1
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        /*定义项目路径，为以后引用静态资源备用*/
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <style type="text/css">
        *{
            margin:0px;
            padding:0px;
        }
        .top{
            width: 100%;
            height: 14.5%;
            background-color: blue;
        }
        .containter{
        }

        .left{
            display: inline;
        }
        #container iframe{
            overflow: hidden;
        }

        .right{
            display: inline;
            overflow: hidden;
        }
        iframe{
            height: 75%;
        }
        .bottom{
            background-color: #9d9d9d;
            width: 100%;
            height: 10%;
        }
    </style>
</head>
<body>
    <div class="top">

    </div>
    <div class="containter">
         <div class="left">
            <iframe style="width: 13%;overflow: hidden" src="http://localhost:8080/${APP_PATH}/menu" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
         </div>
         <div class="right">
             <iframe style="width: 85%;overflow: hidden"src="http://localhost:8080/${APP_PATH}/list" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no"  ></iframe>
         </div>
    </div>
    <div class="bottom">

    </div>
</body>
</html>
