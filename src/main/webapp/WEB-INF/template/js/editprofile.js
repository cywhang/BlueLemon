$(document).ready(function() {
	
	var memberPasswordInput = $('#member_Password');
	var passwordMessage = $('#password_message');
	var confirmPasswordInput = $('#repassword');
	var confirmPasswordMessage = $('#confirm_password_message');
	var checkPasswordInput = $('#check_Password');
	var passwordErrorMessage = $('#password_error_message');
	var memberEmailInput = $('#member_Email');
	var emailMessage = $('#email_error_message');
	var emailaddInput = $('#email_add')
	var memberPhoneInput = $('#member_Phone');
	var phoneMessage = $('#phone_error_message');
	var isIdChecked = false;
	var prevPassword = '';


		// 패스워드 입력칸 포커스 아웃 이벤트
		memberPasswordInput.blur(function() {
			  var password = memberPasswordInput.val();

			  if (password === "") {
			    passwordMessage.text('비밀번호를 입력해 주세요.');
			    passwordMessage.css("color", "red");
			  } else if (!isPasswordValid(password)) {
			    passwordMessage.text("비밀번호는 최소 8자 이상이어야 하며, 영문 대소문자와 숫자를 포함해야 합니다.");
			    passwordMessage.css("color", "red");
			  } else {
			    passwordMessage.text("사용 가능한 패스워드입니다.");
			    passwordMessage.css("color", "green");
			    prevPassword = password;
			  }
			});

		function isPasswordValid(password) {
		    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[a-zA-Z\d@$!%*?&]{8,}$/;
		    return passwordRegex.test(password);
		}
		

		// Repassword 입력칸 포커스 아웃 이벤트
		confirmPasswordInput.blur(function() {
		    var password = memberPasswordInput.val();
		    var confirmPassword = confirmPasswordInput.val();

		    if (password === "") {
		        confirmPasswordMessage.text("먼저 비밀번호를 입력해주세요.");
		        confirmPasswordMessage.addClass('error-message');
		        memberPasswordInput.focus();
		    } else if (password !== confirmPassword) {
		        confirmPasswordMessage.text("입력한 비밀번호와 일치하지 않습니다.");
		        confirmPasswordMessage.addClass('error-message');
		    } else {
		        confirmPasswordMessage.text("입력한 비밀번호와 일치합니다.");
		        confirmPasswordMessage.removeClass('error-message').addClass('success-message');
		    }
		});
		
		
		// 이메일 입력칸 포커스 아웃 이벤트
		memberEmailInput.blur(function() {
		  var email = memberEmailInput.val();
		  var emailadd = emailaddInput.val();
		  
		  if (email === "") {
			  emailMessage.text('이메일ID를 입력해 주세요.');
			  emailMessage.css({
			  "color": "red",
		      "font-weight": "bold"
			  });
		  } else if (!isEmailIdValid(email))  {
			  emailMessage.text('한글은 입력할수 없습니다.');
			  emailMessage.css({
				  "color": "red",
			      "font-weight": "bold"
			  });
		  } else {
			  emailMessage.text('정상적으로 입력되었습니다.');
			  emailMessage.css({
			      "color": "green",
			      "font-weight": "normal"
			    });
		  }
		
		});
		function isEmailIdValid(emailId) {
			  var emailIdRegex = /^[a-zA-Z0-9]+$/;
			  return emailIdRegex.test(emailId);
			}
		
		// 이메일 주소 입력칸 아웃 포커스
		emailaddInput.blur(function() {
		  var emailadd = emailaddInput.val();
		  
		  if (emailadd === "") {
		    emailMessage.text('이메일 주소를 입력해주세요.');
		    emailMessage.css({
		      "color": "red",
		      "font-weight": "bold"
		    });
		  } else if (!isValidEmailAdd(emailadd)) {
		    emailMessage.text('정확한 이메일 주소를 입력해주세요.');
		    emailMessage.css({
		      "color": "red",
		      "font-weight": "bold"
		    });
		  } else {
		    emailMessage.text('정상적으로 입력되었습니다.');
		    emailMessage.css({
		      "color": "green",
		      "font-weight": "normal"
		    });
		  }
		});
		
		// email_add 유호성 함수
		function isValidEmailAdd(emailAdd) {
		  // 입력된 값이 영어와 마침표로만 구성되어 있는지 확인
		  var regex = /^[a-zA-Z.]+$/;
		  return regex.test(emailAdd);
		}
		
		// 전화번호 입력칸 아웃 포커스
		memberPhoneInput.blur(function() {
		  var phoneNumber = memberPhoneInput.val();
	
		  if (phoneNumber === "") {
		    phoneMessage.text('폰번호를 입력해주세요.');
		    phoneMessage.css("color", "red");
		  } else if (!isPhoneNumberValid(phoneNumber)) {
		    phoneMessage.text('숫자만 입력해주세요.');
		    phoneMessage.css("color", "red");
		    memberPhoneInput.focus();
		  } else {
		    phoneMessage.text('폰번호가 입력되었습니다.');
		    phoneMessage.css("color", "green");
		  }
		});

	  // 전화번호 유호성 함수
	  function isPhoneNumberValid(phoneNumber) {
		  var phoneNumberRegex = /^[0-9]{11}$/; // 하이픈 없이 숫자만 11자리 입력되어야 함
	    return phoneNumberRegex.test(phoneNumber);
	  }
	
	  
	  // 탈퇴 패스워드 입력칸 아웃 포커스 유호성 함수
   	  checkPasswordInput.blur(function() {
   	    var password = checkPasswordInput.val();
   	    
   	   //유효성 검사를 통해 패스워드가 비어있는지 확인
	   if (password === "") {
	       setPasswordErrorMessage("패스워드를 입력해주세요.", false);
	   } else {
	   // Ajax 요청을 보내고 서버의 응답을 처리합니다
	   // 비밀번호 일치 여부에 따라 메시지를 출력하거나 감춥니다
	   // 예시로 jQuery Ajax를 사용한 코드입니다
	   $.ajax({
	     url: "/checkPassword",
	     method: "POST",
	     data: { member_Password: password },
	     success: function(response) {
	       if (response === "match") {
	    	   setPasswordErrorMessage("비밀번호가 일치합니다. 탈퇴 하시겠습니까?", true);
	       } else {
	    	   PasswordErrorMessage("비밀번호가 일치하지 않습니다.", false);
	        
	       }
          
	     }
	   });
	   }
	 });
	  
});


function setPasswordErrorMessage(message, isValid) {
  passwordErrorMessage.text(message);
  
  if (isValid) {
	  passwordErrorMessage.css =("color", "green");
  } else {
	  passwordErrorMessage.css ==("color", "red");
  }
}

//	// JavaScript 코드
//	  document.addEventListener('DOMContentLoaded', function() {
//	    var birthdayInput = document.getElementById('birthday');
//	    var today = new Date();
//	    
//	    // 입력된 날짜 변경 시 이벤트 리스너 추가
//	    birthdayInput.addEventListener('change', function() {
//	      var selectedDate = new Date(birthdayInput.value);
//	      
//	      // 현재 날짜와 비교하여 이후 날짜인지 확인
//	      if (selectedDate > today) {
//	        birthdayInput.value = ''; // 선택된 날짜를 초기화
//	        alert('미래 날짜는 선택할 수 없습니다.');
//	      }
//	    });
//    
//	    // 현재 날짜 이후의 날짜 비활성화 함수
//	    function disableFutureDates() {
//	      var maxDate = today.toISOString().split('T')[0]; // 현재 날짜를 ISO 8601 형식으로 변환
//	      birthdayInput.setAttribute('max', maxDate); // max 속성 설정
//	    }
//	    
//	    disableFutureDates(); // 함수 실행하여 현재 날짜 이후의 날짜 비활성화
//	  });
//	});
	
	

// 회원 정보 수정
function go_update() {
	  // 아이디, 비밀번호, 비밀번호 확인, 전화번호를 가져옵니다.
	  var memberId = document.getElementById("member_Id").value;
	  var password = document.getElementById("member_Password").value;
	  var memberName = document.getElementById("member_Name").value;
	  var phoneNumber = document.getElementById("member_Phone").value;
	  

	  // 필수 항목인지 확인합니다.

	  if (password === "") {
	    alert("비밀번호를 입력해주세요.");
	    return;
	  }

	  if (phoneNumber === "") {
	    alert("전화번호를 입력해주세요.");
	    return;
	  }

	  // 모든 필수 항목이 입력되었으므로 회원가입을 진행합니다.
	  alert("수정이 완료되었습니다.");
	  document.getElementById("edit_profile").action = "edit_profile"; // 회원가입 요청 URL
	  document.getElementById("edit_profile").submit();
	}




// 회원 탈퇴
function go_delete(){
	
    window.location.href = "memberDelete";
}
