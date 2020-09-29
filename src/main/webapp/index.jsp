<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<!-- 
	http://localhost:3306/crud
 -->
<!-- Bootstrap -->
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<!-- 表单 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="emp_name_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="emp_name_input" placeholder="emp_name"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@ssm.com"> <span
									class="help-block"></span>
							</div>
						</div>

						<!-- 性别 -->
						<div class="form-group">
							<label for="email_input" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_input" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_input" value="F"> 女
								</label>
							</div>
						</div>

						<!-- 部门 -->
						<div class="form-group">
							<label for="email_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-5">
								<select class="form-control" name="dId" id="dept_add_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>

		</div>
	</div>


	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工修改</h4>
				</div>
				<div class="modal-body">
					<!-- 表单 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="emp_name_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="emp_name_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="email_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@ssm.com"> <span
									class="help-block"></span>
							</div>
						</div>

						<!-- 性别 -->
						<div class="form-group">
							<label for="email_input" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>

						<!-- 部门 -->
						<div class="form-group">
							<label for="email_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-5">
								<select class="form-control" name="dId" id="dept_update_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>

		</div>
	</div>


	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-9">
				<button class="btn btn-success" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="emps_table">

					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页条 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>
	<script type="text/javascript">
		//总记录数,当前页
		var totalRecord,currentPage
		//1.页面加载完后，直接发送一个ajax请求，获取分页数据
		$(function() {
			//发送请求
			to_page(1)
		})

		//ajax方法
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH }/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					console.log(result)
					//1.解析并显示员工数据
					build_emps_table(result)
					//2.解析并显示分页信息和分页条
					build_page_info(result)
					build_page_nav(result)
				}
			})
		}

		//解析emp数据
		function build_emps_table(result) {
			//清空table表格
			$("#emps_table").empty()

			var emps = result.extendManagedMap.pageInfo.list

			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>") 
				var empIdTd = $("<td></td>").append(item.empId)
				var empNameTd = $("<td></td>").append(item.empName)
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女")
				var emailTd = $("<td></td>").append(item.email)
				var deptName = $("<td></td>").append(item.department.deptName)

				//添加按钮
				var editbtn = $("<button></button>").addClass(
						"btn btn-success btn-sm edit_btn").append(
						$("<span><span>")
								.addClass("glyphicon glyphicon-pencil"))
						.append("编辑")
				//为编辑按钮添加一个自定义属性，用于绑定对应的员工id
				editbtn.attr("edit-id",item.empId)

				var delbtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn")
						.append(
								$("<span><span>").addClass(
										"glyphicon glyphicon-trash")).append(
								"删除")
				//为刪除按钮添加一个自定义属性，用于绑定对应的员工id
				delbtn.attr("del-id",item.empId)


				var btnTd = $("<td></td>").append(editbtn).append(" ").append(
						delbtn)

				$("<tr></tr>").append(checkBoxTd)
						.append(empIdTd)
						.append(empNameTd)
						.append(genderTd)
						.append(emailTd).append(deptName)
						.append(btnTd)
						.appendTo("#emps_table")

			})
		}

		//解析分页信息
		function build_page_info(result) {
			$("#page_info").empty()
			$("#page_info").append(
					"当前第" + result.extendManagedMap.pageInfo.pageNum + "页, 总共"
							+ result.extendManagedMap.pageInfo.pages + "页, 总共"
							+ result.extendManagedMap.pageInfo.total + "条记录")
			totalRecord = result.extendManagedMap.pageInfo.total
			currentPage = result.extendManagedMap.pageInfo.pageNum

		}

		//解析分页条
		function build_page_nav(result) {
			$("#page_nav").empty()
			var ul = $("<ul></ul>").addClass("pagination")
			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"))
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"))

			if (result.extendManagedMap.pageInfo.hasPreviousPage == false) {
				prePageLi.addClass("disabled")
				firstPageLi.addClass("disabled")
			} else {
				//绑定事件
				firstPageLi.click(function() {
					to_page(1)
				})
				prePageLi.click(function() {
					to_page(result.extendManagedMap.pageInfo.pageNum - 1)
				})
			}

			//构造元素
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"))
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"))

			if (result.extendManagedMap.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled")
				lastPageLi.addClass("disabled")
			} else {
				//绑定事件
				nextPageLi.click(function() {
					to_page(result.extendManagedMap.pageInfo.pageNum + 1)
				})
				lastPageLi.click(function() {
					to_page(result.extendManagedMap.pageInfo.pages)
				})
			}

			//添加首页、前一页
			ul.append(firstPageLi).append(prePageLi)
			$.each(result.extendManagedMap.pageInfo.navigatepageNums, function(
					index, item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item))
				if (result.extendManagedMap.pageInfo.pageNum == item) {
					numLi.addClass("active")
				}
				numLi.click(function() {
					to_page(item)
				})
				ul.append(numLi)
			})
			//添加后一页、末页
			ul.append(nextPageLi).append(lastPageLi)

			var nav = $("<nav></nav>").append(ul)

			nav.appendTo("#page_nav")
		}

		//清空表单样式
		function reset_form(ele) {
			//重置表单内容
			$(ele)[0].reset()
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success")
			$(ele).find(".help-block").text("")
		}

		//新增按钮弹出模态框
		$("#emp_add_btn").click(function() {
			//重置表单
			reset_form("#empAddModal form")

			//查询部门信息
			getDepts("#dept_add_select")

			//绑定模态框
			$("#empAddModal").modal({
				backdrop : "static"
			})
		})

		//查询部门信息方法
		function getDepts(ele) {
			//清空之前下拉列表的值
			$(ele).empty();
			//发送请求
			$.ajax({
				url : "${APP_PATH }/depts",
				type : "GET",
				success : function(result) {
					$("#dept_add_select").append()
					$.each(result.extendManagedMap.depts,
							function(index, item) {
								var option = $("<option></option>").append(
										item.deptName).attr("value",
										item.deptId)
								$(ele).append(option)
							})
				}
			})
		}

		//校验方法
		function validate_add_form() {
			//获取数据
			var empName = $("#emp_name_input").val()
			//用户名正则表达式
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/
			if (!regName.test(empName)) {
				//用户名不合法
				show_validate("#emp_name_input", false,
						"用户名可以是2-5位中文或6-16位英文或数字")
				return false
			} else {
				show_validate("#emp_name_input", true, "")
			}
			//校验邮箱
			var email = $("#email_add_input").val()
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if (!regEmail.test(email)) {
				show_validate("#email_add_input", false, "邮箱格式不正确")

				return false
			} else {
				show_validate("#email_add_input", true, "")
				$("#email_add_input").parent().addClass("has-success")
				$("#email_add_input").next("span").text("")
			}
			return true
		}

		//根据信息校验结果展示提示信息
		function show_validate(ele, status, mag) {
			//清空当前元素的校验状态
			$(ele).parent().removeClass("has-success has-success")
			$(ele).next("span").text("")
			if (status) {
				//信息合法
				$(ele).parent().addClass("has-success")
				$(ele).next("span").text("")
			} else {
				//信息不合法
				$(ele).parent().addClass("has-error")
				$(ele).next("span").text(mag)
			}

		}

		//用户名校验方法
		$("#emp_name_input").change(
				function() {
					var empName = this.value
					//发送ajax请求校验用户名是否可用
					$.ajax({
						url : "${APP_PATH }/checkEmpName",
						type : "GET",
						data : "empName=" + empName,
						success : function(result) {
							if (result.code == 100) {
								show_validate("#emp_name_input", true, "用户名可用")
								$("#emp_save_btn").attr("ajax-val", "success")
							} else {
								show_validate("#emp_name_input", false,
										result.extendManagedMap.check_res)
								$("#emp_save_btn").attr("ajax-val", "error")
							}
						}
					})

				})

		//保存员工
		$("#emp_save_btn")
				.click(
						function() {
							//数据格式校验
							if (!validate_add_form()) {
								return false
							}
							//用户名校验
							if ($(this).attr("ajax-val") == "error") {
								return false
							}
							//1.发送ajax保存员工
							$
									.ajax({
										url : "${APP_PATH }/saveEmp",
										type : "POST",
										data : $("#empAddModal form")
												.serialize(),
										success : function(result) {
											//判断是否保存成功
											if (result.code == 100) {
												//关闭模态框
												$("#empAddModal").modal('hide')
												//2.跳转到最后一页
												to_page(totalRecord)
											} else {
												//显示失败信息
												//console.log(result)
												//有哪个字段的错误信息就显示那个字段
												if (undefined != result.extendManagedMap.errorField.email) {
													//显示邮箱错误信息
													show_validate(
															"#email_add_input",
															false,
															result.extendManagedMap.errorField.email)
												}
												if (undefined != result.extendManagedMap.errorField.empName) {
													//显示用户名错误信息
													show_validate(
															"#emp_name_input",
															false,
															result.extendManagedMap.errorField.empName)
												}
											}

										}

									})
						})

						
		//绑定编辑单击事件
		$(document).on("click", ".edit_btn", function() {
			//查出员工信息
			getEmp($(this).attr("edit-id"))
			//查询部门信息并显示
			getDepts("#empUpdateModal select")
			//向更新按钮传递员工id
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"))
			//打开模态框
			$("#empUpdateModal").modal({
				backdrop : "static"
			})
		})

		//获取单个员工信息
		function getEmp(id) {
			$.ajax({
				url:"${APP_PATH }/emp/"+id,
				type:"GET",
				success:function(result){
					var empData = result.extendManagedMap.emp
					$("#emp_name_static").text(empData.empName)
					$("#email_update_input").val(empData.email)
					$("#empUpdateModal input[name=gender]").val([empData.gender])
					$("#empUpdateModal select").val([empData.dId])
				}
			})
		}
		
		//绑定更新按钮的单击事件
		$("#emp_update_btn").click(function(){
			//验证邮箱信息的正确性
			var email = $("#email_update_input").val()
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if (!regEmail.test(email)) {
				show_validate("#email_update_input", false, "邮箱格式不正确")

				return false
			} else {
				show_validate("#email_update_input", true, "")
				$("#email_update_input").parent().addClass("has-success")
				$("#email_update_input").next("span").text("")
			}
			
			//发送ajax请求保存更新数据
			$.ajax({
				url:"${APP_PATH }/updateEmp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg)
					//关闭对话框
					$("#empUpdateModal").modal("hide")
					//回到总页面
					to_page(currentPage)
				}
			})
		})
		
		
		//绑定删除按钮的单机事件
		$(document).on("click", ".delete_btn", function(){
			//获取员工名字
			var empName = $(this).parents("tr").find("td:eq(2)").text()
			//是否确认删除对话框
			//alert($(this).parents("tr").find("td:eq(1)").text())
			if(confirm("确认删除【"+empName+"】吗？")){
				//确认，发送ajax
				$.ajax({
				url:"${APP_PATH }/deleteEmp/"+$(this).attr("del-id"),
				type:"DELETE",
				success:function(result){
					alert(result.msg)
					//回到本页
					to_page(currentPage)
				}
			})
			}
		})
		
		//全选功能
		$("#check_all").click(function(){
			//attr获取checked是undefined，原生属性用prop获取值，attr用于获取自定义属性的值
			//alert($(this).attr("checked"))
			//alert($(this).prop("checked"))
			$(".check_item").prop("checked",$(this).prop("checked"))
		})
		
		$(document).on("click", ".check_item", function(){
			//判断当前选择的元素是否选满
			var flag = $(".check_item:checked").length==$(".check_item").length
			$("#check_all").prop("checked",flag)
		})
		
		//绑定全部删除按钮单击事件
		$("#emp_delete_all_btn").click(function(){
			var empNames = ""
			var del_ids = ""
			$.each($(".check_item:checked"),function(){
				//用，组装字符穿
				empNames += $(this).parents("tr").find("td:eq(1)").text()+","
				//用-组装字符穿
				del_ids += $(this).parents("tr").find("td:eq(1)").text()+"-"
			})
			//去除多余的逗号
			empNames = empNames.substring(0,empNames.length-1)
			//去除多余的”-“
			del_ids = del_ids.substring(0,del_ids.length-1)
			
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH }/deleteEmp/"+del_ids,
					type:"DELETE",
					success:function(result){
						alert(result.msg)
						//回到当前页面
						to_page(currentPage)
					}
				})
			}
		})
	</script>
</body>
</html>