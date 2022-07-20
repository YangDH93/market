package com.market.root.chat.handler;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class HandlerChat extends TextWebSocketHandler {
	private File file = new File("C:\\market\\chat\\chat.txt");
	
	// (<"bang_id", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) 형태 
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	// 클라이언트가 서버로 메세지 전송 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, 
			TextMessage message) throws Exception {

		super.handleTextMessage(session, message);

		// JSON --> Map으로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, String> mapReceive = objectMapper.readValue(message.getPayload(), Map.class);

		switch (mapReceive.get("cmd")) {
		
		// CLIENT 입장
		case "CMD_ENTER":
			// 세션 리스트에 저장
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bang_id", mapReceive.get("bang_id"));
			map.put("session", session);
			sessionList.add(map);
			
			// 같은 채팅방에 입장 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String bang_id = (String) mapSessionList.get("bang_id");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				
				if(bang_id.equals(mapReceive.get("bang_id"))) {
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("bang_id", bang_id);
					mapToSend.put("cmd", "CMD_ENTER");
					//session.getId() < 현재 사용자 Id
					String chatUser = (String) session.getAttributes().get("loginUser");
					
					//입장 전 보여줄 메세지
					readFile();
					//입장 후
					mapToSend.put("msg", chatUser + "님이 입장 했습니다.");
					String sendMessage = chatUser + "님이 입장 했습니다.";
					saveFile(chatUser, sendMessage);
				
					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
			break;
			
		// CLIENT 메세지
		case "CMD_MSG_SEND":
			// 같은 채팅방에 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String bang_id = (String) mapSessionList.get("bang_id");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

				if (bang_id.equals(mapReceive.get("bang_id"))) {
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("bang_id", bang_id);
					mapToSend.put("cmd", "CMD_MSG_SEND");
					System.out.println(mapToSend.get("cmd"));
					String chatUser = (String) session.getAttributes().get("loginUser");
					mapToSend.put("msg", chatUser + " : " + mapReceive.get("msg"));
					String sendMessage = chatUser + " : " + mapReceive.get("msg");
					saveFile(chatUser, sendMessage);

					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
			break;
		}
	}

	// 클라이언트가 연결을 끊음 처리
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		super.afterConnectionClosed(session, status);
        
		ObjectMapper objectMapper = new ObjectMapper();
		String now_bang_id = "";
		
		// 사용자 세션을 리스트에서 제거
		for (int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> map = sessionList.get(i);
			String bang_id = (String) map.get("bang_id");
			WebSocketSession sess = (WebSocketSession) map.get("session");
			
			if(session.equals(sess)) {
				now_bang_id = bang_id;
				sessionList.remove(map);
				break;
			}	
		}
		
		// 같은 채팅방에 퇴장 메세지 전송 
		for (int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> mapSessionList = sessionList.get(i);
			String bang_id = (String) mapSessionList.get("bang_id");
			WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

			if (bang_id.equals(now_bang_id)) {
				Map<String, String> mapToSend = new HashMap<String, String>();
				mapToSend.put("bang_id", bang_id);
				mapToSend.put("cmd", "CMD_EXIT");
				String chatUser = (String) session.getAttributes().get("loginUser");
				mapToSend.put("msg", chatUser + "님이 퇴장 했습니다.");
				String sendMessage = chatUser + "님이 퇴장 했습니다.";
				saveFile(chatUser, sendMessage);

				String jsonStr = objectMapper.writeValueAsString(mapToSend);
				sess.sendMessage(new TextMessage(jsonStr));
			}
		}
	}
	
	//파일에 메세지 내용 save
	private void saveFile(String id, String message) {
		try(FileWriter fw = new FileWriter("C:\\market\\chat\\chat.txt", true);
			BufferedWriter bw = new BufferedWriter(fw);
			) 
		{
			bw.write(message); //버퍼에 데이터 입력
			bw.newLine(); //버퍼에 개행 삽입
			bw.flush(); //버퍼 내용 파일에 작성
		} catch (Exception e) {
			e.printStackTrace();
		}
		//파일 존재여부 판단
		if(file.isFile()) {
			System.out.println("chat.txt 파일 존재함.");
		}
	}
	private void readFile(){
		////////////////File Read/////////////////
		Map<String, String> mapToSend = new HashMap<String, String>();
		try(FileReader rw = new FileReader("C:\\market\\chat\\chat.txt");
				BufferedReader br = new BufferedReader( rw );
				) {
			//읽을 라인이 없을 경우 br은 null을 리턴한다.
			String readLine = null;
			while( ( readLine = br.readLine() ) != null ) {
				System.out.println(readLine);
				mapToSend.put("msg", readLine);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}





