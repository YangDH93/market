package com.market.root.member.dto;

import java.sql.Date;

public class MemberDTO {
	private String mbrId;
	private String mbrPw;
	private String mbrEmail;
	private String mbrName;
	private String mbrAddr;
	private String mbrTel;
	
	private int mbrScore;
	private Date mbrDate;
	
	private String sessionId;
	private Date limitTime;
	
	public String getMbrAddr() {
		return mbrAddr;
	}
	public void setMbrAddr(String mbrAddr) {
		this.mbrAddr = mbrAddr;
	}
	public String getMbrTel() {
		return mbrTel;
	}
	public void setMbrTel(String mbrTel) {
		this.mbrTel = mbrTel;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public Date getLimitTime() {
		return limitTime;
	}
	public void setLimitTime(Date limitTime) {
		this.limitTime = limitTime;
	}
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getMbrPw() {
		return mbrPw;
	}
	public void setMbrPw(String mbrPw) {
		this.mbrPw = mbrPw;
	}
	public String getMbrEmail() {
		return mbrEmail;
	}
	public void setMbrEmail(String mbrEmail) {
		this.mbrEmail = mbrEmail;
	}
	public String getMbrName() {
		return mbrName;
	}
	public void setMbrName(String mbrName) {
		this.mbrName = mbrName;
	}
	public int getMbrScore() {
		return mbrScore;
	}
	public void setMbrScore(int mbrScore) {
		this.mbrScore = mbrScore;
	}
	public Date getMbrDate() {
		return mbrDate;
	}
	public void setMbrDate(Date mbrDate) {
		this.mbrDate = mbrDate;
	}
	
	// 로그인 세션 update쿼리문관련 String값 가져오기
	@Override
	public String toString() {
		return "MemberDTO [mbrId=" + mbrId
						+ ", mbrPw=" + mbrPw
						+ ", mbrName=" + mbrName
						+ ", mbrEmail=" + mbrEmail
						+ ", mbrScore=" + mbrScore
						+ ", mbrDate=" + mbrDate
						+ ", sessionId=" + sessionId
						+ ", limitTime=" + limitTime
						+"]";
	}
}
