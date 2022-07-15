package com.market.root.file.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.market.root.file.dto.FileDTO;
import com.market.root.mybatis.file.FileMapper;

@Service
public class FileServiceImpl implements FileService{

	@Autowired FileMapper mapper;
	public void prodImgList(Model model,Object prodId) {
		try {
			String[] orgImg = mapper.prodImgList(prodId).getOrgImg().split("/");
			String[] UUID = mapper.prodImgList(prodId).getUUID().split("/");
			int imgLength = orgImg.length;
			
			model.addAttribute("fileDTO",mapper.prodImgList(prodId));
			model.addAttribute("imgLength",imgLength);
			model.addAttribute("UUID",UUID);
			model.addAttribute("orgImg",orgImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
