package com.market.root.product.dto;

import java.sql.Date;

public class ProductDTO {
	private String mbrId; //primary key
	private String prodId; //primary key
	private String prodTitle;
	private String prodContent;
	private String price;
	private String trdLocation; // 주소 : nan이 아닐경우 mbr_addr에서 값 가져옴, nan의 경우 페이지에서 입력

	private int prodNum; //게시판 넘버
	private int hit; // default 0, 1000 넘으면 안들어가지게 한다. 
	private int prodStat; // 판매중 상태 : default 0, ( 0 판매중 , 1 예약중 , 2 판매완료 )
	private Date prodDate; // 등록일
	
	
	public int getProdNum() {
		return prodNum;
	}

	public void setProdNum(int prodNum) {
		this.prodNum = prodNum;
	}
	
	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getProdTitle() {
		return prodTitle;
	}

	public void setProdTitle(String prodTitle) {
		this.prodTitle = prodTitle;
	}

	public String getProdContent() {
		return prodContent;
	}

	public void setProdContent(String prodContent) {
		this.prodContent = prodContent;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTrdLocation() {
		return trdLocation;
	}

	public void setTrdLocation(String trdLocation) {
		this.trdLocation = trdLocation;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getProdStat() {
		return prodStat;
	}

	public void setProdStat(int prodStat) {
		this.prodStat = prodStat;
	}

	public Date getProdDate() {
		return prodDate;
	}

	public void setProdDate(Date prodDate) {
		this.prodDate = prodDate;
	}

}