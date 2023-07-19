package com.blue.service;

import java.util.ArrayList;
import java.util.List; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blue.dao.PostDAO;
import com.blue.dto.LikeVO;
import com.blue.dto.PostVO;
import com.blue.dto.TagVO;

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

	// 내 profile에서 보여줄 게시글목록
	@Override
	public ArrayList<PostVO> getMyPost(String member_Id) {
		return postDao.getMyPost(member_Id);
	}
	
	@Override
	public ArrayList<PostVO> getMemberPost(PostVO vo) {		
		return postDao.getMemberPost(vo);
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

	@Override
	public int postSeqCheck() {
		// 게시글 인서트시 시퀀스 NEXTVAL 값 예측 연산처리
		int Seq = postDao.postSeqCheck() + 1;
		return Seq;
	}

	@Override
	public void insertTag(TagVO vo) {
		postDao.insertTag(vo);
	}

	@Override
	public ArrayList<TagVO> getHashtagList(int post_Seq) {
		return postDao.getHashtagList(post_Seq);
	}

	@Override
	public void deleteOneMemsTag(String member_Id) {
		postDao.deleteOneMemsTag(member_Id);
	}

	@Override
	public PostVO selectPostDetail(int post_Seq) {
		
		return postDao.selectPostDetail(post_Seq);
	}

	@Override
	public ArrayList<PostVO> getHashTagPost(String hashTag) {
		return postDao.getHashTagPost(hashTag);
	}

	@Override
	public ArrayList<TagVO> getTodaysTag() {
		return postDao.getTodaysTag();
	}

	@Override
	public void updatePost(PostVO vo) {
		postDao.updatePost(vo);
	}

	@Override
	public void deleteTag(int post_Seq) {
		postDao.deleteTag(post_Seq);
	}

	@Override
	public String getPostWriter(int post_Seq) {
		return postDao.getPostWriter(post_Seq);
	}

	@Override
	public List<Integer> seqForUser(String member_Id) {
		return postDao.seqForUser(member_Id);
	}

}
