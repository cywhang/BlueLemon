package com.blue.view;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
		
		if(((MemberVO) session.getAttribute("loginUser")).getMember_Id().equals("admin")) {

			return "admin_Index";
		} else {
			
			model.addAttribute("message", "관리자로 로그인 해주세요");
			
			return "login";			
		}
		
	}
	

	@GetMapping("/member_Table")
	public String member_Table(Model model, HttpSession session) throws ParseException {
		
		if(((MemberVO) session.getAttribute("loginUser")).getMember_Id().equals("admin")) {

			List<MemberVO> allMember = memberService.getAllMember();
			for(int i = 0; i < allMember.size(); i++) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String joinDate = sdf.format(allMember.get(i).getMember_Join_Date());
				allMember.get(i).setMember_Join_Date_String(joinDate);
			}
			
			model.addAttribute("allMember", allMember);
			
			return "member_Table";
		} else {
			model.addAttribute("message", "관리자로 로그인 해주세요");
			return "login";			
		}		
	}
	
	@GetMapping("/member_Delete_By_Admin")
	public String member_Delete_By_Admin(String member_Id) {
		postService.deleteOneMemsTag(member_Id);
		memberService.deleteMember(member_Id);
		return "redirect:member_Table";
	}
	
	@GetMapping("/post_Table")
	public String post_Table(Model model, HttpSession session) {
		if(((MemberVO) session.getAttribute("loginUser")).getMember_Id().equals("admin")) {
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
		} else {
			model.addAttribute("message", "관리자로 로그인 해주세요");
			return "login";			
		}		
		

	}

	
	@GetMapping("/qna_Table")
	public String qna_Table(Model model, HttpSession session) {
		if(((MemberVO) session.getAttribute("loginUser")).getMember_Id().equals("admin")) {

			ArrayList<PostVO> postlist = postService.getAllPost();
			return "qna_Table";
		} else {
			model.addAttribute("message", "관리자로 로그인 해주세요");
			return "login";			
		}
	}
}
