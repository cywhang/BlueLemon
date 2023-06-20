package com.blue.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blue.dao.ReplyDAO;
import com.blue.dto.LikeVO;
import com.blue.dto.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDAO replyDao;
	
	// 각 게시글 댓글 3개까지 조회
	@Override
	public ArrayList<ReplyVO> getReplyPreview(int post_Seq) {
		
		return replyDao.replyPreview(post_Seq);
	}

	// 게시글 상세보기 모달창의 댓글 리스트
	@Override
	public ArrayList<ReplyVO> listReply(int post_Seq) {
		
		return replyDao.listReply(post_Seq);
	}

	// 댓글 좋아요 여부 확인
	@Override
	public String checkReplyLike(ReplyVO voForReplyCheck) {
		
		return replyDao.checkReplyLike(voForReplyCheck);
	}

	// 댓글 좋아요 처리
	@Override
	public void changeReplyLike(LikeVO vo) {
		replyDao.changeReplyLike(vo);
		
	}

	@Override
	public void insertReply(ReplyVO vo) {
		replyDao.insertReply(vo);
	}
	
	

}
