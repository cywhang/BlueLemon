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
		//System.out.println("[좋아요 여부 확인 - 2]DAO - getLikeYN : " + check);
		if (check == null) {
			check = "N";
		} else {
			check = "Y";
		}
		//System.out.println("[좋아요 여부 확인 - 3] DAO에서 리턴 : " + check);
		return check;
	}
	
	// 게시글 좋아요 처리
	public void changeLike(LikeVO vo) {
		//System.out.println("[게시글 좋아요 - 6] changeLike()를 위해 DAO로 옴 member_Id = " + vo.getMember_Id() + "post_Seq = " + vo.getPost_Seq());
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
        
		//System.out.println("[게시글 좋아요 - 7] post-mapping.xml에서 checkLike로 좋아요 체크");
		if(check == null) {
			mybatis.update("PostMapper.addLike", vo);
			//System.out.println("[게시글 좋아요 - 8 - if] 좋아요 중 아니라서 좋아요 함");
			
			if(alarmResult == 0) {
				alarmService.insertAlarm(alarmVO);
			} else {}
			
		} else {
			mybatis.update("PostMapper.delLike", vo);
			//System.out.println("[게시글 좋아요 - 8 - else] 좋아요 중이라서 좋아요 취소 함");
			
			if(alarmResult == 0) {
			} else {
				alarmService.deleteAlarm(alarmResult);
			}
		}
	}
	public List<PostVO> getHottestFeed() {
		//System.out.println("[인기글 - 4] getHottestFeed()를 위해 postDAO로 오고 post-mapping.xml에 가서 받아옴");
		return mybatis.selectList("PostMapper.getHottestFeed");
	}
	
	public void insertPost(PostVO vo) {		
		int result = mybatis.insert("PostMapper.insertPost", vo);
		//System.out.println("게시글 작성 결과 " + result);
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
	public ArrayList<PostVO> getMemberPost(String member_Id) {
		List<PostVO> result =  mybatis.selectList("PostMapper.memberPost", member_Id);
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

}
