package com.blue.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blue.dao.AlarmDAO;
import com.blue.dto.AlarmVO;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	private AlarmDAO alarmDao;
	
	@Override
	public void insertAlarm(AlarmVO alarmVO) {
		alarmDao.insertAlarm(alarmVO);
	}
	
	@Override
	public List<AlarmVO> getAllAlarm(String member_Id) {
		return alarmDao.selectAlarm(member_Id);
	}

	@Override
	public int getOneAlarm_Seq(AlarmVO alarmVO) {
		return alarmDao.getOneAlarm_Seq(alarmVO);
	}

	@Override
	public void deleteAlarm(int alarm_Seq) {
		alarmDao.deleteAlarm(alarm_Seq);
	}

}
