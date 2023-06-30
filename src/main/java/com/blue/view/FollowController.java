package com.blue.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.blue.dto.AlarmVO;
import com.blue.dto.FollowVO;
import com.blue.dto.MemberVO;
import com.blue.dto.PostVO;
import com.blue.service.AlarmService;
import com.blue.service.FollowService;
import com.blue.service.MemberService;
import com.blue.service.PostService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
//컨트롤러에서 'loginUser', 'profileMap' 이라는 이름으로 모델 객체를 생성할때 세션에 동시에 저장한다.
@SessionAttributes({"loginUser", "profileMap"})	
public class FollowController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private PostService postService;
	@Autowired
	private FollowService followService;
	@Autowired
	private AlarmService alarmService;
	
	@GetMapping("/follow")
	public String getFollow(Model model, HttpSession session, @RequestParam String member_Id) {
		
		if(session.getAttribute("loginUser") == null) {
			
			//System.out.println("세션값 없음");			
			model.addAttribute("message", "로그인을 해주세요");			
			
			return "login";			
		} else {
			
			String session_Id = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
			
			String profileImage = memberService.getMemberInfo(member_Id).getMember_Profile_Image();


			
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
			
			//System.out.println("세션값 존재");			
			List<FollowVO> following_Id = followService.getFollowing(member_Id);			
			List<FollowVO> follower_Id = followService.getFollower(member_Id);			
			List<MemberVO> following_info = new ArrayList<MemberVO>();			
			List<MemberVO> follower_info = new ArrayList<MemberVO>();
			
			for(FollowVO id : following_Id) {
				
				MemberVO following_member = memberService.getMemberInfo(id.getFollowing());				
				if(following_member == null) {
					
					//System.out.println("팔로잉 멤버 빈 칸");
				} else {
					
					following_info.add(following_member);
					//System.out.println("팔로잉 멤버 : " + following_member);
				}
			}
			
			for(FollowVO id : follower_Id) {
				
				MemberVO follower_member = memberService.getMemberInfo(id.getFollower());
				
				if(follower_member == null) {
					// System.out.println("팔로워 멤버 빈 칸");
				} else {
					follower_info.add(follower_member);
					//System.out.println("팔로워 멤버 : " + follower_member);
				}
			}
			
			//System.out.println("팔로잉 수 : " + following_info.size());
			//System.out.println("팔로워 수 : " + follower_info.size());
			
			int followingTotalPageNum = 1;
			
			if(following_info.size() % 10 != 0 && following_info.size() > 10) {
				followingTotalPageNum = following_info.size() / 10 + 1;
			} else if(following_info.size() % 10 != 0 && following_info.size() < 10) {
				followingTotalPageNum = 1;
			} else if(following_info.size() % 10 == 0) {
				followingTotalPageNum = following_info.size() / 10;
			}
			
			int followerTotalPageNum = 1;
			
			if(follower_info.size() % 10 != 0 && follower_info.size() > 10) {
				followerTotalPageNum = follower_info.size() / 10 + 1;
			} else if(follower_info.size() % 10 != 0 && follower_info.size() < 10) {
				followerTotalPageNum = 1;
			} else if(follower_info.size() % 10 == 0) {
				followerTotalPageNum = follower_info.size() / 10;
			}
			
			//System.out.println("팔로잉 페이지 수 : " + followingTotalPageNum);
			//System.out.println("팔로워 페이지 수 : " + followerTotalPageNum);			
			
			int followingLoadRow = 10;
			
			if(following_info.size() <= 10) {
				followingLoadRow = following_info.size();
			}
			
			int followerLoadRow = 10;
			
			if(follower_info.size() <= 10) {
				followerLoadRow = follower_info.size();
			}
			
			for(int i = 0; i < followerLoadRow; i++) {
				//System.out.println("팔로워 아이디");
				//System.out.println(follower_info.get(i).getMember_Id());
				for(int j = 0; j < followingLoadRow; j++) {
					//System.out.println("팔로잉 아이디");
					//System.out.println(following_info.get(j).getMember_Id());
					if(follower_info.get(i).getMember_Id().equals(following_info.get(j).getMember_Id())) {
						follower_info.get(i).setBothFollow(1);
						//System.out.println("setBoth 입력 확인 : " + follower_info.get(i).getBothFollow());
					}
				}
			}
			
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
			
			model.addAttribute("profileImage", profileImage);

			
			model.addAttribute("alarmList", alarmList);
			model.addAttribute("alarmListSize", alarmListSize);
			
			return "follow";
		
		}
	}	
	
	// 팔로우 변경
	@PostMapping("/changeFollow")
	@ResponseBody   
	public String changeFollow(@RequestBody String member_Id, HttpSession session) {
		//System.out.println("[팔로우, 언팔로우 - 3] PostMapping으로 /changeFollow 잡아옴, 대상유저 아이디 : " + member_Id);
		String follower = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		//System.out.println("[팔로우, 언팔로우 - 4] 세션에서 로그인 유저 아이디 받아와서 follower에 담음 : " + follower);
		try {
			//System.out.println("[팔로우, 언팔로우 - 5 - try] js에서 data에 넣은게 {member_Id: 아이디} 이런 식이니까 거기서 꺼내는 과정이 필요");
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(member_Id);
			  
			String following = jsonNode.get("member_Id").asText();
			
			//System.out.println("[팔로우, 언팔로우 - 6] 꺼내서 following에 담고 follower와 following을 FollowVO 객체에 담아줌");
			FollowVO vo = new FollowVO();
			vo.setFollower(follower);
			vo.setFollowing(following);
		
			//System.out.println("[팔로우, 언팔로우 - 7] FollowVO객체 vo를 가지고 changeFollow() 요청");
			memberService.changeFollow(vo);
			//System.out.println("[팔로우, 언팔로우 - 12] changeFollow 하고 js에 success 리턴");
			
			return "success";
		} catch (Exception e) {
			//System.out.println("[팔로우, 언팔로우 - 5 - catch] JSON 파싱 오류난 경우");
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
		
		//System.out.println("if이전 현재 페이지 넘버 : "+ followingPageNum);
		//System.out.println("if이전 전체 페이지 수 : " + followingTotalPageNum);
		
		int LocalPageFirstNum = followingPageNum*10+1;
		int LocalPageLastNum = followingPageNum*10+10;
		
		if(followingPageNum < followingTotalPageNum) {
			followingPageNum++;
		} else {
			//System.out.println("현재 페이지 넘버와 전체 페이지 넘버와 같거나 커서 스탑");
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다1");
			return dataMap;
		}
		
		//System.out.println("if이후 : " + followingPageNum);
		
		FollowVO followVo = new FollowVO();
		
		followVo.setFollower(sessionId);
		followVo.setFollowingLocalPageFirstNum(LocalPageFirstNum);
		followVo.setFollowingLocalPageLastNum(LocalPageLastNum);
		
		//System.out.println("첫번째 행 : " + LocalPageFirstNum);
		//System.out.println("마지막 행 : " + LocalPageLastNum);
		
		//System.out.println(sessionId);
		
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
				//System.out.println("팔로잉 멤버 빈 칸");
			}else {
				following_info.add(following_member);
				//System.out.println("팔로잉 멤버 : " + following_member);
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
	    
	    //System.out.println("토탈 페이지 넘버 : " + followerTotalPageNum);
	    //System.out.println("현재 페이지 넘버 : " + followerPageNum);
				
	    //[팔로우, 언팔로우 - 3] PostMapping으로 /moreLoadFollwing 잡아옴, 총 페이지 수 : followerTotalPageNum
		String sessionId = ((MemberVO) session.getAttribute("loginUser")).getMember_Id();
		
		//System.out.println("if이전 현재 페이지 넘버 : "+ followerPageNum);
		//System.out.println("if이전 전체 페이지 수 : " + followerTotalPageNum);
		
		int LocalPageFirstNum = followerPageNum*10+1;
		int LocalPageLastNum = followerPageNum*10+10;
		
		if(followerPageNum < followerTotalPageNum) {
			followerPageNum++;
		} else {
			//System.out.println("현재 페이지 넘버와 전체 페이지 넘버와 같거나 커서 스탑");
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다1");
			return dataMap;
		}
		
		//System.out.println("if이후 현재 페이지 넘버 : " + followerPageNum);
		
		FollowVO followVo = new FollowVO();
		
		followVo.setFollowing(sessionId);
		followVo.setFollowerLocalPageFirstNum(LocalPageFirstNum);
		followVo.setFollowerLocalPageLastNum(LocalPageLastNum);
		
		//System.out.println("첫번째 행 : " + LocalPageFirstNum);
		//System.out.println("마지막 행 : " + LocalPageLastNum);
		
		// 팔로워 추가 로드하기(행~행 조건으로 조회)
		List<FollowVO> follower_Id  = followService.getMoreFollower(followVo);
				
		if(follower_Id == null) {
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다2");
			return dataMap;
		} else if(follower_Id.size() == 0) {
			dataMap.put("message", "불러올 데이터가 존재하지 않습니다3");
			return dataMap;
		}
		
		List<MemberVO> follower_info = new ArrayList<MemberVO>();
		
		for(FollowVO id : follower_Id) {
			
			MemberVO follower_member = memberService.getMemberInfo(id.getFollower());
			
			if(follower_member == null) {
				//System.out.println("팔로워 멤버 빈 칸");
			} else {
				follower_info.add(follower_member);
				//System.out.println("팔로워 멤버 : " + follower_member);
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
	
	@GetMapping("/alarmFollow")
	public String alarmFollow(Model model, HttpSession session, @RequestParam String member_Id, @RequestParam int alarm_Seq) {
		
		if(session.getAttribute("loginUser") == null) {
			
			//System.out.println("세션값 없음");			
			model.addAttribute("message", "로그인을 해주세요");			
			
			return "login";			
		} else {
			
			//알람 삭제
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
			
			//System.out.println("세션값 존재");			
			List<FollowVO> following_Id = followService.getFollowing(member_Id);			
			List<FollowVO> follower_Id = followService.getFollower(member_Id);			
			List<MemberVO> following_info = new ArrayList<MemberVO>();			
			List<MemberVO> follower_info = new ArrayList<MemberVO>();
			
			for(FollowVO id : following_Id) {
				
				MemberVO following_member = memberService.getMemberInfo(id.getFollowing());				
				if(following_member == null) {
					
					//System.out.println("팔로잉 멤버 빈 칸");
				} else {
					
					following_info.add(following_member);
					//System.out.println("팔로잉 멤버 : " + following_member);
				}
			}
			
			for(FollowVO id : follower_Id) {
				
				MemberVO follower_member = memberService.getMemberInfo(id.getFollower());
				
				if(follower_member == null) {
					// System.out.println("팔로워 멤버 빈 칸");
				} else {
					follower_info.add(follower_member);
					//System.out.println("팔로워 멤버 : " + follower_member);
				}
			}
			
			//System.out.println("팔로잉 수 : " + following_info.size());
			//System.out.println("팔로워 수 : " + follower_info.size());
			
			int followingTotalPageNum = 1;
			
			if(following_info.size() % 10 != 0 && following_info.size() > 10) {
				followingTotalPageNum = following_info.size() / 10 + 1;
			} else if(following_info.size() % 10 != 0 && following_info.size() < 10) {
				followingTotalPageNum = 1;
			} else if(following_info.size() % 10 == 0) {
				followingTotalPageNum = following_info.size() / 10;
			}
			
			int followerTotalPageNum = 1;
			
			if(follower_info.size() % 10 != 0 && follower_info.size() > 10) {
				followerTotalPageNum = follower_info.size() / 10 + 1;
			} else if(follower_info.size() % 10 != 0 && follower_info.size() < 10) {
				followerTotalPageNum = 1;
			} else if(follower_info.size() % 10 == 0) {
				followerTotalPageNum = follower_info.size() / 10;
			}
			
			//System.out.println("팔로잉 페이지 수 : " + followingTotalPageNum);
			//System.out.println("팔로워 페이지 수 : " + followerTotalPageNum);			
			
			int followingLoadRow = 10;
			
			if(following_info.size() <= 10) {
				followingLoadRow = following_info.size();
			}
			
			int followerLoadRow = 10;
			
			if(follower_info.size() <= 10) {
				followerLoadRow = follower_info.size();
			}
			
			for(int i = 0; i < followerLoadRow; i++) {
				//System.out.println("팔로워 아이디");
				//System.out.println(follower_info.get(i).getMember_Id());
				for(int j = 0; j < followingLoadRow; j++) {
					//System.out.println("팔로잉 아이디");
					//System.out.println(following_info.get(j).getMember_Id());
					if(follower_info.get(i).getMember_Id().equals(following_info.get(j).getMember_Id())) {
						follower_info.get(i).setBothFollow(1);
						//System.out.println("setBoth 입력 확인 : " + follower_info.get(i).getBothFollow());
					}
				}
			}
			
			//System.out.println("팔로잉 출력 행 수 : " + followingLoadRow);
			//System.out.println("팔로워 출력 행 수 : " + followerLoadRow);

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
			
			model.addAttribute("alarmList", alarmList);
			model.addAttribute("alarmListSize", alarmListSize);
			
			return "follow";
		
		}
	}	
}
