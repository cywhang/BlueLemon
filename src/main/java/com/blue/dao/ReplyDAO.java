package com.blue.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.AlarmVO;
import com.blue.dto.LikeVO;
import com.blue.dto.ReplyVO;
import com.blue.service.AlarmService;

@Repository("ReplyDAO")
public class ReplyDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Autowired
	private AlarmService alarmService;
	
	// 각 게시글에 대한 댓글 3개까지만 출력
	public ArrayList<ReplyVO> replyPreview(int post_Seq) {
		Date currentTime = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		//System.out.println(currentTime);
	    List<ReplyVO> resultList = mybatis.selectList("ReplyMapper.replyPreview", post_Seq);
	    for(ReplyVO vo : resultList) {
	    	String wroteTimeString = dateFormat.format(vo.getReply_Date());
	    	try {
				Date wroteTime = dateFormat.parse(wroteTimeString);				
				long timeDiff = currentTime.getTime() - wroteTime.getTime();
				long minutesDiff = timeDiff / (60 * 1000);
				long hoursDiff = minutesDiff / 60;
				long daysDiff = hoursDiff / 24;
				if (minutesDiff <= 60) {
					vo.setReply_WhenDid(minutesDiff + " minutes ago");
				} else if (minutesDiff > 60 & minutesDiff <= 1440){
					vo.setReply_WhenDid(hoursDiff + " hours ago");
				} else {
					vo.setReply_WhenDid(daysDiff + " days ago");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	
	    }
	    ArrayList<ReplyVO> arrayList = new ArrayList<ReplyVO>(resultList);
	    
	    return arrayList;
	}	
	
	// 게시글 상세보기 모달창의 댓글 리스트
	public ArrayList<ReplyVO> listReply(int post_Seq) {
		Date currentTime = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		List<ReplyVO> resultList = mybatis.selectList("ReplyMapper.listReply", post_Seq);
		
		for(ReplyVO vo : resultList) {
	    	String wroteTimeString = dateFormat.format(vo.getReply_Date());
	    	try {
				Date wroteTime = dateFormat.parse(wroteTimeString);				
				long timeDiff = currentTime.getTime() - wroteTime.getTime();				
				long minutesDiff = timeDiff / (60 * 1000);				
				long hoursDiff = minutesDiff / 60;				
				long daysDiff = hoursDiff / 24;
				
				if (minutesDiff <= 60) {
					vo.setReply_WhenDid(minutesDiff + " minutes ago");
				} else if (minutesDiff > 60 & minutesDiff <= 1440){
					vo.setReply_WhenDid(hoursDiff + " hours ago");
				} else {
					vo.setReply_WhenDid(daysDiff + " days ago");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}	    	
	    }
		
	    ArrayList<ReplyVO> arrayList = new ArrayList<ReplyVO>(resultList);
	    
	    return arrayList;		
	}

	public String checkReplyLike(ReplyVO voForReplyCheck) {
		String check = mybatis.selectOne("ReplyMapper.checkReplyLike", voForReplyCheck);
		//System.out.println("[미리보기 댓글 - 3] DAO - 좋아요 중이면 id 뜸 : " + check);
		if (check == null) {
			check = "N";
		} else {
			check = "Y";
		}
		//System.out.println("[미리보기 댓글 - 4] DAO에서 리턴 : " + check);
		return check;
	}

	public void changeReplyLike(LikeVO vo) {
		//System.out.println("[미리보기 댓글 좋아요 - 6] DAO로 옴 member_Id = " + vo.getMember_Id() + ", post_Seq = " + vo.getPost_Seq() + ", reply_Seq = " + vo.getReply_Seq());
		String check = mybatis.selectOne("ReplyMapper.checkReplyLike", vo);
		//System.out.println("[미리보기 댓글 좋아요 - 7] 댓글 좋아요 여부 체크함 (좋아요 중이면 id 뜸) : " + check);
		
		// 알람
		String reply_Writer = mybatis.selectOne("ReplyMapper.replyWriter", vo.getReply_Seq());
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setKind(4);
		alarmVO.setFrom_Mem(vo.getMember_Id());
		alarmVO.setTo_Mem(reply_Writer);
		alarmVO.setPost_Seq(vo.getPost_Seq());
		alarmVO.setReply_Seq(vo.getReply_Seq());

		// 알람 테이블에 해당 알람 있나 확인
        int alarmResult = alarmService.getOneAlarm_Seq(alarmVO);
        
		if(check == null) {
			mybatis.update("ReplyMapper.addReplyLike", vo);
			//System.out.println("[미리보기 댓글 좋아요 - 8 - if] 좋아요 중 아니라서 좋아요 함");
			
			if(alarmResult == 0) {
				alarmService.insertAlarm(alarmVO);
			} else {}
		} else {
			mybatis.update("ReplyMapper.delReplyLike", vo);
			//System.out.println("[미리보기 댓글 좋아요 - 8 - else] 좋아요 중이라서 좋아요 취소 함");
			
			if(alarmResult == 0) {
			} else {
				alarmService.deleteAlarm(alarmResult);
			}
		}
	}
	
	// 댓글 인서트
	public void insertReply(ReplyVO vo) {
		mybatis.insert("ReplyMapper.insertReply", vo);
	}

	public int getMaxReply_Seq() {
		return mybatis.selectOne("ReplyMapper.getMaxReply_Seq");
	}
}
