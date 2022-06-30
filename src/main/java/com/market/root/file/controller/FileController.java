package com.market.root.file.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("product")
public class FileController{

	/* 첨부 파일 업로드 */
	@PostMapping("uploadAjaxAction")
	@ResponseBody
	public void uploadAjaxActionPOST(MultipartFile[] uploadFile) {
		
		/* 저장 경로 */
		String uploadFolder = "C:\\market\\image_repo";

		for(MultipartFile multipartFile : uploadFile ) {

			/* 날짜별 폴더 생성  */
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			String str = sdf.format(date);
			String datePath = str.replace("-", File.separator);
			
			/* 폴더 생성 */
			File uploadPath = new File(uploadFolder, datePath);
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
			
			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();	
			
			/* uuid 랜덤 적용 파일 이름 , 고유이름 지정 */
			String uuid = UUID.randomUUID().toString();
			uploadFileName = uuid + "_" + uploadFileName;
			
			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);

			/* 파일 저장 */
			try {
				
				multipartFile.transferTo(saveFile);
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				
				/* 썸네일 생성 */
				BufferedImage bo_image = ImageIO.read(saveFile);
				
				/* 비율 */
				double ratio = 1.75;
				
				/*넓이 높이*/
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);
				
				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
				Graphics2D graphic = bt_image.createGraphics();
				graphic.drawImage(bo_image, 0, 0,width,height, null);
				ImageIO.write(bt_image, "jpg", thumbnailFile);
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
	}
}



