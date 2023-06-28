package com.blue.service;

import java.util.List;

import com.blue.dto.AlarmVO;

public interface AlarmService {

	public void insertAlarm(AlarmVO alarmVO);
	
	List<AlarmVO> getAllAlarm(String member_Id);
	
	void deleteAlarm(int alarm_Seq);
}
