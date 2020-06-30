<%--
  Created by IntelliJ IDEA.
  User: Li
  Date: 2020/1/4
  Time: 19:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/static/fj.ico" rel="shortcut icon" type="image/x-icon"/>
    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
        #myTable th {
            text-align: center;
        }
    </style>
</head>
<body>

<%--  一共分为四大块模板  --%>

<%--  头部title --%>
<div class="page-header row">
    <div class="col-md-4">
        <h2>SSM- CRUD
            <small>for LiFanglu</small>
        </h2>
    </div>
</div>

<!--顶部的两个按钮-->
<div class="row">
    <div class="col-md-2 col-md-offset-10">
        <button id="myCreateButton" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
            新建
        </button>
        <button id="myDeletePageButton" type="button" class="btn btn-danger">删除</button>
    </div>

</div>

<!--员工显示列表-->
<div class="row">
    <div class="col-md-12">
        <table class="table table-hover" id="myTable"
               style="text-align: center">
            <thead>
            <tr>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>注册日期</th>
                <th>所属部门</th>
                <th>编辑</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<!--底部显示分页信息-->
<div class="row">
    <!--底部的左边显示内容页码信息-->
    <div class="col-md-4 col-md-offset-2" id="dataPage">
    </div>
    <!--右边显示分页信息-->
    <div class="col-md-4 col-md-offset-6" id="paging">
    </div>
</div>

<!-- 添加员工的模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <%--这里是模态框的内容--%>
                <form id="createForm" method="post">
                    <div class="form-group">
                        <label for="exampleInputName">姓名</label>
                        <input type="text" class="form-control" id="exampleInputName" name="empName">
                    </div>
                    <div class="radio">
                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio1" value="1" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio2" value="0"> 女
                        </label>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputAge">年龄</label>
                        <input type="text" class="form-control" name="empAge" id="exampleInputAge">
                    </div>

                    <select class="form-control" id="deptSelect" name="dpId">

                    </select>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" id="mySubmit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<!--编辑员工的模态框-->
<div class="modal fade" id="myEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改员工</h4>
            </div>
            <div class="modal-body">
                <%--这里是模态框的内容--%>
                <form id="editForm" method="post" onsubmit="return false" action="##">
                    <div class="form-group">
                        <input type="hidden" id="empId" name="empId">
                        <label for="exampleInputName">姓名</label>
                        <input type="text" class="form-control" id="exampleInputName" name="empName">
                    </div>
                    <div class="radio">
                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio1" value="1"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio2" value="0"> 女
                        </label>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputAge">年龄</label>
                        <input type="text" class="form-control" name="empAge" id="exampleInputAge">
                    </div>

                    <select class="form-control" id="editDeptSelect" name="dpId">

                    </select>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" id="editClose" data-dismiss="modal">关闭</button>
                        <button type="button" id="myEditSubmit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>


<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="${APP_PATH}/static/jquery.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">

    //首次加载的jQuery函数
    $(function () {
        //首次加载运行第一页员工信息
        eachEmp(1);

        //点击新建按钮弹窗模态框
        $("#myCreateButton").on("click", function () {
            addDeptOption("deptSelect");
        })

        //调用提交函数
        submitModel();

        //修改
        editSubmitModel();

        //这个是编辑操作
        $("#myTable").on("click", ".editButton", function () {
            $.ajax({
                url: "${APP_PATH}/getEmp",
                data: "id=" + this.id,
                method: "POST",
                success: function (data) {
                    showEditData(data);
                }
            })
        })

        deletPage();

        //删除操作
        $("#myTable").on("click", ".deleteButton", function () {
            $.ajax({
                url: "${APP_PATH}/delEmp",
                data: "id=" + this.id,
                method: "POST",
                success: function (data) {
                    alert("删除成功！");
                    eachEmp($("#dataPage>span:eq(2)").html());
                }
            })
        })

    })

    //编辑模态框显示内容
    function showEditData(data) {
        var emp = data.content.empReturned;
        $("#editForm input[name=\"empId\"]").val(emp.empId);
        $("#editForm input[name=\"empName\"]").val(emp.empName);
        var gender = emp.empGender;
        if (gender == 0) {
            $("#editForm input[id=\"inlineRadio2\"]").attr("checked", "checked");
        } else {
            $("#editForm input[id=\"inlineRadio1\"]").attr("checked", "checked");
        }
        $("#editForm input[name=\"empAge\"]").val(emp.empAge);
        $("#editDeptSelect").empty();
        addDeptOption("editDeptSelect")
        $("#editForm option[value=" + emp.dpId + "]").attr("selected", "selected");
    }

    //删除一页的函数
    function deletPage() {
        $("#myDeletePageButton").on("click", function () {
            $.ajax({
                url: "${APP_PATH}/delPageEmp",
                data: "delPage=" + $("#dataPage>span:eq(2)").html(),
                method: "POST",
                success: function (data) {
                    alert(data.content.delReturned);
                    eachEmp($("#dataPage>span:eq(2)").html());
                }
            })
        })
    }

    //遍历某一页的员工
    function eachEmp(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            method: "GET",
            success: function (data) {
                build_emps_table(data);
                dataPageAdd(data);
                paging(data);
            }
        })
    }

    <!--修改员工提交函数-->
    function editSubmitModel() {
        $("#myEditSubmit").on("click", function () {
            $.ajax({
                url: "${APP_PATH}/editEmp",
                method: "POST",
                data:$("#editForm").serialize(),
                success: function (data) {
                    $("#editClose").click();
                    eachEmp($("#dataPage>span:eq(2)").html());
                }
            })

            <%--$("#editForm").attr("action", "${APP_PATH}/editEmp").submit();--%>
        })
    }

    <!--添加员工提交函数-->
    function submitModel() {
        $("#mySubmit").on("click", function () {
            $("#createForm").attr("action", "${APP_PATH}/addemp").submit();
        })
    }

    <!--添加员工模态框里的部门信息填充，供用户选择添加-->
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

    <!--遍历数据添加到表格-->
    function build_emps_table(data) {
        $("#myTable tbody").empty();
        var result = data.content.pageInfo.list;
        $.each(result, function (index, item) {
            var empId = item.empId;
            var empName = $("<td></td>").append(item.empName);
            var empGender = $("<td></td>").append(item.empGender == 0 ? "女" : "男");
            var empAge = $("<td></td>").append(item.empAge);
            var empDate = $("<td></td>").append(dateFormat(new Date(item.empDateonboard)));
            var empDeptName = $("<td></td>").append(item.department.deptName);
            var btn = $("<td></td>").append("<button type=\"button\" id=\"" + empId + "\" class=\"btn btn-info editButton\"  data-toggle=\"modal\" data-target=\"#myEditModal\">" +
                "<span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>编辑</button>")
                .append(" <button type=\"button\" id=\"" + empId + "\" class=\"btn btn-danger deleteButton\">" +
                    "<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>删除</button>");

            $("<tbody></tbody>")
                .append(empName)
                .append(empGender)
                .append(empAge)
                .append(empDate)
                .append(empDeptName)
                .append(btn)
                .appendTo("#myTable");
        })
    }

    <!--添加分页信息的函数-->
    function dataPageAdd(data) {
        $("#dataPage").empty();
        $("#dataPage").append("当前一共:<span class=\"label label-default\">" + data.content.pageInfo.total + "</span>条数据&nbsp;&nbsp;" +
            "一共:<span class=\"label label-default\">" + data.content.pageInfo.pages + "</span>页&nbsp;&nbsp;" +
            "当前第:<span class=\"label label-default\">" + data.content.pageInfo.pageNum + "</span>页");
    }

    <!--分页按钮函数-->
    function paging(data) {
        $("#paging").empty();
        var navLable = $("<nav aria-label=\"Page navigation\"></nav>");

        var ulLable = $("<ul class=\"pagination\"></ul>");

        if (data.content.pageInfo.hasPreviousPage) {
            var homePage = $("<li></li>").append("<a >首页</a>").appendTo(ulLable);

            var previousPage = $("<li></li>").append($("<a aria-label=\"Previous\"></a>").append("<span aria-hidden=\"true\">&laquo;</span>")).appendTo(ulLable);

            homePage.click(function () {
                eachEmp(1);
            })

            previousPage.click(function () {
                eachEmp(data.content.pageInfo.prePage);
            })
        }


        $.each(data.content.pageInfo.navigatepageNums, function (index, num) {
            if (data.content.pageInfo.pageNum == num) {
                $("<li class=\"active\"></li>").append("<a>" + num + "</a>").appendTo(ulLable).click(function () {
                    eachEmp(num);
                });

            }
            if (data.content.pageInfo.pageNum != num) {
                $("<li></li>").append("<a>" + num + "</a>").appendTo(ulLable).click(function () {
                    eachEmp(num);
                });
            }
        })
        if (data.content.pageInfo.hasNextPage) {
            var nextPage = $("<li></li>").append($("<a aria-label=\"Next\"></a>").append("<span aria-hidden=\"true\">&raquo;</span>")).appendTo(ulLable);
            var trailerPage = $("<li></li>").append("<a>尾页</a>").appendTo(ulLable);
            nextPage.click(function () {
                eachEmp(data.content.pageInfo.nextPage);
            })
            trailerPage.click(function () {
                eachEmp(data.content.pageInfo.pages);
            })
        }

        $(navLable).append(ulLable);

        $("#paging").append(navLable);

    }

    <!--日期格式化函数-->
    function dateFormat(time) {
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
        var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
        var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
    }

</script>

</body>
</html>