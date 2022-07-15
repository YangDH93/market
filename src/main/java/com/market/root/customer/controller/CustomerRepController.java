package com.market.root.customer.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.market.root.common.SessionId;
import com.market.root.customer.dto.CustomerRepDTO;
import com.market.root.customer.service.CustomerService;

@RestController
@RequestMapping("customer")
public class CustomerRepController {
	@Autowired CustomerService cs;
	
	@PostMapping(value="addReply",
			produces = "application/json; charset=utf-8")
	public void addReply(@RequestBody Map<Object, Object> map,
								HttpSession session) {
		CustomerRepDTO dto = new CustomerRepDTO();
		dto.setId((String)session.getAttribute(SessionId.LOGIN));
		dto.setTitle((String)map.get("title"));
		dto.setWrite_group(Integer.parseInt((String)map.get("write_no")));
		dto.setContent( (String)map.get("content") );
		
		System.out.println( dto.getId() );
		System.out.println( dto.getWrite_group() );
		System.out.println( dto.getTitle());
		System.out.println( dto.getContent());
		
		cs.addReply(dto);
	}
	@GetMapping(value="replyData/{w_g}",
			produces = "application/json; charset=utf-8")
	public List<CustomerRepDTO> replyData(
					@PathVariable("w_g") int write_group) {
		return cs.getRepList(write_group);
	}

}















