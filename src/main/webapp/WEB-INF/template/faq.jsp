<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html lang="en">
   <head>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="icon" type="image/png" href="img/logo2.png">
      <title>BlueLemon</title>
      <meta name="description" content="BlueLemon">
      <meta name="keywords" content="bootstrap5, e-learning, forum, games, online course, Social Community, social events, social feed, social media, social media template, social network html, social sharing, twitter">
      <!-- Bootstrap CSS -->
      <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <!-- Slich Slider -->
      <link href="vendor/slick/slick/slick.css" rel="stylesheet">
      <link href="vendor/slick/slick/slick-theme.css" rel="stylesheet">
      <!-- Icofont -->
      <link href="vendor/icofont/icofont.min.css" rel="stylesheet">
      <!-- Font Icons -->
      <link href="vendor/icons/css/materialdesignicons.min.css" rel="stylesheet" type="text/css">
      <!-- Custom Css -->
      <link href="css/style.css" rel="stylesheet">
      <!-- Material Icons -->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
   </head>
   <body class="bg-light">
      <div class="theme-switch-wrapper ms-3">
         <label class="theme-switch" for="checkbox">
            <input type="checkbox" id="checkbox">
            <span class="slider round"></span>
            <i class="icofont-ui-brightness"></i>
         </label>
         <em>Enable Dark Mode!</em>
      </div>
      <div class="web-none d-flex align-items-center px-3 pt-3">
         <a href="index" class="text-decoration-none">
         <img src="img/logo.png" class="img-fluid logo-mobile" alt="brand-logo">
         </a>
         <button class="ms-auto btn btn-primary ln-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
         <span class="material-icons">menu</span>
         </button>
      </div>
      <div class="py-4">
	      <div class="container">
	         <div class="row position-relative">
	            <!-- Main Content -->
	            <main class="col col-xl-6 order-xl-2 col-lg-12 order-lg-1 col-md-12 col-sm-12 col-12">
	               <div class="main-content">
	                  <div class="mb-5">
	                     <div class="feature bg-primary bg-gradient text-white rounded-4 mb-3"><i class="mdi mdi-help"></i></div>
	                     <h2 class="fw-bold text-black mb-1">Frequently Asked Questions</h2>
	                     <p class="lead fw-normal text-muted mb-0">How can we help you?</p>
	                  </div>
	                  <!-- Feeds -->
	                  <div class="feeds">
	                     <!-- Feed Item -->
	                     <div class="bg-white p-4 feed-item rounded-4 shadow-sm faq-page">
	                        <!-- Contact form-->
	                        <div class="rounded-3">
	                           <div class="mb-3">
	                              <h5 class="lead fw-bold text-body mb-0">Basics</h5>
	                           </div>
	                           <div class="row justify-content-center">
	                              <div class="col-lg-12">
	                                 <!-- FAQ Accordion 1-->
	                                 <div class="accordion overflow-hidden bg-white" id="accordionExample">
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingOne"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">프로필 변경 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseOne" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             <p class="m-0">프로필의 변경은 로그인 후 좌측 사이드메뉴에서 Profile을 들어가신 후<br> Edit-Profile을 통해 변경할 수 있습니다.
	                                             </p>
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingTwo"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">프로필 사진 업로드 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseTwo" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                          	  프로필의 변경은 로그인 후 좌측 사이드메뉴에서 Profile을 들어가신 후<br> Edit-Profile을 통해 변경할 수 있습니다.
	                                             <strong>프로필 이미지는 PNG 확장자만 사용 가능합니다.</strong><br>
	                                             		폭력적이거나 선정적인 이미지는 제거되거나 계정 사용이 정지될 수 있습니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingThree"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">게시글 작성 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseThree" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	메인 피드의 상단에 있는 텍스트창을 눌러 작성하실 수 있습니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingFour"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">댓글 작성 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseFour" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	댓글을 게시하고 싶은 게시물을 눌러 들어간 다음<br> 하단의 입력창을 이용하여 댓글을 작성하실 수 있습니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingFive"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">팔로우 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseFive" aria-labelledby="headingFive" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	팔로우하고 싶은 상대방을 눌러 프로필로 들어간 다음 팔로우를 눌러서 팔로우할 수 있습니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingSix"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">로그 아웃 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseSix" aria-labelledby="headingSix" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	좌측 사이드 메뉴의 로그아웃 버튼을 눌러 로그아웃하실 수 있습니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                 </div>
	                              </div>
	                           </div>
	                           <div class="mb-3 mt-4 pt-2">
	                              <h5 class="lead fw-bold text-body mb-0">Account</h5>
	                           </div>
	                           <div class="row justify-content-center">
	                              <div class="col-lg-12">
	                                 <!-- FAQ Accordion 1-->
	                                 <div class="accordion overflow-hidden bg-white" id="accordionExample">
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingTwo4"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo4" aria-expanded="false" aria-controls="collapseTwo4">아이디 찾기</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseTwo4" aria-labelledby="headingTwo4" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	로그인 메뉴의 하단에 있는 아이디/비밀번호 찾기를 이용하여 본인 확인 이후<br> 아이디를 확인하실 수 있습니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingOne1"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne1" aria-expanded="false" aria-controls="collapseOne1">비밀번호 찾기</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseOne1" aria-labelledby="headingOne1" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	로그인 메뉴의 하단에 있는 아이디/비밀번호 찾기를 이용하여 본인 확인 이후<br> 비밀번호의 변경이 가능합니다.
	                                             	이전부터 쓰고 있던 비밀번호는 확인이 불가합니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingTwo2"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo2" aria-expanded="false" aria-controls="collapseTwo2">회원탈퇴 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseTwo2" aria-labelledby="headingTwo2" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	프로필 수정 페이지의 맨 하단에 있는 회원 탈퇴 페이지에서 탈퇴가 가능합니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingThree3"><button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree3" aria-expanded="false" aria-controls="collapseThree3">일대일 문의 방법</button></h3>
	                                       <div class="accordion-collapse collapse" id="collapseThree3" aria-labelledby="headingThree3" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             	좌측 사이드메뉴의 Contact Us 메뉴의 Contact에서 문의가 가능합니다.
	                                          </div>
	                                       </div>
	                                    </div>
	                                 </div>
	                              </div>
	                           </div>
	                        </div>
	                     </div>
	                  </div>
	               </div>
	            </main>
	            <aside class="col col-xl-3 order-xl-1 col-lg-6 order-lg-2 col-md-6 col-sm-6 col-12">
	               <div class="p-2 bg-light offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample">
	                  <div class="sidebar-nav mb-3">
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
                               <a href="follow?member_Id=${loginUser.member_Id}" class="nav-link"><span class="material-icons me-3">diversity_3</span> <span>follow</span></a>
                            </li>
                            <!-- PAGES 드롭다운 항목 -->
                            <li class="nav-item dropdown">
                               <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
                               <a href="follow?member_Id=${loginUser.member_Id}" class="nav-link"><span class="material-icons me-3">diversity_3</span> <span>follow</span></a>
                            </li>
                            <li class="nav-item dropdown">
                               <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
	                           <h6 class="fw-bold text-body p-3 mb-0 border-bottom">What's happening</h6>
	                           <!-- Trending Item -->
	                           <div class="p-3 border-bottom d-flex">
	                              <div>
	                                 <div class="text-muted fw-light d-flex align-items-center">
	                                    <small>Trending in India</small>
	                                 </div>
	                                 <p class="fw-bold mb-0 pe-3 text-dark">News</p>
	                                 <small class="text-muted">52.8k Tweets</small>
	                              </div>
	                              <div class="dropdown ms-auto">
	                                 <a href="#" class="text-muted text-decoration-none material-icons ms-2 md-20 rounded-circle bg-light p-1" id="dropdownMenuButton6" data-bs-toggle="dropdown" aria-expanded="false">more_vert</a>
	                                 <ul class="dropdown-menu fs-13 dropdown-menu-end" aria-labelledby="dropdownMenuButton6">
	                                    <li><a class="dropdown-item text-muted" href="#"><span class="material-icons md-13 me-1">sentiment_very_dissatisfied</span>Not interested in this</a></li>
	                                    <li><a class="dropdown-item text-muted" href="#"><span class="material-icons md-13 me-1">sentiment_very_dissatisfied</span>This trend is harmful or spammy</a></li>
	                                 </ul>
	                              </div>
	                           </div>
	                           <!-- Trending Item -->
	                           <a href="tags" class="p-3 border-bottom d-flex align-items-center text-dark text-decoration-none">
	                              <div>
	                                 <div class="text-muted fw-light d-flex align-items-center">
	                                    <small>Design</small><span class="mx-1 material-icons md-3">circle</span><small>Live</small>
	                                 </div>
	                                 <p class="fw-bold mb-0 pe-3">Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	                              </div>
	                              <img src="img/trend1.jpg" class="img-fluid rounded-4 ms-auto" alt="trending-img">
	                           </a>
	                        </div>
	                     </div>
	                  </div>
	               </div>
	            </aside>
	         </div>
	      </div>
      </div>
      <div class="py-3 bg-white footer-copyright">
         <div class="container">
            <div class="row align-items-center">
               <div class="col-md-8">
                  <span class="me-3 small">Â©2023 <b class="text-primary">BlueLemon</b>. All rights reserved</span>
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
      <!-- Post Modal -->
      <div class="modal fade" id="postModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 p-4 border-0 bg-light">
               <div class="modal-header d-flex align-items-center justify-content-start border-0 p-0 mb-3">
                  <a href="#" class="text-muted text-decoration-none material-icons" data-bs-dismiss="modal">arrow_back_ios_new</a>
                  <h5 class="modal-title text-muted ms-3 ln-0" id="staticBackdropLabel"><span class="material-icons md-32">account_circle</span></h5>
               </div>
               <div class="modal-body p-0 mb-3">
                  <div class="form-floating">
                     <textarea class="form-control rounded-5 border-0 shadow-sm" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 200px"></textarea>
                     <label for="floatingTextarea2" class="h6 text-muted mb-0">What's on your mind...</label>
                  </div>
               </div>
               <div class="modal-footer justify-content-start px-1 py-1 bg-white shadow-sm rounded-5">
                  <div class="rounded-4 m-0 px-3 py-2 d-flex align-items-center justify-content-between w-75">
                     <a href="#" class="text-muted text-decoration-none material-icons">insert_link</a>
                     <a href="#" class="text-muted text-decoration-none material-icons">image</a>
                     <a href="#" class="text-muted text-decoration-none material-icons">smart_display</a>
                     <span class="text-muted">0/500</span>
                  </div>
                  <div class="ms-auto m-0">
                     <a data-bs-dismiss="modal" href="#" class="btn btn-primary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center"><span class="material-icons me-2 md-16">send</span>Post</a>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- Sign In Modal -->
      <div class="modal fade" id="signModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 p-4 border-0">
               <div class="modal-header border-0 p-1">
                  <h6 class="modal-title fw-bold text-body fs-6" id="exampleModalLabel">Choose Language</h6>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <form>
                  <div class="modal-body p-0">
                     <div class="mt-5 login-register" id="number">
                        <h6 class="fw-bold mx-1 mb-2 text-dark">Register your Mobile Number</h6>
                        <div class="row mx-0 mb-3">
                           <div class="col-3 p-1">
                              <div class="form-floating">
                                 <select class="form-select rounded-5" id="floatingSelect" aria-label="Floating label select example">
                                    <option selected>+91</option>
                                    <option value="1">+34</option>
                                    <option value="2">+434</option>
                                    <option value="3">+343</option>
                                 </select>
                                 <label for="floatingSelect">Code</label>
                              </div>
                           </div>
                           <div class="col-9 p-1">
                              <div class="form-floating d-flex align-items-end">
                                 <input type="text" class="form-control rounded-5" id="floatingName" value="1234567890" placeholder="Enter Mobile Number">
                                 <label for="floatingName">Enter Mobile Number</label>
                              </div>
                           </div>
                        </div>
                        <div class="p-1">
                           <button type="button" class="btn btn-primary w-100 text-decoration-none rounded-5 py-3 fw-bold text-uppercase m-0" data-bs-dismiss="modal">Send OTP</button>
                        </div>
                     </div>
                  </div>
               </form>
            </div>
         </div>
      </div>
      
      <!-- Comment Modal -->
      <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 overflow-hidden border-0">
               <div class="modal-header d-none">
                  <h5 class="modal-title" id="exampleModalLabel2">Modal title</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body p-0">
                  <div class="row m-0">
                     <div class="col-sm-7 px-0 m-sm-none">
                        <!-- Image Slider -->
                        <div class="image-slider">
                           <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                              <div class="carousel-indicators">
                                 <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                 <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                 <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                              </div>
                              <div class="carousel-inner">
                                 <div class="carousel-item active">
                                    <img src="img/post-img1.jpg" class="d-block w-100" alt="...">
                                 </div>
                                 <div class="carousel-item">
                                    <img src="img/post-img2.jpg" class="d-block w-100" alt="...">
                                 </div>
                                 <div class="carousel-item">
                                    <img src="img/post-img3.jpg" class="d-block w-100" alt="...">
                                 </div>
                              </div>
                              <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Previous</span>
                              </button>
                              <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                              <span class="carousel-control-next-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Next</span>
                              </button>
                           </div>
                        </div>
                     </div>
                     <div class="col-sm-5 content-body px-web-0">
                        <div class="d-flex flex-column h-600">
                           <div class="d-flex p-3 border-bottom">
                              <img src="img/rmate4.jpg" class="img-fluid rounded-circle user-img" alt="profile-img">
                              <div class="d-flex align-items-center justify-content-between w-100">
                                 <a href="profile" class="text-decoration-none ms-3">
                                    <div class="d-flex align-items-center">
                                       <h6 class="fw-bold text-body mb-0">iamosahan</h6>
                                       <p class="ms-2 material-icons bg-primary p-0 md-16 fw-bold text-white rounded-circle ov-icon mb-0">done</p>
                                    </div>
                                    <p class="text-muted mb-0 small">@johnsmith</p>
                                 </a>
                                 <div class="small dropdown">
                                    <a href="#" class="text-muted text-decoration-none material-icons ms-2 md-" data-bs-dismiss="modal">close</a>
                                 </div>
                              </div>
                           </div>
                           <div class="comments p-3">
                              <div class="d-flex mb-2">
                                 <img src="img/rmate1.jpg" class="img-fluid rounded-circle" alt="profile-img">
                                 <div class="ms-2 small">
                                    <div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text">
                                       <p class="fw-500 mb-0">Macie Bellis</p>
                                       <span class="text-muted">Consecteturut labore et dolor.</span>
                                    </div>
                                    <div class="d-flex align-items-center ms-2">
                                       <a href="#" class="small text-muted text-decoration-none">Like</a>
                                       <span class="fs-3 text-muted material-icons mx-1">circle</span>
                                       <a href="#" class="small text-muted text-decoration-none">Reply</a>
                                       <span class="fs-3 text-muted material-icons mx-1">circle</span>
                                       <span class="small text-muted">1h</span>
                                    </div>
                                 </div>
                              </div>
                              <div class="d-flex mb-2">
                                 <img src="img/rmate3.jpg" class="img-fluid rounded-circle" alt="profile-img">
                                 <div class="ms-2 small">
                                    <div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text">
                                       <p class="fw-500 mb-0">John Smith</p>
                                       <span class="text-muted">Lorem ipsum dolor sit amet, cons	ectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</span>
                                    </div>
                                    <div class="d-flex align-items-center ms-2">
                                       <a href="#" class="small text-muted text-decoration-none">Like</a>
                                       <span class="fs-3 text-muted material-icons mx-1">circle</span>
                                       <a href="#" class="small text-muted text-decoration-none">Reply</a>
                                       <span class="fs-3 text-muted material-icons mx-1">circle</span>
                                       <span class="small text-muted">20min</span>
                                    </div>
                                 </div>
                              </div>
                              <div class="d-flex mb-2">
                                 <img src="img/rmate2.jpg" class="img-fluid rounded-circle" alt="profile-img">
                                 <div class="ms-2 small">
                                    <div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text">
                                       <p class="fw-500 mb-0">Shay Jordon</p>
                                       <span class="text-muted">With our vastly improved notifications system, users have more control.</span>
                                    </div>
                                    <div class="d-flex align-items-center ms-2">
                                       <a href="#" class="small text-muted text-decoration-none">Like</a>
                                       <span class="fs-3 text-muted material-icons mx-1">circle</span>
                                       <a href="#" class="small text-muted text-decoration-none">Reply</a>
                                       <span class="fs-3 text-muted material-icons mx-1">circle</span>
                                       <span class="small text-muted">10min</span>
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div class="border-top p-3 mt-auto">
                              <div class="d-flex align-items-center justify-content-between mb-2">
                                 <div>
                                    <a href="#" class="text-muted text-decoration-none d-flex align-items-start fw-light"><span class="material-icons md-20 me-2">thumb_up_off_alt</span><span>30.4k</span></a>
                                 </div>
                                 <div>
                                    <a href="#" class="text-muted text-decoration-none d-flex align-items-start fw-light"><span class="material-icons md-20 me-2">repeat</span><span>617</span></a>
                                 </div>
                                 <div>
                                    <a href="#" class="text-muted text-decoration-none d-flex align-items-start fw-light"><span class="material-icons md-18 me-2">share</span><span>Share</span></a>
                                 </div>
                              </div>
                              <div class="d-flex align-items-center">
                                 <span class="material-icons bg-white border-0 text-primary pe-2 md-36">account_circle</span>
                                 <div class="d-flex align-items-center border rounded-4 px-3 py-1 w-100">
                                    <input type="text" class="form-control form-control-sm p-0 rounded-3 fw-light border-0" placeholder="Write Your comment">
                                    <a href="#" class="bg-white border-0 text-primary ps-2 text-decoration-none">Post</a>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="modal-footer d-none">
               </div>
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
      <!-- Search Peple Js -->
      <script src="js/searchpeople.js"></script>
   </body>
</html>