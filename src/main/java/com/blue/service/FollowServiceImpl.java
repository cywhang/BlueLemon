package com.blue.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blue.dao.FollowDAO;
import com.blue.dto.FollowVO;


@Service
public class FollowServiceImpl implements FollowService {

	@Autowired
	private FollowDAO followDao;
	
	@Override
	public List<FollowVO> getFollowing(String member_Id) {
		return followDao.getFollowing(member_Id);
	}

	@Override
	public List<FollowVO> getFollower(String member_Id) {
		return followDao.getFollower(member_Id);
	}

	@Override
	public List<FollowVO> getMoreFollowing(FollowVO vo) {
		return followDao.getMoreFollowing(vo);
	}

	@Override
	public List<FollowVO> getMoreFollower(FollowVO vo) {
		return followDao.getMoreFollower(vo);
	}

}
