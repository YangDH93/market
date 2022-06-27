package com.market.root.mybatis.member;

import com.market.root.member.dto.MemberDTO;

public interface MemberMapper {
	public MemberDTO logChk(String mbrId);
}
