package com.blue.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.FollowVO;


@Repository("followDAO")
public class FollowDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<FollowVO> getFollowing(String member_Id) {
		return mybatis.selectList("FollowMapper.getFollowing", member_Id);
	}
	
	public List<FollowVO> getFollower(String member_Id) {
		return mybatis.selectList("FollowMapper.getFollower", member_Id);
	}
	
	public List<FollowVO> getMoreFollowing(FollowVO vo){
		return mybatis.selectList("FollowMapper.getMoreFollowing", vo);
	}
	
	public List<FollowVO> getMoreFollower(FollowVO vo){
		return mybatis.selectList("FollowMapper.getMoreFollower", vo);
	}
}
