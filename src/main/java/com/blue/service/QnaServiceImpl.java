package com.blue.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blue.dao.QnaDAO;
import com.blue.dto.QnaVO;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaDAO qnaDao;
	
	@Override
	public void insertQna(QnaVO vo) {
		qnaDao.insertQna(vo);
	}

	@Override
	public List<QnaVO> getMyQna(String member_Id) {
		
		return qnaDao.getMyQna(member_Id);
	}

}
