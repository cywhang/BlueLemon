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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.blue.dto.AlarmVO;
import com.blue.dto.FollowVO;
import com.blue.dto.MemberVO;
import com.blue.dto.PostVO;
import com.blue.dto.QnaVO;
import com.blue.dto.ReplyVO;
import com.blue.dto.TagVO;
import com.blue.service.AlarmService;
import com.blue.service.MemberService;
import com.blue.service.PostService;
import com.blue.service.QnaService;
import com.blue.service.ReplyService;

@Controller
//컨트롤러에서 'loginUser', 'profileMap' 이라는 이름으로 모델 객체를 생성할때 세션에 동시에 저장한다.
@SessionAttributes({"loginUser", "profileMap"})	
public class MainController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private PostService postService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private QnaService qnaService;
	@Autowired
	private AlarmService alarmService;
	
	// 로그인 페이지로 이동
	@GetMapping(value="/login")
	public String login(){
		//System.out.println("[로그인 - 1] http://localhost:8082/blue/login 입력 시 '/login'을 GetMapping해서 login창으로 이동");
		return "login";
	}
	
	// 로그인 처리
	@PostMapping("/loginProc")
	public String LoginAction(Model model, @ModelAttribute("vo") MemberVO vo) {
		//System.out.println("[로그인 - 2] login.jsp에서 /loginProc 요청한 걸 잡아옴");
		int result = memberService.doLogin(vo);
		
		if(result == 1) {			
			//System.out.println("[로그인 - 7 - if - 1] MemberDAO에서 받아온 result로 로그인 처리하고 memberService의 getMember호출");
			//System.out.println("[로그인 - 7 - if - 5] getMember로 받아온 회원 정보를 loginUser라는 이름으로 세션에 올리고 index.jsp 호출");
			if(vo.getMember_Id().equals("admin")) {
				model.addAttribute("loginUser", memberService.getMember(vo.getMember_Id()));
				return "redirect:admin_Index";
			} else {
				model.addAttribute("loginUser", memberService.getMember(vo.getMember_Id()));
				return "redirect:index";
			}
		} else {
			//System.out.println("[로그인 - 7 - else - 1] 정상이 아니면 login_fail.jsp 호출 -> alert 후 login.jsp로");
			return "login_fail";
		}
	}

	// 로그아웃 처리
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "login";
	}
	
	// index 페이지 로드
	@RequestMapping("/index")
	public String getRecommendMember(Model model, HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
			//System.out.println("세션값 없음");
			model.addAttribute("message", "로그인을 해주세요");
			return "login";
		} else {
									/* index페이지의 팔로우 부분 */
			//System.out.println("[멤버추천 - 1] 로그인 후 index 요청하면 GetMapping으로 잡아오고 세션의 loginUser에서 Id 뽑아서 member_Id에 저장");
			String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
			
			//System.out.println("[멤버추천 - 2] member_Id를 가지고 memberService에 getRecommendMember 요청");		
			List<MemberVO> recommendMember = memberService.getRecommendMember(member_Id);
			//System.out.println("[멤버추천 - 5] DAO에서 추천 리스트를 받아와서 List에 저장하고 model에 올리고 index.jsp 호출");
			
			//System.out.println("[인기글 - 1] 로그인 후 index 요청하면 GetMapping으로 잡아옴");
			//System.out.println("[인기글 - 2] postService에 getHottestFeed 요청");
	    	List<PostVO> hottestFeed = postService.getHottestFeed();
	    	//System.out.println("[인기글 - 5] DAO에서 hottestFeed 받아와서 List에 저장하고 model에 올림");
			
	    	// 알람 리스트를 담는 부분
	    	List<AlarmVO> alarmList = alarmService.getAllAlarm(member_Id);
	    	
	    	int alarmListSize = alarmList.size();
	    	
	    	// 알람의 종류를 파악하는 부분
	    	for(int j=0; j<alarmList.size(); j++) {
	    		int kind = alarmList.get(j).getKind();
	    		if(kind == 1) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님을 팔로우 <br>하였습니다.");
	    		}else if(kind == 2) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>좋아요를 눌렀습니다.");
	    		}else if(kind == 3) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>댓글을 달았습니다.");
	    		}else if(kind == 4) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 댓글에 <br>좋아요를 눌렀습니다.");
	    		}else if(kind == 5) {
	    			alarmList.get(j).setMessage("회원님께서 문의하신 질문에 <br>답글이 달렸습니다.");
	    		}
	    	}
			
									/* index페이지의 뉴스피드 부분 */
			// 자신, 팔로잉한 사람들의 게시글을 담는부분
			ArrayList<PostVO> postlist = postService.getlistPost(member_Id);
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
				// i번째 게시글의 댓글 좋아요 여부 체크
				for(int k = 0; k < replylist.size(); k++) {
					ReplyVO voForReplyCheck = replylist.get(k);
					String realReply_Member_Id = replylist.get(k).getMember_Id();
					voForReplyCheck.setMember_Id(member_Id);
					//System.out.println("[미리보기 댓글 - 2] 댓글 좋아요 눌렀나 확인하러 보냄");				
					String reply_LikeYN = replyService.getCheckReplyLike(voForReplyCheck);
					replylist.get(k).setReply_LikeYN(reply_LikeYN);
					//System.out.println("[미리보기 댓글 - 5] DAO에서 리턴받아서 set해줌. 해당 댓글 좋아요 누름 ? " + replylist.get(k).getReply_LikeYN());
					replylist.get(k).setMember_Id(realReply_Member_Id);
				}
				
				// i번째의 게시글의 댓글을 map에 매핑하는 작업
				replymap.put(i, replylist);
				//System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));			
				
				// i번째 게시글의 좋아요 여부 체크
				PostVO voForLikeYN = new PostVO();
				voForLikeYN.setMember_Id(member_Id);
				voForLikeYN.setPost_Seq(post_Seq);
				//System.out.println("[좋아요 여부 확인 - 0] 게시글 번호 : " + post_Seq);
				//System.out.println("[좋아요 여부 확인 - 1] Setting 전 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
				String post_LikeYN = postService.getLikeYN(voForLikeYN);
				postlist.get(i).setPost_LikeYN(post_LikeYN);
				//System.out.println("[좋아요 여부 확인 - 4] Setting 후 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
				
				// i번째 게시글의 해시태그 체크    hashmap
				ArrayList<TagVO> hash = postService.getHashtagList(post_Seq);
				hashmap.put(post_Seq, hash);
			}
			
			// 전체 회원 프로필 이미지 조회
			HashMap<String, String> profilemap = memberService.getMemberProfile();
			//System.out.println("전체 회원 프로필: " + profilemap);
			
			model.addAttribute("alarmList", alarmList);
			model.addAttribute("alarmListSize", alarmListSize);
			model.addAttribute("profileMap", profilemap);
			model.addAttribute("postList", postlist);
			model.addAttribute("replyMap", replymap);
			model.addAttribute("recommendMember", recommendMember);
			model.addAttribute("hottestFeed", hottestFeed);	
			model.addAttribute("member_Id", member_Id);
			model.addAttribute("hashMap", hashmap);
			return "index";
		}
	}
	
	// PEOPLE 탭 List 가져오기
	@GetMapping("/people_List")
	public ResponseEntity<Map<String, Object>> people_List(HttpSession session, Model model) {
		//System.out.println("[PEOPLE 탭 - 3] people_List GET MAPPING으로 옴");
	    String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	    
	    List<MemberVO> canFollow = memberService.getRecommendMember(member_Id);
	    //System.out.println("[PEOPLE 탭 - 4] CAN FOLLOW LIST를 받아오기 성공");
	    
	    List<MemberVO> mostFamous = memberService.getMostFamousMember();
	    //System.out.println("[PEOPLE 탭 - 7] MOST FAMOUS LIST를 받아오기 성공");
	    
	    for(int i = 0 ; i < mostFamous.size() ; i++) {
	    	String check_Id = mostFamous.get(i).getMember_Id();
	    	FollowVO check_Vo = new FollowVO();
	    	check_Vo.setFollower(member_Id);
	    	check_Vo.setFollowing(check_Id);
	    	String followCheck = memberService.checkFollow(check_Vo);
	    	mostFamous.get(i).setFollow_Check(followCheck);
	    }
	    Map<String, Object> responseData = new HashMap<>();
	    responseData.put("canFollow", canFollow);
	    responseData.put("mostFamous", mostFamous);
	    
	    return ResponseEntity.ok(responseData);
	}

	// Profile 이동
	@GetMapping("/profile")
	public String makeProfile(@RequestParam("member_Id") String member_Id, Model model, HttpSession session) {
		//System.out.println("[프로필 페이지 - 1] GET MAPPING으로 MainController로 옴. 프로필 대상 : " + member_Id);
		MemberVO member = memberService.getMember(member_Id);
		String loginUser_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		FollowVO checkVo = new FollowVO();
		checkVo.setFollower(loginUser_Id);
		checkVo.setFollowing(member_Id);
		String followCheck = memberService.checkFollow(checkVo);
		member.setFollow_Check(followCheck);
		
		// 팔로워 팔로우 숫자 밑에 작은 동그라미 이미지들 채울 용도
		List<MemberVO> followers = memberService.getFollowers(member_Id);
		int followers_Size = followers.size();
		List<MemberVO> followings = memberService.getFollowings(member_Id);
		int followings_Size = followings.size();
		model.addAttribute("followers", followers);
		model.addAttribute("followers_Size", followers_Size);
		model.addAttribute("followings", followings);
		model.addAttribute("followings_Size", followings_Size);
		
		
	    String session_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();

		// 알람 리스트를 담는 부분
    	List<AlarmVO> alarmList = alarmService.getAllAlarm(session_Id);
    	
    	int alarmListSize = alarmList.size();
    	
    	// 알람의 종류를 파악하는 부분
    	for(int j=0; j<alarmList.size(); j++) {
    		int kind = alarmList.get(j).getKind();
    		if(kind == 1) {
    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님을 팔로우 <br>하였습니다.");
    		}else if(kind == 2) {
    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>좋아요를 눌렀습니다.");
    		}else if(kind == 3) {
    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>댓글을 달았습니다.");
    		}else if(kind == 4) {
    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 댓글에 <br>좋아요를 눌렀습니다.");
    		}else if(kind == 5) {
    			alarmList.get(j).setMessage("회원님께서 문의하신 질문에 <br>답글이 달렸습니다.");
    		}
    	}
		
		// 내가 쓴 글을 postlist에 담음
		ArrayList<PostVO> postlist = postService.getMemberPost(member_Id);
		//System.out.println("[프로필 페이지 - 2] 해당 멤버의 정보와 작성한 포스트들을 담아옴");		
		
		// 각 post_seq에 대한 댓글들을 매핑할 공간.
		Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();
		
		// 각 post_seq에 대한 해시태그들을 매핑할 공간.
		Map<Integer, ArrayList<TagVO>> hashmap = new HashMap<>();
				
		// 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
		// 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
		for(int i = 0; i < postlist.size(); i++) {
			
			int post_Seq = postlist.get(i).getPost_Seq();
			
			// i번째 게시글의 댓글 리스트를 담음
			ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
			// i번째 게시글의 댓글 좋아요 여부 체크
			for(int k = 0; k < replylist.size(); k++) {
				ReplyVO voForReplyCheck = replylist.get(k);
				String realReply_Member_Id = replylist.get(k).getMember_Id();
				voForReplyCheck.setMember_Id(loginUser_Id);		
				String reply_LikeYN = replyService.getCheckReplyLike(voForReplyCheck);
				replylist.get(k).setReply_LikeYN(reply_LikeYN);
				replylist.get(k).setMember_Id(realReply_Member_Id);

				//System.out.println("[프로필 페이지 - 3] 해당 댓글 좋아요 눌렀나 체크됨");
			}
			
			// i번째의 게시글의 댓글을 map에 매핑하는 작업
			replymap.put(i, replylist);
			//System.out.println("[프로필 페이지 - 4] 게시글 별 댓글을 매핑함");		
			
			// i번째 게시글의 좋아요 여부 체크
			PostVO voForLikeYN = new PostVO();
			voForLikeYN.setMember_Id(loginUser_Id);
			voForLikeYN.setPost_Seq(post_Seq);
			String post_LikeYN = postService.getLikeYN(voForLikeYN);
			int post_Like_Count = postService.getPost_Like_Count(post_Seq);
			postlist.get(i).setPost_Like_Count(post_Like_Count);
			postlist.get(i).setPost_LikeYN(post_LikeYN);
			//System.out.println("[프로필 페이지 - 5] " + i + "번째 게시글 좋아요 눌렀나 체크됨 : " + post_LikeYN);
			
			// i번째 게시글의 해시태그 체크    hashmap
			ArrayList<TagVO> hash = postService.getHashtagList(post_Seq);
			hashmap.put(post_Seq, hash);
			
		}
		
		// 전체 회원 프로필 이미지 조회
		HashMap<String, String> profilemap = memberService.getMemberProfile();
		//System.out.println("전체 회원 프로필: " + profilemap);		
		//System.out.println("[프로필 페이지 - 6] 출력준비를 위한 postvo 준비");
		
		// 화면 우측 Hottest Feed
		List<PostVO> hottestFeed = postService.getHottestFeed();
		
		model.addAttribute("loginUser_Id", loginUser_Id);
		model.addAttribute("member", member);
		model.addAttribute("member_Id", member_Id);
		model.addAttribute("postlist", postlist);
		model.addAttribute("profileMap", profilemap);
		model.addAttribute("replyMap", replymap);
		model.addAttribute("hottestFeed", hottestFeed);
		model.addAttribute("hashMap", hashmap);
		model.addAttribute("alarmList", alarmList);
		model.addAttribute("alarmListSize", alarmListSize);
		
		return "profile";
	} 
	
	
	// Profile 이동
	@PostMapping("/profileInfinite")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> MoreProfilePost(@RequestBody Map<String, String> requestBody, Model model, HttpSession session) {
		
		String member_Id = requestBody.get("member_Id");
		
		//System.out.println("[프로필 페이지 - 1] GET MAPPING으로 MainController로 옴. 프로필 대상 : " + member_Id);
		MemberVO member = memberService.getMember(member_Id);
		
		String loginUser_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		
		// 내가 쓴 글을 postlist에 담음
		ArrayList<PostVO> postlist = postService.getMemberPost(member_Id);
		//System.out.println("[프로필 페이지 - 2] 해당 멤버의 정보와 작성한 포스트들을 담아옴");		
		
		// 각 post_seq에 대한 댓글들을 매핑할 공간.
		Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();
		
		// 각 post_seq에 대한 해시태그들을 매핑할 공간.
		Map<Integer, ArrayList<TagVO>> hashmap = new HashMap<>();
				
		// 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
		// 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
		for(int i = 0; i < postlist.size(); i++) {
			
			int post_Seq = postlist.get(i).getPost_Seq();
			
			// i번째 게시글의 댓글 리스트를 담음
			ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
			// i번째 게시글의 댓글 좋아요 여부 체크
			for(int k = 0; k < replylist.size(); k++) {
				ReplyVO voForReplyCheck = replylist.get(k);
				String realReply_Member_Id = replylist.get(k).getMember_Id();
				voForReplyCheck.setMember_Id(loginUser_Id);		
				String reply_LikeYN = replyService.getCheckReplyLike(voForReplyCheck);
				replylist.get(k).setReply_LikeYN(reply_LikeYN);
				replylist.get(k).setMember_Id(realReply_Member_Id);

				//System.out.println("[프로필 페이지 - 3] 해당 댓글 좋아요 눌렀나 체크됨");
			}
			
			// i번째의 게시글의 댓글을 map에 매핑하는 작업
			replymap.put(i, replylist);
			//System.out.println("[프로필 페이지 - 4] 게시글 별 댓글을 매핑함");		
			
			// i번째 게시글의 좋아요 여부 체크
			PostVO voForLikeYN = new PostVO();
			voForLikeYN.setMember_Id(loginUser_Id);
			voForLikeYN.setPost_Seq(post_Seq);
			String post_LikeYN = postService.getLikeYN(voForLikeYN);
			int post_Like_Count = postService.getPost_Like_Count(post_Seq);
			postlist.get(i).setPost_Like_Count(post_Like_Count);
			postlist.get(i).setPost_LikeYN(post_LikeYN);
			//System.out.println("[프로필 페이지 - 5] " + i + "번째 게시글 좋아요 눌렀나 체크됨 : " + post_LikeYN);
			
			// i번째 게시글의 해시태그 체크    hashmap
			ArrayList<TagVO> hash = postService.getHashtagList(post_Seq);
			hashmap.put(post_Seq, hash);
			
		}
		
		// 전체 회원 프로필 이미지 조회
		HashMap<String, String> profilemap = memberService.getMemberProfile();
		//System.out.println("전체 회원 프로필: " + profilemap);		
		//System.out.println("[프로필 페이지 - 6] 출력준비를 위한 postvo 준비");
		
		// 화면 우측 Hottest Feed
		List<PostVO> hottestFeed = postService.getHottestFeed();
		
		Map<String, Object> responseData = new HashMap<>();
		
		responseData.put("session_Id", loginUser_Id);
		responseData.put("postlist", postlist);
		responseData.put("profileMap", profilemap);
		responseData.put("replyMap", replymap);
		responseData.put("hashMap", hashmap);

	      
	    return ResponseEntity.ok(responseData);
	} 
	
	@GetMapping("trending_List")
	public ResponseEntity<Map<String, Object>> trending_List(HttpSession session, Model model) {
	      
		//System.out.println("[멤버추천 - 1] 로그인 후 trending_List 요청하면 GetMapping으로 잡아오고 세션의 loginUser에서 Id 뽑아서 member_Id에 저장");
	    String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	      
	    //System.out.println("[인기글 - 1] index에서 tranding tab요청하면 js가 잡아서 던짐  GetMapping으로 잡아옴");
	    //System.out.println("[인기글 - 2] postService에 getHottestFeed 요청");
	    List<PostVO> hottestFeed = postService.getHottestFeed();
	    //System.out.println("[인기글 - 5] DAO에서 hottestFeed 받아와서 List에 저장하고 model에 올림");
	       
	    // 각 post_seq에 대한 댓글들을 매핑할 공간.
	    Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();

	    // 각 post_seq에 대한 해시태그들을 매핑할 공간.
	 	Map<Integer, ArrayList<TagVO>> hashmap = new HashMap<>();
	 	
	    // 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
	    // 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
	    for(int i=0; i<hottestFeed.size(); i++) {
	        // 자신, 팔로잉한 사람들의 게시글의 post_seq를 불러온다.
	        int post_Seq = hottestFeed.get(i).getPost_Seq();
	        
	        // i번째 게시글의 댓글 리스트를 담음
	        ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
	        // System.out.println("replylist로 담음");
	        // System.out.println("[미리보기 댓글 - 1] replylist에 해당 게시글의 댓글 3개를 가져옴 / 아직 해당 댓글 좋아요 눌렀나 체크는 안됨");
	        // System.out.println("[미리보기 댓글 - 1.5] replylist size : " + replylist.size());
	        // i번째 게시글의 댓글 좋아요 여부 체크
	        for(int k = 0; k < replylist.size(); k++) {
	            ReplyVO voForReplyCheck = replylist.get(k);
	            String realReply_Member_Id = replylist.get(k).getMember_Id();
	            voForReplyCheck.setMember_Id(member_Id);
	            //  System.out.println("[미리보기 댓글 - 2] 댓글 좋아요 눌렀나 확인하러 보냄");            
	            String reply_LikeYN = replyService.getCheckReplyLike(voForReplyCheck);
	            replylist.get(k).setReply_LikeYN(reply_LikeYN);
	            // System.out.println("[미리보기 댓글 - 5] DAO에서 리턴받아서 set해줌. 해당 댓글 좋아요 누름 ? " + replylist.get(k).getReply_LikeYN());
	            replylist.get(k).setMember_Id(realReply_Member_Id);
	        }
	         
	        // i번째의 게시글의 댓글을 map에 매핑하는 작업
	        replymap.put(i, replylist);
	        // System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));         
	        
	        // i번째 게시글의 좋아요 여부 체크
	        PostVO voForLikeYN = new PostVO();
	        voForLikeYN.setMember_Id(member_Id);
	        voForLikeYN.setPost_Seq(post_Seq);
	        //  System.out.println("[좋아요 여부 확인 - 0] 게시글 번호 : " + post_Seq);
	        //  System.out.println("[좋아요 여부 확인 - 1] Setting 전 post_LikeYN = " + hottestFeed.get(i).getPost_LikeYN());
	        String post_LikeYN = postService.getLikeYN(voForLikeYN);
	        hottestFeed.get(i).setPost_LikeYN(post_LikeYN);
	        //  System.out.println("[좋아요 여부 확인 - 4] Setting 후 post_LikeYN = " + hottestFeed.get(i).getPost_LikeYN());
	        
	     // i번째 게시글의 해시태그 체크    hashmap
	     			ArrayList<TagVO> hash = postService.getHashtagList(post_Seq);
	     			hashmap.put(post_Seq, hash);
	    }
	      	      
	    // 전체 회원 프로필 이미지 조회
	    HashMap<String, String> profilemap = memberService.getMemberProfile();
	     
	    //System.out.println("전체 회원 프로필: " + profilemap);
	      
	    Map<String, Object> responseData = new HashMap<>();
	      
	    responseData.put("session_Id", member_Id);
	    responseData.put("trending_profileMap", profilemap);
	    responseData.put("trending_postList", hottestFeed);
	    responseData.put("trending_replyMap", replymap);
	    responseData.put("hashMap", hashmap);
	      
	    return ResponseEntity.ok(responseData);
	}
	 
	// Contact Form
	@GetMapping("/contact")
	public String contactPage(HttpSession session, Model model) {
		
		String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		
		if(session.getAttribute("loginUser") == null) {
			model.addAttribute("message", "로그인을 해주세요");
			return "login";
		} else {
			
			String session_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();

			// 알람 리스트를 담는 부분
	    	List<AlarmVO> alarmList = alarmService.getAllAlarm(session_Id);
	    	
	    	int alarmListSize = alarmList.size();
	    	
	    	// 알람의 종류를 파악하는 부분
	    	for(int j=0; j<alarmList.size(); j++) {
	    		int kind = alarmList.get(j).getKind();
	    		if(kind == 1) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님을 팔로우 <br>하였습니다.");
	    		}else if(kind == 2) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>좋아요를 눌렀습니다.");
	    		}else if(kind == 3) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>댓글을 달았습니다.");
	    		}else if(kind == 4) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 댓글에 <br>좋아요를 눌렀습니다.");
	    		}else if(kind == 5) {
	    			alarmList.get(j).setMessage("회원님께서 문의하신 질문에 <br>답글이 달렸습니다.");
	    		}
	    	}
			
			// 우측 Hottest Feed
			List<PostVO> hottestFeed = postService.getHottestFeed();
			model.addAttribute("hottestFeed", hottestFeed);
			
		    // 내가 작성한 qna
			List<QnaVO> qnaList = qnaService.getMyQna(member_Id);
			
			model.addAttribute("qnaList", qnaList);
			model.addAttribute("alarmList", alarmList);
			model.addAttribute("alarmListSize", alarmListSize);
			
			return "contact";
			
		}
	}
	
	// Contact Form
		@GetMapping("/alarmContact")
		public String alarmContact(HttpSession session, Model model, @RequestParam("alarm_Seq") int alarm_Seq) {
			
			String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
			
			if(session.getAttribute("loginUser") == null) {
				model.addAttribute("message", "로그인을 해주세요");
				return "login";
			} else {
				
				alarmService.deleteAlarm(alarm_Seq);
				
				String session_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();

				// 알람 리스트를 담는 부분
		    	List<AlarmVO> alarmList = alarmService.getAllAlarm(session_Id);
		    	
		    	int alarmListSize = alarmList.size();
		    	
		    	// 알람의 종류를 파악하는 부분
		    	for(int j=0; j<alarmList.size(); j++) {
		    		int kind = alarmList.get(j).getKind();
		    		if(kind == 1) {
		    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님을 팔로우 <br>하였습니다.");
		    		}else if(kind == 2) {
		    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>좋아요를 눌렀습니다.");
		    		}else if(kind == 3) {
		    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>댓글을 달았습니다.");
		    		}else if(kind == 4) {
		    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 댓글에 <br>좋아요를 눌렀습니다.");
		    		}else if(kind == 5) {
		    			alarmList.get(j).setMessage("회원님께서 문의하신 질문에 <br>답글이 달렸습니다.");
		    		}
		    	}
				
		    	model.addAttribute("alarmList", alarmList);
				model.addAttribute("alarmListSize", alarmListSize);
		    	
				// 우측 Hottest Feed
				List<PostVO> hottestFeed = postService.getHottestFeed();
				model.addAttribute("hottestFeed", hottestFeed);
			    // 내가 작성한 qna
				List<QnaVO> qnaList = qnaService.getMyQna(member_Id);
				model.addAttribute("qnaList", qnaList);
				
				
				return "contact";
			}
		}
	
	@PostMapping("/qna")
	public String qnaSending(@ModelAttribute("contactForm") QnaVO vo, HttpSession session, Model model) {
		
		if(session.getAttribute("loginUser") == null) {
			model.addAttribute("message", "로그인을 해주세요");
			return "login";
		} else {
			int qna_Seq = qnaService.checkMaxSeq() + 1;
			vo.setQna_Seq(qna_Seq);
			qnaService.insertQna(vo);
			
			return "redirect:contact";
		}
	}
	// index 페이지 로드
	@GetMapping("/feedInfinite")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> feedInfinite(HttpSession session) {

			String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();

									/* index페이지의 뉴스피드 부분 */
			// 자신, 팔로잉한 사람들의 게시글을 담는부분
			ArrayList<PostVO> postlist = postService.getlistPost(member_Id);

			System.out.println(postlist.get(0).getMember_Id());
			System.out.println("게시글 " + postlist.size() + "개 불러옴");

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
				// i번째 게시글의 댓글 좋아요 여부 체크
				for(int k = 0; k < replylist.size(); k++) {
					ReplyVO voForReplyCheck = replylist.get(k);
					String realReply_Member_Id = replylist.get(k).getMember_Id();
					voForReplyCheck.setMember_Id(member_Id);
					//System.out.println("[미리보기 댓글 - 2] 댓글 좋아요 눌렀나 확인하러 보냄");				
					String reply_LikeYN = replyService.getCheckReplyLike(voForReplyCheck);
					replylist.get(k).setReply_LikeYN(reply_LikeYN);
					//System.out.println("[미리보기 댓글 - 5] DAO에서 리턴받아서 set해줌. 해당 댓글 좋아요 누름 ? " + replylist.get(k).getReply_LikeYN());
					replylist.get(k).setMember_Id(realReply_Member_Id);
				}

				// i번째의 게시글의 댓글을 map에 매핑하는 작업
				replymap.put(i, replylist);
				//System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));			

				// i번째 게시글의 좋아요 여부 체크
				PostVO voForLikeYN = new PostVO();
				voForLikeYN.setMember_Id(member_Id);
				voForLikeYN.setPost_Seq(post_Seq);
				//System.out.println("[좋아요 여부 확인 - 0] 게시글 번호 : " + post_Seq);
				//System.out.println("[좋아요 여부 확인 - 1] Setting 전 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
				String post_LikeYN = postService.getLikeYN(voForLikeYN);
				postlist.get(i).setPost_LikeYN(post_LikeYN);
				//System.out.println("[좋아요 여부 확인 - 4] Setting 후 post_LikeYN = " + postlist.get(i).getPost_LikeYN());

				// i번째 게시글의 해시태그 체크    hashmap
				
				ArrayList<TagVO> hash = postService.getHashtagList(post_Seq);
				hashmap.put(post_Seq, hash);
			}


			// 전체 회원 프로필 이미지 조회
			HashMap<String, String> profilemap = memberService.getMemberProfile();
			//System.out.println("전체 회원 프로필: " + profilemap);

			Map<String, Object> responseData = new HashMap<>();
			
			responseData.put("profileMap", profilemap);
			responseData.put("postList", postlist);
			responseData.put("replyMap", replymap);
			responseData.put("session_Id", member_Id);
			responseData.put("hashMap", hashmap);

			return ResponseEntity.ok(responseData);

	}
	
	@PostMapping("/deleteAlarm")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteAlarm(@RequestBody Map<String, Integer> requestBody){
		
		int alarm_Seq = requestBody.get("alarm_Seq");
		
		alarmService.deleteAlarm(alarm_Seq);
		
		Map<String, Object> responseData = new HashMap<>();
		
		responseData.put("message", "알람 삭제 성공");
		
		return ResponseEntity.ok(responseData);
	}
	
	@GetMapping("/alarmIndex")
	public String alarmIndex(Model model, HttpSession session,@RequestParam("post_Seq") int P_Seq, @RequestParam("alarm_Seq") int alarm_Seq) {
		
		if(session.getAttribute("loginUser") == null) {
			//System.out.println("세션값 없음");
			model.addAttribute("message", "로그인을 해주세요");
			return "login";
		} else {
			
			// 클릭한 알람을 삭제
	    	alarmService.deleteAlarm(alarm_Seq);
	    	
									/* index페이지의 팔로우 부분 */
			//System.out.println("[멤버추천 - 1] 로그인 후 index 요청하면 GetMapping으로 잡아오고 세션의 loginUser에서 Id 뽑아서 member_Id에 저장");
			String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
			
			//System.out.println("[멤버추천 - 2] member_Id를 가지고 memberService에 getRecommendMember 요청");		
			List<MemberVO> recommendMember = memberService.getRecommendMember(member_Id);
			//System.out.println("[멤버추천 - 5] DAO에서 추천 리스트를 받아와서 List에 저장하고 model에 올리고 index.jsp 호출");
			
			//System.out.println("[인기글 - 1] 로그인 후 index 요청하면 GetMapping으로 잡아옴");
			//System.out.println("[인기글 - 2] postService에 getHottestFeed 요청");
	    	List<PostVO> hottestFeed = postService.getHottestFeed();
	    	//System.out.println("[인기글 - 5] DAO에서 hottestFeed 받아와서 List에 저장하고 model에 올림");
			
	    	// 알람 리스트를 담는 부분
	    	List<AlarmVO> alarmList = alarmService.getAllAlarm(member_Id);
	    	
	    	int alarmListSize = alarmList.size();
	    	
	    	// 알람의 종류를 파악하는 부분
	    	for(int j=0; j<alarmList.size(); j++) {
	    		int kind = alarmList.get(j).getKind();
	    		if(kind == 1) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님을 팔로우 <br>하였습니다.");
	    		}else if(kind == 2) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>좋아요를 눌렀습니다.");
	    		}else if(kind == 3) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 게시글에 <br>댓글을 달았습니다.");
	    		}else if(kind == 4) {
	    			alarmList.get(j).setMessage(alarmList.get(j).getFrom_Mem() + "님께서 회원님의 댓글에 <br>좋아요를 눌렀습니다.");
	    		}else if(kind == 5) {
	    			alarmList.get(j).setMessage("회원님께서 문의하신 질문에 <br>답글이 달렸습니다.");
	    		}
	    	}
			
									/* index페이지의 뉴스피드 부분 */
			// 자신, 팔로잉한 사람들의 게시글을 담는부분
			ArrayList<PostVO> postlist = new ArrayList<PostVO>();
			
			postlist.add(postService.selectPostDetail(P_Seq));
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
				// i번째 게시글의 댓글 좋아요 여부 체크
				for(int k = 0; k < replylist.size(); k++) {
					ReplyVO voForReplyCheck = replylist.get(k);
					String realReply_Member_Id = replylist.get(k).getMember_Id();
					voForReplyCheck.setMember_Id(member_Id);
					//System.out.println("[미리보기 댓글 - 2] 댓글 좋아요 눌렀나 확인하러 보냄");				
					String reply_LikeYN = replyService.getCheckReplyLike(voForReplyCheck);
					replylist.get(k).setReply_LikeYN(reply_LikeYN);
					//System.out.println("[미리보기 댓글 - 5] DAO에서 리턴받아서 set해줌. 해당 댓글 좋아요 누름 ? " + replylist.get(k).getReply_LikeYN());
					replylist.get(k).setMember_Id(realReply_Member_Id);
				}
				
				// i번째의 게시글의 댓글을 map에 매핑하는 작업
				replymap.put(i, replylist);
				//System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));			
				
				// i번째 게시글의 좋아요 여부 체크
				PostVO voForLikeYN = new PostVO();
				voForLikeYN.setMember_Id(member_Id);
				voForLikeYN.setPost_Seq(post_Seq);
				//System.out.println("[좋아요 여부 확인 - 0] 게시글 번호 : " + post_Seq);
				//System.out.println("[좋아요 여부 확인 - 1] Setting 전 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
				String post_LikeYN = postService.getLikeYN(voForLikeYN);
				postlist.get(i).setPost_LikeYN(post_LikeYN);
				//System.out.println("[좋아요 여부 확인 - 4] Setting 후 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
				
				// i번째 게시글의 해시태그 체크    hashmap
				ArrayList<TagVO> hash = postService.getHashtagList(post_Seq);
				hashmap.put(post_Seq, hash);
			}
			
			// 전체 회원 프로필 이미지 조회
			HashMap<String, String> profilemap = memberService.getMemberProfile();
			//System.out.println("전체 회원 프로필: " + profilemap);
			
			model.addAttribute("alarmList", alarmList);
			model.addAttribute("alarmListSize", alarmListSize);
			model.addAttribute("profileMap", profilemap);
			model.addAttribute("postList", postlist);
			model.addAttribute("replyMap", replymap);
			model.addAttribute("recommendMember", recommendMember);
			model.addAttribute("hottestFeed", hottestFeed);	
			model.addAttribute("member_Id", member_Id);
			model.addAttribute("hashMap", hashmap);
		
		return "index";
		}
	
	}
	
}
