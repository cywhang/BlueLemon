
                                             /*  게시글 등록 처리    */

// 해시태그
const input = document.querySelector('textarea[name=post_Hashtag]');

let tagify = new Tagify(input); // initialize Tagify

// 태그가 추가되면 이벤트 발생
tagify.on('add', function() {
  console.log(tagify.value); // 입력된 태그 정보 객체
})

// 게시글 작성 변수들
var fileNo = 0;
var filesArr = new Array();




// 추가로 업로드한 이미지 개수
var editFileNo = 0;
// 추가로 업로드한 파일들을 담은 배열
var editFilesArr = new Array();

// 기존에 업로드된 이미지 개수
var alreadyFileNo = 0;
// 기존에 업로드된 이미지 배열
var alreadyFileArr = new Array();

// 실시간으로 업로드된 이미지 갯수
var currentEditFileNo = 0;

// 추가이미지 현황을 유지하기 위한 전역변수 변경
function editVariable(neweditFileArr, neweditFileNo){
	editFileNo = neweditFileNo;
	editFilesArr = neweditFileArr;
	
	console.log("추가 업로드 이미지  정보 배열: ", neweditFileArr);
	console.log("추가 업로드 이미지 length : ", neweditFileNo);
}

// 기존이미지 현황을 유지하기 위한 전역변수 변경
function alreadyVariable(newalreadyFileArr, newalreadyFileNo) {
	  // 기존 이미지 개수
	  alreadyFileNo = newalreadyFileNo;
	  // 기존 이미지 정보 배열
	  alreadyFileArr = newalreadyFileArr;
	  // 기존 이미지 개수를 현재 이미지 개수로 저장한다.
	  currentEditFileNo = newalreadyFileNo;
	  // 변경된 전역 변수 값을 확인
	  console.log("기존 업로드 이미지 length : ", newalreadyFileNo);
	  console.log("기존 업로드 이미지 배열 : ", newalreadyFileArr);
	}
function currentVariable(newEditFileNo) {
	// 전역 변수 값 변경
	currentEditFileNo = newEditFileNo;
	// 변경된 전역 변수 값을 확인
	console.log("현재 업로드 이미지 length : ", newEditFileNo);
}


// 이미지 업로드
$(function() {
  // 드래그 앤 드롭
  $(".sortable").sortable();	
  
  // 글 작성 모달창 뒤로가기 버튼시 내용 초기화
  $('#closeModal').on('click', function() {
	    // form 태그 초기화
	    $('#postInsert')[0].reset();
	    console.log("postInsert.reset");
	    // 이미지 컨테이너 초기화
	    $('#Preview').empty();
	    console.log("Preview.reset");
	    // 실제 이미지 배열 초기화
	    filesArr = [];
	    console.log("fileArr 비우기 ");
	});
  
  // 글 수정 모달창 뒤로가기 버튼시 내용 초기화
  $('#closeEditModal').on('click', function() {
	    // form 태그 초기화
	    $('#postUpdate')[0].reset();
	    console.log("postUpdate.reset");
	    // 이미지 컨테이너 초기화
	    $('#editPreview').empty();
	    console.log("editPreview.reset");
	    
	    
	    // 실제 이미지 배열 초기화
	    editFilesArr = [];
	    console.log("editFileArr 비우기 ");
	});
  
  // 초기화 버튼 클릭시 내용 초기화
  $('#resetB').on('click', function() {
	    // 이미지 컨테이너 초기화
	    $('#Preview').empty();
	});
  
  
});
	//특수문자 입력 방지            %%%%%% 아직 안됨 %%%%%%%%%ㄴ
	function characterCheck(obj) {
	  var regExp = /[<>'#]/g; // 허용하지 않을 특수문자 패턴 설정
	  if (regExp.test(obj.value)) {
	    alert("#, <, > 문자는 입력하실 수 없습니다.");
	    obj.value = obj.value.replace(regExp, ''); // 특수문자 제거
	  }
	}

  
  // 게시글 인서트
  /* 첨부파일 추가 */
  function addFile(obj){
      var maxFileCnt = 4;   // 첨부파일 최대 개수
      console.log("첨부파일 최대 개수 : ", maxFileCnt);
      var attFileCnt = $('.filebox').length;    // 기존 추가된 첨부파일 개수
      console.log("기존 추가된 첨부파일 개수 : ", attFileCnt);
      var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
      console.log("추가로 첨부가능한 개수 : ", remainFileCnt);
      var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수
      console.log("현재 선택된 첨부파일 개수 : ", curFileCnt);
      // 첨부파일 개수 확인
      if (curFileCnt > remainFileCnt) {
          alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
      } else {
          for (const file of obj.files) {
              // 첨부파일 검증
              if (validation(file)) {
                  // 파일 배열에 담기
                  var reader = new FileReader();
                  reader.onload = function (e) {
                	  var imageData = e.target.result; // 파일 데이터
                      filesArr.push(file);
                      console.log("filesArr : ", filesArr);
                      
                      let htmlData = '';
                      htmlData += '<li id="file' + fileNo + '" class="filebox ui-state-default">';
                      htmlData += '   <img src="' + imageData  + '" width="80" height="80">';
                      htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');"><span class="delBtn">x</span></a>';
                      htmlData += '</li>';
                      
                      $('#Preview').append(htmlData);
                      fileNo++;
                      
                  };
                  reader.readAsDataURL(file);
                  // 목록 추가
                  
              } else {
                  continue;
              }
          }
      }
      // 초기화
      document.querySelector("input[type=file]").value = "";
  }
  
  /* 게시글 작성 첨부파일 삭제 */
  function deleteFile(num) {
      document.querySelector("#file" + num).remove();
      filesArr[num].is_delete = true;
      console.log(num, " 파일 삭제");
  }
  
  
  // 게시글 수정
  /* 첨부파일 추가 */
  function editFile(obj){
      var maxFileCnt = 4;   // 첨부파일 최대 개수
      console.log("첨부파일 최대 개수 : ", maxFileCnt);
      
      var attFileCnt = $('.editfilebox').length;    // 기존 추가된 첨부파일 개수
      console.log("기존 추가된 첨부파일 개수 : ", attFileCnt);
      
      var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
      console.log("추가로 첨부가능한 개수 : ", remainFileCnt);
      
      var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수
      console.log("현재 선택된 첨부파일 개수 : ", curFileCnt);
      
      // 첨부파일 개수 확인
      if (curFileCnt > remainFileCnt) {
          alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
      } else {
          for (const file of obj.files) {
              // 첨부파일 검증
              if (validation(file)) {
                  // 파일 배열에 담기
                  var reader = new FileReader();
                  reader.onload = function (e) {
                	  var imageData = e.target.result; // 파일 데이터
                	  editFilesArr.push(file);
                      console.log("editFilesArr : ", editFilesArr);
                      
                      let htmlData = '';
                      htmlData += '<li id="file' + currentEditFileNo + '" class="editfilebox ui-state-default">';
                      htmlData += '   <img src="' + imageData  + '" width="80" height="80">';
                      htmlData += '   <a class="delete" onclick="deleteEditFile(' + currentEditFileNo + ');"><span class="delBtn">x</span></a>';
                      htmlData += '</li>';
                      
                      $('#editPreview').append(htmlData);
                      currentEditFileNo++;
                      console.log("후 currentEditFileNo", currentEditFileNo);
                      currentVariable(currentEditFileNo);
                  };
                  reader.readAsDataURL(file);
                  // 목록 추가
                  
                  editVariable(editFilesArr, (editFileNo+1));
              } else {
                  continue;
              }
          }
      }
      // 초기화
      document.querySelector("input[type=file]").value = "";
      
      // 현재 이미지가 몇 개 업로드되었는지 반환해주는 부분
	  var attFileCnt = $('.editfilebox').length;
	  // 다음 이미지 추가시 부여할 fileNo를 전역변수 변경
	  currentVariable(attFileCnt);
  }
  
  
  var deletedStrings = []; // 삭제된 문자열을 저장할 배열
  
  /* 새롭게 추가된 이미지 삭제 */
  function deleteEditFile(num) {
	  // 미리보기 컨테이너에서 이미지를 지움.
	  document.querySelector("#file" + num).remove();
	  
	  var item = editFilesArr[num];
	  console.log("삭제된 아이템: ",item);
	  item.is_delete = true; // is_delete 속성을 true로 설정
	  // 삭제한 파일 콘솔에 출력해줌.
	  console.log(num, " 파일 삭제");

	  // 기존 이미지 순번 다시 정렬
	  for (var i = num + 1; i < currentEditFileNo; i++) {
	    var li = document.querySelector("#file" + i);
	    if (li) {
	      li.id = "file" + (i - 1);
	      console.log("순서 다시 정렬함");
	      // 삭제 버튼의 onclick 속성 업데이트
	      var deleteBtn = li.querySelector('.delete');
	      if (deleteBtn) {
	    	  deleteBtn.setAttribute('onclick', 'deleteEditFile(' + (i - 1) + ');');
	      }
	    }
	  }
	  
	  // 현재 이미지가 몇 개 업로드되었는지 반환해주는 부분
	  var attFileCnt = $('.editfilebox').length;
	  // 다음 이미지 추가시 부여할 fileNo를 전역변수 변경
	  currentVariable(attFileCnt);
	}

  
  /* 기존 이미지 삭제 */
  function deleteAlreadyFile(num){
	  // 미리보기 컨테이너에서 이미지를 지움.
	  document.querySelector("#file" + num).remove();
	  
	  var item = alreadyFileArr[num];
	  deletedStrings.push(item); // 삭제한 기본 이미지 정보 배열에 따로 저장
	  // 삭제한 파일 콘솔에 출력해줌.
	  console.log(num, " 아이템 삭제");

	  // 순번 다시 정렬
	  for (var i = num + 1; i < alreadyFileNo; i++) {
	    var li = document.querySelector("#file" + i);
	    if (li) {
	      li.id = "file" + (i - 1);
	      console.log("순서 다시 정렬함");
	      // 삭제 버튼의 onclick 속성 업데이트
	      var deleteBtn = li.querySelector('.delete');
	      if (deleteBtn) {
	    	  deleteBtn.setAttribute('onclick', 'deleteAlreadyFile(' + (i - 1) + ');');
	      }
	    }
	  }
	  
	  // 순번 다시 정렬
	  for (var i = alreadyFileNo; i < currentEditFileNo; i++) {
		  var li = document.querySelector("#file" + i);
		  if (li) {
			  li.id = "file" + (i - 1);
			  console.log("순서 다시 정렬함");
			  // 삭제 버튼의 onclick 속성 업데이트
			  var deleteBtn = li.querySelector('.delete');
			  if (deleteBtn) {
				  deleteBtn.setAttribute('onclick', 'deleteEditFile(' + (i - 1) + ');');
			  }
		  }
	  }
	  
	  // 현재 이미지가 몇 개 업로드되었는지 반환해주는 부분
	  var attFileCnt = $('.editfilebox').length;
	  // 다음 이미지 추가시 부여할 fileNo를 전역변수 변경
	  currentVariable(attFileCnt);
  }
  
  /* 첨부파일 검증 */
  function validation(obj){
      const fileTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
      if (obj.name.length > 100) {
          alert("파일명이 100자 이상인 파일은 제외되었습니다.");
          return false;
      } else if (obj.size > (100 * 1024 * 1024)) {
          alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
          return false;
      } else if (obj.name.lastIndexOf('.') == -1) {
          alert("확장자가 없는 파일은 제외되었습니다.");
          return false;
      } else if (!fileTypes.includes(obj.type)) {
          alert("첨부가 불가능한 파일은 제외되었습니다.");
          return false;
      } else {
          return true;
      }
  }
  
  
  
  // preview컨테이너에 변경된 순서 정보를 담는 작업
  var fileList = [];
	$('#Preview').on('sortupdate', function(event, ui) {
		newFileList = [];
		$('#Preview li').each(function() {
			var fileId = $(this).attr('id'); // 파일의 고유 ID
			newFileList.push(fileId);
		});
		// 이미지 순서 변경이 있을 때만 fileList에 할당
		fileList = newFileList.length > 0 ? newFileList : null;
		// fileList 배열에 변경된 파일 순서 정보가 포함됩니다.
		console.log(fileList);
	});
	
	
  /* 폼 전송 */
  function submitForm() {
      // 폼데이터 담기
      var form = document.getElementById("postInsert");
      var formData = new FormData(form);
      // 삭제되지 않은 파일만 폼데이터에 담기
      for (var i = 0; i < filesArr.length; i++) {
          if (!filesArr[i].is_delete) {
              formData.append("attach_file", filesArr[i]);
          }
      }
      // 최종적으로 순서가 변경된 정보를 formData에 담음
      for (var i = 0; i < fileList.length; i++) {
          formData.append("fileList[]", fileList[i]);
      }
      console.log(filesArr);
      
      $.ajax({
          method: 'POST',
          url: 'insertPost',
          enctype: "multipart/form-data", //form data 설정
          data: formData,
          contentType: false,
          processData: false,
          async: true,
          timeout: 30000,
          cache: false,
          headers: {'cache-control': 'no-cache', 'pragma': 'no-cache'},
          success: function (response) {
        	  window.location.href = '/blue/index'
          }
      });
  }

  											/*  게시글 수정 처리    */
//edit action
function postEditAction(post_Seq){
	
	
	// url = postEditAction
	// method = POST
	var form = document.getElementById("postUpdate");
    var formData = new FormData(form);
    formData.append("post_Seq", post_Seq);
    
    // 기존 이미지 파일중 삭제한 파일 정보만을 담는 배열
    formData.append("deletedStrings", deletedStrings);
    // 유지된 기존 이미지 파일 개수
    formData.append("alreadyFileNo", alreadyFileNo);
    // 현제 이미지 컨테이너에 올라온 이미지 개수
    formData.append("currentEditFileNo", currentEditFileNo);
    
    // 삭제되지 않은 파일만 폼데이터에 담기 (Type = Multipart)
    for (var i = 0; i < editFilesArr.length; i++) {
        if (!editFilesArr[i].is_delete) {
            formData.append("editAttach_file", editFilesArr[i]);
            console.log("기존 이미지 를 포함한 editFileArr : ",editFilesArr[i]);
        }
    }
    
    debugger;
    $.ajax({
        method: 'POST',
        url: 'postEditAction',
        enctype: "multipart/form-data", //form data 설정
        data: formData,
        contentType: false,
        processData: false,
        async: true,
        timeout: 30000,
        cache: false,
        headers: {'cache-control': 'no-cache', 'pragma': 'no-cache'},
        success: function (response) {
      	  window.location.href = '/blue/index'
        }
    });
}
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
