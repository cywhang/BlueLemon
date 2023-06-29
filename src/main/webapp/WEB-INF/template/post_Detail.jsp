<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>BlueLemon</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/admin_Styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
 <style>
.postDetailTable {
	border-collapse: collapse;
	margin-left : 20%
}

.postDetailTable th,
.postDetailTable td {
	border: 1px solid black;
	padding: 8px;
	text-align : center;
}

.postDetailTable th {
	background-color: #f2f2f2;
}
		
    </style>
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="admin_Index">BlueLemon</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
					   <div class="sb-sidenav-menu-heading">Core</div>
					   <a class="nav-link" href="admin_Index">
						  <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
					      Dashboard
					   </a>
                       <a class="nav-link" href="index">
                          <div class="sb-nav-link-icon"><i class="fas fa-laptop"></i></div>
                          FEED
                       </a>                        
					   <div class="sb-sidenav-menu-heading">Interface</div>
					   <a class="nav-link" href="member_Table">
					      <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
					      Member Table
					   </a> 
					   <a class="nav-link" href="post_Table">
					      <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
					      Post Table
					   </a>
					   <a class="nav-link" href="qna_Table">
					      <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
					      Q&A Table
					   </a>
                       <a class = "nav-link" href = "logout">
                          <div class = "sb-nav-link-icon"><i class = "fas fa-power-off"></i></div>
                          LogOut
                       </a>
					</div>
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
			<div class="container-fluid px-4">
				<h1 class="mt-4">Post Table</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">Tables</li>
				</ol>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table me-1"></i> 게시글 상세조회
						Post DetailTable
					</div>
					<div class="card-body">
						<table id="datatablesSimple">
								<table class="postDetailTable" style="text-align:center;">
								<tr>
									<tr>
										 <th colspan="5">게시글</th>
									</tr>
										<tr>
										    <th style="width: 20%">게시글 번호</th>
										    <th style="width: 20%">아이디</th>
										    <th style="width: 25%">작성일</th>
										    <th style="width: 15%">좋아요</th>
										    <th style="width: 20%">게시글 사진 번호</th>
										</tr>
										<tr>
									        <td>${post.post_Seq}</td>
											<td>${post.member_Id}</td>
        									<td>${post.post_Date}</td>
									        <td>${post.post_Like_Count}</td>
									        <td>${post.post_Image_Count}</td>
										</tr>
										<tr>
										    <th>게시글 내용</th>
										    <td colspan = "5">${post.post_Content}</td>
										</tr>
										<tr>
										<th colspan="5">게시글 사진</th>
										</tr>
									      <!-- 이미지를 출력할 공간 -->
									      <c:choose>
										      <c:when test="${post.post_Image_Count eq 0}">		
										      </c:when>
										      <c:otherwise>			
										      	<tr>					      
												  <td colspan="5">
											         <c:forEach begin="1" end="${post.post_Image_Count}" var="i">																			
												    		<div class="image-container">
											          			<img src="img/uploads/post/${post.post_Seq}-${i}.png" alt="...">											          
												    		</div>
											      </c:forEach>	
												  		</td>
												</tr>	
										      </c:otherwise>									      
									      </c:choose>
									<%-- 댓글 --%>
									<tr>
									    <th colspan="5">댓글</th>
									</tr>
									    <c:choose>
									    	<c:when test="${empty reply}">
										    <tr style="display: none;"></tr>
										
									    	</c:when>
									    	<c:otherwise>
									    	<tr>
									        <th colspan="1">아이디</th>
									        <th colspan="2">댓글 내용</th>
									        <th colspan="1">작성일</th>
									        <th colspan="1">좋아요</th>
									    	</tr>
									    	<c:forEach items="${reply}" var="reply">
										    <tr>
									        <td colspan="1">${reply.member_Id}</td>
									        <td colspan="2">${reply.reply_Content}</td>
        									<td colspan="1">${reply.reply_Date}</td>
									        <td colspan="1">${reply.reply_Like_Count}</td>
									    	</tr>
									    	</c:forEach>
									    	</c:otherwise>
									    </c:choose>
									<%-- 해시태그 --%>
									<tr>
									    <th colspan="5">해시태그</th>
									</tr>
									  <c:choose>
									    	<c:when test="${empty hash}">
									    		<tr style="display: none;"></tr>
									    	</c:when>
										    <c:otherwise>
											    <tr>
											    	<th>게시글 번호</th>
											    	<th>해시태그 번호</th>
											        <th colspan = "3">해시태그 내용</th>
										    	</tr>
											    <c:forEach items="${hash}" var="hash">
										        <tr>
											    	<td>${hash.post_Seq}</td>
											    	<td>${hash.tag_Seq}</td>
											        <td colspan = "3">${hash.tag_Content}</td>
									    		</tr>
										</c:forEach>
									   </c:otherwise>
									 </c:choose>
								</table>
								<div style="text-align: right; margin-right: 1px;">
								    <a href="deletePost?post_Seq=${post.post_Seq}" class="btn btn-primary">delete</a>
								    <a href="post_Table" class="btn btn-primary">List</a>
								</div>
						</table>
					</div>
				</div>
			</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2023</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script src="js/datatables-simple-demo.js"></script>
	<!-- modal Js -->
	<script src="js/modal.js"></script>
</body>
</html>
