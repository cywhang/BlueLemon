package com.blue.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVO {

	private int reply_Seq;
	private int post_Seq;
	private String member_Id;
	private String reply_Content;
	private Date reply_Date;
	private int reply_Like_Count;
	private String	reply_LikeYN;		// 댓글 좋아요 여부 N = 좋아요 안누른 상태 Y = 좋아요 누른 상태
	private String reply_WhenDid;		// 댓글 얼마 전에 등록됐는지
}
