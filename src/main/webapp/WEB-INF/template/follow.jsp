<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html lang="en">
<!-- Follow Js -->
      <script src="js/follow.js"></script>
   <head>
      <!-- 필수 메타 태그 -->
      <meta charset="utf-8">
      <!-- 데스크톱, 태블릿, 모바일 등 화면 크기를 자동으로 조절해주는 곳 -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- 파비콘의 이미지를 지정하는 곳 -->
      <link rel="icon" type="image/png" href="img/logo2.png">
      <title>BlueLemon</title>
      <!-- description : 웹 페이지의 내용을 간략하게 설명하는 역할(검색 엔진 최적화, 웹 페이지의 구조화 와 관리) -->
      <meta name="description" content="BlueLemon">
      <!-- keywords 메타 태그를 선언하는 이유는 검색 엔진 최적화와 웹 사이트의 구조화와 관리를 위한 참고 자료를 제공하기 위해서 이다. -->
      <meta name="keywords" content="bootstrap5, e-learning, forum, games, online course, Social Community, social events, social feed, social media, social media template, social network html, social sharing, twitter">
      
      <!-- 부트스트랩 css -->
      <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <!-- Slich Slider -->
      <link href="vendor/slick/slick/slick.css" rel="stylesheet">
      <link href="vendor/slick/slick/slick-theme.css" rel="stylesheet">
      <!-- Icofont -->
      <link href="vendor/icofont/icofont.min.css" rel="stylesheet">
      <!-- Font Icons -->
      <link href="vendor/icons/css/materialdesignicons.min.css" rel="stylesheet" type="text/css">
      <!-- 수정해 볼수있는 css들 (index, slidebar 등등) -->
      <link href="css/style.css" rel="stylesheet">
      <!-- 아이콘 css -->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
   </head>
   
   
   
   <!-- body부분의 class : light모드, dark모드 버튼 -->
   <body class="bg-light">
   	  <!-- 페이지 우측 하단에 고정되어있는 테마 변경 스위치  -->
      <div class="theme-switch-wrapper ms-3">
         <label class="theme-switch" for="checkbox">
            <input type="checkbox" id="checkbox">
            <span class="slider round"></span>
            <i class="icofont-ui-brightness"></i>
         </label>
         <em>Enable Dark Mode!</em>
      </div>
      
      <!-- 브라우저 창의 크기가 줄어들때 오른쪽 위에 출력되는 메뉴펼치기 버튼 -->
      <div class="web-none d-flex align-items-center px-3 pt-3">
         <a href="index" class="text-decoration-none">
         <img src="img/logo.png" class="img-fluid logo-mobile" alt="brand-logo">
         </a>
         <button class="ms-auto btn btn-primary ln-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
         <span class="material-icons">menu</span>
         </button>
      </div>
      
      <!-- index페이지의 구성 요소들 -->
      <div class="py-4">
         <!-- 반응형 컨테이너 div -->
         <div class="container">
         	<!-- row : 열(col)을 포함하는 행(row)를 생상하는데 사용되는 css프레임워크 클래스 -->
         	<!-- position-relative : 요소들의 위치를 상대적으로 설정 -->
            <div class="row position-relative">
               <!-- Main Content -->
               <!-- index페이지의 센터 column -->
               <main class="col col-xl-6 order-xl-2 col-lg-12 order-lg-1 col-md-12 col-sm-12 col-12">
               	  <!-- 메인 컨테이너 요소들을 감싸고있는 div -->
                  <div class="main-content">
                  	 <!-- 피드, 피플, 트랜딩 버튼 -->
                     <ul class="top-osahan-nav-tab nav nav-pills justify-content-center nav-justified mb-4 shadow-sm rounded-4 overflow-hidden bg-white sticky-sidebar2" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                           <button class="p-3 nav-link text-muted active" id="pills-feed-tab" data-bs-toggle="pill" data-bs-target="#pills-feed" type="button" role="tab" aria-controls="pills-feed" aria-selected="true">Following</button>
                        </li>
                        <li class="nav-item" role="presentation">
                           <button class="p-3 nav-link text-muted" id="pills-people-tab" data-bs-toggle="pill" data-bs-target="#pills-people" type="button" role="tab" aria-controls="pills-people" aria-selected="false">Follower</button>
                        </li>
                     </ul>
                     
                     <!-- Following 버튼 클릭시 출력부분 -->
                     <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-feed" role="tabpanel" aria-labelledby="pills-feed-tab">
                        <h6 class="mb-3 fw-bold text-body">Your Following</h6>
                           <div class="bg-white rounded-4 overflow-hidden mb-4 shadow-sm">
                           
                              <!-- Account Item -->
                              
                              
                              <c:forEach items="${following}" var="memberVO" begin="0" end="9">
                              <a href="profile?member_Id=${memberVO.member_Id}" class="p-3 d-flex text-dark text-decoration-none account-item pf-item">
                                 <img src="img/uploads/profile/${memberVO.member_Profile_Image}" class="img-fluid rounded-circle me-3" alt="profile-img">
                                 <div>
                                    <p class="fw-bold mb-0 pe-3 d-flex align-items-center">${memberVO.member_Id} </p>
                                    <div>
                                       <p class="text-muted fw-light mb-1 small">${memberVO.member_Name}</p>
                                       <span class="d-flex align-items-center small">${memberVO.member_Mbti}/${memberVO.member_Gender}/${memberVO.member_Email}</span>
                                    </div>
                                 </div>
                                 <div class="ms-auto">
                                    <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                       		<input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck${memberVO.member_Id}" checked>
                                       	<label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck${memberVO.member_Id}" onclick = "changeFollow('${memberVO.member_Id}')"><span class="following d-none">Following</span><span class="follow">+ Follow</span></label>
	                                </div>
                                 </div>
                              </a>
                              </c:forEach>
                              <div id="followingContainer"></div>
                              </div>
                              
                              <div id="followingloadButton">
		                         	<c:choose>
			                         	<c:when test="${followingTotalPageNum<2}">
			                         		
			                         	</c:when>
			                         	<c:otherwise>
							                <div class="ms-auto" align="center">
		                                    	<span class="btn btn-outline-primary btn-sm px-3 rounded-pill" id="followingload" onclick="followingload(${followingTotalPageNum}, ${followingPageNum})">+ 더보기</span>
		                                	</div>
			                         	</c:otherwise>
		                         </c:choose>
		                         </div>
                              </div>
                         
                         
                         
                         
                       	 
                        
                          
                        <!-- Follower 탭 클릭시 -->
                        <div class="tab-pane fade" id="pills-people" role="tabpanel" aria-labelledby="pills-people-tab">
                           <h6 class="mb-3 fw-bold text-body">Your Follower</h6>
                           <div class="bg-white rounded-4 overflow-hidden mb-4 shadow-sm">
                           	<div>
                              <!-- Account Item -->
                              <c:forEach items="${follower}" var="memberVO" begin="0" end="9">
                              <a href="profile?member_Id=${memberVO.member_Id}"  class="p-3 d-flex text-dark text-decoration-none account-item pf-item">
                                 <img src="img/uploads/profile/${memberVO.member_Profile_Image}" class="img-fluid rounded-circle me-3" alt="profile-img">
                                 <div>
                                    <p class="fw-bold mb-0 pe-3 d-flex align-items-center">${memberVO.member_Id}</p>
                                    <div>
                                       <p class="text-muted fw-light mb-1 small">${memberVO.member_Name}</p>
                                       <span class="d-flex align-items-center small">${memberVO.member_Mbti}/${memberVO.member_Gender}/${memberVO.member_Email}</span>
                                    </div>
                                 </div>
                                 <div class="ms-auto" id="followerBtnContainer">
                                    <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                    
										<c:if test="${memberVO.bothFollow eq 1}">
										  <!-- 숫자 1과 동일한 경우에 실행될 내용 -->
										  <input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck2${memberVO.member_Id}" checked="checked">
										</c:if>
										<c:if test="${memberVO.bothFollow ne 1}">
										  <!-- 숫자 1과 다른 경우에 실행될 내용 -->
										  <input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck2${memberVO.member_Id}">
										</c:if>
										
                                       <label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck2${memberVO.member_Id}" onclick = "changeFollow('${memberVO.member_Id}')"><span class="following d-none">Following</span><span class="follow">+ Follow</span></label>
	                                </div>
                                 </div>
                              </a>
                              </c:forEach>
                              </div>
                              <div id="followerContainer"></div>
                           </div>
                          
                           		<div id="followerloadButton">
                              	<c:choose>
		                         	<c:when test="${followerTotalPageNum<2}">
		                         		
		                         	</c:when>
		                         	<c:otherwise>
			                         	<div class="ms-auto" align="center">
	                                    	<span class="btn btn-outline-primary btn-sm px-3 rounded-pill" id="followerload" onclick="followerload(${followerTotalPageNum}, ${followerPageNum})">+ 더보기</span>
	                                	</div>
		                         	</c:otherwise>
		                         </c:choose>	
		                         </div>
		                         
                        <!-- trending탭 클릭시 -->
                        <div class="tab-pane fade" id="pills-trending" role="tabpanel" aria-labelledby="pills-trending-tab">
                           <!-- 트랜딩 탭의 Feeds -->
                           <div class="feeds">
                        </div><!-- class="trending" -->
                     </div> <!-- class="feed" -->
                  </div><!-- class="main container" -->
                  
               </main> <!-- index페이지의 센터 column -->
               
               <!-- index페이지 왼쪽 사이드바 column -->
               <aside class="col col-xl-3 order-xl-1 col-lg-6 order-lg-2 col-md-6 col-sm-6 col-12">
                  <div class="p-2 bg-light offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample">
                     <div class="sidebar-nav mb-3">
                        <!-- 좌측 상단의 홈페이지 로고 -->
                        <div class="pb-4">
                           <a href="index" class="text-decoration-none">
                           <img src="img/logo.png" class="img-fluid logo" alt="brand-logo">
                           </a>
                        </div>
                        <!-- 사이드바의 항목들을 정의하는 부분 -->
                        <ul class="navbar-nav justify-content-end flex-grow-1">
                           <li class="nav-item">
                              <a href="index" class="nav-link"><span class="material-icons me-3">house</span> <span>Feed</span></a>
                           </li>
                           <li class="nav-item">
                              <a href = "profile?member_Id=${sessionScope.loginUser.member_Id}" class="nav-link"><img src = "img/uploads/profile/${loginUser.member_Profile_Image}" style = "width : 27px; height : 27px; border-radius : 50%; overfloiw : hidden;"> <span>&nbsp;&nbsp;&nbsp;${loginUser.member_Id}'s PROFILE</span></a>
                           </li>
                           <li class="nav-item">
                              <a href="follow?member_Id=${loginUser.member_Id}" class="nav-link active"><span class="material-icons me-3">diversity_3</span> <span>follow</span></a>
                           </li>
                           <!-- PAGES 드롭다운 항목 -->
                           <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                              <span class="material-icons me-3">web</span> Contact Us
                              </a>
                              <ul class="dropdown-menu px-2 py-1 mb-2">
                                 <li><a class="dropdown-item rounded-3 px-2 py-1 my-1" href="contact">Contact</a></li>
                                 <li><a class="dropdown-item rounded-3 px-2 py-1 my-1" href="faq">FAQ</a></li>
                              </ul>
                           </li>
                           
                           <li class="nav-item">
                              <a href="logout" class="nav-link"><span class="material-icons me-3">logout</span> <span>Logout</span></a>
                           </li>
                           <!-- 
                           <li class="nav-item">
                              <a href="tags" class="nav-link"><span class="material-icons me-3">local_fire_department</span> <span>Trending</span></a>
                           </li>
                            -->
                        </ul>
                     </div>
                  </div>
                  
                  <!-- Sidebar -->
                  <!-- 브라우저 창의 크기가 줄어들때 나오는 메뉴버튼을 누르면 왼쪽에서 나타나는 사이드바 -->
                  <div class="ps-0 m-none fix-sidebar">
                     <div class="sidebar-nav mb-3">
                        <div class="pb-4 mb-4">
                           <a href="index" class="text-decoration-none">
                           <img src="img/logo.png" class="img-fluid logo" alt="brand-logo">
                           </a>
                        </div>
                        <ul class="navbar-nav justify-content-end flex-grow-1">
                           <li class="nav-item">
                              <a href="index" class="nav-link"><span class="material-icons me-3">house</span> <span>Feed</span></a>
                           </li>
                           <li class="nav-item">
                              <a href = "profile?member_Id=${sessionScope.loginUser.member_Id}" class="nav-link"><img src = "img/uploads/profile/${loginUser.member_Profile_Image}" style = "width : 27px; height : 27px; border-radius : 50%; overfloiw : hidden;"> <span>&nbsp;&nbsp;&nbsp;${loginUser.member_Id}'s PROFILE</span></a>
                           </li>
                           <li class="nav-item">
                              <a href="follow?member_Id=${loginUser.member_Id}" class="nav-link active"><span class="material-icons me-3">diversity_3</span> <span>follow</span></a>
                           </li>
                           <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                              <span class="material-icons me-3">web</span> Contact Us
                              </a>
                              <ul class="dropdown-menu px-2 py-1 mb-2">
                                 <li><a class="dropdown-item rounded-3 px-2 py-1 my-1" href="contact">Contact</a></li>
                                 <li><a class="dropdown-item rounded-3 px-2 py-1 my-1" href="faq">FAQ</a></li>
                                 <!-- <li><a class="dropdown-item rounded-3 px-2 py-1 my-1" href="404">404 Error</a></li>  -->
                              </ul>
                           </li>
                           
                           <li class="nav-item">
                              <a href="logout" class="nav-link"><span class="material-icons me-3">logout</span> <span>Logout</span></a>
                           </li>
                           <!-- 
                           <li class="nav-item">
                              <a href="tags" class="nav-link"><span class="material-icons me-3">local_fire_department</span> <span>Trending</span></a>
                           </li>
                            -->
                        </ul>
                     </div>
                  </div>
                  
               </aside>
               
               
               <!-- index페이지 오른쪽 사이드바 column -->
               <aside class="col col-xl-3 order-xl-3 col-lg-6 order-lg-3 col-md-6 col-sm-6 col-12">
                  <div class="fix-sidebar">
                     <div class="side-trend lg-none">
                        <!-- Search Tab -->
                        <div class="input-group mb-4 shadow-sm rounded-4 overflow-hidden py-2 bg-white">
                           <span class="input-group-text material-icons border-0 bg-white text-primary">search</span>
                           <form action="/blue/search_HashTag" method="get">
                           		<input type="text" class="form-control border-0 fw-light ps-1" placeholder="Search People" id="keyword" name="tag_Content" onkeyup="searchMembers()">
                           </form>
                        </div>
                        <!-- 검색 결과 리스트 -->
                        <div id="searchResults"></div>
                           <div class="bg-white rounded-4 overflow-hidden shadow-sm mb-4">
                              <!-- 실시간 인기 급상승 게시글 -->
                              <h6 class="fw-bold text-body p-3 mb-0 border-bottom">Hottest Feed</h6>
                              <!-- 트랜딩 아이템 -->
                              <!-- 표시할 최대 문자 수 -->
                              <c:set var = "maxChar" value = "50"/>                              
                              <c:forEach items="${hottestFeed}" var="postVO" begin="0" end="4">
                         	     <div class="p-3 border-bottom d-flex">
								    <div>
									   <div class="text-muted fw-light d-flex align-items-center">
									      <small class="text-muted">
										     ${postVO.member_Id}
									      </small>
									   </div>
									   <c:choose>
									      <c:when test = "${postVO.post_Image_Count == 0}">
										     <small class="text-muted">
											    <c:out value = "${fn:substring(postVO.post_Content, 0, maxChar)}"/>
									         </small>
											 <p class="fw-bold mb-0 pe-3 text-dark">${postVO.post_Hashtag}</p>
										  	 <small class="text-muted">
											    ${postVO.post_Like_Count}'s Like
										     </small>							
									      </c:when>
										  <c:otherwise>
									         <a id="openModalBtn" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal" onclick="modalseq(${postVO.post_Seq})">
											    <img src="img/uploads/post/${postVO.post_Seq}-1.png" class="img-fluid rounded-4 ms-auto" width = "120" height = "120">
											    <br>
											  	<small class="text-muted">
											       <c:out value = "${fn:substring(postVO.post_Content, 0, maxChar)}"/>
											    </small>
												<p class="fw-bold mb-0 pe-3 text-dark">${postVO.post_Hashtag}</p>
										  		<small class="text-muted">
												   ${postVO.post_Like_Count}'s Like
											    </small>		
									         </a>					
									      </c:otherwise>
									   </c:choose>	
									   <br>	
								    </div>
						         </div>
							  </c:forEach>
                           </div>
                        </div>
                     </div>
                  </div>
               </aside>
            </div> <!-- class="row position-relative" -->
         </div> <!-- class="container" -->
      </div> <!-- class="py-4" --> 
      
      <!-- left footer -->
      <!-- 좌측 하단 부분 -->
      <div class="py-3 bg-white footer-copyright">
         <div class="container">
            <div class="row align-items-center">
               <div class="col-md-8">
                  <span class="me-3 small">©2023 <b class="text-primary">BlueLemon</b>. All rights reserved</span>
               </div>
               <div class="col-md-4 text-end">
                  <a target="_blank" href="#" class="btn social-btn btn-sm text-decoration-none"><i class="icofont-facebook"></i></a>
                  <a target="_blank" href="#" class="btn social-btn btn-sm text-decoration-none"><i class="icofont-twitter"></i></a>
                  <a target="_blank" href="#" class="btn social-btn btn-sm text-decoration-none"><i class="icofont-linkedin"></i></a>
                  <a target="_blank" href="#" class="btn social-btn btn-sm text-decoration-none"><i class="icofont-youtube-play"></i></a>
                  <a target="_blank" href="#" class="btn social-btn btn-sm text-decoration-none"><i class="icofont-instagram"></i></a>
               </div>
            </div>
         </div>
      </div>

     <!-- 이 아래부터는 모달창에 관한 코드 -->
      <!-- Post Modal -->
      <!-- 글 작성 모달창 -->
      <div class="modal fade" id="postModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 p-4 border-0 bg-light">
               <div class="modal-header d-flex align-items-center justify-content-start border-0 p-0 mb-3">
                  <!-- 뒤로가기 버튼 -->
                  <a href="#" class="text-muted text-decoration-none material-icons" data-bs-dismiss="modal">arrow_back_ios_new</a>
                  <!-- 기본 사람모양 아이콘 -->
                  <h5 class="modal-title text-muted ms-3 ln-0" id="staticBackdropLabel"><span class="material-icons md-32">account_circle</span></h5>
                  <!-- 작성자 아이디 표시 -->
                  <h5 class="modal-title text-muted ms-3 ln-0" id="staticBackdropLabel">작성자: ${sessionScope.loginUser.member_Id}</h5>
               </div>
               
               <!-- 게시글 작성 폼 -->
               <form action="insertPost" method="POST" enctype="multipart/form-data">
               <div class="modal-body p-0 mb-3">
               	  <!-- 입력 부분 -->
               	  <!-- 작성자 아이디 -->
               	  <input type="hidden" name="member_Id" value="${sessionScope.loginUser.member_Id}">
               	  <!-- 공개 여부 체크박스 -->
                  <label for="post_Public" class="h6 text-muted mb-0">게시글 공개 여부</label>
                  <input type="checkbox" name="post_Public" value="y" checked="checked">
               	  <!-- 게시글 내용 작성창 -->
                  <div class="form-floating">
                     <textarea class="form-control rounded-5 border-0 shadow-sm" name="post_Content" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 200px"></textarea>
                     <label for="floatingTextarea2" class="h6 text-muted mb-0">게시글 내용</label>
                  </div>
                  <!-- 해시태그 입력창 -->
                  <div class="form-floating">
                     <input type="text" name="post_Hashtag" class="form-control rounded-5 border-0 shadow-sm" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 50px"></input>
                     <label for="floatingTextarea2" class="h6 text-muted mb-0">해시 태그</label>
                  </div>
                  <div class="d-flex justify-content-between">
                	 <button type="reset" class="btn btn-secondary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center">
  				 	 	<span class="material-icons me-2 md-16">refresh</span>초기화
					 </button>
                  	 <button type="submit" data-bs-dismiss="modal" class="btn btn-primary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center"><span class="material-icons me-2 md-16">send</span>Post</button>
                  </div>
               </div>
               <!-- 이미지 업로드 부분 -->
               <div class="uploaderContainer">
			       <label class="uploaderLabel" id="uploaderLabel" for="uploaderInput">
			      		<div class="uploaderInner" id="inner">드래그하거나 클릭해서 업로드</div>
			       </label>
				   <input id="uploaderInput" class="input" name="uploadImgs" accept="image/png" type="file" multiple="multiple" hidden="true" max="4">
			       <div class="preview" id="preview"></div>
		       </div>
		  	   </form>
            </div>
         </div>
      </div>
      
      <!-- 게시글 상세보기 모달창 1 -->
      <!-- 이미지 슬라이드, 댓글 리스트 모달창 -->
      <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 overflow-hidden border-0">
               <div class="modal-header d-none">
                  <h5 class="modal-title" id="exampleModalLabel2">Modal title</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body p-0">
                  <div class="row m-0">
                  	 <!-- 모달창의 왼쪽 컬럼 -->
                     <div class="col-sm-7 px-0 m-sm-none">
                        <!-- 게시글의 이미지슬라이드 -->
                        <div class="image-slider" width = "100%">
                           <div id="carouselExampleIndicators" class="carousel slide" c="carousel">
                           	  <!-- 이미지 슬라이드 하단의 인덱스 버튼 -->
                              <div class="carousel-indicators">
                              </div>
                              <!-- 게시글의 이미지 출력부분 -->
                              <div class="carousel-inner">
                              </div>
                              <!-- 전, 후  이미지 이동 버튼 -->
                              <div class="arrow-button">
	                          </div>
                           </div>
                        </div> <!-- 이미지 슬라이드 -->
                     </div>
                     
                     <!-- 모달창의 오른쪽 컬럼 -->
                     <div class="col-sm-5 content-body px-web-0">
                        <div class="d-flex flex-column h-600">
                           <!-- 게시글 작성자 정보 -->
                           <div class="d-flex p-3 border-bottom">
                           	  <!-- 게시글 작성자 프로필이미지 -->
                              <div id="profileImgContainer"></div>
                              <div class="d-flex align-items-center justify-content-between w-100">
                                 <a href="profile" class="text-decoration-none ms-3">
                                    <div class="d-flex align-items-center">
                                       <!-- 작성자 아이디 -->
                                       <div id="writerContainer"></div>
                                       <!-- 인증마크(파란색 체크 아이콘) -->
                                       <p class="ms-2 material-icons bg-primary p-0 md-16 fw-bold text-white rounded-circle ov-icon mb-0">done</p>
                                    </div>
                                    <!-- 작성자 아이디(@아이디) -->
                                    <div id="smallWriterContainer"></div>
                                 </a>
                                 <!-- 모달창 닫기 버튼 (x모양 아이콘) -->
                                 <div class="small dropdown">
                                    <a href="#" class="text-muted text-decoration-none material-icons ms-2 md-" data-bs-dismiss="modal">close</a>
                                    <!-- 임시  -->
                                 </div>
                              </div>
                           </div>
                           
                           <!-- 댓글들 리스트 div -->
                           <!-- id는 스크롤을 하기 위해서 지정해줌 -->
                           <div class="comments p-3" id="replyList">
	                           <div id="replyListContainer">
		                       </div>
                           </div>
						                                          
                           <!-- 모달창 우측 하단의 좋아요 수,댓글 수, 댓글입력창, post버튼 -->
                           <div class="border-top p-3 mt-auto">
                              <div class="d-flex align-items-center justify-content-between mb-2">
                                 <!-- 좋아요 버튼 이미지, 좋아요 카운트를 출력해줌 -->
                              	 <div class="like-group" role="group">
	                                 <div id = "likeImage">
	                                 </div>
                                 </div>
                                 <!-- 해당 게시글의 총 댓글 수 표시 -->
                                 <div>
                                    <div class="text-muted text-decoration-none d-flex align-items-start fw-light"><span class="material-icons md-20 me-2">chat_bubble_outline</span><div id="replyContainer"></div></div>
                                 </div>
                              </div>
                              
                              <div class="d-flex align-items-center">
                                 <span class="material-icons bg-white border-0 text-primary pe-2 md-36">account_circle</span>
                                 <div class="d-flex align-items-center border rounded-4 px-3 py-1 w-100">
                                    <input type="text" id="inputContent" class="form-control form-control-sm p-0 rounded-3 fw-light border-0" placeholder="Write Your comment">
                                    <div id="postButton">
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div> 
                  </div>
               </div>
               <div class="modal-footer d-none"></div>
            </div>
         </div>
      </div>
      
      <!-- 게시글 상세보기 모달창 2 -->
      <!-- 댓글 리스트 모달창 -->
      <div class="modal fade" id="commentModal2" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 overflow-hidden border-0">
               <div class="modal-header d-none">
                  <h5 class="modal-title" id="exampleModalLabel2">Modal title</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body p-0">
                 <div class="d-flex flex-column h-600">
                    <!-- 게시글 작성자 정보 -->
                    <div class="d-flex p-3 border-bottom">
                    	  <!-- 게시글 작성자 프로필이미지 -->
                       <div id="profileImgContainer2" style="width: 15%; height: auto;"></div>
                       <div class="d-flex align-items-center justify-content-between w-100">
                          <a href="profile" class="text-decoration-none ms-3">
                             <div class="d-flex align-items-center">
                                <!-- 작성자 아이디 -->
                                <div id="writerContainer2"></div>
                                <!-- 인증마크(파란색 체크 아이콘) -->
                                <p class="ms-2 material-icons bg-primary p-0 md-16 fw-bold text-white rounded-circle ov-icon mb-0">done</p>
                             </div>
                             <!-- 작성자 아이디(@아이디) -->
                             <div id="smallWriterContainer2"></div>
                          </a>
                          <!-- 모달창 닫기 버튼 (x모양 아이콘) -->
                          <div class="small dropdown">
                             <a href="#" class="text-muted text-decoration-none material-icons ms-2 md-" data-bs-dismiss="modal">close</a>
                             <!-- 임시  -->
                          </div>
                       </div>
                    </div>
                    
                    <!-- 댓글들 리스트 div -->
                    <!-- id는 스크롤을 하기 위해서 지정해줌 -->
                    <div class="comments p-3" id="replyList">
	                    <div id="replyListContainer2">
	                  	</div>
                    </div>
                    
                    
                    <!-- 모달창 우측 하단의 좋아요 수,댓글 수, 댓글입력창, post버튼 -->
                    <div class="border-top p-3 mt-auto">
                       <div class="d-flex align-items-center justify-content-between mb-2">
                         <!-- 좋아요 버튼 이미지, 좋아요 카운트를 출력해줌 -->
                       	  <div class="like-group" role="group">
	                          <div id = "likeImage2">
	                          </div>
                          </div>
                          <div class="text-muted text-decoration-none d-flex align-items-start fw-light"><span class="material-icons md-20 me-2">chat_bubble_outline</span><div id="replyContainer2"></div></div>
                       </div>
                       <div class="d-flex align-items-center">
                          <span class="material-icons bg-white border-0 text-primary pe-2 md-36">account_circle</span>
                          <div class="d-flex align-items-center border rounded-4 px-3 py-1 w-100">
                             <input type="text" id="inputContent2" class="form-control form-control-sm p-0 rounded-3 fw-light border-0" placeholder="Write Your comment">
                             <div id="postButton2">
                             </div>
                          </div>
                       </div>
                    </div>
                    
                 </div>
               </div>
               <div class="modal-footer d-none"></div>
               
            </div>
         </div>
      </div>
      <!-- Jquery Js -->
      <script src="vendor/jquery/jquery.min.js"></script>
      <!-- Bootstrap Bundle Js -->
      <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
      <!-- Custom Js -->
      <script src="js/custom.js"></script>
      <!-- Slick Js -->
      <script src="vendor/slick/slick/slick.min.js"></script>
      <!-- Follow Js -->
      <script src="js/follow.js"></script>
      <!-- Like Js -->
      <script src="js/like.js"></script>
      <!-- Modal Js -->
      <script src="js/modal.js"></script>
      <!-- People Js -->
      <script src="js/people.js"></script>      
      <!-- infinite Js -->
      <script src="js/infinite.js"></script>
      <!-- Search Peple Js -->
      <script src="js/searchpeople.js"></script>
   </body>
</html>