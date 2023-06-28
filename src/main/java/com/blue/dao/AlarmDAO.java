package com.blue.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.AlarmVO;

@Repository("AlarmDao")
public class AlarmDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void insertAlarm(AlarmVO alarmVO) {
		System.out.println("DAO에서 sql 타기 전 : " + alarmVO);
		mybatis.insert("AlarmMapper.insertAlarm", alarmVO);		
	}
	
	public List<AlarmVO> selectAlarm(String member_Id){
		return mybatis.selectList("AlarmMapper.selectAlarm", member_Id);
	}
	
	public void deleteAlarm(int alarm_Seq) {
		mybatis.delete("AlarmMapper.deleteAlarm", alarm_Seq);
	}

}
