package com.blue.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.AlarmVO;
import com.blue.dto.FollowVO;
import com.blue.dto.MemberVO;
import com.blue.service.AlarmService;

@Repository("MemberDao")
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	@Autowired
	private AlarmService alarmService;

	// 회원 ID를 조건으로 회원 조회
	public MemberVO getMember(String member_Id) {
		return mybatis.selectOne("MemberMapper.getMemberInfo", member_Id);
	}

	// 회원 ID를 조건으로 회원 조회
	public MemberVO getMemberInfo(String member_Id) {
		return mybatis.selectOne("MemberMapper.getMember", member_Id);
	}

	// 회원 존재 여부 조회
	public int confirmID(String member_Id) {
		String member_Password = mybatis.selectOne("MemberMapper.confirmID", member_Id);

		if (member_Password != null) {
			return 1;
		} else {
			return -1;
		}
	}

	// 회원 insert
	public void insertMember(MemberVO vo) {
		mybatis.update("MemberMapper.insertMember", vo);
	}

	// 로그인 처리
	// confirmID로 비밀번호 조회해서 입력한 값과 비교
	// 리턴값 : ID가 존재하고 비밀번호가 같으면 1 / 비밀번호가 다르면 0 / ID가 없으면 -1
	public int doLogin(MemberVO vo) {
		int result = -1;
		String pwd = mybatis.selectOne("MemberMapper.confirmID", vo.getMember_Id());
		
		// ID가 없는 경우
		if (pwd == null) {
			result = -1;
			// 정상 로그인
		} else if (pwd.equals(vo.getMember_Password())) {
			result = 1;
			// 비밀번호 틀림
		} else {
			result = 0;
		}
		return result;
	}

	// 회원정보 수정
	// 프로필 이미지 새로 등록
	public void updateMember(MemberVO vo) {
		mybatis.selectOne("MemberMapper.memberUpdate", vo);
	}
	
	// 회원정보 수정2
	// 프로필 이미지 새로 등록 X
   	public void updateMember2(MemberVO vo) {
      mybatis.selectOne("MemberMapper.memberUpdate2", vo);
    }
	
	// 패스워드 확인
	public boolean checkPassword(String member_Id, String member_Password) {
		MemberVO vo = getMember(member_Id);
		return vo != null && vo.getMember_Password().equals(member_Password);
	}

	// 회원 탈퇴
	public void deleteMember(String member_Id) {
		mybatis.delete("MemberMapper.memberDelete", member_Id);		
	}

	public MemberVO loginUser(MemberVO vo) {
		return mybatis.selectOne("MemberMapper.loginUser", vo);
	}

	// 아이디 찾기
	public String searchId(MemberVO vo) {
		return mybatis.selectOne("MemberMapper.searchId", vo);
	}

	// 패스워드 찾기
	public MemberVO findPassword(MemberVO vo) {
		return mybatis.selectOne("MemberMapper.findPassword", vo);
	}

	// 패스워드 변경
	public void updatePassword(MemberVO vo) {
		mybatis.update("MemberMapper.updatePassword", vo);
	}

	// 아이디 이메일 확인후 패스워드 찾기
	public String PwdByIdNameEmail(MemberVO vo) {
		return mybatis.selectOne("MemberMapper.PwdByIdNameEmail", vo);
	}

	// 아이디로 회원 검색
	public List<MemberVO> searchMembers(String keyword) {
		return mybatis.selectList("MemberMapper.searchMembers", keyword);
	}

	// 추천 회원 조회
	public List<MemberVO> getRecommendMember(String member_Id) {
		return mybatis.selectList("MemberMapper.getRecommendMember", member_Id);
	}

	// 팔로우 / 언팔로우 처리
	public void changeFollow(FollowVO vo) {
		String check = mybatis.selectOne("MemberMapper.checkFollow", vo);
		
		// 알람
        AlarmVO alarmVO = new AlarmVO();
        alarmVO.setKind(1);
        alarmVO.setFrom_Mem(vo.getFollower());
        alarmVO.setTo_Mem(vo.getFollowing());
        alarmVO.setPost_Seq(0);
        alarmVO.setReply_Seq(0);
        
        // 알람 테이블에 해당 알람 있나 확인
        int result = alarmService.getOneAlarm_Seq(alarmVO);	
        
		// 팔로우 중이 아닌 경우
		if (check == null) {
			mybatis.update("MemberMapper.addFollow", vo);
			
			// 알람 테이블에 해당 알람 없으면 insert
	        if(result == 0) {
		        alarmService.insertAlarm(alarmVO);
	        } else {
	        }
		// 팔로우 중인 경우
		} else {
			mybatis.update("MemberMapper.delFollow", vo);
			
			// 알람 테이블에 해당 알람 있으면 delete
	        if(result == 0) {
	        } else {
	        	alarmService.deleteAlarm(result);
	        }
		}
	}

	// 전체 회원 프로필 이미지 조회
	public HashMap<String, String> memberProfile() {
		List<HashMap<String, String>> resultList = mybatis.selectList("MemberMapper.memberProfile");
		HashMap<String, String> profileMap = new HashMap<>();

		for (HashMap<String, String> row : resultList) {
			String member_Id = row.get("member_Id");
			String member_Profile_Image = row.get("member_Profile_Image");
			profileMap.put(member_Id, member_Profile_Image);
		}
		return profileMap;
	}

	// 팔로워가 가장 많은 멤버 조회
	public List<MemberVO> getMostFamousMember() {
		List<MemberVO> mostFamous = mybatis.selectList("MemberMapper.MostFamous");
		return mostFamous;
	}

	public List<MemberVO> getFollowers(String member_Id) {
		List<MemberVO> followers = mybatis.selectList("MemberMapper.getFollowers", member_Id);
		return followers;
	}

	public List<MemberVO> getFollowings(String member_Id) {
		List<MemberVO> followings = mybatis.selectList("MemberMapper.getFollowings", member_Id);
		return followings;
	}

	// 관리자 - 전체 회원 조회
	public List<MemberVO> getAllMember() {
		return mybatis.selectList("MemberMapper.getAllMember");
	}
	
	// 내가 상대를 팔로우했나 체크
	public String checkFollow(FollowVO check_Vo) {
		String result = null;
		if(mybatis.selectOne("MemberMapper.checkFollow", check_Vo) != null) {
			result = "y";
		} else {
			result = "n";
		}
		return result;
	}

	// 관리자 페이지 회원수 현황 그래프
	public List<Integer> getMemberTendency() {
		return mybatis.selectList("MemberMapper.getMemberTendency");
	}
}
