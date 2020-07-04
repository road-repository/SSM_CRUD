<%--
  Created by IntelliJ IDEA.
  User: Li
  Date: 2020/7/1
  Time: 15:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>菜单</title>
    <%
        /*定义项目路径，为以后引用静态资源备用*/
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <link rel="stylesheet" href="${APP_PATH}/static/css/menu.css">
    <jsp:include page="config.jsp"></jsp:include>
    <script type="text/javascript">
        $(function () {
            //导航切换
            $(".menuson li").click(function () {
                $(".menuson li.active").removeClass("active")
                $(this).addClass("active");
            });

            $('.title').click(function () {
                var $ul = $(this).next('ul');
                $('dd').find('ul').slideUp();
                if ($ul.is(':visible')) {
                    $(this).next('ul').slideUp();
                } else {
                    $(this).next('ul').slideDown();
                }
            });
        })
    </script>
</head>
<body>
<div class="left_top">
    <span></span> 用户信息管理系统
</div>
<dl class="left_menu">
    <dd>
        <div class="title">
            <span><img src="main/img/leftico03.png"></span>用户信息管理
        </div>
        <ul class="menuson">
            <li><cite></cite><a href="findUserByPageServlet" target="rightFrame">用户信息列表</a><i></i></li>
            <li><cite></cite><a href="regist.jsp" target="rightFrame">添加用户</a><i></i></li>
        </ul>
    </dd>
</dl>
</body>
</html>

