package com.market.root.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.market.root.file.dto.FileDTO;
import com.market.root.file.service.FileService;
import com.market.root.mybatis.categories.CategoriesMapper;
import com.market.root.mybatis.pick.PickMapper;
import com.market.root.mybatis.product.ProductMapper;
import com.market.root.pick.dto.PickDTO;
import com.market.root.pick.service.PickService;
import com.market.root.product.dto.CategoriesDTO;
import com.market.root.product.dto.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired ProductMapper mapper;
	@Autowired CategoriesMapper cMapper; //카테고리 mapper
	@Autowired PickMapper pMapper;
	@Autowired FileService fs; //파일 서비스 처리
	@Autowired PickService pickSc; //찜 처리
	
	//판매중인 게시판
	public void psAllView(Model model, int num, HttpSession session) {
			System.out.println("num : " + num);
			int repeat, allCount;
			String mbrId = (String)session.getAttribute("loginUser");
		try {
			//개인 작성 판매글 수
			int prodStat = 0;
			int persCount = mapper.personalSell(mbrId,prodStat);
			//한 페이지당 보여줄 게시글 수
			int pageLetter = 5; 
			//전체 게시글 수 불러오기
			if(mbrId.equals("admin")) {
				//페이지 수 = 전체 게시글 수 / 보여줄 게시글 수
				allCount = mapper.selectBoardCount();
				repeat = allCount / pageLetter;
				if(allCount % pageLetter != 0 || repeat == 0) {
						repeat += 1;
				}
			}else {
				repeat = persCount / pageLetter;
				//전체 페이지(마지막 보여질 페이지) % 보여줄 게시글 수가 0이 아니면 페이지+1 증가
				if(persCount % pageLetter != 0 || repeat == 0) {
					repeat += 1;
				}
			}

			//끝 페이지 번호
			int end = num * pageLetter;
			//시작 페이지 번호
			int start = end + 1 - pageLetter;
			//마지막 페이지번호 가져옴
			model.addAttribute("repeat", repeat);
			//게시글 모든 정보 가져옴
			model.addAttribute("psList", mapper.psAllView(start,end,mbrId) );
			//게시글에 맞는 이미지 가져옴
			addImgModel(model, mapper.psAllView(start,end,mbrId));
			//게시글에 맞는 pickTotal값 가져옴
			pickSc.getTotalList(model, mapper.psAllView(start,end,mbrId));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//판매 완료된 모든 정보
	public void sellsAllView(Model model, int num, HttpSession session) {
		int repeat;
		String mbrId = (String)session.getAttribute("loginUser");
		try {
			//개인 작성 판매글 수
			int prodStat = 1;
			int allCount;
			int persCount = mapper.personalCompleSell(mbrId, prodStat);
			//한 페이지당 보여줄 게시글 수
			int pageLetter = 5; 
			//전체 게시글 수 불러오기
			if(mbrId.equals("admin")) {
				allCount = mapper.selectCompleBoardCount();
				//페이지 수 = 전체 게시글 수 / 보여줄 게시글 수
				repeat = allCount / pageLetter;
				if(allCount % pageLetter != 0 || repeat == 0) {
						repeat += 1;
				}
			}else {
				repeat = persCount / pageLetter;
				if(persCount % pageLetter != 0 || repeat == 0) {
					repeat += 1;
				}
			}
			
			//끝 페이지 번호
			int end = num * pageLetter;
			//시작 페이지 번호
			int start = end + 1 - pageLetter;
			//마지막 페이지번호 가져옴
			model.addAttribute("repeat", repeat);
			//게시글 모든 정보 가져옴
			model.addAttribute("psList", mapper.sellsAllView(start,end,mbrId) );
			//게시글에 맞는 이미지 가져옴
			addImgModel(model, mapper.sellsAllView(start,end,mbrId));
			//게시글에 맞는 pickTotal값 가져옴
			pickSc.getTotalList(model, mapper.sellsAllView(start,end,mbrId));
			
	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//userPick 구현 
	@Override
	public void picksAllView(Model model, int num, HttpSession session) {
		int repeat;
		String mbrId = (String)session.getAttribute("loginUser");
		try {
			int allCount; //개인 pickList 수
			int pageLetter = 5; 
			//전체 게시글 수 불러오기
			allCount = mapper.selectPickBoardCount(mbrId);
			//페이지 수 = 전체 게시글 수 / 보여줄 게시글 수
			repeat = allCount / pageLetter;
			if(allCount % pageLetter != 0 || repeat == 0) {
					repeat += 1;
			}
			
			//끝 페이지 번호
			int end = num * pageLetter;
			//시작 페이지 번호
			int start = end + 1 - pageLetter;
			//마지막 페이지번호 가져옴
			model.addAttribute("repeat", repeat);
			//게시글 모든 정보 가져옴
			model.addAttribute("pickList", mapper.picksAllView(start,end,mbrId));
			//게시글에 맞는 이미지 가져옴
			addImgModel(model, mapper.picksAllView(start,end,mbrId));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//상품 검색 기능
	public void prodSearch(String keyword, Model model) {
		try {
			model.addAttribute("prodList", mapper.prodSearch(keyword));	
			addImgModel(model, mapper.prodSearch(keyword));
		} catch (Exception e) {
			e.printStackTrace(); 
		}
	}
	//한 개의 상품정보 가져오기 - prodTrade로 연결 + 조회수 증가
	//시간 계산
	public void oneProduct(Map<Object, Object> map, Model model) {
			try {
				System.out.println("등록된 상품시간 : " + map.get("prodDate"));
				String prodTime = String.valueOf(map.get("prodDate"));
				//등록상품 시간
				long pTime = Long.parseLong(prodTime);
				//현재 시간
				long time = System.currentTimeMillis();
				long setTime = time-pTime;
				
				long sec = setTime / 1000; //초
				long min = setTime / 60000; //분
				long hour = setTime / 3600000; // 시
				long days = sec / (24*60*60); //일
				
				System.out.println(days + "일" + hour + "시 " + min + "분 " + sec + "초");
				
				Map<Object, Object> timer = new HashMap<Object, Object>();
				timer.put("sec",sec);
				timer.put("hour", hour);
				timer.put("min", min);
				timer.put("days", days);
				
				mapper.upHit(map);
				model.addAttribute("timer",timer);
				model.addAttribute("prod",mapper.oneProduct(map));
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	
	//자신의 상품 삭제
	public int prodDelete(int prodId) {
		int result = 0;
		try {
			result = mapper.prodDelete(prodId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	//한개 상품 정보만을 가져옴 - 시간처리 x	
	public void prodStatus(int prodId, Model model) {
		try {
			model.addAttribute("prod", mapper.prodStatus(prodId));
			//카테고리명만 가져오는 model - cateNameAll
			oneCateAll(model, mapper.prodStatus(prodId));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//카테고리 대분류 불러오기
	@Override
	public void cateAllList(Model model) {
		try {
			model.addAttribute("cateList", cMapper.cateAllList());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//카테고리 하위분류 불러오기
	@Override
	public ArrayList<CategoriesDTO> cateList(String sltCode) {
		ArrayList<CategoriesDTO> arr = new ArrayList<CategoriesDTO>();
		try {
			arr = cMapper.cateList(sltCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	
	//하나의 상품 카테고리 model
	@Override
	public void oneCateAll(Model model,ProductDTO dto) {
		try {
			ArrayList<CategoriesDTO> arr = cMapper.oneCateAll(dto.getCateCode());
			String getCateName = "";
			for(int i=0; i<arr.size(); i++) {
				CategoriesDTO cDto = arr.get(i);
				
				if(i != 0) { getCateName += " > "; }
				getCateName += cDto.getCateName();
			}
			model.addAttribute("cateNameAll", getCateName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//상품 등록
	public int prodRegister(ProductDTO dto , String orgImg,String uploadPath,String UUID) {
		int result = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("orgImg", orgImg);
		map.put("uploadPath",uploadPath.replace("\\", "/"));
		map.put("UUID",UUID);
		try {
			// 결과 1 또는 0 반환
			result = mapper.prodRegister(dto);
			result = mapper.prodImgRegister(map);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	//상품 정보 업데이트
	public int prodUpdate(ProductDTO dto,String orgImg,String uploadPath,String UUID) {
		int result = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("orgImg", orgImg);
		map.put("uploadPath",uploadPath.replace("\\", "/"));
		map.put("UUID",UUID);
		map.put("prodId",dto.getProdId());
		try {
			// 결과 1 또는 0 반환
			result = mapper.prodUpdate(dto);
			result = mapper.prodImgUpdate(map);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	//상품 판매완료로 변경 - update
	public int sellsComple(ProductDTO dto,Model model) {
		int result = 0;
		System.out.println("상품상태 다시 확인 : "+dto.getProdStat());
		try {
			result = mapper.sellsComple(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	//main페이지 상품 출력 메소드
	@Override
	public void mainAllView(Model model) {
		try {
			model.addAttribute("mainAllView", mapper.mainAllView()); //모델값 저장
			addImgModel(model,mapper.mainAllView()); //이미지경로 모델값 저장 메소드
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//카테고리 검색 상품 출력 메소드
	@Override
	public void cateSerchView(Model model,String cateCode) {
		try {
			model.addAttribute("cateSerchView", mapper.cateSerchView(cateCode)); //모델값 저장
			addImgModel(model,mapper.cateSerchView(cateCode)); //이미지경로 모델값 저장 메소드
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//현재 model로 출력될 리스트의 이미지들 새로운 이미지 model에 저장하는 메소드
	public void addImgModel(Model model, 
							List<ProductDTO> arr) {
		List<String> fArr = new ArrayList<String>();
		
		try {
			for(int i=0; i<arr.size(); i++) {
				ProductDTO dto = arr.get(i); //prod 값 저장
				//System.out.println("상품번호 : "+dto.getProdId());
				//이미지 관련 메소드 호출
				fs.prodImgList(model, dto.getProdId());
				
				FileDTO fDto = (FileDTO) model.getAttribute("fileDTO");//file 값 저장
				
				//이미지 경로 저장 준비
				String getU = fDto.getUUID();
				String[] UUID = getU.split("/");
				
				String getO = fDto.getOrgImg();
				String[] OrgImg = getO.split("/");
				
				//이미지 경로 저장
				String filePath = fDto.getUploadPath()+"/s_"+UUID[0]+"_"+OrgImg[0];
				
				fArr.add(filePath); // 배열에 저장
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("filePath", fArr);
	}
	
	//찜 삭제 메소드
	@Override
	public void pickDelete(ProductDTO dto) {
		
		String prodId = Integer.toString(dto.getProdId());
		String mbrId = dto.getMbrId();
		try {
			pMapper.pickDelete(prodId, mbrId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}






	
