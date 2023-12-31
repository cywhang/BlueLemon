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
	
	 .custom-file-upload {
        display: inline-block;
        padding: 6px 12px;
        cursor: pointer;
        background-color: #0d6efd;
        color: #0d6efd;
        border-radius: 4px;
        border: none;
        transition: background-color 0.3s ease;
    }

    .custom-file-upload:hover {
        background-color: #0d6efd;
    }

    .custom-file-upload input[type="file"] {
        display: none;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
		console.log("msg", msg);
		alert("잘못된 비밀번호입니다.\n 다시 시도해주세요.")
	} else if (msg === "withdrawlSuccess") {
		console.log("탈퇴완료 else if 타기");
		alert("BLUE LEMON 탈퇴가 완료되었습니다.\n 그동안 이용해주셔서 감사합니다.")
	}
	
	$('#member_Country').val("${loginUser.member_Country}").prop("selected", true);
</script>	  

   <!-- body부분의 class : light모드, dark모드 버튼 -->
   <body class="bg-light">   
      <div class = "goToTop">
 	     <a href = "#"><img src = "img/goToTop.png"></a>
      </div>
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
             <form id="edit_profile" method="post" action="update_form" enctype="multipart/form-data">
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
                                    name="member_Password" value="${loginUser.member_Password}" maxlength="12">
                                    <span id="password_message" class="error-message"></span>
                                    <label for="floatingssName">PASSWORD</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="password" name="repassowrd" class="form-control rounded-5" id="repassword" 
                                    placeholder="#" value="${loginUser.member_Password}" maxlength="12">
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
                                 <label class="mb-2 text-muted small" style = "margin-left : 5px;">선택 입력 항목</label>
								 <div class="form-floating mb-3 d-flex align-items-center">
								    <select name="member_Country" class="form-control rounded-5" id="member_Country">
								       <option value=""></option>
								       <option value="Korea" <c:if test="${loginUser.member_Country eq 'Korea'}">selected</c:if>>Korea</option>
								       <option value="Japan" <c:if test="${loginUser.member_Country eq 'Japan'}">selected</c:if>>Japan</option>
								       <option value="China" <c:if test="${loginUser.member_Country eq 'China'}">selected</c:if>>China</option>
								       <option value="America" <c:if test="${loginUser.member_Country eq 'America'}">selected</c:if>>America</option>
								       <option value="Russia" <c:if test="${loginUser.member_Country eq 'Russia'}">selected</c:if>>Russia</option>
								       <option value="Germany" <c:if test="${loginUser.member_Country eq 'Germany'}">selected</c:if>>Germany</option>
								       <option value="Italy" <c:if test="${loginUser.member_Country eq 'Italy'}">selected</c:if>>Italy</option>
								       <option value="Spain" <c:if test="${loginUser.member_Country eq 'Spain'}">selected</c:if>>Spain</option>
									</select>
                                    <label for="member_Country">Country</label>
								 </div>
								 <div class="form-floating mb-3 d-flex align-items-center">
								    <select name="member_Mbti" class="form-control rounded-5" id="member_Mbti">
								       <option value=""></option>
								       <option value="INFJ" <c:if test="${loginUser.member_Mbti eq 'INFJ'}">selected</c:if>>INFJ</option>
								       <option value="INFP" <c:if test="${loginUser.member_Mbti eq 'INFP'}">selected</c:if>>INFP</option>
								       <option value="ISFJ" <c:if test="${loginUser.member_Mbti eq 'ISFJ'}">selected</c:if>>ISFJ</option>
								       <option value="ISFP" <c:if test="${loginUser.member_Mbti eq 'ISFP'}">selected</c:if>>ISFP</option>
								       <option value="ISTP" <c:if test="${loginUser.member_Mbti eq 'ISTP'}">selected</c:if>>ISTP</option>
								       <option value="ISTJ" <c:if test="${loginUser.member_Mbti eq 'ISTJ'}">selected</c:if>>ISTJ</option>
								       <option value="INTP" <c:if test="${loginUser.member_Mbti eq 'INTP'}">selected</c:if>>INTP</option>
								       <option value="INTJ" <c:if test="${loginUser.member_Mbti eq 'INTJ'}">selected</c:if>>INTJ</option>
								       <option value="ENTP" <c:if test="${loginUser.member_Mbti eq 'ENTP'}">selected</c:if>>ENTP</option>
								       <option value="ESTJ" <c:if test="${loginUser.member_Mbti eq 'ESTJ'}">selected</c:if>>ESTJ</option>
								       <option value="ESTP" <c:if test="${loginUser.member_Mbti eq 'ESTP'}">selected</c:if>>ESTP</option>
								       <option value="ENFP" <c:if test="${loginUser.member_Mbti eq 'ENFP'}">selected</c:if>>ENFP</option>
								       <option value="ESFJ" <c:if test="${loginUser.member_Mbti eq 'ESFJ'}">selected</c:if>>ESFJ</option>
								       <option value="ENTJ" <c:if test="${loginUser.member_Mbti eq 'ENTJ'}">selected</c:if>>ENTJ</option>
								       <option value="ENFJ" <c:if test="${loginUser.member_Mbti eq 'ENFJ'}">selected</c:if>>ENFJ</option>
								       <option value="ESFP" <c:if test="${loginUser.member_Mbti eq 'ESFP'}">selected</c:if>>ESFP</option>
								    </select>
								    <label for="member_Mbti">MBTI</label>
								 </div>
	                          </div>
	                          <div class="rounded"  style="border:1px solid #dee2e6; height : auto; width: 96%;">
								<label style = "width : 23%; margin-top : 12px; margin-left : 10px; color : #a4aaaf;" for="member_Profile_Image">
									Profile Image
								</label><br>
								<label for="member_Profile_Image" class="custom-file-upload" style = "margin-left : 2%; margin-bottom : 3%; margin-top : 2%;">
									<span style = "color : white;">Upload</span>
									<input type="file" name="profile_Image" accept=".png" id="member_Profile_Image" onchange="previewProfileImage(event)">
								</label>											
								<img id="profile_image_preview" src="#" alt="" style="max-width: 200px; max-height: 200px; border-radius: 50%; overflow: hidden; margin-left : 20%;">
							</div>
	                   	 </div>
	                   	 <br>
	                    <div>
	                       <button class="btn btn-primary rounded-5 w-100 text-decoration-none py-3 fw-bold text-uppercase m-0" onclick ="go_update(event)">SAVE</button>
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
				        <form action="memberDelete" method="post" onsubmit="return confirmWithdrawal()">
				           <div class="form-floating mb-3 d-flex align-items-center">
				              <input type="password" class="form-control rounded-5" name="member_Password" id="check_Password" placeholder="비밀번호">
				              <span id="password_error_message" class="error-message"></span>
				              <label for="floatingPass">PASSWORD</label>
				           </div>
				           <button class="btn btn-primary w-100 text-decoration-none rounded-5 py-3 fw-bold text-uppercase m-0" type="submit">Withdrawal</button>
				        </form>					               
				     </div>
			      </div>
		       </div>
               </main> <!-- index페이지의 센터 column -->
               
               <script> // 회원탈퇴 시 확인용 alert창 출력 스크립트
			    function confirmWithdrawal() {
			        if (confirm("정말로 탈퇴하시겠습니까?")) {
			            return true;
			        } else {
			            return false;
			        }
			    }
			   </script>
               
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
                              <a href = "profile?member_Id=${sessionScope.loginUser.member_Id}" class="nav-link"><img src = "img/uploads/profile/${profileImage}" style = "width : 27px; height : 27px; border-radius : 50%; overfloiw : hidden;"> <span>&nbsp;&nbsp;&nbsp;${loginUser.member_Id}'s PROFILE</span></a>
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
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmFollow?member_Id=${alarmVO.to_Mem}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px; background-color: azure;">
													${alarmVO.message}
												</a>
											</li> 			
                              			</c:when>
                              			<c:when test="${alarmVO.kind==5}">
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmContact?alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px; background-color: azure;">
													${alarmVO.message}
												</a>
											</li> 
                              			</c:when>
                              			<c:otherwise>
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmIndex?post_Seq=${alarmVO.post_Seq}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px; background-color: azure;">
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
                              <a href = "profile?member_Id=${sessionScope.loginUser.member_Id}" class="nav-link"><img src = "img/uploads/profile/${profileImage}" style = "width : 27px; height : 27px; border-radius : 50%; overfloiw : hidden;"> <span>&nbsp;&nbsp;&nbsp;${loginUser.member_Id}'s PROFILE</span></a>
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
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmFollow?member_Id=${alarmVO.to_Mem}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px; background-color: azure;">
													${alarmVO.message}
												</a>
											</li> 			
                              			</c:when>
                              			<c:when test="${alarmVO.kind==5}">
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmContact?alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px; background-color: azure;">
													${alarmVO.message}
												</a>
											</li> 
                              			</c:when>
                              			<c:otherwise>
                              				<li>
												<a class="dropdown-item rounded-3 px-2 py-1 my-1" href="/blue/alarmIndex?post_Seq=${alarmVO.post_Seq}&alarm_Seq=${alarmVO.alarm_Seq}" style="font-size:11px; background-color: azure;">
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
                       	        		<c:choose>
								   			<c:when test = "${postVO.post_Image_Count == 0}">
								      			<a id="openModalBtn" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal2" onclick="replyModalseq(${postVO.post_Seq})" style = "width : 100%;">
							            	 		<div class = "d-flex">
							                			<div>
								               				<p class="fw-bold mb-0 pe-3 text-dark">${postVO.post_Like_Count}'s Likes</p>
								               				<small class="text-muted">Posted by ${postVO.member_Id}</small>
								               				<br><div style = "height : 5%;"></div>
											               	<small class="text-muted">
											               		<c:choose>
											               			<c:when test="${fn:length(postVO.post_Content) > 25 }">
											               				<c:out value = "${fn:substring(postVO.post_Content, 0, 25)}"/> . . .
											               			</c:when>
											               			<c:otherwise>
											               				${postVO.post_Content}
											               			</c:otherwise>
											               		</c:choose>
											               	</small>
								               				<br><div style = "height : 5%;"></div>
								               				<c:choose>
											                  	<c:when test="${postVO.post_Hashtag eq null }">
											                  	</c:when>
								                  				<c:otherwise>
								                     				<small class="text-muted">
													               		<c:choose>
													               			<c:when test="${fn:length(postVO.post_Hashtag) > 22 }">
													               				<c:out value = "${fn:substring(postVO.post_Hashtag, 0, 22)}"/> . . .
													               			</c:when>
													               			<c:otherwise>
													               				${postVO.post_Hashtag}
													               			</c:otherwise>
													               		</c:choose>
								                     				</small>									                  
								                  				</c:otherwise>
								               				</c:choose>
								            			</div>
													</div>
												</a>
											</c:when>
											<c:otherwise>
												<a id="openModalBtn" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal" onclick="modalseq(${postVO.post_Seq})" style = "width : 100%;">
													<div class = "d-flex">
														<div style = "width : 60%;">
															<p class="fw-bold mb-0 pe-3 text-dark">${postVO.post_Like_Count}'s Likes</p>
															<small class="text-muted">Posted by ${postVO.member_Id}</small>
															<br><div style = "height : 5%;"></div>
															<small class="text-muted">
																<c:out value = "${fn:substring(postVO.post_Content, 0, 15)}"/> . . .
															</small>
															<br><div style = "height : 5%;"></div>
															<c:choose>
																<c:when test="${postVO.post_Hashtag eq null }">
																</c:when>
																<c:otherwise>
																	<small class="text-muted">
																		<c:out value = "${fn:substring(postVO.post_Hashtag, 0, 15)}"/> . . .
																	</small>									                  
																</c:otherwise>
															</c:choose>
														</div>
														<div style = "width : 40%;">								      									         
															<img src="img/uploads/post/${postVO.post_Seq}-1.png" class="img-fluid rounded-4 ms-auto" width = "100" height = "100">									         
														</div>
													</div>
												</a>
											</c:otherwise>
										</c:choose>	
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
      
      <%@ include file="modal.jsp" %>
 
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
      <!-- editprofile JS -->
      <script src="js/editprofile.js"></script>
   </body>
</html>