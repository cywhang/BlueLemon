package com.blue.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.QnaVO;

@Repository("QnaDAO")
public class QnaDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	public void insertQna(QnaVO vo) {
		mybatis.insert("QnaMapper.insertQna", vo);
	}

	public List<QnaVO> getMyQna(String member_Id) {
		List<QnaVO> result = mybatis.selectList("QnaMapper.getMyQna", member_Id);
		return mybatis.selectList("QnaMapper.getMyQna", member_Id);
	}
	
	public int checkMaxSeq() {
		int max_Qna_Seq = mybatis.selectOne("QnaMapper.checkMaxSeq");
		return max_Qna_Seq;
	}
	
	public List<QnaVO> getAllQna() {
		return mybatis.selectList("QnaMapper.getAllQna");
	}
	
	public QnaVO getQnaDetail(int qna_Seq) {
		return mybatis.selectOne("QnaMapper.getQnaDetail", qna_Seq);
	}
	
	public void updateQnaAnswer(QnaVO vo) {
		mybatis.update("QnaMapper.updateQnaAnswer", vo);
	}

	public void deleteQna(int qna_Seq) {
		mybatis.delete("QnaMapper.deleteQna", qna_Seq);
	}
}
