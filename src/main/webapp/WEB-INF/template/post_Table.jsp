<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>BlueLemon</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="css/admin_Styles.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
                        <li class="breadcrumb-item"><a href="admin_Index">Dashboard</a></li>
                        <li class="breadcrumb-item active">Tables</li>
                    </ol>                        
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
							게시글 리스트
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Post_Content</th>
                                        <th>Hash_Tag</th>
                                        <th>Post_Seq</th>
                                        <th>Post_Date</th>
                                        <th>Like_Count</th>
                                        <th>Reply_Count</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${postList}" var="postVO" varStatus="status" begin="0" end="${postListSize}">
                                     <tr>
                                         <td>${postVO.member_Id}</td>
                                         <td><a href="post_Detail?post_Seq=${postVO.post_Seq}">${postVO.post_Content}</a></td>
                                         <td>
                                          <c:choose>
                                          	<c:when test="${empty hashMap[postVO.post_Seq]}">
                                           	등록된 해쉬태그가 없습니다.
										</c:when>
										<c:otherwise>
											<c:forEach var="hash" items="${hashMap[postVO.post_Seq]}">
                                              		#${hash.tag_Content}&nbsp;&nbsp;
											</c:forEach>
										</c:otherwise>
									</c:choose>
                                            </td>
                                         <td>${postVO.post_Seq}</td>
                                         <td>${postVO.post_Date}</td>
                                         <td>${postVO.post_Like_Count}</td>
                                         <td>${postVO.post_Reply_Count}</td>
                                     </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">Copyright &copy; Your Website 2023</div>
                        <div>
                            <a href="#">Privacy Policy</a>
                            &middot;
                            <a href="#">Terms &amp; Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>
    <!-- modal Js -->
  	<script src="js/modal.js"></script>
</body>
</html>
