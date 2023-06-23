<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Tables - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/admin_Styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <style>
	    .qnaDetailTable {
			border-collapse: collapse;
			margin-left : 20%
		}
		
		.qnaDetailTable th,
		.qnaDetailTable td {
			border: 1px solid black;
			padding: 8px;
		}
		
		.qnaDetailTable th {
			text-align: left;
			background-color: #f2f2f2;
		}
		
    </style>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="admin_Index.html">Blue Lemon</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
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
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
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
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Q&A Table</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="admin_Index.html">Dashboard</a></li>
                            <li class="breadcrumb-item active">Tables</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Q&A DataTable
                            </div>
                            <div class="card-body">
                                <table class = "qnaDetailTable">
                                    <tr>
                                        <th style = "width : 10%">Sequence</th>
                                        <td style = "width : 10%">${qnaDetail.qna_Seq}</td>
                                        <th style = "width : 10%">ID</th>
                                        <td style = "width : 20%">${qnaDetail.member_Id}</td>
                                        <th style = "width : 10%">Date</th>
                                        <td style = "width : 40%">${qnaDetail.qna_Date}</td>
                                    </tr>    
                                    <tr>
                                        <th colspan = "2">Title</th>
                                        <td colspan = "4">${qnaDetail.qna_Title}</td>
                                    </tr>
                                    <tr>
                                        <th colspan = "2">Message</th>
                                        <td colspan = "4">${qnaDetail.qna_Message}"</td>
                                    </tr>
                                    <tr>
                                    <c:choose>
                                    	<c:when test="${qnaDetail.qna_Done eq 1}">
                                    		<th colspan = "2">Answer</th>
	                                    	<td colspan = "4">
	                                    		<form id = "qna_Answer" action = "qna_Answer" method = "POST">
	                                    			<input type = "text" name = "qna_Answer">
	                                    			<input type = "hidden" name = "qna_Seq" value = "${qnaDetail.qna_Seq}">
	                                    			<button type = "submit">Send</button>
	                                    		</form>
	                                    	</td>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<th colspan = "2">Answer</th>
	                                    	<td colspan = "4">${qnaDetail.qna_Answer}</td>
                                    	</c:otherwise>
                                    </c:choose>
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
    </body>
</html>
