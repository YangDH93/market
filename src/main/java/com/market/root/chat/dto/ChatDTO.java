package com.market.root.chat.dto;

public class ChatDTO {

	private String bangId, sellerId, sellerName, buyerId, buyerName;
	private int prodId, sellerBang, buyerBang;
	
	//date랑 fileName DTO아직 추가안함 DB에는 적혀있음
	
	public String getBangId() {
		return bangId;
	}
	public void setBangId(String bangId) {
		this.bangId = bangId;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
	public int getProdId() {
		return prodId;
	}
	public void setProdId(int prodId) {
		this.prodId = prodId;
	}
	public int getSellerBang() {
		return sellerBang;
	}
	public void setSellerBang(int sellerBang) {
		this.sellerBang = sellerBang;
	}
	public int getBuyerBang() {
		return buyerBang;
	}
	public void setBuyerBang(int buyerBang) {
		this.buyerBang = buyerBang;
	}
	
}
