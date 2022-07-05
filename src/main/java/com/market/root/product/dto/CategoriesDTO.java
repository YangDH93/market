package com.market.root.product.dto;

public class CategoriesDTO {

	private int tier;
	private String cateName, cateParent, cateCode;
	
	public int getTier() {
		return tier;
	}
	public void setTier(int tier) {
		this.tier = tier;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getCateParent() {
		return cateParent;
	}
	public void setCateParent(String cateParent) {
		this.cateParent = cateParent;
	}
	public String getCateCode() {
		return cateCode;
	}
	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}
	

	
}
