package com.market.root.customer.dto;

import java.sql.Date;

public class CustomerDTO {
	private int csNum;
	private String mbrId;
	private String csTitle;
	private String csImg;
	private String csContent;
	private Date date;
	private int replyStat;
	
	public int getCsNum() {
		return csNum;
	}
	public void setCsNum(int csNum) {
		this.csNum = csNum;
	}
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getCsTitle() {
		return csTitle;
	}
	public void setCsTitle(String csTitle) {
		this.csTitle = csTitle;
	}
	public String getCsImg() {
		return csImg;
	}
	public void setCsImg(String csImg) {
		this.csImg = csImg;
	}
	public String getCsContent() {
		return csContent;
	}
	public void setCsContent(String csContent) {
		this.csContent = csContent;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getReplyStat() {
		return replyStat;
	}
	public void setReplyStat(int replyStat) {
		this.replyStat = replyStat;
	}
	
}
