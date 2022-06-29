package com.market.root.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.root.mybatis.member.MemberMapper;

@Service
public class RegisterServiceImpl implements RegisterService{

	@Autowired MemberMapper mapper;
	
}
