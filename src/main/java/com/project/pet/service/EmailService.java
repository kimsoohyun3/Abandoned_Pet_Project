package com.project.pet.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	@Autowired
	JavaMailSender mailSender;

	// 이메일 인증
	public String mailCheck(String email) {
		// 인증번호 생성
		Random random = new Random();
		int mailCheckNum = random.nextInt(888888) + 111111;

		// 인증번호 이메일 보내기
		try {
			// 메세지 구성 메서드
			MimeMessage message = mailSender.createMimeMessage();
			// +파일 첨부 기능 클래스(메세지 객체, 파일 유무, charset)
			MimeMessageHelper helper = new MimeMessageHelper(message, false, "utf-8");
			helper.setFrom("ghfkddl9608@naver.com");
			helper.setTo(email);
			helper.setSubject("AbandonedPet 회원가입을 위한 이메일 인증번호입니다.");
			// (text, html 유무)
			helper.setText("AbandonedPet 홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증번호는 " + mailCheckNum + " 입니다." + "<br>"
					+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.", true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		String num = Integer.toString(mailCheckNum);
		return num;
	}
}
