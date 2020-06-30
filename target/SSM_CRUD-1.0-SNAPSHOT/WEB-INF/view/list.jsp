<%--
  Created by IntelliJ IDEA.
  User: Li
  Date: 2019/12/24
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%--  一共分为四大块模板  --%>

<%--  头部title  --%>
<div class="page-header row">
    <div class="col-md-4">
        <h2>SSM- CRUD
            <small>for Fanglu Li</small>
        </h2>
    </div>
</div>

<div class="row">
    <div class="col-md-2 col-md-offset-10">
        <button type="button" class="btn btn-primary">新建</button>
        <button type="button" class="btn btn-danger">删除</button>
    </div>

</div>

<div class="row">
    <div class="col-md-12">
        <table class="table table-hover">
            <tr>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>注册日期</th>
                <th>所属部门</th>
                <th>编辑</th>
            </tr>
            <c:forEach items="${pageInfo.list}" var="emp">
                <tr>
                    <td>${emp.empName}</td>
                    <td>${emp.empGender==0?'男':'女'}</td>
                    <td>${emp.empAge}</td>
                    <td>${emp.empDateonboard}</td>
                    <td>${emp.department.deptName}</td>
                    <td>
                        <button type="button" class="btn btn-info">修改</button>
                        <button type="button" class="btn btn-danger">删除</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<div class="row">
    <div class="col-md-4 col-md-offset-2">
        一共有:<span class="label label-default">${pageInfo.total}</span>条数据
        &nbsp;&nbsp;
        总页数:<span class="label label-default">${pageInfo.pages}</span>页&nbsp;&nbsp;
        当前页数:第<span class="label label-default">${pageInfo.pageNum}</span>页

    </div>

    <div class="col-md-4 col-md-offset-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                <li>
                    <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum<2?1:pageInfo.pageNum-1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                    <c:if test="${pageInfo.pageNum==num}">
                        <li class="active"><a href="${APP_PATH}/emps?pn=${num}">${num}</a></li>
                    </c:if>
                    <c:if test="${pageInfo.pageNum!=num}">
                        <li><a href="${APP_PATH}/emps?pn=${num}">${num}</a></li>
                    </c:if>
                </c:forEach>
                <li>
                    <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum<pageInfo.pages?pageNum+1:pageInfo.pages}"
                       aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a></li>
            </ul>
        </nav>
    </div>
</div>


<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="${APP_PATH}/static/jquery.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
