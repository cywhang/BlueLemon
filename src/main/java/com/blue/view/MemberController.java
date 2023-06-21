package com.blue.view;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.blue.dto.MemberVO;
import com.blue.dto.PostVO;
import com.blue.service.MemberService;
import com.blue.service.PostService;

@Controller
@SessionAttributes("loginUser")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private PostService postService;
	
	// 회원가입 화면 표시
	@RequestMapping("/join_view")
	public String joinView() {
		
		return "createAccount";
	}		
	
	// 아이디 중복체크
	@PostMapping("/checkDuplicate")
	public ResponseEntity<String> checkDuplicate(@RequestParam("member_Id") String member_Id) {
	    int result = memberService.confirmID(member_Id);
	    if (result == 1) {
	    	//System.out.println("중복된 아이디 :" + result);
	        return ResponseEntity.ok("duplicate");
	        
	    } else {
	    	//System.out.println("사용가능한 아이디:" + result);
	        return ResponseEntity.ok("not-duplicate");
	      
	    } 
	}

    // 회원가입 처리
	@PostMapping("create_form")
    public String joinAction(MemberVO vo, @RequestParam(value="profile_Image") MultipartFile profilePhoto,
    									  @RequestParam(value="email_add") String email_add) {
        if (!profilePhoto.isEmpty()) {
             // 프로필 사진을 저장할 경로를 결정합니다.
	          String image_Path = "C:/spring-workspace/BlueLemon/src/main/webapp/WEB-INF/template/img/uploads/profile/";
	          //System.out.println("저장할 경로 설정 = " + image_Path);
	          // 저장할 파일명을 생성합니다. 파일명에는 member_Id와 확장자명을 포함합니다.
	          String fileName = vo.getMember_Id() + ".png";
	          // System.out.println("저장할 파일명 = " + fileName);
	          // 파일을 지정된 경로에 저장합니다.
	         
	          // System.out.println("add : " + email_add );
		
	          try {
	        	  profilePhoto.transferTo(new File(image_Path + fileName));
	        	  // System.out.println("profilePhoto 값 = " + profilePhoto);
	        	  // 저장된 파일의 경로를 MemberVO에 설정합니다.
	        	  vo.setMember_Profile_Image(fileName);
	          } catch (IOException e) {
	        	  e.printStackTrace();
	        	  // 예외 처리를 수행합니다.
	          } 
        // 이미지 업로드 없을시 기본 이미지 사용   
        } else {
        	//System.out.println("업로드 이미지 없음 > 기본이미지 사용");
        	vo.setMember_Profile_Image("default.png");
        }
        
        if(email_add.equals(email_add)){
        	//System.out.println("이메일 주소 입력칸 입력");
        	vo.setMember_Email(vo.getMember_Email() + "@" + email_add);
        } else {
        	//System.out.println("이메일 주소가 입력되지 않았습니다.");
        }        
        
        memberService.insertMember(vo);
        
        return "login";	
	}

	// 회원정보 수정
	@PostMapping("update_form")
	public String updateMember(MemberVO vo, HttpSession session, Model model,
							   @RequestParam(value="profile_Image") MultipartFile profilePhoto,
	                           @RequestParam(value="email_add") String emailAdd) {
		
	    // 기존 프로필 사진을 삭제합니다.
	    String existingImagePath = "C:/spring-workspace/BlueLemon/src/main/webapp/WEB-INF/template/img/uploads/profile/" 
	    							+ vo.getMember_Profile_Image();
	    File existingImage = new File(existingImagePath);
	    if (existingImage.exists()) {
	        existingImage.delete();
	    }
	    
	    // 새로운 프로필 사진을 저장합니다.
	    if (!profilePhoto.isEmpty()) {
	        String imagePath = "C:/spring-workspace/BlueLemon/src/main/webapp/WEB-INF/template/img/uploads/profile/";
	        String fileName = vo.getMember_Id() + ".png";
	        try {
	            profilePhoto.transferTo(new File(imagePath + fileName));
	            vo.setMember_Profile_Image(fileName);
	        } catch (IOException e) {
	            e.printStackTrace();
	        } 
	    } else {
	        // 이미지 업로드가 없을 시 기본 이미지를 사용합니다.
	        vo.setMember_Profile_Image("default.png");
	    }
	    
	    // 이메일 주소를 설정합니다.
	    String email = vo.getMember_Email() + "@" + emailAdd;
	    vo.setMember_Email(email);
	    
	    memberService.updateMember(vo);

	    // 세션의 로그인 회원 정보를 업데이트합니다.
        session.setAttribute("loginUser", vo);
        
        // 수정된 회원 정보를 모델에 추가하여 JSP 페이지에서 사용할 수 있도록 함
        model.addAttribute("loginUser", vo);
        
        // 이메일 아이디와 이메일 주소를 분리하여 모델에 추가하여 JSP 페이지에서 사용할 수 있도록 함
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        
        String email1 = loginUser.getMember_Email();
	    int atIndex = email1.indexOf("@");
	    String email_Id = email.substring(0, atIndex);
	    String email_add = email.substring(atIndex + 1);
	    model.addAttribute("member_Email", email_Id);
	    model.addAttribute("email_add", email_add);
	    
	    return "redirect:edit_profile";
	}
	
	// 회원정보 수정 불러오기
	@GetMapping("/edit_profile")
	public String userProfile(MemberVO vo,HttpSession session, Model model) {
		//System.out.println("edit_profile getmapping해서 컨트롤러로 옴");
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	   
	    // 이메일 주소를 @ 기준으로 분리하여 메일 아이디와 메일 도메인으로 설정
	    String email = loginUser.getMember_Email();
	    int atIndex = email.indexOf("@");
	    String email_Id = email.substring(0, atIndex);
	    String email_add = email.substring(atIndex + 1);
	    model.addAttribute("member_Email", email_Id);
	    model.addAttribute("email_add", email_add);	  
		// 화면 우측 Hottest Feed
		List<PostVO> hottestFeed = postService.getHottestFeed();
		model.addAttribute("hottestFeed", hottestFeed);	

	    if (loginUser != null) {
	        // 유저 정보를 모델에 추가하여 JSP 페이지에서 사용할 수 있도록 함
	        model.addAttribute("loginUser", loginUser);
	        
	        return "edit_profile";
	    } else {
	        // 로그인되지 않은 경우 처리
	        return "redirect:/login";
	    }
	    
	}

	// 회원 탈퇴 post
	@PostMapping(value="/memberDelete")
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		
		// 세션에 있는 member를 가져와 member변수에 넣어줍니다.
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		// 세션에있는 비밀번호
		String sessionPass = loginUser.getMember_Password();
		//System.out.println("DB 상 Pass = " + sessionPass);

		// 입력받아서 vo로 들어오는 비밀번호
		String voPass = vo.getMember_Password();
		//System.out.println("입력받은 Pass = " +voPass);
		
		if(!(sessionPass.equals(voPass))) {
			// alert 관련은 edit_profile.jsp 맨 위에 있음
			rttr.addFlashAttribute("msg", "wrong");
			//System.out.println("비번 틀림");
			return "redirect:edit_profile";
		} else {
			memberService.deleteMember(loginUser);
			session.invalidate();
			//System.out.println("탈퇴 완료");
			rttr.addFlashAttribute("msg", "withdrawlSuccess");
			return "redirect:login";
		}
	}	
} 
