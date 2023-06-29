package com.blue.view;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.blue.dto.AlarmVO;
import com.blue.dto.MemberVO;
import com.blue.dto.PostVO;
import com.blue.service.AlarmService;
import com.blue.service.PostService;

@Controller
@SessionAttributes("loginUser")
public class HomeController {

	@Autowired
	private AlarmService alarmService;
	@Autowired
	private PostService postService;
	
	@GetMapping(value="/faq")
	public String Faq(HttpSession session, Model model) {
		
		if(session.getAttribute("loginUser") == null) {
			//System.out.println("세션값 없음");
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
    	
    	model.addAttribute("alarmList", alarmList);
		model.addAttribute("alarmListSize", alarmListSize);
		
		
		
		return "faq";
		
		}
	}
	
	@GetMapping(value="/404")
	public String a404() {
		
		return "404";
	}
	
	@GetMapping("/{statusCode}")
	public String getErrorPage(@PathVariable String statusCode) {
	    return statusCode;
	}
	
	@GetMapping(value="/editProfile")
	public String editProfile(HttpSession session, Model model) {
		
		if(session.getAttribute("loginUser") == null) {
			//System.out.println("세션값 없음");
			model.addAttribute("message", "로그인을 해주세요");
			return "login";
		} else {
			
		List<PostVO> hottestFeed = postService.getHottestFeed();
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
    	
    	MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
    	
    	String email = loginUser.getMember_Email();
		int atIndex = email.indexOf("@");
		String email_Id = email.substring(0, atIndex);
		String email_add = email.substring(atIndex + 1);
		
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("member_Email", email_Id);
		model.addAttribute("email_add", email_add);
    	model.addAttribute("alarmList", alarmList);
		model.addAttribute("alarmListSize", alarmListSize);
		model.addAttribute("hottestFeed", hottestFeed);
		
		return "edit_profile";
		
		}
	}
}
