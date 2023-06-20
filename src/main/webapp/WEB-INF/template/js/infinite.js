/**
 *  인피니트 스크롤을 구현하기 위한 js
 */

function followingload(followingTotalPageNum, followingPageNum){
	
	var followingTotalPageNum = followingTotalPageNum
	
	// 요청 바디에 전송할 데이터 설정
    var data = {
    	followingTotalPageNum : followingTotalPageNum,
    	followingPageNum : followingPageNum
    };

	$.ajax({
	    url: "/blue/moreLoadFollowing",
	    type: "POST",
	    dataType: "json",
	    contentType: "application/json",
	    data: JSON.stringify(data),

	    success: function (response) {
	      
	     console.log(response);
	     
	  // 데이터 맵에서 값 가져오기
	      var following_info = response.following_info;
	      var following_size = response.following_size;
	      var followingPageNum = response.followingPageNum;
	      var followingTotalPageNum = response.followingTotalPageNum;

	      // HTML 생성을 위한 변수
	      var html = '';
	      
	      // following_info를 순회하며 HTML 생성
	      for (var i = 0; i < following_size; i++) {
	        var memberVO = following_info[i];
	        html += '<a href="profile" class="p-3 d-flex text-dark text-decoration-none account-item pf-item">';
	        html += '<img src="img/uploads/profile/' + memberVO.member_Profile_Image + '" class="img-fluid rounded-circle me-3" alt="profile-img">';	        html += '<div>';
	        html += '<p class="fw-bold mb-0 pe-3 d-flex align-items-center">' + memberVO.member_Id + '</p>'
	        html += '<div>';
	        html += '<p class="text-muted fw-light mb-1 small">' + memberVO.member_Name + '</p>';
	        html += '<span class="d-flex align-items-center small">' + '' + '/' + memberVO.member_Gender + '/' + memberVO.member_Email + '</span>';
	        html += '</div>';
	        html += '</div>';
	        html += '<div class="ms-auto">';
	        html += '<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">';
	        html += '<input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck' + memberVO.member_Id + '2" checked>';
	        html += '<label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck' + memberVO.member_Id + '2" onclick="changeFollowing(\'' + memberVO.member_Id + '\')">';
	        html += '<span class="following d-none">Following</span><span class="follow">+ Follow</span></label>';
	        html += '</div>';
	        html += '</div>';
	        html += '</a>';
	      }

	      
	      // HTML 요소에 추가
	      var container = document.getElementById("followingContainer");
	      container.innerHTML += html;

	      // "더보기" 버튼 추가 여부 결정
	      var loadButton = document.getElementById("followingloadButton");
	      var loadButtonHTML = '';
	      
	      if (followingPageNum >= followingTotalPageNum) {
	    	  console.log(followingPageNum);
	    	  console.log(followingTotalPageNum);
	        loadButtonHTML = '';
	      } else {
	        loadButtonHTML = '<div class="ms-auto" align="center">';
	        loadButtonHTML += '<span class="btn btn-outline-primary btn-sm px-3 rounded-pill" id="load" onclick="followingload(\'' + followingTotalPageNum + '\', \'' + followingPageNum + '\')">+ 더보기</span>';
	        loadButtonHTML += '</div>';
	      }
	      loadButton.innerHTML = loadButtonHTML;
	    },
	    error : function(request,status,error){
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	  });
	}

function followerload(followerTotalPageNum, followerPageNum) {
	  var data = {
	    followerTotalPageNum: followerTotalPageNum,
	    followerPageNum: followerPageNum
	  };

	  console.log(followerTotalPageNum);
	  console.log(followerPageNum);
	  console.log(data);

	  $.ajax({
	    url: "/blue/moreLoadFollower",
	    type: "POST",
	    dataType: "json",
	    contentType: "application/json",
	    data: JSON.stringify(data),

	    success: function (response) {
	      
	     console.log(response);
	     
	  // 데이터 맵에서 값 가져오기
	      var follower_info = response.follower_info;
	      var follower_size = response.follower_size;
	      var followerPageNum = response.followerPageNum;
	      var followerTotalPageNum = response.followerTotalPageNum;
	      var following_Id = response.following_Id;
	      var following_size = response.following_size;
	      
	      console.log(followerPageNum);
	      
	      // HTML 생성을 위한 변수
	      var html = '';
	      
	      // follower_info를 순회하며 HTML 생성
	      for (var i = 0; i < follower_size; i++) {
	        var memberVO = follower_info[i];
	        html += '<a href="profile" class="p-3 d-flex text-dark text-decoration-none account-item pf-item">';
	        html += '<img src="img/uploads/profile/' + memberVO.member_Profile_Image + '" class="img-fluid rounded-circle me-3" alt="profile-img">';	        html += '<div>';
	        html += '<p class="fw-bold mb-0 pe-3 d-flex align-items-center">' + memberVO.member_Id + '</p>';
	        html += '<div>';
	        html += '<p class="text-muted fw-light mb-1 small">' + memberVO.member_Name + '</p>';
	        html += '<span class="d-flex align-items-center small">' + '' + '/' + memberVO.member_Gender + '/' + memberVO.member_Email + '</span>';
	        html += '</div>';
	        html += '</div>';
	        html += '<div class="ms-auto">';
	        html += '<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">';
	        var exist = 0;
	        
	        for(var j = 0; j < following_size; j++){
	        		
	        	var followingId = following_Id[j]
	        	
	        	if(memberVO.member_Id === followingId.following){
	        			exist = 1;
	        		}
	        	}
	        if(exist === 0){
	        	html += '<input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck' + memberVO.member_Id + '2">';
	        }else if(exist === 1){
	        	html += '<input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck' + memberVO.member_Id + '2" checked>';
	        }
	        html += '<label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck' + memberVO.member_Id + '2" onclick="changeFollow(\'' + memberVO.member_Id + '\')">';
	        html += '<span class="following d-none">Following</span><span class="follow">+ Follow</span></label>';
	        html += '</div>';
	        html += '</div>';
	        html += '</a>';
	      }

	      // HTML 요소에 추가
	      var container = document.getElementById("followerContainer");
	      container.innerHTML += html;
	      
	      // "더보기" 버튼 추가 여부 결정
	      var loadButton = document.getElementById("followerloadButton");
	      var loadButtonHTML = '';
	      
	      if (followerPageNum >= followerTotalPageNum) {
	    	  console.log(followerPageNum);
	    	  console.log(followerTotalPageNum);
	        loadButtonHTML = '';
	      } else {
	        loadButtonHTML = '<div class="ms-auto" align="center">';
	        loadButtonHTML += '<span class="btn btn-outline-primary btn-sm px-3 rounded-pill" id="load" onclick="follwerload(\'' + followerTotalPageNum + '\', \'' + followerPageNum + '\')">+ 더보기</span>';
	        loadButtonHTML += '</div>';
	      }
	      loadButton.innerHTML = loadButtonHTML;
	    },
	    error : function(request,status,error){
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	  });
	}



