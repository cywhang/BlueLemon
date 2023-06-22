package com.blue.view;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.blue.dto.LikeVO;
import com.blue.dto.MemberVO;
import com.blue.dto.PostVO;
import com.blue.dto.ReplyVO;
import com.blue.dto.TagVO;
import com.blue.service.PostService;
import com.blue.service.ReplyService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
//컨트롤러에서 'loginUser', 'profileMap' 이라는 이름으로 모델 객체를 생성할때 세션에 동시에 저장한다.
@SessionAttributes({"loginUser", "profileMap"})	
public class PostAndLikeController {

	@Autowired
	private PostService postService;
	@Autowired
	private ReplyService replyService;
	
	
	// 좋아요 변경(PostMapping)
	@PostMapping("/changeLike")
	@ResponseBody
	public String changeLike(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
		//System.out.println("[게시글 좋아요 - 3] PostMapping으로 /changeLike 를 Map 형식으로 잡아옴.");
	    int post_Seq = requestBody.get("post_Seq");
	    String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	    //System.out.println("[게시글 좋아요 - 4] 세션에서 로그인 유저 아이디 받아옴 member_Id = " + member_Id);
	    try {
	        LikeVO vo = new LikeVO();
	        vo.setMember_Id(member_Id);
	        vo.setPost_Seq(post_Seq);

	        // System.out.println("[게시글 좋아요 - 5] LikeVO객체 vo를 가지고 changeLike() 요청 시작");
	        postService.changeLike(vo);
	        // System.out.println("[게시글 좋아요 - 9] changeLike 하고 js에 success 리턴");
	        return "success";
	    } catch (Exception e) {
	    	// System.out.println("[좋아요 - 5 - catch] JSON 파싱 오류난 경우");
	        // JSON 파싱 오류 처리
	        e.printStackTrace();
	        return "error";
	    }
	}
	
	// 미리보기 댓글 좋아요 변경
	@PostMapping("/changeReplyLike")
	@ResponseBody
	public String changeReplyLike(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
		//System.out.println("[미리보기 댓글 좋아요 - 3] PostMapping으로 /changeReplyLike 를 Map 형식으로 잡아옴.");
	    int post_Seq = requestBody.get("post_Seq");
	    int reply_Seq = requestBody.get("reply_Seq");
	    String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	    //System.out.println("[미리보기 댓글 좋아요 - 4] 세션에서 로그인 유저 아이디 받아옴 member_Id = " + member_Id);
	    try {
	        LikeVO vo = new LikeVO();
	        vo.setMember_Id(member_Id);
	        vo.setPost_Seq(post_Seq);
	        vo.setReply_Seq(reply_Seq);
	        
	        //System.out.println("[게시글 좋아요 - 5] LikeVO객체 vo를 가지고 changeLike() 요청 시작");
	        replyService.changeReplyLike(vo);
	        //System.out.println("[게시글 좋아요 - 9] changeLike 하고 js에 success 리턴");
	        return "success";
	    } catch (Exception e) {
	    	//System.out.println("[좋아요 - 5 - catch] JSON 파싱 오류난 경우");
	        // JSON 파싱 오류 처리
	        e.printStackTrace();
	        return "error";
	    }
	}
	
	// 게시글 작성
	@PostMapping("insertPost")
	// @ResponseBody
	public String insertPost(PostVO vo, @RequestParam("attach_file") MultipartFile[] attach_file,
							 @RequestParam("fileList[]") String[] fileList,
						     HttpSession session) {
		System.out.println("==================================게시글 작성=====================================");

		System.out.println("insertPost vo : " + vo);
		System.out.println("insertPost file길이 : " + attach_file.length);
		
		// 바뀐 순서정보를 담는부분
		Map<Integer, Integer> index = new HashMap<>();
		for(int k=0; k < fileList.length; k++) {
			String file = fileList[k];
	        int aa = Integer.parseInt(file.substring(4));
	        index.put(k+1 , aa);
	    }
		System.out.println("인덱스사이즈 : " + index.size());
		
		// post_seq.nextval
		int nextSeq = postService.postSeqCheck();
		
		// 1. 이미지 업로드 처리 부분
		String folderPath = session.getServletContext().getRealPath("/WEB-INF/template/img/uploads/post/");
		// 1-1. 업로드할 이미지 개수 vo 객체에 저장
		int imgCount = attach_file.length;
		vo.setPost_Image_Count(imgCount);
		
		// 1-2. 이미지 파일명 수정 후 지정해 놓은 경로에 저장하는 부분
		for(int i=1; i < (imgCount+1); i++) {
			if(imgCount == 0) { // 이미지를 업로드 하지 않았을때
				System.out.println("이미지 없음");
				continue;
			}else {      	    // 1개이상의 이미지를 업로드 했을때
				System.out.println("이미지 " + imgCount + " 개");
				int real = index.get(i);
				System.out.println("real : "+real);
				MultipartFile file = attach_file[real];
				String fileName = nextSeq + "-" + i + ".png";
				System.out.println(fileName);
				System.out.println("File Name: " + file.getOriginalFilename());
				
				try {
		            // 파일을 지정된 경로에 저장
		            file.transferTo(new File(folderPath + fileName));
		            System.out.println("파일 저장 성공");
		        } catch (IOException e) {
		            e.printStackTrace();
		            System.out.println("파일 저장 실패");
		        }
			}
		}
		
		// 2. 해시태그 처리 부분
		String hashTag = vo.getPost_Hashtag();
		
		try { // 2-1. 사용자가 입력한 해시태그들을 json형태로 받아와서 사용할 수 있게 파싱하는 작업
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(hashTag);

            for (JsonNode node : jsonNode) {
            	// n번째 해시태그 내용 
                String value = node.get("value").asText();
                
                // 사용자가 입력한 해시태그를 디비에 저장할때 '#' 문자를 조립
                String values = "#" + value;
                
                TagVO tvo = new TagVO();
                tvo.setPost_Seq(nextSeq);
                tvo.setTag_Content(values);
                postService.insertTag(tvo);
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
		
		// 3. 게시글의 공개여부를 체크하지 않았다면 n값으로 set
		if (vo.getPost_Public() == "") {
			vo.setPost_Public("n");
		}
		
		// 4. 인서트 처리
		postService.insertPost(vo);

		return "/index";
	}
	
	// 게시글 상세보기 페이지 (모달창)
	@GetMapping("/modal")
	@ResponseBody
	public Map<String, Object> modal(@RequestParam int post_Seq, HttpSession session) {
		// 0. 세션에 저장되어있는 아이디 불러옴
		String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		
		// 0. ajax요청에 대한 response값 전달을 위한 Map 변수 선언
		Map<String, Object> dataMap = new HashMap<>();
		
		// 1. 게시글 상세페이지에서 클릭한 게시글의 정보를 출력하기 위한 PostVO 값 저장
		PostVO postInfo = postService.getpostDetail(post_Seq);
		
		// 2. 게시글의 댓글리스트를 출력하기 위한 ArrayList<ReplyVO> 값 저장
		ArrayList<ReplyVO> replyList = replyService.getListReply(post_Seq);
		
        // 3. 전체 회원 프로필 이미지 조회
		HashMap<String, String> profileMap = (HashMap<String, String>) session.getAttribute("profileMap");
		//System.out.println("세션객체에 profileMap값 불러옴 : " + profileMap);
	
		// 4. 게시글의 좋아요 여부 체크
		// 조회를 위한 객체 생성
		PostVO LikeYN = new PostVO();
		LikeYN.setMember_Id(member_Id);
		LikeYN.setPost_Seq(post_Seq);
		
		// 조회 결과 담음
		String post_LikeYN = postService.getLikeYN(LikeYN);
		postInfo.setPost_LikeYN(post_LikeYN);
		
		// 5. 게시글 댓글의 좋아요 여부 체크
		for(int i=0; i<replyList.size(); i++) {
			// 조회를 위한 객체 생성
			ReplyVO replyLikeYN = new ReplyVO();
			replyLikeYN.setMember_Id(member_Id);
			replyLikeYN.setPost_Seq(post_Seq);
			replyLikeYN.setReply_Seq(replyList.get(i).getReply_Seq());
			
			// 조회 결과 담음
			String reply_LikeYN = replyService.getCheckReplyLike(replyLikeYN);
			replyList.get(i).setReply_LikeYN(reply_LikeYN);
		}
		
 		// 게시글 상세정보 VO
 		dataMap.put("post", postInfo);  
 		// 게시글의 댓글 리스트
 		dataMap.put("replies", replyList);
 		// 전체 회원의 프로필 이미지
 		dataMap.put("profile", profileMap);
		
		return dataMap;
	}
	
	
	// 게시글 상세보기 페이지 (댓글 리스트만)
	@GetMapping("/replyModal")
	@ResponseBody
	public Map<String, Object> modalReply(@RequestParam int post_Seq, HttpSession session) {
		// 0. 세션에 저장되어있는 아이디 불러옴
		String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
				
		// 0. ajax요청에 대한 response값 전달을 위한 Map 변수 선언
		Map<String, Object> dataMap = new HashMap<>();
		
		// 1. 게시글 상세페이지에서 클릭한 게시글의 정보를 출력하기 위한 PostVO 값 저장
		PostVO postInfo = postService.getpostDetail(post_Seq);
		
		// 2. 게시글의 댓글리스트를 출력하기 위한 ArrayList<ReplyVO> 값 저장
		ArrayList<ReplyVO> replyList = replyService.getListReply(post_Seq);
		
        // 3. 전체 회원 프로필 이미지 조회
		HashMap<String, String> profileMap = (HashMap<String, String>) session.getAttribute("profileMap");
 		
		// 4. 게시글의 좋아요 여부 체크
		// 조회를 위한 객체 생성
		PostVO LikeYN = new PostVO();
		LikeYN.setMember_Id(member_Id);
		LikeYN.setPost_Seq(post_Seq);
		
		// 조회 결과 담음
		String post_LikeYN = postService.getLikeYN(LikeYN);
		postInfo.setPost_LikeYN(post_LikeYN);
		
		// 5. 게시글 댓글의 좋아요 여부 체크
		for(int i=0; i<replyList.size(); i++) {
			// 조회를 위한 객체 생성
			ReplyVO replyLikeYN = new ReplyVO();
			replyLikeYN.setMember_Id(member_Id);
			replyLikeYN.setPost_Seq(post_Seq);
			replyLikeYN.setReply_Seq(replyList.get(i).getReply_Seq());
			
			// 조회 결과 담음
			String reply_LikeYN = replyService.getCheckReplyLike(replyLikeYN);
			replyList.get(i).setReply_LikeYN(reply_LikeYN);
		}
		
 		// 게시글 상세정보 VO
 		dataMap.put("post", postInfo);  
 		// 게시글의 댓글 리스트
 		dataMap.put("replies", replyList);
 		// 전체 회원의 프로필 이미지
 		dataMap.put("profile", profileMap);
		
		return dataMap;
	}
	
	// 댓글 인서트
	@GetMapping("/insertReply")
	@ResponseBody
	public Map<String, Object> insertReply(@RequestParam("post_Seq") int post_Seq, 
						   @RequestParam("reply_Content") String reply_Content, HttpSession session) {
		// ajax에서 받은 값들.
		//System.out.println("컨트롤러의 포스트 시퀀스: " + post_Seq + ", 컨트롤러의 리플라이 컨텐츠: " + reply_Content);
		
		// 0. ajax요청에 대한 response값 전달을 위한 Map 변수 선언
		Map<String, Object> dataMap = new HashMap<>();
		
		// 1. 세션객체인 'loginUfser'객체를 MemberVO 객체로 강제 파싱해서 getter 메소드인 getMember_Id를 호출해 아이디를 가져온다.
		String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		//System.out.println("세션 아이디: " + member_Id);

		// 2. insert쿼리문에 파라미터 객체로 보낼 변수선언
		ReplyVO rep = new ReplyVO();
		rep.setMember_Id(member_Id);
		rep.setPost_Seq(post_Seq);
		rep.setReply_Content(reply_Content);
		//System.out.println("인서트 쿼리문에 보낼 객체 내용물: " + rep);
		
		// 3. insert쿼리문 실행
		replyService.insertReply(rep);
		
		// 4. 게시글의 댓글리스트를 출력하기 위한 ArrayList<ReplyVO> 값 저장
		ArrayList<ReplyVO> replyList = replyService.getListReply(post_Seq);
		
		// 5. 전체 회원의 이미지 Map을 세션에서 받아옴
		HashMap<String, String> profileMap = (HashMap<String, String>) session.getAttribute("profileMap");
		
		// 6. 해당 게시글의 상세정보를 조회해서 가져옴(게시글의 댓글 카운트 변경을 위함)
		PostVO postInfo = postService.getpostDetail(post_Seq);
		
		// 7. 게시글 댓글의 좋아요 여부 체크
		for(int i=0; i<replyList.size(); i++) {

			// 조회를 위한 객체 생성
			ReplyVO replyLikeYN = new ReplyVO();
			replyLikeYN.setMember_Id(member_Id);
			replyLikeYN.setPost_Seq(post_Seq);
			replyLikeYN.setReply_Seq(replyList.get(i).getReply_Seq());
			
			// 조회 결과 담음
			String reply_LikeYN = replyService.getCheckReplyLike(replyLikeYN);
			replyList.get(i).setReply_LikeYN(reply_LikeYN);
		}
		
		// 8. ajax의 응답성공(success)의 response로 들어갈 값들 매핑
		dataMap.put("postInfo", postInfo);
		dataMap.put("replies", replyList);
		dataMap.put("profile", profileMap);
		
		return dataMap;
	}
	
	@GetMapping("/postDelete")
	public String postDelete(@RequestParam(value="post_Seq") int post_Seq) {
		
		postService.deletePost(post_Seq);
		
		return "redirect:/index";
	}
	
}
