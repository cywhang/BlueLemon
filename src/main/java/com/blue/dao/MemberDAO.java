package com.blue.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blue.dto.FollowVO;
import com.blue.dto.MemberVO;

@Repository("MemberDao")
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 회원 ID를 조건으로 회원 조회
	public MemberVO getMember(String member_Id) {
		// System.out.println("[로그인 - 7 - if - 3] getMember()를 위해 MemberServiceImpl에서
		// DAO로 옴");
		// System.out.println("[로그인 - 7 - if - 4] getMember()를 위해 member-mapping의
		// getMember를 통해 회원정보를 받아 옴");
		return mybatis.selectOne("MemberMapper.getMemberInfo", member_Id);
	}

	// 회원 ID를 조건으로 회원 조회
	public MemberVO getMemberInfo(String member_Id) {
		// System.out.println("[로그인 - 7 - if - 3] getMember()를 위해 MemberServiceImpl에서
		// DAO로 옴");
		return mybatis.selectOne("MemberMapper.getMember", member_Id);
		// System.out.println("[로그인 - 7 - if - 4] getMember()를 위해 member-mapping의
		// getMember를 통해 회원정보를 받아 옴");
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
		// System.out.println("[로그인 - 4] doLogin()을 위해 MemberServiceImpl에서 DAO로 옴");
		int result = -1;
		String pwd = mybatis.selectOne("MemberMapper.confirmID", vo.getMember_Id());
		// System.out.println("[로그인 - 5] doLogin()을 위해 member-mapping의 confirmID를 통해 PW
		// 받아옴");
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
		// System.out.println("[로그인 - 6] ID 여부, 비번 확인 후 result에 값을 담아서 MainController로
		// 리턴");
		return result;
	}

	// 회원정보 수정
	public void updateMember(MemberVO vo) {
		mybatis.selectOne("MemberMapper.memberUpdate", vo);
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
		System.out.println("==> Mybatis로 loginUser() 기능 처리");
		return mybatis.selectOne("MemberMapper.loginUser", vo);
	}

	// 아이디 찾기
	public String searchId(MemberVO vo) {

		return mybatis.selectOne("MemberMapper.searchId", vo);
	}

	// 패스워드 찾기
	public MemberVO findPassword(MemberVO vo) {
		System.out.println("==> Mybatis로 findPassword() 기능 처리");
		return mybatis.selectOne("MemberMapper.findPassword", vo);
	}

	// 패스워드 변경
	public void updatePassword(MemberVO vo) {
		System.out.println("==> Mybatis로 updatePassword() 기능 처리");
		mybatis.update("MemberMapper.updatePassword", vo);
	}

	// 아이디 이메일 확인후 패스워드 찾기
	public String PwdByIdNameEmail(MemberVO vo) {

		return mybatis.selectOne("MemberMapper.PwdByIdNameEmail", vo);
	}

	// 아이디로 회원 검색
	public List<MemberVO> searchMembers(String keyword) {
		// 실제 데이터베이스에서 회원을 검색하는 로직을 작성하고 실행
		// 예시로 EntityManager를 사용하여 JPQL을 실행하는 방법을 보여줍니다.

		return mybatis.selectList("MemberMapper.searchMembers", keyword);
	}

	// 추천 회원 조회
	public List<MemberVO> getRecommendMember(String member_Id) {
		// System.out.println("[멤버추천 - 4] getRecommendMember()를 위해 MemberServiceImpl에서
		// DAO로 오고 member-mapping.xml을 통해 처리");
		return mybatis.selectList("MemberMapper.getRecommendMember", member_Id);
	}

	// 팔로우 / 언팔로우 처리
	public void changeFollow(FollowVO vo) {
		// System.out.println("[팔로우, 언팔로우 - 9] changeFollow()를 위해 DAO로 옴, follower = " +
		// vo.getFollower() + ", following = " + vo.getFollowing());
		String check = mybatis.selectOne("MemberMapper.checkFollow", vo);
		// System.out.println("[팔로우, 언팔로우 - 10] member-mapping.xml에서 checkFollow로 팔로우
		// 체크");
		// 팔로우 중이 아닌 경우
		if (check == null) {
			mybatis.update("MemberMapper.addFollow", vo);
			// System.out.println("[팔로우, 언팔로우 - 11 - if] 팔로우 중 아니라서 팔로우 함");
			// 팔로우 중인 경우
		} else {
			mybatis.update("MemberMapper.delFollow", vo);
			// System.out.println("[팔로우, 언팔로우 - 11 - else] 팔로우 중이라서 팔로우 취소 함");
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
		// System.out.println("[PEOPLE 탭 - 5] DAO로 옴");
		List<MemberVO> mostFamous = mybatis.selectList("MemberMapper.MostFamous");
		// System.out.println("[PEOPLE 탭 - 6] DAO에서 DB로 들어가 mostFamous로 받아와서 리턴요청");
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
