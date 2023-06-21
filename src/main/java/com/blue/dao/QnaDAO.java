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
		System.out.println(member_Id);
		System.out.println("DAO ¿È");
		List<QnaVO> result = mybatis.selectList("QnaMapper.getMyQna", member_Id);
		System.out.println("mapping ´Ù³à¿È");
		System.out.println(result);
		for(QnaVO abc : result) {
			System.out.println(abc);
		}
		return mybatis.selectList("QnaMapper.getMyQna", member_Id);
	}
}
