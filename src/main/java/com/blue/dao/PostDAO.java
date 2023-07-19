package com.blue.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.AlarmVO;
import com.blue.dto.LikeVO;
import com.blue.dto.PostVO;
import com.blue.dto.TagVO;
import com.blue.service.AlarmService;

@Repository("PostDAO")
public class PostDAO {
 
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Autowired
	private AlarmService alarmService;
	
	// index페이지 요청시 실행되는 부분(게시글 리스트)
	public ArrayList<PostVO> listPost(String member_Id) {
	    List<PostVO> resultList = mybatis.selectList("PostMapper.listPost", member_Id);
	    ArrayList<PostVO> arrayList = new ArrayList<PostVO>(resultList);
	    
	    return arrayList;
	}
	
	// 게시글 좋아요 여부 체크
	public String getLikeYN(PostVO voForLikeYN) {
		String check = mybatis.selectOne("PostMapper.checkLike", voForLikeYN);;
		
		if (check == null) {
			check = "N";
		} else {
			check = "Y";
		}
		return check;
	}
	
	// 게시글 좋아요 처리
	public void changeLike(LikeVO vo) {
		String check = mybatis.selectOne("PostMapper.checkLike", vo);
		
		// 알람
		String post_Writer = mybatis.selectOne("PostMapper.postWriter", vo.getPost_Seq());
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setKind(2);
		alarmVO.setFrom_Mem(vo.getMember_Id());
		alarmVO.setTo_Mem(post_Writer);
		alarmVO.setPost_Seq(vo.getPost_Seq());
		alarmVO.setReply_Seq(0);
		
		// 알람 테이블에 해당 알람 있나 확인
        int alarmResult = alarmService.getOneAlarm_Seq(alarmVO);	
        
        // 1. 해당 게시글에 좋아요를 누른 상태가 아닐때
		if(check == null) {
			// 좋아요 추가
			mybatis.update("PostMapper.addLike", vo);
			
			// 알람 테이블에서 해당 게시글의 알람이 없으면  알람 추가
			if(alarmResult == 0) {
				alarmService.insertAlarm(alarmVO);
				
			// 알람 테이블에서 해당 게시글의 알림이 있으면 아무것도x
			} else {}
			
		// 2. 해당 게시글에 좋아요를 누른 상태일때
		} else {
			// 좋아요 취소
			mybatis.update("PostMapper.delLike", vo);
			
			// 게시글 작성자가 알람을 확인하기전에 게시글의 좋아요를 취소했을때의 경우에 알림을 삭제 처리하는 부분
			if(alarmResult == 0) {
				
			// 게시글 작성자가 알람을 확인하지 않았다면 해당 알람을 삭제 처리하는 부분
			} else {
				alarmService.deleteAlarm(alarmResult);
			}
		}
	}
	
	public List<PostVO> getHottestFeed() {
		return mybatis.selectList("PostMapper.getHottestFeed");
	}
	
	public void insertPost(PostVO vo) {		
		int result = mybatis.insert("PostMapper.insertPost", vo);
	}
	
	// 게시글 좋아요 카운트
	public int postLikeCount(int post_Seq) {		
		return mybatis.selectOne("LikeMapper.postLikeCount", post_Seq);
	}
	
	// 게시글 댓글 카운트
	public int postReplyCount(int post_Seq) {		
		return mybatis.selectOne("ReplyMapper.postReplyCount", post_Seq);
	}
	
	// 게시글 상세보기(모달창)
	public PostVO postDetail(int post_Seq) {		
		return mybatis.selectOne("PostMapper.postDetail", post_Seq);
	}

	// 내 profile에서 보여줄 게시글목록
	public ArrayList<PostVO> getMyPost(String member_Id) {
		List<PostVO> result =  mybatis.selectList("PostMapper.myPost", member_Id);
		ArrayList<PostVO> myPostList = new ArrayList<PostVO>(result);
		return myPostList;
	}
	
	// 개인 페이지용 게시글 목록
	public ArrayList<PostVO> getMemberPost(PostVO vo) {
		List<PostVO> result =  mybatis.selectList("PostMapper.memberPost", vo);
		ArrayList<PostVO> memberPostList = new ArrayList<PostVO>(result);
		return memberPostList;
	}

	public ArrayList<PostVO> getAllPost() {
		List<PostVO> result = mybatis.selectList("PostMapper.getAllPost");
		ArrayList<PostVO> getAllPost = new ArrayList<PostVO>(result);
		return getAllPost;
	}
	
	//게시글 삭제
	public void deletePost(int post_Seq) {
		mybatis.delete("PostMapper.deletePost", post_Seq);
	}
	
	// 게시글 추가 시 필요한 가장높은 시퀀스 조회
	public int postSeqCheck() {
		int result = mybatis.selectOne("PostMapper.postSeqCheck");
		System.out.println(result);
		return result;
	}
	
	// 게시글 추가의 해시태그 인서트
	public void insertTag(TagVO vo) {
		// 컨트롤러에서넘어온 값
		mybatis.insert("PostMapper.insertTag", vo);
	}
	
	// 게시글 해시태그 조회
	public ArrayList<TagVO> getHashtagList(int post_Seq) {
		List<TagVO> result = mybatis.selectList("PostMapper.postHashtag", post_Seq);
		ArrayList<TagVO> hashList = new ArrayList<TagVO>(result);
		return hashList;
	}
	
	// 한 회원의 전체 해시태그 삭제
	public void deleteOneMemsTag(String member_Id) {
		mybatis.delete("PostMapper.deleteOneMemsTag", member_Id);
	}
	
	// 관리자 게시글 상세조회
	public PostVO selectPostDetail(int post_Seq) {
		return mybatis.selectOne("PostMapper.selectPostDetail", post_Seq); 
	}
	
	// 해시태그로 게시글 검색
	public ArrayList<PostVO> getHashTagPost(String hashTag){
		List<PostVO> result = mybatis.selectList("PostMapper.getHashTagPost", hashTag);
		ArrayList<PostVO> memberPostList = new ArrayList<PostVO>(result);
		
		return memberPostList;
	}

	public ArrayList<TagVO> getTodaysTag() {
		List<TagVO> result = mybatis.selectList("PostMapper.getTodaysTag");
		ArrayList<TagVO> todaysTag = new ArrayList<TagVO>(result);
		
		return todaysTag;
	}
	
	// 게시글 수정 처리
	public void updatePost(PostVO vo) {
		mybatis.update("PostMapper.updatePost", vo);
	}
	
	// 게시글 해시태그 수정전 삭제 처리
	public void deleteTag(int post_Seq) {
		mybatis.delete("PostMapper.deleteTag", post_Seq);
	}

	public String getPostWriter(int post_Seq) {
		return mybatis.selectOne("PostMapper.postWriter", post_Seq);
	}

	// 게시글 이미지 삭제를 위한 사용자가 작성한 게시글의 시퀀스 번호
	public List<Integer> seqForUser(String member_Id){
		return mybatis.selectList("PostMapper.seqForUser", member_Id);
	}
	
	
}
