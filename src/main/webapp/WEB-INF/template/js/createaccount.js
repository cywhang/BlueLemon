$(document).ready(function() {
	var memberIdInput = $('#member_Id');
	var idErrorMessage = $('#id_error_message');
	var duplicateResult = $('#duplicate_result');
	var memberPasswordInput = $('#member_Password');
	var passwordMessage = $('#password_message');
	var confirmPasswordInput = $('#repassword');
	var confirmPasswordMessage = $('#confirm_password_message');
	var memberNameInput = $('#member_Name');
	var nameMessage = $('#name_error_message');
	var memberEmailInput = $('#member_Email');
	var emailMessage = $('#email_error_message');
	var emailaddInput = $('#email_add')
	var memberPhoneInput = $('#member_Phone');
	var phoneMessage = $('#phone_error_message');
	var isIdChecked = false;
	var prevPassword = '';

	// 중복 체크 버튼 클릭 이벤트
	$('#check_duplicate_button').click(function() {
		
		var memberId = memberIdInput.val();

		if (memberId === "") {
			console.log("아이디가 빈칸")
	        setIdErrorMessage("아이디를 입력해주세요.", false);
	        memberIdInput.focus();
		} else if (!isIdValid(memberId)) {
			console.log("숫자로만 입력")
	        setIdErrorMessage("숫자로만 아이디 생성이 불가능합니다.영문또는 영문숫자로만 이루어진 아이디를 입력해주세요.", false);
	        
	    } else {
	    	console.log("아이디 중복 요청 실행")
	        // 중복 체크를 위한 AJAX 요청
	        $.ajax({
	            url: "checkDuplicate",
	            type: "POST",
	            data: { member_Id: memberId },
	            success: function(response) {
	                if (response === "duplicate") {
	                    setIdErrorMessage("이미 사용 중인 아이디입니다.", false);
	                } else if (response === "not-duplicate") {
	                	setIdErrorMessage("사용 가능한 아이디입니다.", true);
	                    isIdChecked = true;
	                }
	            },
	            error: function() {
	                setIdErrorMessage("중복 체크에 실패했습니다.", false);
	                isIdChecked = false;
	            }
	        });	    
	    }
	});
		
	// 아이디 유호성 함수
	function isIdValid(member_Id) {
	    var idRegex = /^(?=.*[a-zA-Z])[a-zA-Z0-9]+$/;
	    return idRegex.test(member_Id);
	}

	function setIdErrorMessage(message, isValid) {
	    idErrorMessage.text(message);

	    if (isValid) {
	        idErrorMessage.css("color", "green");
	    } else {
	        idErrorMessage.css("color", "red");
	    }
	}

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
	    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[a-zA-Z\d@$!#%*?^~&]{8,}$/;
	    return passwordRegex.test(password);
	}
		

	// Repassword 입력칸 포커스 아웃 이벤트
	confirmPasswordInput.blur(function() {
	    var password = memberPasswordInput.val();
	    var confirmPassword = confirmPasswordInput.val();

	    if (password === "") {
	        confirmPasswordMessage.text("먼저 비밀번호를 입력해주세요.");
	        confirmPasswordMessage.css("color", "red");
	        memberPasswordInput.focus();
	    } else if (password !== confirmPassword) {
	        confirmPasswordMessage.text("입력한 비밀번호와 일치하지 않습니다.");
	        confirmPasswordMessage.css("color", "red");
	    } else {
	        confirmPasswordMessage.text("입력한 비밀번호와 일치합니다.");
	        confirmPasswordMessage.css("color", "green");
	    }
	});
		
	memberNameInput.blur(function() {
		var name = memberNameInput.val();
		
		if (name === "") {
			nameMessage.text('이름을 입력해 주세요.');
			nameMessage.css("color", "red");
		} else if (!isKoreanNameValid(name)) {
			nameMessage.text('한글만 입력 가능합니다.');
			nameMessage.css("color", "red");
		} else {
			nameMessage.text('이름이 입력되었습니다.');
			nameMessage.css("color", "green");
		}
	});

	// 이름 유호성 함수	
	function isKoreanNameValid(name) {
		var koreanRegex = /^[가-힣]+$/;
		return koreanRegex.test(name);
	}
		
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
			emailMessage.text('한글 및 특수문자는 입력할수 없습니다.');
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
			phoneMessage.text('13자의 숫자만 입력해주세요.');
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
});	  
//생년월일 오늘 일자 기준 이후 날짜 선택불가
function handleDateClick() {
    var birthInput = document.getElementById("member_Birth");
    var nowUtc = Date.now();
    var timeOffset = new Date().getTimezoneOffset() * 60000;
    var today = new Date(nowUtc - timeOffset).toISOString().split("T")[0];
    birthInput.max = today;
}


	
	
	// 회원가입 폼 제출 이벤트
	function go_save() {
	  // 아이디, 비밀번호, 비밀번호 확인, 전화번호를 가져옵니다.
	  var memberId = document.getElementById("member_Id").value;
	  var password = document.getElementById("member_Password").value;
	  var memberName = document.getElementById("member_Name").value;
	  var phoneNumber = document.getElementById("member_Phone").value;

	  // 필수 항목인지 확인합니다.
	  if (memberId === "") {
	    alert("아이디를 입력해주세요.");
	    return;
	  }

	  if (password === "") {
	    alert("비밀번호를 입력해주세요.");
	    return;
	  }

	  if (phoneNumber === "") {
	    alert("전화번호를 입력해주세요.");
	    return;
	  }

	  // 모든 필수 항목이 입력되었으므로 회원가입을 진행합니다.
	  alert("회원가입이 완료되었습니다.");
	  document.getElementById("createAccount").action = "createAccount"; // 회원가입 요청 URL
	  document.getElementById("createAccount").submit();
	} 
	
