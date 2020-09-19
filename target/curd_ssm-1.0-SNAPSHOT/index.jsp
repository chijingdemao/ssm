<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>员工列表</title>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 编辑员工模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">UpdateEmployee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                Male
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> Female
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">Update changes</button>
            </div>
        </div>
    </div>
</div>

<!-- 新增员工模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">ADDEmployee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@shayz.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">
                                Male
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> Female
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <!--部门-->
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save changes</button>
            </div>
        </div>
    </div>
</div>


<!--搭配显示页面-->
<div class="container">
    <!--标题行-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table table-striped table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"/></th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="table_body">

                </tbody>
            </table>
        </div>

    </div>
    <!--显示分页信息-->
    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord, currentPage,empId;//全局保存总记录数

    //1.在页面加载完成之后，直接发送ajax请求，要到分页数据

    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result)
            }
        });
    }

    /**
     * 解析显示员工信息
     * */
    function build_emps_table(result){

        $("#emps_table tbody").empty();
        //查看json格式，取出员工的信息
        var emps = result.extend.pageInfo.list;

        var html="";
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'></input></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为编辑按钮添加自定义属性，来表示当时按钮的Id
            editBtn.attr("edit-id", item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加自定义属性
            delBtn.attr("del-id", item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }



    /**
     * 解析显示分页信息
     */
    function build_page_info(result) {
        $("#page_info_area").empty();

        $("#page_info_area").append("当前"
            + result.extend.pageInfo.pageNum
            + "第页,总"
            + result.extend.pageInfo.pages
            + "页,总共"
            + result.extend.pageInfo.total
            + "有条记录")

        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }


    /**
     * 解析显示分页条
     */
    function build_page_nav(result) {
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>")
            .append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>")
            .append($("<a></a>").append("&laquo;"));
        if (!result.extend.pageInfo.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }


        var nextPageLi = $("<li></li>")
            .append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>")
            .append($("<a></a>").append("尾页").attr("href", "#"));
        if (!result.extend.pageInfo.hasNextPage) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        } else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>")
                .append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item)
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        $("#page_nav_area").append(navEle);
    }


    /**
     * 表单重置
     */
    function reset_form(ele) {
        //重置内容
        $(ele)[0].reset();
        //重置表单样式
        $(ele).find("*").removeClass("has-error has_success");
        $(ele).find(".help-block").text("");
    }


    //为新增按钮绑定事件,弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //发送ajax请求，查出部门信息，显示在下拉列表中

        //重置表单  内容+样式
        //$("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");

        //查出部门信息
        getDepts("#dept_add_select");

        $("#empAddModal").modal({
            backdrop: "static"
        });
    });


    //查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();

        $.ajax({
            url: "depts",
            type: "GET",
            success: function (result) {
               //console.log(result);

               <!--填充到下拉列表    attr：是option的属性-->
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }


    /**
     * 校验数据
     */
    function validate_add_form(){
        //1.拿到要校验的数据，使用正则表达式进行验证
        var empName = $("#empName_add_input").val();
        //支持中文
        var regName = /(^[A-Za-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)){
            //alert("名字必须是2-5个中文或者3-16位英文数字组合");
            //应该清空之前元素的样式
            show_validate_msg("#empName_add_input", "error",
                "名字必须是2-5个中文或者6-16位英文数字组合");
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("名字必须是2-5个中文或者3-16位英文数字组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input", "success", "格式正确");
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("格式正确");
        }

        //2.校验邮箱的信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式输入错误");
            show_validate_msg("#email_add_input", "error",
                "邮箱格式输入错误");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式输入错误");
            return false;
        }else {
            show_validate_msg("#email_add_input", "success", "格式正确");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("格式正确");
        }
        return true;
    }

    /**
     * 格式验证样式抽取
     */
    function  show_validate_msg(ele, status, msg){
        //清楚当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if ("success" == status) {
            $(ele).parent().addClass("has-success");
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
        }
        $(ele).next("span").text(msg);
    }

    $("#empName_add_input").change(function () {
        var empName = this.value;
        //发送ajax请求，校验用户名是否可用
        $.ajax({
            url: "checkuser",
            type: "POST",
            data: "empName=" + empName,
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    //在按钮上自定义属性，用来判断如果校验失败，是不能保存信息的
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    })

    /**
     * 新增模态框中保存按钮点击事件
     */
    $("#emp_save_btn").click(function () {
        //1.先对提交到服务器的数据进行校验
        if(!validate_add_form()){
            return false;
        }
        //3.判断之前ajax用户名是否成功。
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        //2.模态窗口填写的数据提交到服务器
        $.ajax({
            url: "emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),//serialize()这个方法就可以获取表单中填写的数据
            success: function (result) {
                //alert(result.msg);
                if (result.code == 100) {
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');

                    //2.来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据
                    to_page(totalRecord);
                }else {
                    //显示失败信息
                    //console.log(result);
                    if (undefined != result.extend.errorFields.email) {
                        //未发生错误的称为undefined
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });


    /**
     * 编辑按钮点击事件
     *
     * 1.我们是按钮创建之前就绑定了click,所以绑定不上
     * 解决办法：live(),但是jquery新版本替换掉了，换成on
     *
     * 在整个文档中，选中按钮进行On事件绑定
     */
    $(document).on("click", ".edit_btn", function () {
        //alert("edit");
        //0.查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //1.查出部门信息，并显示部门列表
        getDepts("#dept_update_select");
        //3.把员工的Id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

        //2.弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });



    function getEmp(id) {
        $.ajax({
            url: "emp/" + id,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //{"code":100,"msg":"处理成功!","extend":{"emp":{"empId":1,"empName":"jimin","gender":"M","email":"jimin@163.com","dId":1,"department":null}}}
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#dept_update_select").val([empData.dId]);
            }
        });
    }


    /**
     * 编辑模态框更新按钮点击事件
     */
    $("#emp_update_btn").click(function () {
        //1.验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式输入错误");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        //2.发送ajax请求，保存更新   当前对象属性“edit-id”的值
        $.ajax({
            url : "emp/" + $(this).attr("edit-id"),
            type : "PUT",
            data : $("#empUpdateModal form").serialize(),
            success : function(result) {
                if (result.code == 100) {
                    $("#empUpdateModal").modal("hide");
                    to_page(currentPage);
                } else {
                    alert("更新失败");
                }
            }
        });
    });


    /**
     * 删除按钮点击事件
     */
    $(document).on("click", ".delete_btn", function () {
        //1.弹出确定删除对话框
        //找名字
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");

        if(confirm("确认删除["+empName+"]吗?")){
            $.ajax({
                url:"emp/" + empId,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });


    /**
     * 全选checkbox
     */
    $("#check_all").click(function () {
        //prop获取dom原生属性，attr获取自定义属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    })
    $(document).on("click",".check_item",function(){
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });


    /**
     * 删除全部按钮点击事件
     */
    $("#emp_delete_all_btn").click(function(){
        var empNames = "";
        //员工id字符串
        var del_idstr = "";
        //遍历每一个被选中的元素
        $.each($(".check_item:checked"),function(){
            //this代表的是当前Item
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除empNames最后一个，
        empNames = empNames.substring(0,empNames.length-1);
        //去除del_idstr最后一个，
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除["+empNames+"]吗?")){
            $.ajax({
                url:"emp/" + del_idstr,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

</script>
</body>
</html>
