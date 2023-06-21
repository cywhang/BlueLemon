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
   <style>
   		table {
   			border-collapse : collapse;
   		}
   		th, td {
   			border : 1px solid black;
   			padding : 5px;
   		}
   		.qnaDiv {
   			border : 1px solid black;
   			padding : 5px;
   			border-radius : 10px;
   		}
   </style>
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
                     <div class="feature bg-primary bg-gradient text-white rounded-4 mb-3"><i class="icofont-envelope"></i></div>
                     <h1 class="fw-bold text-black mb-1">How can we help?</h1>
                     <p class="lead fw-normal text-muted mb-0">We'd love to hear from you</p>
                  </div>
                  <!-- Feeds -->
                  <div class="feeds">
                     <!-- Feed Item -->
                     <div class="bg-white p-4 feed-item rounded-4 shadow-sm faq-page">
                        <div class="mb-3">
                           <h5 class="lead fw-bold text-body mb-0">Contact Form</h5>
                        </div>
                        <div class="row justify-content-center">
                           <div class="col-lg-12">
                           	  <!-- action으로 폼 데이터 처리 해야함. -->
                              <form class="form-floating-space" id="contactForm" data-sb-form-api-token="API_TOKEN" action="qna" method = "post">                              
                                 <!-- Name input-->
                                 <div class="form-floating mb-3">
                                    <input class="form-control rounded-5" id="member_Id" name = "member_Id" type="text" value = "${sessionScope.loginUser.member_Id}" readonly>
                                    <label for="member_Id">Member ID</label>
                                 </div>
                                 
                                 <!-- Phone number input-->
                                 <div class="form-floating mb-3">
                                    <input class="form-control rounded-5" id="qna_Title" name = "qna_Title" type="text" data-sb-validations="required">
                                    <label for="qna_Title">Title</label>
                                    <div class="invalid-feedback" data-sb-feedback="qna_Title:required">A Title is required.</div>
                                 </div>
                                 
                                 <!-- Message input-->
                                 <div class="form-floating mb-3">
                                    <textarea class="form-control rounded-5" id="qna_Message" name = "qna_Message" style="height: 10rem" data-sb-validations="required"></textarea>
                                    <label for="qna_Message">Message</label>
                                    <div class="invalid-feedback" data-sb-feedback="qna_Message:required">A Message is required.</div>
                                 </div>
                                 
                                 <div class="d-none" id="submitSuccessMessage">
                                    <div class="text-center mb-3">
                                       <div class="fw-bolder">Form submission successful!</div>
                                    </div>
                                 </div>
                                 
                                 <div class="d-none" id="submitErrorMessage">
                                    <div class="text-center text-danger mb-3">Error sending message!</div>
                                 </div>
                                 
                                 <!-- Submit Button-->
                                 <div class="d-grid">
                                 	<button class="btn btn-primary w-100 rounded-5 text-decoration-none py-3 fw-bold text-uppercase m-0" id="submitButton" type="submit">문의하기</button>
                                 </div>
                              </form>
                           </div>
                        </div>
                        <!-- Contact form-->
                        <div class="bg-white p-4 feed-item rounded-4 shadow-sm faq-page">
	                        <div class="rounded-3">
	                           <div class="mb-3">
	                              <h5 class="lead fw-bold text-body mb-0">mmmmmmMy Questionsssssssssssssssssssss</h5>
	                           </div>
	                           <div class="row justify-content-center">
	                              <div class="col-lg-12">								     
								     <div class="accordion overflow-hidden bg-white" id="accordionExample">
									    <c:forEach items = "${qnaList}" var = "qna">
		                                   <div class="accordion-item">
		                                      <h3 class="accordion-header" id="heading_${qna.qna_Seq}">
		                                         <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapse_${qna.qna_Seq}" aria-expanded="false" aria-controls="collapse_${qna.qna_Seq}">
		                                  	        ${qna.qna_Title}
		                                         </button>
		                                      </h3>
		                                      <div class="accordion-collapse collapse" id="collapse_${qna.qna_Seq}" aria-labelledby="heading_${qna.qna_Seq}" data-bs-parent="#accordionExample">
		                                         <div class="accordion-body">
		                                            <div class = "qnaDiv">
		                                         	   <label>Message</label>
		                                         	   <hr>
		                                         	   <div>${qna.qna_Message}</div>		                                         		
		                                         	</div>
		                                         	<hr>
		                                         	<c:choose>
		                                         	   <c:when test = "${qna.qna_Done eq '2'}">
		                                         	      <div class = "qnaDiv">
		                                         		     <label>Answer</label>
		                                         		     <hr>
		                                         		     <div>${qna.qna_Answer}</div>		                                         		
		                                         	      </div>
		                                         	   </c:when>
		                                         	   <c:otherwise>
		                                         	      <div class = "qnaDiv">
		                                         		     <label>Answer</label>
		                                         		     <hr>
		                                         		     <div>Sorry, Now We Are Checking Your Question</div>		                                         		
		                                         	      </div>
		                                         	   </c:otherwise> 
		                                         	</c:choose>
		                                         </div>
		                                      </div>
		                                   </div>     
		                                </c:forEach>
	                                    <div class="accordion-item">
	                                       <h3 class="accordion-header" id="headingTwo">
	                                          <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
	                                             프로필 사진 업로드 방법
	                                          </button>
	                                       </h3>
	                                       <div class="accordion-collapse collapse" id="collapseTwo" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
	                                          <div class="accordion-body">
	                                             프로필의 변경은 로그인 후 좌측 사이드메뉴에서 Profile을 들어가신 후
	                                          </div>
	                                       </div>
	                                    </div>	                      
		                             </div>                       
	                              </div>
	                           </div>
	                        </div>
	                    </div>
                        <div class="row row-cols-2 row-cols-lg-4 pt-5">
                           <div class="col">
                              <div class="feature bg-primary bg-gradient text-white rounded-4 mb-3"><i class="icofont-chat"></i></div>
                              <div class="h6 mb-2 fw-bold text-black">Chat with us</div>
                              <p class="text-muted mb-0">Chat live with one of our support specialists.</p>
                           </div>
                           <div class="col">
                              <div class="feature bg-primary bg-gradient text-white rounded-4 mb-3"><i class="icofont-people"></i></div>
                              <div class="h6 fw-bold text-black">Ask the community</div>
                              <p class="text-muted mb-0">Explore our community forums and communicate with other users.</p>
                           </div>
                           <div class="col">
                              <div class="feature bg-primary bg-gradient text-white rounded-4 mb-3"><i class="icofont-question-circle"></i></div>
                              <div class="h6 fw-bold text-black">Support center</div>
                              <p class="text-muted mb-0">Browse FAQ's and support articles to find solutions.</p>
                           </div>
                           <div class="col">
                              <div class="feature bg-primary bg-gradient text-white rounded-4 mb-3"><i class="icofont-telephone"></i></div>
                              <div class="h6 fw-bold text-black">Call us</div>
                              <p class="text-muted mb-0">Call us during normal business hours at (555) 892-9403.</p>
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
                           <li class="nav-item dropdown active">
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
                                 <li><a class="dropdown-item rounded-3 px-2 py-1 my-1 active" href="contact">Contact</a></li>
                                 <li><a class="dropdown-item rounded-3 px-2 py-1 my-1" href="faq">FAQ</a></li>
                              </ul>
                           </li>
                           
                           <li class="nav-item">
                              <a href="logout" class="nav-link"><span class="material-icons me-3">logout</span> <span>Logout</span></a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </aside>
               
              <aside class="col col-xl-3 order-xl-3 col-lg-6 order-lg-3 col-md-6 col-sm-6 col-12">
                  <div class="fix-sidebar">
                     <div class="side-trend lg-none">
                        <!-- Search Tab -->
                        <div class="sticky-sidebar2 mb-3">
                           <!-- 우측 상단의 검색탭 -->
                           <div class="input-group mb-4 shadow-sm rounded-4 overflow-hidden py-2 bg-white">
                              <span class="input-group-text material-icons border-0 bg-white text-primary">search</span>
                              <input type="text" class="form-control border-0 fw-light ps-1" placeholder="Search People">
                           </div>
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
      <!-- Trending Js -->
      <script src="js/trending.js"></script>
   </body>
</html>