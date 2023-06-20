package com.blue.view;

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
import com.blue.service.PostService;
import com.blue.service.ReplyService;

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
	@PostMapping("/insertPost")
	public String insertPost(PostVO vo, @RequestParam("uploadImgs") MultipartFile[] uploadImgs) {
		
		//System.out.println("insertPost vo : " + vo);
		//System.out.println("insertPost file : " + uploadImgs.length);
		
		// 게시글의 공개여부를 체크하지 않았다면 n값으로 set
		if(vo.getPost_Public() == "") {
			vo.setPost_Public("n");
		}
		postService.insertPost(vo);
		
		return "redirect:/index";
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
}
