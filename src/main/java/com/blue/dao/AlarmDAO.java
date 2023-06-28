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
		mybatis.insert("AlarmMapper.insertAlarm", alarmVO);		
	}
	
	public List<AlarmVO> selectAlarm(String member_Id){
		return mybatis.selectList("AlarmMapper.selectAlarm", member_Id);
	}

	public int getOneAlarm_Seq(AlarmVO alarmVO) {
        String result = mybatis.selectOne("AlarmMapper.getOneAlarm_Seq", alarmVO);
        System.out.println("mapper ´Ù³à¿Â result : " + result);
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
