package com.blue.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FollowVO {
	private String follower;
	private String following;
	
	private int	FollowingLocalPageFirstNum;	//현재 페이지 최초 행 넘버
	private int	FollowingLocalPageLastNum;	//현재 페이지 마지막 행 넘버
	private int	FollowerLocalPageFirstNum;	//현재 페이지 최초 행 넘버
	private int	FollowerLocalPageLastNum;	//현재 페이지 마지막 행 넘버
}
