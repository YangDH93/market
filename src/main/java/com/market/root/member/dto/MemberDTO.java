package com.market.root.member.dto;

import java.sql.Date;

public class MemberDTO {
	private String mbrId;
	private String mbrPw;
	private String mbrEmail;
	private String mbrName;
	private int mbrScore;
	private int mbrLevel;
	private Date mbrDate;
	
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
	public int getMbrLevel() {
		return mbrLevel;
	}
	public void setMbrLevel(int mbrLevel) {
		this.mbrLevel = mbrLevel;
	}
	public Date getMbrDate() {
		return mbrDate;
	}
	public void setMbrDate(Date mbrDate) {
		this.mbrDate = mbrDate;
	}
	
}
