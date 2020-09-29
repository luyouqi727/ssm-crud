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
				<button class="btn btn-success">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName}</th>
							<th>${emp.gender=="M"?"女":"男"}</th>
							<th>${emp.email}</th>
							<th>${emp.department.deptName}</th>
							<th>
								<button class="btn btn-success btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
		<!-- 分页条 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6">当前第${pageInfo.pageNum }页,
				总共${pageInfo.pages }页, 总共${pageInfo.total }条记录</div>
			<!-- 分页条 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">

						<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						<!-- 上一页 -->
						<c:if test="${pageInfo.hasPreviousPage }">
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum -1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:if test="${!pageInfo.hasPreviousPage }">
							<li class="disabled"><a href="#"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>


						<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
							<c:if test="${page_num == pageInfo.pageNum }">
								<li class="active"><a href="#">${page_num}</a></li>
							</c:if>
							<c:if test="${page_num != pageInfo.pageNum }">
								<li><a href="${APP_PATH }/emps?pn=${page_num}">${page_num}</a></li>
							</c:if>

						</c:forEach>
						
						<!-- 下一页 -->
						<c:if test="${pageInfo.hasNextPage }">
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum +1}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						</c:if>
						<c:if test="${!pageInfo.hasNextPage }">
							<li class="disabled"><a href="#" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						</c:if>
						
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>