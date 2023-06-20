package com.blue.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;


@Controller
@SessionAttributes("loginUser")
public class HomeController {
	
	@GetMapping(value="/explore")
	public String Explore() {
		
		return "explore";
	}
	
	@GetMapping(value="/tags")
	public String Tags() {
		
		return "tags";
	}
	
	@GetMapping(value="/contact")
	public String Contact() {
		
		return "contact";
	}
	
	@GetMapping(value="/faq")
	public String Faq() {
		
		return "faq";
	}
	
	@GetMapping(value="/404")
	public String a404() {
		
		return "404";
	}
	
	@GetMapping(value="/edit-profile")
	public String EditProfile() {
		
		return "edit-profile";
	}
	
}
