package com.market.root.product.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.market.root.mybatis.product.ProductMapper;
import com.market.root.product.dto.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired ProductMapper mapper;

	//상품관리 게시판
	public void psAllView(Model model, int num) {

		try {
			//한 페이지당 보여줄 게시글 수
			int pageLetter = 5; 
			//게시글 수 불러오기
			int allCount = mapper.selectBoardCount();
			//페이지 수 = 전체 게시글 수 / 보여줄 게시글 수
			int repeat = allCount / pageLetter;
			//전체 페이지(마지막 보여질 페이지) % 보여줄 게시글 수가 0이 아니면 페이지+1 증가
			if(allCount % pageLetter != 0) {
				repeat += 1;
			}
			//끝 페이지 번호
			int end = num * pageLetter;
			//시작 페이지 번호
			int start = end + 1 - pageLetter;
			//마지막 페이지번호 가져옴
			model.addAttribute("repeat",repeat);
			//게시글 모든 정보 가져옴
			model.addAttribute("psList", mapper.psAllView(start,end) );	

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//상품 검색 기능
	public void prodSearch(String keyword, Model model) {
		try {
			model.addAttribute("prodList", mapper.prodSearch(keyword));
			System.out.println("디비연결"); 
		} catch (Exception e) {
			System.out.println("디비고장");
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
	//상품 정보 업데이트
	public int prodUpdate(int prodId) {
		int result = 0;
		try {
			result = mapper.prodUpdate(prodId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	//한개 상품 정보만을 가져옴 - 시간처리 x	
	public void prodStatus(int prodId, Model model) {
		try {
			model.addAttribute("prod", mapper.prodStatus(prodId));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}






	
