package com.blue.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.blue.dto.MemberVO;
import com.blue.dto.PostVO;
import com.blue.dto.QnaVO;
import com.blue.dto.ReplyVO;
import com.blue.dto.TagVO;
import com.blue.service.MemberService;
import com.blue.service.PostService;
import com.blue.service.QnaService;
import com.blue.service.ReplyService;

@Controller
//컨트롤러에서 'loginUser', 'profileMap' 이라는 이름으로 모델 객체를 생성할때 세션에 동시에 저장한다.
@SessionAttributes({"loginUser", "profileMap"})	
public class AdminController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private PostService postService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private QnaService qnaService;
	
	
	// index 페이지 로드
	@GetMapping("/admin_Index")
	public String getRecommendMember(Model model, HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
			model.addAttribute("message", "로그인을 해주세요");
			return "login";
		} else {
			
			List<MemberVO> allMember = memberService.getAllMember();
			
			ArrayList<PostVO> postlist = postService.getAllPost();
			
//			Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();
//			
//			// 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
//			// 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
//			for(int i=0; i<postlist.size(); i++) {
//				// 자신, 팔로잉한 사람들의 게시글의 post_seq를 불러온다.
//				int post_Seq = postlist.get(i).getPost_Seq();
//				
//				// i번째 게시글의 댓글 리스트를 담음
//				ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
//				//System.out.println("replylist로 담음");
//				//System.out.println("[미리보기 댓글 - 1] replylist에 해당 게시글의 댓글 3개를 가져옴 / 아직 해당 댓글 좋아요 눌렀나 체크는 안됨");
//				//System.out.println("[미리보기 댓글 - 1.5] replylist size : " + replylist.size());
//				// i번째 게시글의 댓글 좋아요 여부 체크
//				for(int k = 0; k < replylist.size(); k++) {
//					ReplyVO voForReplyCheck = replylist.get(k);
//					String realReply_Member_Id = replylist.get(k).getMember_Id();
//					voForReplyCheck.setMember_Id(member_Id);
//					//System.out.println("[미리보기 댓글 - 2] 댓글 좋아요 눌렀나 확인하러 보냄");				
//					String reply_LikeYN = replyService.getCheckReplyLike(voForReplyCheck);
//					replylist.get(k).setReply_LikeYN(reply_LikeYN);
//					//System.out.println("[미리보기 댓글 - 5] DAO에서 리턴받아서 set해줌. 해당 댓글 좋아요 누름 ? " + replylist.get(k).getReply_LikeYN());
//					replylist.get(k).setMember_Id(realReply_Member_Id);
//				}
//				
//				// i번째의 게시글의 댓글을 map에 매핑하는 작업
//				replymap.put(i, replylist);
//				//System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));			
//				
//				// i번째 게시글의 좋아요 여부 체크
//				PostVO voForLikeYN = new PostVO();
//				voForLikeYN.setMember_Id(member_Id);
//				voForLikeYN.setPost_Seq(post_Seq);
//				//System.out.println("[좋아요 여부 확인 - 0] 게시글 번호 : " + post_Seq);
//				//System.out.println("[좋아요 여부 확인 - 1] Setting 전 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
//				String post_LikeYN = postService.getLikeYN(voForLikeYN);
//				postlist.get(i).setPost_LikeYN(post_LikeYN);
//				//System.out.println("[좋아요 여부 확인 - 4] Setting 후 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
//				
//			}
//			
//			// 전체 회원 프로필 이미지 조회
//			HashMap<String, String> profilemap = memberService.getMemberProfile();
//			//System.out.println("전체 회원 프로필: " + profilemap);
//			
//			model.addAttribute("profileMap", profilemap);
//			model.addAttribute("postList", postlist);
//			model.addAttribute("replyMap", replymap);
//			model.addAttribute("recommendMember", recommendMember);
//			model.addAttribute("hottestFeed", hottestFeed);	
			return "admin_Index";
		}
	}
	

	@GetMapping("/member_Table")
	public String member_Table() {
		return "member_Table";
	}
	
	@GetMapping("/post_Table")
	public String post_Table(Model model, HttpSession session) {
		
		
		// 모든 회원의 게시글을 담는부분
		ArrayList<PostVO> postlist = postService.getAllPost();
		//System.out.println("게시글 " + postlist.size() + "개 불러옴");
		
		// 각 post_seq에 대한 댓글들을 매핑할 공간.
		Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();
		
		// 각 post_seq에 대한 해시태그들을 매핑할 공간.
		Map<Integer, ArrayList<TagVO>> hashmap = new HashMap<>();
		
		// 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
		// 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
		for(int i=0; i<postlist.size(); i++) {
			// 자신, 팔로잉한 사람들의 게시글의 post_seq를 불러온다.
			int post_Seq = postlist.get(i).getPost_Seq();
			
			// i번째 게시글의 댓글 리스트를 담음
			ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
			//System.out.println("replylist로 담음");
			//System.out.println("[미리보기 댓글 - 1] replylist에 해당 게시글의 댓글 3개를 가져옴 / 아직 해당 댓글 좋아요 눌렀나 체크는 안됨");
			//System.out.println("[미리보기 댓글 - 1.5] replylist size : " + replylist.size());
			
			
			// i번째의 게시글의 댓글을 map에 매핑하는 작업
			replymap.put(i, replylist);
			//System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));			
			
			
			// i번째 게시글의 해시태그 체크    hashmap
			ArrayList<TagVO> hash = postService.getHashtagList(post_Seq);
			hashmap.put(post_Seq, hash);
		}
		
		// 전체 회원 프로필 이미지 조회
		HashMap<String, String> profilemap = memberService.getMemberProfile();
		//System.out.println("전체 회원 프로필: " + profilemap);
		
		int postListSize = postlist.size();
		
		model.addAttribute("profileMap", profilemap);
		model.addAttribute("postList", postlist);
		model.addAttribute("hashMap", hashmap);
		model.addAttribute("postListSize", postListSize);
	
		return "post_Table";
	}
	
	@GetMapping("/post_Table")
	public String viewPostDetail(@RequestParam(value = "post_Seq") int post_Seq, Model model, HttpSession session) {
		
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
 		model.addAttribute("post", postInfo);  
 		// 게시글의 댓글 리스트
 		model.addAttribute("replies", replyList);
 		// 전체 회원의 프로필 이미지
 		model.addAttribute("profile", profileMap);
		
		return "";
	}
	
	@GetMapping("/qna_Table")
	public String qna_Table() {
		return "qna_Table";
	}
}
