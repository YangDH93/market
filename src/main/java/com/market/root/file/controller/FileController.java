package com.market.root.file.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.market.root.file.dto.FileDTO;

import net.coobird.thumbnailator.Thumbnails;


@Controller
@RequestMapping("product")
public class FileController{

   /* 첨부 파일 업로드 */
   @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
   public ResponseEntity<List<FileDTO>> uploadAjaxActionPOST(MultipartFile[] uploadImg) {
      
      /* 이미지 파일 체크 */
      for(MultipartFile multipartFile: uploadImg) {
         
         File checkfile = new File(multipartFile.getOriginalFilename());
         String type = null;
         
         try {
            type = Files.probeContentType(checkfile.toPath());
         } catch (IOException e) {
            e.printStackTrace();
         }
         
         if(!type.startsWith("image")) {
            List<FileDTO> list = null;
            return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
         }
         
      }// for      
      
      String uploadFolder = "C:\\market";
      
      /* 날짜 폴더 경로 */
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Date date = new Date();
      String str = sdf.format(date);
      String datePath = str.replace("-", File.separator);
      
      /* 폴더 생성 */
      File uploadPath = new File(uploadFolder, datePath);
      if(uploadPath.exists() == false) {
         uploadPath.mkdirs();
      }
      
      /* 이미저 정보 담는 객체 */
      List<FileDTO> list = new ArrayList();
      
      // 향상된 for
      for(MultipartFile multipartFile : uploadImg) {
         
         /* 이미지 정보 객체 */
         FileDTO dto = new FileDTO();
         
         /* 파일 이름 + 파일 저장하는 위치 */
         String uploadImgName = multipartFile.getOriginalFilename();
         dto.setOrgImg(uploadImgName);
         dto.setUploadPath(datePath);
         
         /* uuid 적용 파일 이름 */
         String uuid = UUID.randomUUID().toString();
         
         uploadImgName = uuid + "_" + uploadImgName;
         dto.setUUID(uuid);
         
         /* 파일 위치, 파일 이름을 합친 File 객체 */
         File saveFile = new File(uploadPath, uploadImgName);
         
         /* 파일 저장 */
         try {
            multipartFile.transferTo(saveFile);
            
            /* 썸네일 생성(ImageIO) */
            File thumbnailFile = new File(uploadPath, "s_" + uploadImgName);   
            
            BufferedImage bo_image = ImageIO.read(saveFile);
            //비율 
            double ratio = 3;
            //넓이 높이
            int width = (int) (bo_image.getWidth() / ratio);
            int height = (int) (bo_image.getHeight() / ratio);         
            Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);
             
         } catch (Exception e) {
            e.printStackTrace();
         } 
         list.add(dto);
         
      } //for

      ResponseEntity<List<FileDTO>> result = new ResponseEntity<List<FileDTO>>(list, HttpStatus.OK);
      
      return result;
   }
   
   
   /* 이미지 출력 */
   @GetMapping("/display")
   public ResponseEntity<byte[]> getImage(String fileName){
      
      File file = new File("c:\\market\\" + fileName);
      
      ResponseEntity<byte[]> result = null;

      try {

         HttpHeaders header = new HttpHeaders();
         header.add("Content-type", Files.probeContentType(file.toPath()));
         result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

      }catch (IOException e) {
         e.printStackTrace();
      }

      return result;
   }
}


