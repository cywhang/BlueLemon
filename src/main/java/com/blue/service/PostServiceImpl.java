package com.blue.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blue.dao.PostDAO;
import com.blue.dto.LikeVO;
import com.blue.dto.PostVO;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostDAO postDao;
	
	// 게시글 가져오기
	@Override
	public ArrayList<PostVO> getlistPost(String member_Id) {		
		return postDao.listPost(member_Id);
	}
	
	// 게시글 좋아요 여부 체크
	@Override
	public String getLikeYN(PostVO voForLikeYN) {
		return postDao.getLikeYN(voForLikeYN);
		
	}

	// 게시글 좋아요 처리
	@Override
	public void changeLike(LikeVO vo) {
		postDao.changeLike(vo);
	}
	
	// 인기글 조회
	@Override
	public List<PostVO> getHottestFeed() {
		//System.out.println("[인기글 - 3] getHottestFeed()를 위해 postService를 통해 postServiceImpl로 옴");
		return postDao.getHottestFeed();
	}

	// 게시글 작성
	@Override
	public void insertPost(PostVO vo) {
		postDao.insertPost(vo);
	}
	
	// 게시글 상세보기
	@Override
	public PostVO getpostDetail(int post_Seq) {
		return postDao.postDetail(post_Seq);
	}

	@Override
	public ArrayList<PostVO> getMemberPost(String member_Id) {		
		return postDao.getMemberPost(member_Id);
	}

	@Override
	public int getPost_Like_Count(int post_Seq) {
		return postDao.postLikeCount(post_Seq);
	}

	// 관리자용 전체 게시글 조회
	@Override
	public ArrayList<PostVO> getAllPost() {
		return postDao.getAllPost();
	}
	
	@Override
	public void deletePost(int post_Seq) {
		postDao.deletePost(post_Seq);
	}

	
}
