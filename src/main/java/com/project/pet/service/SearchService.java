package com.project.pet.service;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.pet.entity.MemberVo;
import com.project.pet.repository.SearchDao;

@Service
public class SearchService {
	@Autowired
	SearchDao searchDao;
	@Autowired
	BCryptPasswordEncoder pswdEncoder;
	@Autowired
	JavaMailSender mailSender;

	// 이메일 존재여부
	public int searchEmailCheck(MemberVo vo) {
		return searchDao.searchEmailCheck(vo);
	}

	// 이메일 찾기
	public List<String> searchEmail(MemberVo vo) {
		return searchDao.searchEmail(vo);
	}

	// 비밀번호 존재여부
	public int searchPswdCheck(MemberVo vo) {
		return searchDao.searchPswdCheck(vo);
	}

	// 비밀번호 찾기
	public void searchPswd(MemberVo vo) {
		// 임시 비밀번호 생성
		Random random = new Random();
		String tempPswd = "a";
		tempPswd = tempPswd.concat(Integer.toString((random.nextInt(8888888) + 1111111)));

		// 보안을 위해 비밀번호 암호화
		String encodeTempPswd = pswdEncoder.encode(tempPswd);
		vo.setPswd(encodeTempPswd);

		searchDao.searchPswd(vo);

		try {
			// 메세지 구성 메서드
			MimeMessage message = mailSender.createMimeMessage();
			// +파일 첨부 기능 클래스(메세지 객체, 파일 유무, charset)
			MimeMessageHelper helper = new MimeMessageHelper(message, false, "utf-8");
			helper.setFrom("ghfkddl9608@naver.com");
			helper.setTo(vo.getEmail());
			helper.setSubject("AbandonedPet 계정의 임시 비밀번호입니다.");
			// (text, html 유무)
			helper.setText("AbandonedPet 홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "임시 비밀번호는 " + tempPswd + " 입니다." + "<br>"
					+ "해당 임시 비밀번호로 로그인하여 비밀번호를 변경해주시길 바랍니다.", true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
