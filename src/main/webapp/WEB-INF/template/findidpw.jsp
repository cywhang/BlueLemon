<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
 
<style>
    /* 전체 페이지 스타일 */
     body {
   display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #eee;
}

.container {
 width: 500px;
  height: 50%;
  margin: 0 auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}



    
    .sub_title {
        margin-bottom: 20px;
    }
    
    /* 입력 폼 스타일 */
    .form-group {
        margin-bottom: 15px;
    }
    
	.custom-control-inline {
	  display: inline-block;
	}
	
	.custom-control-inline+.custom-control-inline {
	  margin-left: 10px;
	}
    
    .form-control {
        width: 200px;
        padding: 10px;
        font-size: 16px;
        border-radius: 3px;
        border: 1px solid #ccc;
    }
    
    .btn {
        display: inline-block;
        padding: 10px 20px;
        font-size: 16px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        color: #fff;
        background-color: #007bff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }
    
    .btn-primary {
        background-color: #007bff;
    }
    
    .btn-danger {
        background-color: #dc3545;
    }
     #inputName_1, #inputPhone_1 {
        width: 200px;
    }
     #inputId, #inputEmail_2 {
        width: 200px;
    }
    
    
    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .container {
            padding: 10px;
        }
        
        .form-control {
            font-size: 14px;
        }
    }
 
</style>

</head>
<body>
	
	<div class="full">
		<form action="pwdauth" id="pwdauth" method="post">
		<div class="container">
			<div class="area_inputs wow fadeIn">
				<div class="sub_title font-weight-bold text-white">
					<h3>아이디/비밀번호 찾기</h3>
					<p>인증된 이메일만 정보 찾기가 가능합니다 :)</p>
				</div>
				<div style="margin-bottom: 10px;">
					<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" class="custom-control-input" id="search_1" name="search_total" onclick="search_check(1)" checked="checked">
					<label class="custom-control-label font-weight-bold text-white"	for="search_1">Find ID</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" class="custom-control-input" id="search_2" name="search_total" onclick="search_check(2)"> 
					<label class="custom-control-label font-weight-bold text-white" for="search_2">Find Password</label>
				</div>
				<div id="searchI">
					<div class="form-group">
					
						<label class="font-weight-bold text-white" for="inputName_1">Name</label>
						<div>
							<input type="text" class="form-control" id="inputName_1" name="inputName_1" placeholder="ex) 김민수">
						</div>
					</div>
					<div class="form-group">
						<label class="font-weight-bold text-white" for="inputPhone_1">Phone</label>
						<div>
							<input type="text" class="form-control" id="inputPhone_1" name="inputPhone_1" placeholder="ex) 01077779999">
						</div>
					</div>
					
					<div class="form-group">
						<button id="searchBtn" type="button"  class="btn btn-primary btn-block">확인</button>
					<a class="btn btn-danger btn-block"	href="login">취소</a>
					</div>
				</div>
				<div id="searchP" style="display: none;">
					<div class="form-group">
						<label class="font-weight-bold text-white" for="inputId">ID</label>
						<div>
							<input type="text" class="form-control" id="inputId" name="member_Id" placeholder="ex) godmisu">
						</div>
					</div>
					<div class="form-group">
						<label class="font-weight-bold text-white" for="inputEmail_2">Email</label>
						<div>
							<input type="email" class="form-control" id="inputEmail_2"	name="member_Email" placeholder="ex) E-mail@gmail.com">
						</div>
					</div>
					<div class="form-group">
						<button id="searchBtn2" type="button" class="btn btn-primary btn-block" onclick="go_password()">확인</button>
					<a class="btn btn-danger btn-block"	href="login">취소</a>
				</div>
				</div>
			</div>
		</div>
	</div>
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="js/findInfo.js"></script>
</html>