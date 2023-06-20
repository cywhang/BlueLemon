package com.blue.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PostVO {

	private int 	post_Seq;            // 게시글 고유번호
	private String  member_Id;		 // 게시글 작성자
	private String  post_Content;  		 // 게시글 내용
	private String 	post_Date;			 // 게시글 작성일
	private String 	post_Update; 		 // 게시글 수정일
	private String  post_Public;		 // 게시글 공개 여부
	private int 	post_Image_Count;    // 게시글 첨부 이미지 갯수
	private int 	post_Count;			 // 게시글 조회수
	private int 	post_Like_Count;  	 // 게시글 좋아요 수
	private int 	post_Reply_Count;	 // 게시글 댓글 수
	private String  post_Hashtag;		 // 게시글 해시태그
	private String	post_LikeYN;		 // 게시글 좋아요 여부 N = 좋아요 안누른 상태 Y = 좋아요 누른 상태
}
