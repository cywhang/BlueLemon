<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="UTF-8">
   <head>
      <!-- 필수 메타 태그 -->
      <meta charset="utf-8">
      <!-- 데스크톱, 태블릿, 모바일 등 화면 크기를 자동으로 조절해주는 곳 -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- 파비콘의 이미지를 지정하는 곳 -->
      <link rel="icon" type="image/png" href="img/logo2.png">
      <title>BlueLemon</title>
      <!-- description : 웹 페이지의 내용을 간략하게 설명하는 역할(검색 엔진 최적화, 웹 페이지의 구조화 와 관리) -->
      <meta name="description" content="Vogel - Social Network & Community HTML Template">
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
      <!-- 파일 업로드 -->
	  <script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>    
	  <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">
   </head>
 <style>
	.error-message {
		color: red;
	}
	
	.success-message {
		color: green;
	
	/* 파일 선택 버튼 옆의 파일 이름 숨김 */
	input[type="file"] {
	    width: 0.1px;
	    height: 0.1px;
	    opacity: 0;
	    overflow: hidden;
	    position: absolute;
	    z-index: -1;
	}
	input[type="file"] + label {
	    font-size: 1.25em;
	    font-weight: 700;
	    color: white;
	    background-color: #4CAF50;
	    display: inline-block;
	    padding: 8px 12px;
	    cursor: pointer;
	    border-radius: 4px;
	}
	
	input[type="file"] + label:hover {
	    background-color: #45a049;
	}
	
	input[type="file"] + label:active {
	    background-color: #3e8e41;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="js/editprofile.js"></script>
<script>
	// 프로필 사진 미리보기 함수	
	function previewProfileImage(event) {
		var reader = new FileReader();
		reader.onload = function() {
			var output = document.getElementById('profile_image_preview');
			output.src = reader.result;
		};
		reader.readAsDataURL(event.target.files[0]);
		// 이미지 파일 이름은 출력하지 않음
		var fileName = event.target.files[0].name;
		document.getElementById('photo_file_name').textContent = "";
	}
	var msg = "${msg}";
	if (msg === "wrong") {
		alert("잘못된 비밀번호입니다.\n 다시 시도해주세요.")
	} else if (msg === "withdrawlSuccess") {
		alert("BLUE LEMON 탈퇴가 완료되었습니다.\n 그동안 이용해주셔서 감사합니다.")
	}
	
</script>	  

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
             <form id="update_form" method="post" action="update_form" enctype="multipart/form-data">
               	  <div class="main-content">
	                 <div class="mb-5">
	                    <header class="profile d-flex align-items-center">
	                       <img alt="#" src="img/uploads/profile/${loginUser.member_Profile_Image}" class="rounded-circle me-3">
	                       <div>
	                          <span class="text-muted text_short">Hello, ${loginUser.member_Id}</span>
	                          <h4 class="mb-0 text-dark"><span class="fw-bold">EDIT PROFILE PAGE</span></h4>
	                       </div>
	                    </header>
	                 </div>
	                 <div class="feeds">
	                    <div class="bg-white p-4 feed-item rounded-4 shadow-sm mb-3 faq-page">
	                       <div class="mb-3">
	                          <h5 class="lead fw-bold text-body mb-0">Edit Profile</h5>
	                       </div>
	                       <div class="row justify-content-center">
	                          <div class="col-lg-12">
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="text" class="form-control rounded-5" id="member_Id" name="member_Id" value="${loginUser.member_Id}" readonly>
                                    <label for="floatingssName">ID</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="password" class="form-control rounded-5" id="member_Password" 
                                    name="member_Password" value="${loginUser.member_Password}">
                                    <span id="password_message" class="error-message"></span>
                                    <label for="floatingssName">PASSWORD</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="password" name="repassowrd" class="form-control rounded-5" id="repassword" 
                                    placeholder="#" value="${loginUser.member_Password}">
                                    <span id="confirm_password_message" class="error-message"></span>
                                    <label for="floatingssName">REPASSWORD</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="text" class="form-control rounded-5" id="member_Name" name="member_Name"
                                    value="${loginUser.member_Name}" readonly>
                                    <span id="name_error_message" class="error-message"></span>
                                    <label for="floatingssName">NAME</label>
                                 </div>                                 
                                 <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="text" class="form-control rounded-5" name="member_Email" id="member_Email" 
                                    value="${member_Email}">@
                                    <input type="text" class="form-control rounded-5" name="email_add" id="email_add"
                                    value="${email_add}">
                                    <span id="email_error_message" class="error-message"></span>
                                    <label for="floatingEmail">EMAIL</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="text" class="form-control rounded-5" name="member_Phone" id="member_Phone"  value="${loginUser.member_Phone}">
                                    <span id="phone_error_message" class="error-message"></span>
                                    <label for="floatingEmail">PHONE</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="text" class="form-control rounded-5" id="member_Birthday" name="member_Birthday" value="${loginUser.member_Birthday}" readonly>
                                    <label for="floatingBirth">DATE OF BIRTH</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-center">
	                                <input type="text" name="member_Country" class="form-control rounded-5" name="member_Country" id="member_Country" value="${loginUser.member_Country}">
	                                <label for="floatingBirth">Country</label>
	                             </div>
	                             <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="text" name="member_Mbti" class="form-control rounded-5" name="member_Mbti" id="member_Mbti" value="${loginUser.member_Mbti}">
                                    <label for="floatingBirth">MBTI</label>
                                 </div>
	                          </div>
	                          <div>
							     <label>Profile</label>
								 <input type="file" name="profile_Image" accept=".png" id="member_Profile_Image" onchange="previewProfileImage(event)">
								 <img id="profile_image_preview" src="#" alt="" style="max-width: 200px; max-height: 200px; border-radius: 50%; overflow: hidden;">
							     <p id="photo_file_name"></p>
						      </div>
	                       </div>
	                    </div>
	                    <div class="d-grid">
	                       <button class="btn btn-primary rounded-5 w-100 text-decoration-none py-3 fw-bold text-uppercase m-0" onclick ="go_update()">SAVE</button>
	                    </div>
	                 </div>
               	  </div>
               </form>
			   <div class="mb-5"></div>                     
               <!-- 회원 탈퇴 폼 -->
		       <div class="bg-white p-4 feed-item rounded-4 shadow-sm faq-page mb-3" width = "150">
		          <div class="mb-3">
		             <h5 class="lead fw-bold text-body mb-0">Withdrawal (BlueLemon 탈퇴)</h5>
				     <p class="mb-0">To initiate the withdrawal, please enter your password</p>
			      </div>
			      <div class="row justify-content-center">
		             <div class="col-lg-12">
				        <form action="memberDelete" method="post">
				           <div class="form-floating mb-3 d-flex align-items-center">
				              <input type="password" class="form-control rounded-5" name="member_Password" id="check_Password" placeholder="비밀번호">
				              <span id="password_error_message" class="error-message"></span>
				              <label for="floatingPass">PASSWORD</label>
				           </div>
				           <button class="btn btn-primary w-100 text-decoration-none rounded-5 py-3 fw-bold text-uppercase m-0">Withdrawal</button>
				        </form>					               
				     </div>
			      </div>
		       </div>
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
                              <a href="index" class="nav-link active"><span class="material-icons me-3">house</span> <span>Feed</span></a>
                           </li>
                           <li class="nav-item">
                              <a href = "profile?member_Id=${sessionScope.loginUser.member_Id}" class="nav-link"><img src = "img/uploads/profile/${loginUser.member_Profile_Image}" style = "width : 27px; height : 27px; border-radius : 50%; overfloiw : hidden;"> <span>&nbsp;&nbsp;&nbsp;${loginUser.member_Id}'s PROFILE</span></a>
                           </li>
                           <li class="nav-item">
                              <a href="follow?member_Id=${loginUser.member_Id}" class="nav-link"><span class="material-icons me-3">diversity_3</span> <span>follow</span></a>
                           </li>
                           <li class="nav-item">
			                  <a href="edit_profile" class="nav-link"><span class="material-icons me-3">edit</span> <span>Edit Profile</span></a>
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
                           
                           <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                              	<c:choose>
                              		<c:when test="${alarmListSize==0}">
                              		<span class="material-icons me-3"><span class="material-symbols-outlined">notifications</span></span> Notification
                              		</c:when>
                              		<c:otherwise>
                              		<span class="material-icons me-3"><span class="material-symbols-outlined">notifications_active</span></span> Notification  +${alarmListSize}
                              		</c:otherwise>
                              	</c:choose>
                              </a>
                              <ul class="dropdown-menu px-2 py-1 mb-2">
                              	<c:forEach var="alarmVO" items="${alarmList}" begin="0" end="10">
                              		<c:choose>
                              			<c:when test="${alarmVO.kind==1}">
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmFollow?member_Id=${alarmVO.to_Mem}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px">
													${alarmVO.message}
												</a>
											</li> 			
                              			</c:when>
                              			<c:when test="${alarmVO.kind==5}">
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmContact?alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px">
													${alarmVO.message}
												</a>
											</li> 
                              			</c:when>
                              			<c:otherwise>
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmIndex?post_Seq=${alarmVO.post_Seq}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px">
													${alarmVO.message}
												</a>
											</li>   
                              			</c:otherwise>
                              		</c:choose>
                                </c:forEach>
                              </ul>
                           </li>
                           
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
			                  <a href="edit_profile" class="nav-link active"><span class="material-icons me-3">edit</span> <span>Edit Profile</span></a>
			               </li>
                           <li class="nav-item">
                              <a href="follow?member_Id=${loginUser.member_Id}" class="nav-link"><span class="material-icons me-3">diversity_3</span> <span>follow</span></a>
                           </li>
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
                           
                           <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                              	<c:choose>
                              		<c:when test="${alarmListSize==0}">
                              		<span class="material-icons me-3"><span class="material-symbols-outlined">notifications</span></span> Notification
                              		</c:when>
                              		<c:otherwise>
                              		<span class="material-icons me-3"><span class="material-symbols-outlined">notifications_active</span></span> Notification  +${alarmListSize}
                              		</c:otherwise>
                              	</c:choose>
                              </a>
                              <ul class="dropdown-menu px-2 py-1 mb-2">
                              	<c:forEach var="alarmVO" items="${alarmList}" begin="0" end="10">
                              		<c:choose>
                              			<c:when test="${alarmVO.kind==1}">
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmFollow?member_Id=${alarmVO.to_Mem}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px">
													${alarmVO.message}
												</a>
											</li> 			
                              			</c:when>
                              			<c:when test="${alarmVO.kind==5}">
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmContact?alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px">
													${alarmVO.message}
												</a>
											</li> 
                              			</c:when>
                              			<c:otherwise>
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmIndex?post_Seq=${alarmVO.post_Seq}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px">
													${alarmVO.message}
												</a>
											</li>   
                              			</c:otherwise>
                              		</c:choose>
                                </c:forEach>
                              </ul>
                           </li>
                           
                        </ul>
                     </div>
                  </div>
                  
               </aside>
               
               
               <!-- index페이지 오른쪽 사이드바 column -->
               <aside class="col col-xl-3 order-xl-3 col-lg-6 order-lg-3 col-md-6 col-sm-6 col-12">
                  <div class="fix-sidebar">
                     <div class="side-trend lg-none">
                        <!-- Search Tab -->
                        <div class="sticky-sidebar2 mb-3">
                           <!-- 우측 상단의 검색탭 -->
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
                              <!-- Show More -->
                              <a href="follow" class="text-decoration-none">
                                 <div class="p-3">Show More</div>
                              </a>
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
      <!-- Insert Js -->
      <script src="js/insert.js"></script>
      <!-- Search Peple Js -->
      <script src="js/searchpeople.js"></script>
   </body>
</html>