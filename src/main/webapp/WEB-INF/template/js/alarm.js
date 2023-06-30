
function clickAlarm(alarm_kind , alarm_Seq, post_Seq, reply_Seq, to_Mem){
	
	var alarm_kind = alarm_kind;
	var post_Seq = post_Seq;
	var reply_Seq = reply_Seq;
	var to_Mem = to_Mem;
	
	var data = {
			alarm_Seq: alarm_Seq
	};
	
	$.ajax({
	    url: "/blue/deleteAlarm",
	    type: "POST",
	    dataType: "json",
	    contentType: "application/json",
	    data: JSON.stringify(data),
	    success: function (response) {
	    	
	    	if(alarm_kind == 1){
	    		window.location.href="/blue/follow?member_Id=" + to_Mem;
	    	}else if(alarm_kind == 2){
	    		alarmPostView(post_Seq);
	    	}else if(alarm_kind == 3){
	    		alarmPostView(post_Seq);
	    	}else if(alarm_kind == 4){
	    		alarmPostView(post_Seq);
	    	}else if(alarm_kind == 5){
	    		window.location.href="/blue/contact";
	    	};
	    	
	    },
	    error : function(request,status,error){
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	  });
	}



function alarmPostView(post_Seq) {
	
	console.log("알림 포스트 생성 실행");
	
	var data = {
			post_Seq: post_Seq
	};

$.ajax({
   url: "selectOnePost",
   type: "POST",
   dataType: "json",
   contentType: "application/json",
   data: JSON.stringify(data),

   success: function (response) {
	   
	   console.log("실행중")

 	   var PostVO = response.postVO;
       var reply = response.replylist;
       var hash = response.hash;
       var profileMap = response.profileMap;
       var session_Id = response.session_Id;
       
       var feed = document.getElementById("firstShowMainFeed");
       
       //안에 있는 거 싹 삭제
       feed.innerHTML = "";

       var html = "";

           html += '<div class="bg-white p-3 feed-item rounded-4 mb-3 shadow-sm">';
           html += '   <div class="d-flex">';
           html += '      <img src="img/uploads/profile/'+ profileMap[PostVO.member_Id] + '"  class="img-fluid rounded-circle user-img" alt="profile-img">';
           html += '      <div class="d-flex ms-3 align-items-start w-100">';
           html += '         <div class="w-100">';
           html += '            <div class="d-flex align-items-center justify-content-between">';
           html += '               <a href="profile?member_Id=' + PostVO.member_Id + '" class="text-decoration-none">';
           html += '                  <h6 class="fw-bold mb-0 text-body" style="font-size: 26px;">' + PostVO.member_Id + '</h6>';
           html += '               </a>';
           html += '               <div class="d-flex align-items-center small">';
           html += '                  <p class="text-muted mb-0">' + PostVO.post_Date + '</p>';

           if(session_Id == PostVO.member_Id){
					html += '                <div class="dropdown">';
                    html += '                  <a href="#" class="text-muted text-decoration-none material-icons ms-2 md-20 rounded-circle bg-light p-1" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">more_vert</a>';
                    html += '                  <ul class="dropdown-menu fs-13 dropdown-menu-end" aria-labelledby="dropdownMenuButton1">';
                    html += '                    <li><a class="dropdown-item text-muted editbutton" data-bs-toggle="modal" data-bs-target="#postModal2" onclick="postEditView(' + PostVO.post_Seq + ')"><span class="material-icons md-13 me-1">edit</span>Edit</a></li>';
                    html += '                    <li><a class="dropdown-item text-muted deletebutton" onclick="deletePost(' + PostVO.post_Seq + ')"><span class="material-icons md-13 me-1">delete</span>Delete</a></li>';
                    html += '                  </ul>';
                    html += '                </div>';
				}else{

				};

           html += '               </div>';
           html += '            </div>';
           html += '            <div class="my-2">';
           html += '               <p class="text-dark">' + PostVO.post_Content + '</p>';
           html += '               <br>';
           
             if(hash == null){

             }else{
            	 
          	  for(var j=0; j<hash.length; j++){
          		  var Tag = hash[j]
             		html += '               <a href="search_HashTag?tag_Content=' + Tag.tag_Content + '" class="mb-3 text-primary">#' + Tag.tag_Content + '</a>';
          	  }
             }

           html += '               <a id="openModalBtn" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal" onclick="modalseq(' + PostVO.post_Seq + ')">';


           if(PostVO.post_Image_Count == 0){
           	html += '                        <br>';
           }else{
           	html += '                        <img src="img/uploads/post/' + PostVO.post_Seq + '-1.png" class="img-fluid rounded mb-3" alt="post-img">';
           }


           html += '               </a>';
           html += '               <div class="d-flex align-items-center justify-content-between mb-2">';
           html += '                  <div class="like-group" role="group">';

           if(PostVO.post_LikeYN == "Y"){
               html += '                           <button type="button" style = "border : none; background-color : white;" onclick="toggleLike(' + PostVO.post_Seq + ')">';
               html += '                              <img class="likeImage_' + PostVO.post_Seq + '" src="img/unlike.png" width="20px" height="20px" data-liked = "true">';
               html += '                           </button>';
               html += '                              <p class ="post_Like_Count_' + PostVO.post_Seq + '" style="display: inline; margin-left: 3px; font-size : 13px;">' + PostVO.post_Like_Count + '</p>';

           }else{
               html += '                           <button type="button" style = "border : none; background-color : white;" onclick="toggleLike(' + PostVO.post_Seq + ')">';
               html += '                              <img class="likeImage_' + PostVO.post_Seq + '" src="img/like.png" width="20px" height="20px" data-liked = "false">';
               html += '                           </button>';
               html += '                              <p class ="post_Like_Count_' + PostVO.post_Seq + '" style="display: inline; margin-left: 3px; font-size : 13px;">' + PostVO.post_Like_Count + '</p>';
           }

           html += '                           </div>';
           html += '                          		<div>';
           html += '                           		<div class="text-muted text-decoration-none d-flex align-items-start fw-light"><span class="material-icons md-20 me-2">chat_bubble_outline</span><span>' + PostVO.post_Reply_Count + '</span></div>';		
           html += '								</div>';
           html += '							</div>';
           html += '							<div class="d-flex align-items-center mb-3" data-bs-toggle="modal" data-bs-target="#commentModal2" onclick="replyModalseq(' + PostVO.post_Seq + ')">';
           html += '								<span class="material-icons bg-white border-0 text-primary pe-2 md-36">account_circle</span>';
           html += '								<input type="text" class="form-control form-control-sm rounded-3 fw-light" placeholder="Write Your comment">';
           html += '							</div>';

           html += '							<div class="comments">';


           //html += '								<c:set var="key" value="' + i + '"/>';
           //html += '								<c:set var="value" value="' + replyMap[i] + '"/>';
           //html += '								<c:forEach var="reply" items="' + value + '" begin="0" end="2">';

           var reply

           for(j=0; j<=2; j++){
				var replyVO = reply[j];


           if(replyVO == null){

           }else{



           html += '									<div class="d-flex mb-2">';
           html += '										<a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal2" onclick="replyModalseq(' + replyVO.post_Seq + ')">';
           html += '										<img src="img/uploads/profile/' + profileMap[replyVO.member_Id] + '" class="img-fluid rounded-circle profile" alt="commenters-img">';
           html += '										</a>';
           html += '										<div class="ms-2 small">';
           html += '											<a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal2" onclick="replyModalseq(' + replyVO.post_Seq + ');">';
           html += '											<div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text" style="display: inline-block;">';
           html += '												<p class="fw-500 mb-0">' + replyVO.member_Id + '</p>';
           html += '												<span class="text-muted">' + replyVO.reply_Content + '</span>';
           html += '											</div>';
           html += '											</a>';
           html += '											<div class="reply-like-group" role="group" style="display: inline-block;">';

           //html += '												<c:set var="replySeq" value="' + reply.reply_Seq + '"/>';

           if(replyVO.reply_LikeYN == 'N'){
           	html += '														<button type="button" style="border: none; background-color: white;" onclick="toggleReplyLike(\'' + replyVO.post_Seq + '\', \'' + replyVO.reply_Seq + '\');">';
               html += '														<img class="likeReplyImage_' + replyVO.reply_Seq + '" src="img/unlike.png" data-liked="false">';
               html += '														</button>';
               html += '														<p class="reply_Like_Count_' + replyVO.reply_Seq + '" style="display: inline; margin-left: 1px; font-size: 10px;">' + replyVO.reply_Like_Count + '</p>';
           }else{
               html += '														<button type="button" style="border: none; background-color: white;" onclick="toggleReplyLike(\'' + replyVO.post_Seq + '\', \'' + replyVO.reply_Seq + '\');">';
               html += '														<img class="likeReplyImage_' + replyVO.reply_Seq + '" src="img/like.png" data-liked="true">';
               html += '														</button>';
               html += '														<p class="reply_Like_Count_' + replyVO.reply_Seq + '" style="display: inline; margin-left: 1px; font-size: 10px;">' + replyVO.reply_Like_Count + '</p>';
           }

           html += '											</div>';
           html += '											<div style="display: inline-block;" width="5px"></div>';
           html += '												<span class="small text-muted">' + replyVO.reply_WhenDid + '</span>';
           html += '											</a>';
           html += '												<div class="d-flex align-items-center justify-content-between mb-2">';
           html += '												</div>';
           html += '											</div>';
           html += '										</div>';

       		}	

           }

           html += '									</div>';
           html += '								</div>';
           html += '							</div>';
           html += '						</div>';
           html += '					</div>';
           html += '				</div>';
           html += '			</div>';
           
           html += '<div id="feedEnd">';
           html += '          <br>';
           html += '          <h5 align="center">No Post To Show</h5>';
           html += '          <br>';
           html += '      </div>';
           

           feed.innerHTML += html;
           html = "";


           }
	,error: function(xhr, status, error) {
       console.error(error);
   }
});
}