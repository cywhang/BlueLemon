package com.blue.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.AlarmVO;
import com.blue.dto.PostVO;
import com.blue.dto.ReplyVO;

@Repository("alarmDao")
public class AlarmDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void insertAlarm(AlarmVO alarmVO) {
      String result1 = mybatis.selectOne("PostMapper.checkZeroPostSeq");
      if(result1 == null) {
         PostVO postVO = new PostVO();
         postVO.setPost_Seq(0);
         postVO.setMember_Id("admin");
         postVO.setPost_Content("알람 등록을 위한 게시글");
         postVO.setPost_Public("n");
         postVO.setPost_Image_Count(0);
         mybatis.insert("PostMapper.insertPost", postVO);         
      }
      
      String result2 = mybatis.selectOne("ReplyMapper.checkZeroReplySeq");
      if(result2 == null) {         
         ReplyVO replyVO = new ReplyVO();
         replyVO.setPost_Seq(0);
         replyVO.setReply_Seq(0);
         replyVO.setMember_Id("admin");
         replyVO.setReply_Content("알람 등록을 위한 댓글");
         mybatis.insert("ReplyMapper.insertReply", replyVO);
      }
      
      mybatis.insert("AlarmMapper.insertAlarm", alarmVO);      
         
   }
	
	public List<AlarmVO> selectAlarm(String member_Id){
		return mybatis.selectList("AlarmMapper.selectAlarm", member_Id);
	}

	public int getOneAlarm_Seq(AlarmVO alarmVO) {
        String result = mybatis.selectOne("AlarmMapper.getOneAlarm_Seq", alarmVO);
        if(result == null) {
        	return 0;
        } else {
        	return Integer.parseInt(result);
        }
	}

	public void deleteAlarm(int alarm_Seq) {
		mybatis.delete("AlarmMapper.deleteAlarm", alarm_Seq);
	}
	
}
