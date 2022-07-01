package com.project.pet.entity;

import javax.validation.constraints.Pattern;

public class MemberVo {

	@Pattern(regexp = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$", message = "!")
	String email;

	int code;
	
	@Pattern(regexp = "^(?=.*[a-zA-z])(?=.*[0-9])(?!.*[^a-zA-z0-9]).{8,13}$", message = "!")
	String pswd;

	@Pattern(regexp = "^(?=.*[a-zA-z])(?=.*[0-9])(?!.*[^a-zA-z0-9]).{8,13}$", message = "!")
	String cfpswd;

	@Pattern(regexp = "^[가-힣]{2,6}", message = "!")
	String name;

	@Pattern(regexp = "^[가-힣]{1,8}", message = "!")
	String nickname;

	@Pattern(regexp = "^[0-9].{10,10}$", message = "!")
	String phone;

	String auth;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getPswd() {
		return pswd;
	}

	public void setPswd(String pswd) {
		this.pswd = pswd;
	}

	public String getCfpswd() {
		return cfpswd;
	}

	public void setCfpswd(String cfpswd) {
		this.cfpswd = cfpswd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}
}
