<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	  <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
	  <script src="https://code.jquery.com/jquery-latest.min.js"></script>
  	  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
  	  <!-- 해시태그  -->
  	  <script src="https://unpkg.com/@yaireo/tagify"></script>
	  <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
	  <link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
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
                           <button class="p-3 nav-link text-muted active" id="pills-feed-tab" data-bs-toggle="pill" data-bs-target="#pills-feed" type="button" role="tab" aria-controls="pills-feed" aria-selected="true">Feed</button>
                        </li>
                        <li class="nav-item" role="presentation">
                           <button class="p-3 nav-link text-muted" id="pills-people-tab" data-bs-toggle="pill" data-bs-target="#pills-people" type="button" role="tab" aria-controls="pills-people" aria-selected="false" onclick = "people_List()">People</button>
                        </li>
                        <li class="nav-item" role="presentation">
                           <button class="p-3 nav-link text-muted" id="pills-trending-tab" data-bs-toggle="pill" data-bs-target="#pills-trending" type="button" role="tab" aria-controls="pills-trending" aria-selected="false" onclick = "trending_List()">Trending</button>
                        </li>
                     </ul>
                     
                     <!-- feed 버튼 클릭시 출력부분 -->
                     <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-feed" role="tabpanel" aria-labelledby="pills-feed-tab">
                           <!-- Post Tab -->
                           <!-- index페이지 글 작성 탭 (클릭시 모달창 띄움) -->
                           <div class="input-group mb-4 shadow-sm rounded-4 overflow-hidden py-2 bg-white" data-bs-toggle="modal" data-bs-target="#postModal">
                              <span class="input-group-text material-icons border-0 bg-white text-primary">account_circle</span>
                              <input type="text" class="form-control border-0 fw-light ps-1" placeholder="What's on your mind.">
                              <a href="#" class="text-decoration-none input-group-text bg-white border-0 material-icons text-primary">add_circle</a>
                           </div>
                           <!-- Follow People -->
                           <!-- index페이지 친구 추천창 -->
                           <div class="d-flex align-items-center justify-content-between mb-1">
                              <h6 class="mb-0 fw-bold text-body">Follow People</h6>
                              <!-- 오른쪽 화살표 버튼 -->
                              <a href="#" class="text-dark text-decoration-none material-icons">east</a>
                           </div>
                           <!-- Slider Accounts -->
                           <!-- 좌우 드래그로 스크롤 하기위한 div -->
                           <div class="account-slider">
                              <!-- Account Item -->
                              <!-- 친구 추천창 요소 -->
                              <c:forEach items="${recommendMember}" var="memberVO" begin="0" end="5">
	                             <div class="account-item">
	                                <div class="me-2 bg-white shadow-sm rounded-4 p-3 user-list-item d-flex justify-content-center my-2">
	                                   <div class="text-center">
	                                      <div class="position-relative d-flex justify-content-center">
	                                         <a href = "profile?member_Id=${memberVO.member_Id}" class="text-decoration-none">
	                                            <img src="img/uploads/profile/${profileMap[memberVO.member_Id]}" class="img-fluid rounded-circle mb-3" alt="profile-img">
	                                            <p class="fw-bold text-dark m-0">${memberVO.member_Id}</p>
	                                            <p class="small text-muted">${memberVO.member_Name}</p>
	                                         </a>
	                                      </div>
	                                          
	                                      <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
	                                         <input type="checkbox" class="btn-check" id="btncheck_${memberVO.member_Id}">
	                                         <label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck_${memberVO.member_Id}" onclick ="changeFollow('${memberVO.member_Id}')">
	                                            <span class="follow">+ Follow</span>
	                                            <span class="following d-none">Following</span>	
	                                            <!-- [팔로우, 언팔로우 - 1] 버튼 누르면 해당 회원 ID를 들고 follow.js로 감 -->	                                      
	                                         </label>
	                                      </div>
	                                   </div>
	                                </div>
	                             </div>
                              </c:forEach>                                           
                           </div>
                              
                           <!-- Feeds -->
                           <!-- 뉴스피드들을 감싸는 부분 -->
                           <div class="pt-4 feeds">                              
                              <!-- Feed Item -->
                              <c:forEach var="postVO" items="${postList}" varStatus="status" begin="0" end="9">
                                 <div class="bg-white p-3 feed-item rounded-4 mb-3 shadow-sm">
                                    <div class="d-flex">
                                       <!-- 작성자의 프로필사진 -->
                                       <img src="img/uploads/profile/${profileMap[postVO.member_Id]}"  class="img-fluid rounded-circle user-img" alt="profile-img">
                                       <div class="d-flex ms-3 align-items-start w-100">
                                          <div class="w-100">
                                             <div class="d-flex align-items-center justify-content-between">
                                                <a href = "profile?member_Id=${postVO.member_Id}" class="text-decoration-none" >
                                                   <h6 class="fw-bold mb-0 text-body" style="font-size: 26px;">${postVO.member_Id}</h6>
                                                </a>
                                                <div class="d-flex align-items-center small">
                                                   <p class="text-muted mb-0">${postVO.post_Date}</p>
                                                      <c:choose>
                                                      	<c:when test="${member_Id == postVO.member_Id}">
		                                                     <div class="dropdown">
		                                                      <a href="#" class="text-muted text-decoration-none material-icons ms-2 md-20 rounded-circle bg-light p-1" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">more_vert</a>
		                                                      	<ul class="dropdown-menu fs-13 dropdown-menu-end" aria-labelledby="dropdownMenuButton1">
		                                                         <li><a class="dropdown-item text-muted" href="#"><span class="material-icons md-13 me-1">edit</span>Edit</a></li>
		                                                         <!-- deletePost()는 custom.js에 있음 -->
		                                                         <li><a class="dropdown-item text-muted" onclick="deletePost(${postVO.post_Seq})"><span class="material-icons md-13 me-1">delete</span>Delete</a></li>
		                                                        </ul>
		                                                   	 </div>
                                                      	</c:when>
                                                      	<c:otherwise>
                                                      	</c:otherwise>
                                                      </c:choose>
                                                </div>
                                             </div>
                                             <div class="my-2">
                                                <!-- 게시글의 사진 (클릭시 게시글 상세보기 모달창 출력) -->
                                                <a id="openModalBtn" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal" onclick="modalseq(${postVO.post_Seq})">
	                                               <c:choose>
	                                                  <c:when test="${postVO.post_Image_Count == 0}">
	                                                     <br>
	                                                  </c:when>
	                                                  <c:otherwise>
	                                                     <img src="img/uploads/post/${postVO.post_Seq}-1.png" class="img-fluid rounded mb-3" alt="post-img">
	                                                  </c:otherwise>
	                                               </c:choose>
                                                </a>      
                                             	<!-- 게시글 내용 -->                                        
                                                <p class="text-dark">${postVO.post_Content}</p>
                                                <br>
                                                
                                                <!-- 해시태그 -->
                                                <c:forEach var="hash" items="${hashMap[postVO.post_Seq]}">
                                                	<a id="hash" href="#" class="mb-3 text-primary">${hash.tag_Content}</a>&nbsp;&nbsp;
                                                </c:forEach>
                                                <hr>
                                                <!-- 게시글 바로 아래 좋아요, 댓글 버튼 부분 -->
                                                <div class="d-flex align-items-center justify-content-between mb-2">
                                                   <%-- 게시글 좋아요 버튼 (카운트) --%>
                                                   <div class="like-group" role="group">
												      <c:choose>
													     <c:when test="${postVO.post_LikeYN eq 'N'}">
													        <button type="button" style = "border : none; background-color : white;" onclick="toggleLike('${postVO.post_Seq}')">
													           <img class="likeImage_${postVO.post_Seq}" src="img/like.png" width="20px" height="20px" data-liked = "false">
													        </button>
													        <p class ="post_Like_Count_${postVO.post_Seq}" style="display: inline; margin-left: 3px; font-size : 13px;">${postVO.post_Like_Count}</p>
													     </c:when>
													     <c:otherwise>
													     	<button type="button" style = "border : none; background-color : white;" onclick="toggleLike('${postVO.post_Seq}')">
													           <img class="likeImage_${postVO.post_Seq}" src="img/unlike.png" width="20px" height="20px" data-liked = "true">
													        </button>
													        <p class ="post_Like_Count_${postVO.post_Seq}" style="display: inline; margin-left: 3px; font-size : 13px;">${postVO.post_Like_Count}</p>
													     </c:otherwise>
											          </c:choose>
												   </div>													
							                       <div>
                                                   	  <%-- 댓글 버튼 + 카운트 --%>
      					                              <div class="text-muted text-decoration-none d-flex align-items-start fw-light"><span class="material-icons md-20 me-2">chat_bubble_outline</span><span>${postVO.post_Reply_Count}</span></div>
                                                   </div>
                                                </div>
                                                <br>
                                                 
                                                <!-- 댓글 입력창 부분 (클릭시 모달창) -->
                                                <div class="d-flex align-items-center mb-3" data-bs-toggle="modal" data-bs-target="#commentModal2" onclick="replyModalseq(${postVO.post_Seq})">
                                                   <span class="material-icons bg-white border-0 text-primary pe-2 md-36">account_circle</span>
                                                   <input type="text" class="form-control form-control-sm rounded-3 fw-light" placeholder="Write Your comment">
                                                </div>
                                                
                                                <!-- 댓글 출력 부분 -->
                                                <div class="comments">
	                                               <c:set var="key" value="${status.index}"/>
	                                               <c:set var="value" value="${replyMap[key]}"/>
		                                           <c:forEach var="reply" items="${value}" begin="0" end="2">
                                                      <div class="d-flex mb-2">
                                                 	     <!-- 댓글 작성자 프로필 이미지 출력부분 -->
		                                                    <a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal2" onclick="replyModalseq(${reply.post_Seq})">
		                                                       <img src="img/uploads/profile/${profileMap[reply.member_Id]}" class="img-fluid rounded-circle profile" alt="commenters-img">
		                                                    </a>
	                                                     	<div class="ms-2 small">
	                                                           <a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal2" onclick="replyModalseq(${reply.post_Seq});">
		                                                          <div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text" style="display: inline-block;">
		                                                             <p class="fw-500 mb-0">${reply.member_Id}</p>
		                                                             <span class="text-muted">${reply.reply_Content}</span>
		                                                          </div>
		                                                       </a>
		                                                       <div class="reply-like-group" role="group" style="display: inline-block;">
		                                                          <c:set var = "replySeq" value = "${reply.reply_Seq}"/>
		                                                          <script>
		                                                             var reply_Seq = ${replySeq};
		                                                          </script>
															      <c:choose>
																     <c:when test="${reply.reply_LikeYN eq 'N'}">
																	    <button type="button" style = "border : none; background-color : white;" onclick="toggleReplyLike('${reply.post_Seq}', '${reply.reply_Seq}');">
																	       <img class="likeReplyImage_${reply.reply_Seq}" src="img/like.png" data-liked = "false">
																	    </button>
																	    <p class ="reply_Like_Count_${reply.reply_Seq}" style="display: inline; margin-left: 1px; font-size : 10px;">${reply.reply_Like_Count}</p>
																	 </c:when>
																	 <c:otherwise>
																	    <button type="button" style = "border : none; background-color : white;" onclick="toggleReplyLike('${reply.post_Seq}', '${reply.reply_Seq}');">
																	       <img class="likeReplyImage_${reply.reply_Seq}" src="img/unlike.png" data-liked = "true">
																	    </button>
																	    <p class ="reply_Like_Count_${reply.reply_Seq}" style="display: inline; margin-left: 1px; font-size : 10px;">${reply.reply_Like_Count}</p>
																	 </c:otherwise>
														          </c:choose>
															   </div>
															   <div  style="display: inline-block;" width = "5px"></div>
		                                                          <span class="small text-muted">${reply.reply_WhenDid}</span>
	                                                           <div class="d-flex align-items-center justify-content-between mb-2">
		                                                    </div>
		                                                 </div>
                                                   	  </div>
	                                               </c:forEach> <!-- 실질적인 댓글 추출 하는 반복문 -->
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </c:forEach> <!-- 게시글 출력 반복문 -->          
                              <div id="main_feed"></div>
                              <div id="loadingStop"></div>           
		                         <!-- 피드무한스크롤 -->
		                         <c:choose>
		                         	<c:when test="${fn:length(postList)<=10}">
		                         		<div id="feedEnd">
						                    <br>
						                    <h5 align="center">No Post To Show</h5>
						                    <br>
						                </div>
		                         	</c:when>
		                         	<c:otherwise>
			                         	<div class="text-center mt-4" id="feedInfinity">
										    <div class="spinner-border" role="status">
											   <span class="visually-hidden">Loading...</span>
											</div>
											<p class="mb-0 mt-2">Loading</p>
				                  		</div>  
		                         	</c:otherwise>
		                         </c:choose>		                                                                  
                           </div>
                        </div><!-- 뉴스피드 부분 -->
                        
                        <!-- people 탭 클릭시 -->                        
                        <div class="tab-pane fade" id="pills-people" role="tabpanel" aria-labelledby="pills-people-tab">
                           <h6 class="mb-3 fw-bold text-body">People Who Follow You</h6>
                           <div id="canFollowPeople-cards-container" class="bg-white rounded-4 overflow-hidden mb-4 shadow-sm"></div>
                           
                           <h6 class="mb-3 fw-bold text-body">Most Popular People</h6>
                           <div id="mostFollowPeople-cards-container" class="bg-white rounded-4 overflow-hidden mb-4 shadow-sm"></div>
                        </div>
                        
                        <!-- trending탭 클릭시 -->
                        <div class="tab-pane fade" id="pills-trending" role="tabpanel" aria-labelledby="pills-trending-tab">
                           <!-- Post Tab -->
                           <div class="input-group shadow-sm mb-3 rounded-4 overflow-hidden py-2 bg-white" data-bs-toggle="modal" data-bs-target="#postModal">
                              <span class="input-group-text material-icons border-0 bg-white text-primary">account_circle</span>
                              <input type="text" class="form-control border-0 fw-light ps-1" placeholder="What's on your mind.">
                              <a href="#" class="text-decoration-none input-group-text bg-white border-0 material-icons text-primary">add_circle</a>
                           </div>                           
                           <!-- 트랜딩 탭의 Feeds -->
                           <div class="feeds">
                              <!-- Feed Item -->                              
                              <div id="trending_feed"></div>
                              	<div id="trendingFeedInfinite"></div>
                              	<div id="trendingFeedStop"></div>
                              	<div class="text-center mt-4" id="trendFeedLoading">
				                    <div class="ms-auto" align="center">
		                               <span class="btn btn-outline-primary btn-sm px-3 rounded-pill" id="followingload" onclick="handleTrendInfinity()">+ 더보기</span>
		                            </div>
                              	</div>
                           </div><!-- class="trending" -->                        
                        </div> <!-- class="feed" -->
                     </div>
                  </div><!-- class="main container" -->
               </main> <!-- index페이지의 센터 column -->
               
               <!-- Sidebar -->
               <!-- 브라우저 창의 크기가 줄어들때 나오는 메뉴버튼을 누르면 왼쪽에서 나타나는 사이드바 -->
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
                           <c:choose>
                              <c:when test="${loginUser.member_Id eq 'admin'}">
                           	     <a href="admin_Index" class="nav-link"><img src = "img/admin_Icon.png"/><span style = "margin-left : 16px;">Admin Page</span></a>
                           	  </c:when>
                              <c:otherwise>
                           	  </c:otherwise>
                           </c:choose>
                           <li class="nav-item">
                              <a href = "profile?member_Id=${loginUser.member_Id}" class="nav-link"><img src = "img/uploads/profile/${loginUser.member_Profile_Image}" style = "width : 27px; height : 27px; border-radius : 50%; overfloiw : hidden;"> <span>&nbsp;&nbsp;&nbsp;${loginUser.member_Id}'s PROFILE</span></a>
                           </li>
                           <li class="nav-item">
                              <a href="follow?member_Id=${loginUser.member_Id}" class="nav-link"><span class="material-icons me-3">diversity_3</span> <span>follow</span></a>
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
                        </ul>
                     </div>
                  </div>
                  
                  <!-- index페이지 왼쪽 사이드바 column -->
                  <div class="ps-0 m-none fix-sidebar">
                     <div class="sidebar-nav mb-3">
                        <div class="pb-4 mb-4">
                           <a href="index" class="text-decoration-none">
                           <img src="img/logo.png" class="img-fluid logo" alt="brand-logo">
                           </a>
                        </div>
                        <ul class="navbar-nav justify-content-end flex-grow-1">
                           <li class="nav-item">
                              <a href="index" class="nav-link active"><span class="material-icons me-3">house</span> <span>Feed</span></a>
                           </li>
                           <c:choose>
                              <c:when test="${loginUser.member_Id eq 'admin'}">
                           	     <a href="admin_Index" class="nav-link"><img src = "img/admin_Icon.png"/><span style = "margin-left : 16px;">Admin Page</span></a>
                           	  </c:when>
                              <c:otherwise>
                           	  </c:otherwise>
                           </c:choose>
                           <li class="nav-item">
                              <a href = "profile?member_Id=${loginUser.member_Id}" class="nav-link"><img src = "img/uploads/profile/${loginUser.member_Profile_Image}" style = "width : 27px; height : 27px; border-radius : 50%; overfloiw : hidden;"> <span>&nbsp;&nbsp;&nbsp;${loginUser.member_Id}'s PROFILE</span></a>
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
											 <p class="fw-bold mb-0 pe-3 text-dark"><!-- 해시태그 --></p>
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
												<p class="fw-bold mb-0 pe-3 text-dark"><!-- 해시태그 --></p>
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
                  <a href="#" id="closeModal" class="text-muted text-decoration-none material-icons" data-bs-dismiss="modal">arrow_back_ios_new</a>
                  <!-- 작성자 프로필 이미지 -->
                  <img src="img/uploads/profile/${profileMap[sessionScope.loginUser.member_Id]}"  class="img-fluid rounded-circle user-img" id = "wirter" alt="profile-img">
                  <!-- 작성자 아이디 표시 -->
                  <h5 class="modal-title text-muted ms-3 ln-0" id="staticBackdropLabel">작성자: ${sessionScope.loginUser.member_Id}</h5>
               </div>
               <!-- 게시글 작성 폼 -->
               <form onsubmit="return false;" enctype="multipart/form-data" id="postInsert">
               <div class="modal-body p-0 mb-3">
               	  <!-- 입력 부분 -->
               	  <!-- 작성자 아이디 -->
               	  <input type="hidden" name="member_Id" value="${sessionScope.loginUser.member_Id}">
               	  <!-- 공개 여부 체크박스 -->
                  <label for="post_Public" class="h6 text-muted mb-0">게시글 공개 여부</label>
                  <input type="checkbox" name="post_Public" value="y" checked="checked">
               	  <!-- 게시글 내용 작성창 -->
                  <div class="form-floating">
                     <textarea class="form-control rounded-5 border-0 shadow-sm" name="post_Content" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 200px" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)"></textarea>
                     <label for="floatingTextarea2" class="h6 text-muted mb-0">게시글 내용</label>
                  </div>
                  
                  <!-- 해시태그 입력창 -->
                  <div>
                     <textarea name="post_Hashtag" class="form-control rounded-5 border-0 shadow-sm" placeholder="해시태그: #없이 입력" id="floatingTextarea2" style="height: 50px"></textarea>
                     <!-- <label for="floatingTextarea2" class="h6 text-muted mb-0">해시 태그</label> -->
                  </div>
                  <div class="d-flex justify-content-between">
                	 <button id="resetB" type="reset" class="btn btn-secondary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center">
  				 	 	<span class="material-icons me-2 md-16">refresh</span>초기화
					 </button>
                  	 <button onclick="submitForm()" id="submitButton" data-bs-dismiss="modal" class="btn btn-primary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center"><span class="material-icons me-2 md-16">send</span>Post</button>
                  </div>
               </div>
               <!-- 이미지 업로드 부분 -->
               <div class="clearfix">
			   	  <div class="inputFile">
			   	    <!-- 파일을 입력할 수 있는 +버튼 -->
			        <label for="AddImgs" class="addImgBtn">+</label>
			        <!-- 숨겨져있는 file입력창 (위 label은 이 input태그를 가리키고있다.) -->
			        <input  type="file" onchange="addFile(this);" name="uploadImgs" id="AddImgs" class="upload-hidden" accept=".png, .gif" multiple="multiple" hidden="true" max="4">
				  </div>
				  <!-- 이미지 미리보기 컨테이너 -->
				  <ul id="Preview" class="sortable"></ul>
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
      <!-- Infinite Js -->
      <script src="js/infinite.js"></script>
      <!-- Search Peple Js -->
      <script src="js/searchpeople.js"></script>
   </body>
</html>