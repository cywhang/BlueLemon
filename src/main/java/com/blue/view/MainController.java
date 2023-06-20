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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.blue.dto.FollowVO;
import com.blue.dto.LikeVO;
import com.blue.dto.MemberVO;
import com.blue.dto.PostVO;
import com.blue.dto.ReplyVO;
import com.blue.service.FollowService;
import com.blue.service.MemberService;
import com.blue.service.PostService;
import com.blue.service.ReplyService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	private FollowService followService;
	//테스트로 풀리퀘스트 할거임 ㅋㅋㅋㅋㅋㅋㅋ
	// 로그인 페이지로 이동
	@GetMapping(value="/login")
	public String login(){
		System.out.println("[로그인 - 1] http://localhost:8082/blue/login 입력 시 '/login'을 GetMapping해서 login창으로 이동");
		return "login";
	}
	
	// 로그인 처리
	@PostMapping("/loginProc")
	public String LoginAction(Model model, @ModelAttribute("vo") MemberVO vo) {
		System.out.println("[로그인 - 2] login.jsp에서 /loginProc 요청한 걸 잡아옴");
		int result = memberService.doLogin(vo);
		
		if(result == 1) {			
			System.out.println("[로그인 - 7 - if - 1] MemberDAO에서 받아온 result로 로그인 처리하고 memberService의 getMember호출");
			System.out.println("[로그인 - 7 - if - 5] getMember로 받아온 회원 정보를 loginUser라는 이름으로 세션에 올리고 index.jsp 호출");
			model.addAttribute("loginUser", memberService.getMember(vo.getMember_Id()));
			return "redirect:index";
		} else {
			System.out.println("[로그인 - 7 - else - 1] 정상이 아니면 login_fail.jsp 호출 -> alert 후 login.jsp로");
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
	@GetMapping("/index")
	public String getRecommendMember(Model model, HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
			System.out.println("세션값 없음");
			model.addAttribute("message", "로그인을 해주세요");
			return "login";
		} else {
									/* index페이지의 팔로우 부분 */
			System.out.println("[멤버추천 - 1] 로그인 후 index 요청하면 GetMapping으로 잡아오고 세션의 loginUser에서 Id 뽑아서 member_Id에 저장");
			String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
			
			System.out.println("[멤버추천 - 2] member_Id를 가지고 memberService에 getRecommendMember 요청");		
			List<MemberVO> recommendMember = memberService.getRecommendMember(member_Id);
			System.out.println("[멤버추천 - 5] DAO에서 추천 리스트를 받아와서 List에 저장하고 model에 올리고 index.jsp 호출");
			
			System.out.println("[인기글 - 1] 로그인 후 index 요청하면 GetMapping으로 잡아옴");
	    	System.out.println("[인기글 - 2] postService에 getHottestFeed 요청");
	    	List<PostVO> hottestFeed = postService.getHottestFeed();
	    	System.out.println("[인기글 - 5] DAO에서 hottestFeed 받아와서 List에 저장하고 model에 올림");
			
			
									/* index페이지의 뉴스피드 부분 */
			// 자신, 팔로잉한 사람들의 게시글을 담는부분
			ArrayList<PostVO> postlist = postService.getlistPost(member_Id);
			System.out.println("게시글 " + postlist.size() + "개 불러옴");
			
			// 각 post_seq에 대한 댓글들을 매핑할 공간.
			Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();
			
			// 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
			// 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
			for(int i=0; i<postlist.size(); i++) {
				// 자신, 팔로잉한 사람들의 게시글의 post_seq를 불러온다.
				int post_Seq = postlist.get(i).getPost_Seq();
				
				// i번째 게시글의 댓글 리스트를 담음
				ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
				System.out.println("replylist로 담음");
				System.out.println("[미리보기 댓글 - 1] replylist에 해당 게시글의 댓글 3개를 가져옴 / 아직 해당 댓글 좋아요 눌렀나 체크는 안됨");
				System.out.println("[미리보기 댓글 - 1.5] replylist size : " + replylist.size());
				// i번째 게시글의 댓글 좋아요 여부 체크
				for(int k = 0; k < replylist.size(); k++) {
					ReplyVO voForReplyCheck = replylist.get(k);
					String realReply_Member_Id = replylist.get(k).getMember_Id();
					voForReplyCheck.setMember_Id(member_Id);
					System.out.println("[미리보기 댓글 - 2] 댓글 좋아요 눌렀나 확인하러 보냄");				
					String reply_LikeYN = replyService.checkReplyLike(voForReplyCheck);
					replylist.get(k).setReply_LikeYN(reply_LikeYN);
					System.out.println("[미리보기 댓글 - 5] DAO에서 리턴받아서 set해줌. 해당 댓글 좋아요 누름 ? " + replylist.get(k).getReply_LikeYN());
					replylist.get(k).setMember_Id(realReply_Member_Id);
				}
				
				// i번째의 게시글의 댓글을 map에 매핑하는 작업
				replymap.put(i, replylist);
				System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));			
				
				// i번째 게시글의 좋아요 여부 체크
				PostVO voForLikeYN = new PostVO();
				voForLikeYN.setMember_Id(member_Id);
				voForLikeYN.setPost_Seq(post_Seq);
				System.out.println("[좋아요 여부 확인 - 0] 게시글 번호 : " + post_Seq);
				System.out.println("[좋아요 여부 확인 - 1] Setting 전 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
				String post_LikeYN = postService.getLikeYN(voForLikeYN);
				postlist.get(i).setPost_LikeYN(post_LikeYN);
				System.out.println("[좋아요 여부 확인 - 4] Setting 후 post_LikeYN = " + postlist.get(i).getPost_LikeYN());
				
			}
			
			// 전체 회원 프로필 이미지 조회
			HashMap<String, String> profilemap = memberService.getMemberProfile();
			System.out.println("전체 회원 프로필: " + profilemap);
			
			model.addAttribute("profileMap", profilemap);
			model.addAttribute("postList", postlist);
			model.addAttribute("replyMap", replymap);
			model.addAttribute("recommendMember", recommendMember);
			model.addAttribute("hottestFeed", hottestFeed);	
			return "index";
		}
	}
	
	@GetMapping("/follow")
	public String getFollow(Model model, HttpSession session, @RequestParam String member_Id) {
		
		if(session.getAttribute("loginUser") == null) {
			
			System.out.println("세션값 없음");
			
			model.addAttribute("message", "로그인을 해주세요");
			
			return "login";
			
		} else {
			
			System.out.println("세션값 존재");			
			
			List<FollowVO> following_Id = followService.getFollowing(member_Id);
			
			List<FollowVO> follower_Id = followService.getFollower(member_Id);
			
			List<MemberVO> following_info = new ArrayList<MemberVO>();
			
			List<MemberVO> follower_info = new ArrayList<MemberVO>();
			
			for(FollowVO id : following_Id) {
				
				MemberVO following_member = memberService.getMemberInfo(id.getFollowing());
				
				if(following_member == null) {
					System.out.println("팔로잉 멤버 빈 칸");
				}else {
					following_info.add(following_member);
					System.out.println("팔로잉 멤버 : " + following_member);
				}
			}
			
			for(FollowVO id : follower_Id) {
				
				MemberVO follower_member = memberService.getMemberInfo(id.getFollower());
				
					if(follower_member == null) {
					System.out.println("팔로워 멤버 빈 칸");
				}else {
					follower_info.add(follower_member);
					System.out.println("팔로워 멤버 : " + follower_member);
				}
			}
			
			System.out.println("팔로잉 수 : " + following_info.size());
			System.out.println("팔로워 수 : " + follower_info.size());
			
			int followingTotalPageNum = 1;
			
			if(following_info.size() % 10 != 0 && following_info.size() > 10) {
				followingTotalPageNum = following_info.size() / 10 + 1;
			}else if(following_info.size() % 10 != 0 && following_info.size() < 10) {
				followingTotalPageNum = 1;
			}else if(following_info.size() % 10 == 0) {
				followingTotalPageNum = following_info.size() / 10;
			}
			
			int followerTotalPageNum = 1;
			
			if(follower_info.size() % 10 != 0 && follower_info.size() > 10) {
				followerTotalPageNum = follower_info.size() / 10 + 1;
			}else if(follower_info.size() % 10 != 0 && follower_info.size() < 10) {
				followerTotalPageNum = 1;
			}else if(follower_info.size() % 10 == 0) {
				followerTotalPageNum = follower_info.size() / 10;
			}
			
			System.out.println("팔로잉 페이지 수 : " + followingTotalPageNum);
			System.out.println("팔로워 페이지 수 : " + followerTotalPageNum);
			
			
			int followingLoadRow = 10;
			
			if(following_info.size() <= 10) {
				followingLoadRow = following_info.size();
			}
			
			int followerLoadRow = 10;
			
			if(follower_info.size() <= 10) {
				followerLoadRow = follower_info.size();
			}
			
			
			
			for(int i = 0; i < followerLoadRow; i++) {
				System.out.println("팔로워 아이디");
				System.out.println(follower_info.get(i).getMember_Id());
				for(int j = 0; j < followingLoadRow; j++) {
					System.out.println("팔로잉 아이디");
					System.out.println(following_info.get(j).getMember_Id());
					if(follower_info.get(i).getMember_Id().equals(following_info.get(j).getMember_Id())) {
						follower_info.get(i).setBothFollow(1);
						System.out.println("setBoth 입력 확인 : " + follower_info.get(i).getBothFollow());
					}
				}
			}
			
			System.out.println("팔로잉 출력 행 수 : " + followingLoadRow);
			System.out.println("팔로워 출력 행 수 : " + followerLoadRow);

			model.addAttribute("following", following_info);
			model.addAttribute("followingLoadRow", followingLoadRow);
			model.addAttribute("followingTotalPageNum", followingTotalPageNum);
			model.addAttribute("followingPageNum", 1);
			
			model.addAttribute("follower", follower_info);
			model.addAttribute("followerLoadRow", followerLoadRow);
			model.addAttribute("followerTotalPageNum", followerTotalPageNum);
			model.addAttribute("followerPageNum", 1);
			
			// 화면 우측 Hottest Feed
			List<PostVO> hottestFeed = postService.getHottestFeed();
			model.addAttribute("hottestFeed", hottestFeed);	
			
			//model.addAttribute("following_Id", following_Id);
			//model.addAttribute("following_size", following_Id.size());
			
			return "follow";
		
		}
	}	
	
	// 팔로우 변경
	@PostMapping("/changeFollow")
	@ResponseBody   
	public String changeFollow(@RequestBody String member_Id, HttpSession session) {
		System.out.println("[팔로우, 언팔로우 - 3] PostMapping으로 /changeFollow 잡아옴, 대상유저 아이디 : " + member_Id);
		String follower = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		System.out.println("[팔로우, 언팔로우 - 4] 세션에서 로그인 유저 아이디 받아와서 follower에 담음 : " + follower);
		try {
			System.out.println("[팔로우, 언팔로우 - 5 - try] js에서 data에 넣은게 {member_Id: 아이디} 이런 식이니까 거기서 꺼내는 과정이 필요");
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(member_Id);
			  
			String following = jsonNode.get("member_Id").asText();
			
			System.out.println("[팔로우, 언팔로우 - 6] 꺼내서 following에 담고 follower와 following을 FollowVO 객체에 담아줌");
			FollowVO vo = new FollowVO();
			vo.setFollower(follower);
			vo.setFollowing(following);
		
			System.out.println("[팔로우, 언팔로우 - 7] FollowVO객체 vo를 가지고 changeFollow() 요청");
			memberService.changeFollow(vo);
			System.out.println("[팔로우, 언팔로우 - 12] changeFollow 하고 js에 success 리턴");
			return "success";
		} catch (Exception e) {
			System.out.println("[팔로우, 언팔로우 - 5 - catch] JSON 파싱 오류난 경우");
			// JSON 파싱 오류 처리
			e.printStackTrace();
			return "error";
		}
	}

	@PostMapping("/moreLoadFollowing")
	@ResponseBody
	public Map<String, Object> moreLoadFollwing(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
		

		// 0. ajax요청에 대한 response값 전달을 위한 Map 변수 선언
		Map<String, Object> dataMap = new HashMap<>();
		
		// 1. ajax에서 받아온 객체 받아놓기
		int followingTotalPageNum = requestBody.get("followingTotalPageNum");
	    int followingPageNum = requestBody.get("followingPageNum");
		
		
	    //[팔로우, 언팔로우 - 3] PostMapping으로 /moreLoadFollwing 잡아옴, 총 페이지 수 : followerTotalPageNum
		String sessionId = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		
		System.out.println("if이전 현재 페이지 넘버 : "+ followingPageNum);
		System.out.println("if이전 전체 페이지 수 : " + followingTotalPageNum);
		
		int LocalPageFirstNum = followingPageNum*10+1;
		int LocalPageLastNum = followingPageNum*10+10;
		
		if(followingPageNum < followingTotalPageNum) {
			followingPageNum++;
		}else {
			System.out.println("현재 페이지 넘버와 전체 페이지 넘버와 같거나 커서 스탑");
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다1");
			return dataMap;
		}
		
		System.out.println("if이후 : " + followingPageNum);
		
		FollowVO followVo = new FollowVO();
		
		followVo.setFollower(sessionId);
		followVo.setFollowingLocalPageFirstNum(LocalPageFirstNum);
		followVo.setFollowingLocalPageLastNum(LocalPageLastNum);
		
		System.out.println("첫번째 행 : " + LocalPageFirstNum);
		System.out.println("마지막 행 : " + LocalPageLastNum);
		
		System.out.println(sessionId);
		
		// 팔로워 추가 로드하기(행~행 조건으로 조회)
		List<FollowVO> following_Id  = followService.getMoreFollowing(followVo);
		
		if(following_Id == null) {
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다2");
			return dataMap;
		}else if(following_Id.size() == 0) {
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다3");
			return dataMap;
		}
		
		List<MemberVO> following_info = new ArrayList<MemberVO>();
		
		for(FollowVO id : following_Id) {
			
			MemberVO following_member = memberService.getMemberInfo(id.getFollowing());
			
			if(following_member == null) {
				System.out.println("팔로잉 멤버 빈 칸");
			}else {
				following_info.add(following_member);
				System.out.println("팔로잉 멤버 : " + following_member);
			}
		}
		
		
		dataMap.put("following_info", following_info);
		dataMap.put("following_size", following_Id.size());
		dataMap.put("followingPageNum", followingPageNum);
		dataMap.put("followingTotalPageNum", followingTotalPageNum);
		

		return dataMap;
		
	}
	
	
	@PostMapping("/moreLoadFollower")
	@ResponseBody
	public Map<String, Object> moreLoadFollwer(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
		
		// 0. ajax요청에 대한 response값 전달을 위한 Map 변수 선언
		Map<String, Object> dataMap = new HashMap<>();
		
		// 1. ajax에서 받아온 객체 받아놓기
		int followerTotalPageNum = requestBody.get("followerTotalPageNum");
	    int followerPageNum = requestBody.get("followerPageNum");
	    
	    System.out.println("토탈 페이지 넘버 : " + followerTotalPageNum);
	    System.out.println("현재 페이지 넘버 : " + followerPageNum);
		
		
	    //[팔로우, 언팔로우 - 3] PostMapping으로 /moreLoadFollwing 잡아옴, 총 페이지 수 : followerTotalPageNum
		String sessionId = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		
		System.out.println("if이전 현재 페이지 넘버 : "+ followerPageNum);
		System.out.println("if이전 전체 페이지 수 : " + followerTotalPageNum);
		
		int LocalPageFirstNum = followerPageNum*10+1;
		int LocalPageLastNum = followerPageNum*10+10;
		
		if(followerPageNum < followerTotalPageNum) {
			followerPageNum++;
		}else {
			System.out.println("현재 페이지 넘버와 전체 페이지 넘버와 같거나 커서 스탑");
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다1");
			return dataMap;
		}
		
		System.out.println("if이후 현재 페이지 넘버 : " + followerPageNum);
		
		
		
		FollowVO followVo = new FollowVO();
		
		followVo.setFollowing(sessionId);
		followVo.setFollowerLocalPageFirstNum(LocalPageFirstNum);
		followVo.setFollowerLocalPageLastNum(LocalPageLastNum);
		
		System.out.println("첫번째 행 : " + LocalPageFirstNum);
		System.out.println("마지막 행 : " + LocalPageLastNum);
		
		// 팔로워 추가 로드하기(행~행 조건으로 조회)
		List<FollowVO> follower_Id  = followService.getMoreFollower(followVo);
		
		
		if(follower_Id == null) {
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다2");
			return dataMap;
		}else if(follower_Id.size() == 0) {
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다3");
			return dataMap;
		}
		
		List<MemberVO> follower_info = new ArrayList<MemberVO>();
		
		for(FollowVO id : follower_Id) {
			
			MemberVO follower_member = memberService.getMemberInfo(id.getFollower());
			
			if(follower_member == null) {
				System.out.println("팔로워 멤버 빈 칸");
			}else {
				follower_info.add(follower_member);
				System.out.println("팔로워 멤버 : " + follower_member);
			}
		}
		
		//로드한 팔로워에서 내가 팔로잉한 사람이 있는지 비교하기 위해 팔로잉 멤버를 조회
		List<FollowVO> following_Id = followService.getFollowing(sessionId);
		
		
		dataMap.put("follower_size", follower_Id.size());
		dataMap.put("followerPageNum", followerPageNum);
		dataMap.put("followerTotalPageNum", followerTotalPageNum);
		dataMap.put("follower_info", follower_info);
		dataMap.put("following_Id", following_Id);
		dataMap.put("following_size", following_Id.size());

		return dataMap;
		
	}
	
	// 좋아요 변경(PostMapping)
	@PostMapping("/changeLike")
	@ResponseBody
	public String changeLike(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
	    System.out.println("[게시글 좋아요 - 3] PostMapping으로 /changeLike 를 Map 형식으로 잡아옴.");
	    int post_Seq = requestBody.get("post_Seq");
	    String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	    System.out.println("[게시글 좋아요 - 4] 세션에서 로그인 유저 아이디 받아옴 member_Id = " + member_Id);
	    try {
	        LikeVO vo = new LikeVO();
	        vo.setMember_Id(member_Id);
	        vo.setPost_Seq(post_Seq);

	        System.out.println("[게시글 좋아요 - 5] LikeVO객체 vo를 가지고 changeLike() 요청 시작");
	        postService.changeLike(vo);
	        System.out.println("[게시글 좋아요 - 9] changeLike 하고 js에 success 리턴");
	        return "success";
	    } catch (Exception e) {
	        System.out.println("[좋아요 - 5 - catch] JSON 파싱 오류난 경우");
	        // JSON 파싱 오류 처리
	        e.printStackTrace();
	        return "error";
	    }
	}
	
	// 미리보기 댓글 좋아요 변경
	@PostMapping("/changeReplyLike")
	@ResponseBody
	public String changeReplyLike(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
	    System.out.println("[미리보기 댓글 좋아요 - 3] PostMapping으로 /changeReplyLike 를 Map 형식으로 잡아옴.");
	    int post_Seq = requestBody.get("post_Seq");
	    int reply_Seq = requestBody.get("reply_Seq");
	    String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	    System.out.println("[미리보기 댓글 좋아요 - 4] 세션에서 로그인 유저 아이디 받아옴 member_Id = " + member_Id);
	    try {
	        LikeVO vo = new LikeVO();
	        vo.setMember_Id(member_Id);
	        vo.setPost_Seq(post_Seq);
	        vo.setReply_Seq(reply_Seq);
	        
	        System.out.println("[게시글 좋아요 - 5] LikeVO객체 vo를 가지고 changeLike() 요청 시작");
	        replyService.changeReplyLike(vo);
	        System.out.println("[게시글 좋아요 - 9] changeLike 하고 js에 success 리턴");
	        return "success";
	    } catch (Exception e) {
	        System.out.println("[좋아요 - 5 - catch] JSON 파싱 오류난 경우");
	        // JSON 파싱 오류 처리
	        e.printStackTrace();
	        return "error";
	    }
	}
	
	// 게시글 작성
	@PostMapping("/insertPost")
	public String insertPost(PostVO vo, @RequestParam("uploadImgs") MultipartFile[] uploadImgs) {
		
		System.out.println("insertPost vo : " + vo);
		System.out.println("insertPost file : " + uploadImgs.length);
		
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
		ArrayList<ReplyVO> replyList = replyService.listReply(post_Seq);
		
        // 3. 전체 회원 프로필 이미지 조회
		HashMap<String, String> profileMap = (HashMap<String, String>) session.getAttribute("profileMap");
		System.out.println("세션객체에 profileMap값 불러옴 : " + profileMap);
		

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
			String reply_LikeYN = replyService.checkReplyLike(replyLikeYN);
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
		ArrayList<ReplyVO> replyList = replyService.listReply(post_Seq);
		
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
			String reply_LikeYN = replyService.checkReplyLike(replyLikeYN);
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
		System.out.println("컨트롤러의 포스트 시퀀스: " + post_Seq + ", 컨트롤러의 리플라이 컨텐츠: " + reply_Content);
		
		// 0. ajax요청에 대한 response값 전달을 위한 Map 변수 선언
		Map<String, Object> dataMap = new HashMap<>();
		
		// 1. 세션객체인 'loginUfser'객체를 MemberVO 객체로 강제 파싱해서 getter 메소드인 getMember_Id를 호출해 아이디를 가져온다.
		String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		System.out.println("세션 아이디: " + member_Id);

		// 2. insert쿼리문에 파라미터 객체로 보낼 변수선언
		ReplyVO rep = new ReplyVO();
		rep.setMember_Id(member_Id);
		rep.setPost_Seq(post_Seq);
		rep.setReply_Content(reply_Content);
		System.out.println("인서트 쿼리문에 보낼 객체 내용물: " + rep);
		
		// 3. insert쿼리문 실행
		replyService.insertReply(rep);
		
		// 4. 게시글의 댓글리스트를 출력하기 위한 ArrayList<ReplyVO> 값 저장
		ArrayList<ReplyVO> replyList = replyService.listReply(post_Seq);
		
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
			String reply_LikeYN = replyService.checkReplyLike(replyLikeYN);
			replyList.get(i).setReply_LikeYN(reply_LikeYN);
		}
		
		// 8. ajax의 응답성공(success)의 response로 들어갈 값들 매핑
		dataMap.put("postInfo", postInfo);
		dataMap.put("replies", replyList);
		dataMap.put("profile", profileMap);
		
		return dataMap;
	}

	// PEOPLE 탭 List 가져오기
	@GetMapping("/people_List")
	public ResponseEntity<Map<String, Object>> people_List(HttpSession session, Model model) {
	    System.out.println("[PEOPLE 탭 - 3] people_List GET MAPPING으로 옴");
	    String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	    
	    List<MemberVO> canFollow = memberService.getRecommendMember(member_Id);
	    System.out.println("[PEOPLE 탭 - 4] CAN FOLLOW LIST를 받아오기 성공");
	    
	    List<MemberVO> mostFamous = memberService.getMostFamousMember();
	    for(MemberVO vo : mostFamous) {
	        System.out.println(vo);
	    }
	    System.out.println("[PEOPLE 탭 - 7] MOST FAMOUS LIST를 받아오기 성공");
	    
	    Map<String, Object> responseData = new HashMap<>();
	    responseData.put("canFollow", canFollow);
	    responseData.put("mostFamous", mostFamous);
	    
	    return ResponseEntity.ok(responseData);
	}

	// Profile 이동
	@GetMapping("/profile")
	public String makeProfile(@RequestParam("member_Id") String member_Id, Model model, HttpSession session) {
		System.out.println("[프로필 페이지 - 1] GET MAPPING으로 MainController로 옴. 프로필 대상 : " + member_Id);
		MemberVO member = memberService.getMember(member_Id);
		String loginUser_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		
		// 팔로워 팔로우 숫자 밑에 작은 동그라미 이미지들 채울 용도
		List<MemberVO> followers = memberService.getFollowers(member_Id);
		int followers_Size = followers.size();
		List<MemberVO> followings = memberService.getFollowings(member_Id);
		int followings_Size = followings.size();
		model.addAttribute("followers", followers);
		model.addAttribute("followers_Size", followers_Size);
		model.addAttribute("followings", followings);
		model.addAttribute("followings_Size", followings_Size);
		
		System.out.println("[프로필 페이지] 대상 멤버 vo");
		System.out.println(member);
		// 내가 쓴 글을 postlist에 담음
		ArrayList<PostVO> postlist = postService.getMemberPost(member_Id);
		System.out.println("[프로필 페이지] "+ member_Id + "가 쓴 글 리스트 시작");
		for(PostVO abc : postlist) {
			System.out.println(abc);
		}
		System.out.println("[프로필 페이지] " + member_Id + "가 쓴 글 리스트 끝");
		System.out.println("[프로필 페이지 - 2] 해당 멤버의 정보와 작성한 포스트들을 담아옴");		
		
		// 각 post_seq에 대한 댓글들을 매핑할 공간.
		Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();
				
		// 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
		// 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
		for(int i = 0; i < postlist.size(); i++) {
			
			int post_Seq = postlist.get(i).getPost_Seq();
			
			// i번째 게시글의 댓글 리스트를 담음
			ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
			System.out.println("[프로필 페이지] " + i +"번재 게시글의 미리보기 댓글 리스트 시작");
			for(ReplyVO abc : replylist) {
				System.out.println(abc);
			}
			System.out.println("[프로필 페이지] " + (i) +"번재 게시글의 미리보기 댓글 리스트 끝");
			// i번째 게시글의 댓글 좋아요 여부 체크
			for(int k = 0; k < replylist.size(); k++) {
				ReplyVO voForReplyCheck = replylist.get(k);
				String realReply_Member_Id = replylist.get(k).getMember_Id();
				voForReplyCheck.setMember_Id(loginUser_Id);		
				String reply_LikeYN = replyService.checkReplyLike(voForReplyCheck);
				replylist.get(k).setReply_LikeYN(reply_LikeYN);
				replylist.get(k).setMember_Id(realReply_Member_Id);
				System.out.println("[프로필 페이지] " + i+ "번재 게시글의 " + (k) + "번째 댓글 좋아요 여부 : " + reply_LikeYN);

				System.out.println("[프로필 페이지 - 3] 해당 댓글 좋아요 눌렀나 체크됨");
			}
			
			// i번째의 게시글의 댓글을 map에 매핑하는 작업
			replymap.put(i, replylist);
			System.out.println("[프로필 페이지 - 4] 게시글 별 댓글을 매핑함");		
			
			// i번째 게시글의 좋아요 여부 체크
			PostVO voForLikeYN = new PostVO();
			voForLikeYN.setMember_Id(loginUser_Id);
			voForLikeYN.setPost_Seq(post_Seq);
			String post_LikeYN = postService.getLikeYN(voForLikeYN);
			int post_Like_Count = postService.getPost_Like_Count(post_Seq);
			postlist.get(i).setPost_Like_Count(post_Like_Count);
			postlist.get(i).setPost_LikeYN(post_LikeYN);
			System.out.println("[프로필 페이지 - 5] " + i + "번째 게시글 좋아요 눌렀나 체크됨 : " + post_LikeYN);
			
		}
		
		// 전체 회원 프로필 이미지 조회
		HashMap<String, String> profilemap = memberService.getMemberProfile();
		System.out.println("전체 회원 프로필: " + profilemap);
		
		System.out.println("[프로필 페이지 - 6] 출력준비를 위한 postvo 준비");
		for(PostVO abc : postlist) {
			System.out.println(abc);
		}
		System.out.println("[프로필 페이지 - 6] 출력준비 완료");
		
		// 화면 우측 Hottest Feed
		List<PostVO> hottestFeed = postService.getHottestFeed();
		
		model.addAttribute("member", member);
		model.addAttribute("postlist", postlist);
		model.addAttribute("profileMap", profilemap);
		model.addAttribute("replyMap", replymap);
		model.addAttribute("hottestFeed", hottestFeed);	
		return "profile";
	}
	
	 @GetMapping("trending_List")
	   public ResponseEntity<Map<String, Object>> trending_List(HttpSession session, Model model) {
	      
	      System.out.println("[멤버추천 - 1] 로그인 후 trending_List 요청하면 GetMapping으로 잡아오고 세션의 loginUser에서 Id 뽑아서 member_Id에 저장");
	      String member_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
	      
	      System.out.println("[인기글 - 1] index에서 tranding tab요청하면 js가 잡아서 던짐  GetMapping으로 잡아옴");
	       System.out.println("[인기글 - 2] postService에 getHottestFeed 요청");
	       List<PostVO> hottestFeed = postService.getHottestFeed();
	       System.out.println("[인기글 - 5] DAO에서 hottestFeed 받아와서 List에 저장하고 model에 올림");
	      
	      
	      // 각 post_seq에 대한 댓글들을 매핑할 공간.
	      Map<Integer, ArrayList<ReplyVO>> replymap = new HashMap<>();
	      
	      // 정렬된 postlist의 인덱스 순으로 댓글 리스트를 매핑함.
	      // 동시에 각 게시글의 좋아요 카운트와 댓글 카운트를 저장.
	      for(int i=0; i<hottestFeed.size(); i++) {
	         // 자신, 팔로잉한 사람들의 게시글의 post_seq를 불러온다.
	         int post_Seq = hottestFeed.get(i).getPost_Seq();
	         
	         // i번째 게시글의 댓글 리스트를 담음
	         ArrayList<ReplyVO> replylist = replyService.getReplyPreview(post_Seq);
	         System.out.println("replylist로 담음");
	         System.out.println("[미리보기 댓글 - 1] replylist에 해당 게시글의 댓글 3개를 가져옴 / 아직 해당 댓글 좋아요 눌렀나 체크는 안됨");
	         System.out.println("[미리보기 댓글 - 1.5] replylist size : " + replylist.size());
	         // i번째 게시글의 댓글 좋아요 여부 체크
	         for(int k = 0; k < replylist.size(); k++) {
	            ReplyVO voForReplyCheck = replylist.get(k);
	            String realReply_Member_Id = replylist.get(k).getMember_Id();
	            voForReplyCheck.setMember_Id(member_Id);
	            System.out.println("[미리보기 댓글 - 2] 댓글 좋아요 눌렀나 확인하러 보냄");            
	            String reply_LikeYN = replyService.checkReplyLike(voForReplyCheck);
	            replylist.get(k).setReply_LikeYN(reply_LikeYN);
	            System.out.println("[미리보기 댓글 - 5] DAO에서 리턴받아서 set해줌. 해당 댓글 좋아요 누름 ? " + replylist.get(k).getReply_LikeYN());
	            replylist.get(k).setMember_Id(realReply_Member_Id);
	         }
	         
	         // i번째의 게시글의 댓글을 map에 매핑하는 작업
	         replymap.put(i, replylist);
	         System.out.println(i + "번째 게시글 댓글 여부" + replymap.get(i));         
	         
	         // i번째 게시글의 좋아요 여부 체크
	         PostVO voForLikeYN = new PostVO();
	         voForLikeYN.setMember_Id(member_Id);
	         voForLikeYN.setPost_Seq(post_Seq);
	         System.out.println("[좋아요 여부 확인 - 0] 게시글 번호 : " + post_Seq);
	         System.out.println("[좋아요 여부 확인 - 1] Setting 전 post_LikeYN = " + hottestFeed.get(i).getPost_LikeYN());
	         String post_LikeYN = postService.getLikeYN(voForLikeYN);
	         hottestFeed.get(i).setPost_LikeYN(post_LikeYN);
	         System.out.println("[좋아요 여부 확인 - 4] Setting 후 post_LikeYN = " + hottestFeed.get(i).getPost_LikeYN());
	         
	      }
	      
	      
	      // 전체 회원 프로필 이미지 조회
	      HashMap<String, String> profilemap = memberService.getMemberProfile();
	      
	      
	      
	      System.out.println("전체 회원 프로필: " + profilemap);
	      
	      Map<String, Object> responseData = new HashMap<>();
	      
	      responseData.put("session_Id", member_Id);
	      responseData.put("trending_profileMap", profilemap);
	      responseData.put("trending_postList", hottestFeed);
	      responseData.put("trending_replyMap", replymap);
	      
	      return ResponseEntity.ok(responseData);
	   }
}
