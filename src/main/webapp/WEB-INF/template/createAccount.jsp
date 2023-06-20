<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
   <head>
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
   <script src="js/createaccount.js"></script>
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
</script>		
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="icon" type="image/png" href="img/logo.png">
      <title>Vogel - Social Network & Community HTML Template</title>
      <meta name="description" content="Vogel - Social Network & Community HTML Template">
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
   <body class="bg-light">
      <div class="theme-switch-wrapper ms-3">
         <label class="theme-switch" for="checkbox">
            <input type="checkbox" id="checkbox">
            <span class="slider round"></span>
            <i class="icofont-ui-brightness"></i>
         </label>
         <em>Enable Dark Mode!</em>
      </div>
      <div class="py-4">
      <div class="container">
         <div class="row position-relative">
            <!-- Main Content -->
            <main class="col col-xl-6 order-xl-2 col-lg-12 order-lg-1 col-md-12 col-sm-12 col-12">
            <form id="create_form" method="post" action="create_form" enctype="multipart/form-data">
               <div class="main-content">
                  <div class="mb-5">
                     <header class="profile d-flex align-items-center">
                        <img alt="#" src="img/rmate2.jpg" class="rounded-circle me-3">
                        <div>
                           <span class="text-muted text_short">WELCOME SIGN UP</span>
                           <h4 class="mb-0 text-dark"><span class="fw-bold">AskBootstrap</span></h4>
                        </div>
                     </header>
                  </div>
                  <!-- Feeds -->
                  <div class="feeds">
                     <!-- Feed Item -->
                     <div class="bg-white p-4 feed-item rounded-4 shadow-sm mb-3 faq-page">
                        <div class="mb-3">
                           <h5 class="lead fw-bold text-body mb-0">Create Account</h5>
                        </div>
                        <div class="row justify-content-center">
                           <div class="col-lg-12">
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="text" class="form-control rounded-5" id="member_Id" name="member_Id" placeholder="#">
                                    <button type="button" class="btn btn-primary rounded-5 w-50 text-decoration-none py-3 fw-bold text-uppercase m-0" 
                                    	id="check_duplicate_button">중복 체크</button>
									<span id="id_error_message" class="error-message"></span>
									<span id="duplicate_result"></span>
                                    <label for="floatingssName">ID</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="password" name="member_Password" class="form-control rounded-5" id="member_Password" placeholder="#">
                                    <span id="password_message" class="error-message"></span>
                                    <label for="floatingssName">PASSWORD</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="password" name="repassowrd" class="form-control rounded-5" id="repassword" placeholder="#">
                                    <span id="confirm_password_message" class="error-message"></span>
                                    <label for="floatingssName">REPASSWORD</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-end">
                                    <input type="text" class="form-control rounded-5" id="member_Name" name="member_Name" placeholder="#">
                                    <span id="name_error_message" class="error-message"></span>
                                    <label for="floatingssName">NAME</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="text" class="form-control rounded-5" name="member_Email" id="member_Email" placeholder="#">@
                                    <input type="text" class="form-control rounded-5" name="email_add" id="email_add">
                                    <span id="email_error_message" class="error-message"></span>
                                    <label for="floatingEmail">EMAIL</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="text" class="form-control rounded-5" name="member_Phone" id="member_Phone" placeholder="#">
                                    <span id="phone_error_message" class="error-message"></span>
                                    <label for="floatingEmail">PHONE</label>
                                 </div>
                                 <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="date" class="form-control rounded-5" name="member_Birthday" id="member_Birth" >
                                    <label for="floatingBirth">DATE OF BIRTH</label>
                                 </div>
                                 <label class="mb-2 text-muted small">GENDER</label>
                                 <div class="d-flex align-items-center mb-3 px-0">
                                    <div class="form-check">
                                       <input class="form-check-input" type="radio" value="M" name="member_Gender" id="male">
                                       <label class="form-check-label" for="male">
                                       Male
                                       </label>
                                    </div>
                                    <div class="form-check mx-3">
                                       <input class="form-check-input" type="radio" value="F" name="member_Gender" id="female">
                                       <label class="form-check-label" for="female">
                                       Female
                                       </label>
                                    </div>
	                                <div class="form-floating mb-3 d-flex align-items-center">
	                                    <input type="text" name="member_Country" class="form-control rounded-5" name="member_Country" id="member_Country" placeholder="#">
	                                    <label for="floatingBirth">Country</label>
	                                </div>
	                                <div class="form-floating mb-3 d-flex align-items-center">
	                                    <input type="text" name="member_Mbti" class="form-control rounded-5" name="member_Mbti" id="member_Mbti" placeholder="#">
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
                                 
                                 <div class="d-grid">
                                    <button class="btn btn-primary rounded-5 w-100 text-decoration-none py-3 fw-bold text-uppercase m-0" onclick ="go_save()">SAVE</button>
                                 </div>
                              </form>
                           </div>
                        </div>
                     </div>
                     <!--  
                     <div class="bg-white p-4 feed-item rounded-4 shadow-sm faq-page mb-3">
                        <div class="mb-3">
                           <h5 class="lead fw-bold text-body mb-0">User withdrawal
                           </h5>
                           <p class="mb-0">Please enter your password in order to get this.
                           </p>
                        </div>
                        <div class="row justify-content-center">
                           <div class="col-lg-12">
                              <form action="profile">
                                 <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="password" class="form-control rounded-5" id="floatingPass" placeholder="password">
                                    <label for="floatingPass">PASSWORD</label>
                                 </div>
                                 <div class="d-grid">
                                    <button class="btn btn-primary w-100 text-decoration-none rounded-5 py-3 fw-bold text-uppercase m-0">Withdrawal</button>
                                 </div>
                           </div>
                        </div>
                     </div>
                     -->
      <!-- Jquery Js -->
      <script src="vendor/jquery/jquery.min.js"></script>
      <!-- Bootstrap Bundle Js -->
      <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
      <!-- Custom Js -->
      <script src="js/custom.js"></script>
      <!-- Slick Js -->
      <script src="vendor/slick/slick/slick.min.js"></script>
      </form>
   </body>
</html>