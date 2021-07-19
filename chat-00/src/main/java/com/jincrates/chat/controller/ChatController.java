package com.jincrates.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jincrates.chat.dto.ChatMessage;
import com.jincrates.chat.service.ChatService;

@Controller
public class ChatController {
	@Autowired
	ChatService service;
	
	@RequestMapping("/chat/room")
	public String showRoom(int roomId, Model model) {
		model.addAttribute("roomId", roomId);
		
		return "chat/room";
	}
	
	@RequestMapping("/chat/doClearAllMessages")
	@ResponseBody
	public Map doClearAllMessages() {
		service.clearAllMessages();
		
		Map rs = new HashMap<>();
		
		rs.put("resultCode", "S-1");
		rs.put("msg", "모든 메시지를 삭제하였습니다.");
		
		return rs;
	}
	
	@RequestMapping("/chat/doAddMessage")
	@ResponseBody
	public Map doAddMessage(int roomId, String writer, String body) {
		service.addMessage(roomId, writer, body);
		
		Map rs = new HashMap<>();
		
		rs.put("resultCode", "S-1");
		rs.put("msg", "채팅 메시지가 추가되었습니다.");
		
		return rs;
	}
	
	@RequestMapping("/chat/getAllMessages")
	@ResponseBody
	public List getAllMessages() {
		return service.getAllMessages();
	}
	
	@RequestMapping("/chat/getMessages")
	@ResponseBody
	public Map getMessages(int roomId, int from) {
		List<ChatMessage> messages =  service.getMessages(roomId, from);
		
		Map rs = new HashMap<>();
		
		rs.put("resultCode", "S-1");
		rs.put("msg", "새 메시지를 가져왔습니다.");
		rs.put("messages", messages);
		
		return rs;
	}
}
