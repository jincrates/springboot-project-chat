package com.jincrates.chat.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.jincrates.chat.dto.ChatMessage;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.slf4j.Slf4j;

@Component
//@Slf4j
public class ChatDao {
	private List<ChatMessage> chatMessageList;
	
	ChatDao() {
		chatMessageList = new ArrayList<>();
	}
	
	public void addMessage(int roomId, String writer, String content) {
		int newId = chatMessageList.size() + 1;
		ChatMessage aChatMessage = new ChatMessage(newId, roomId, writer, content);
		
		chatMessageList.add(aChatMessage);
	}

	public List getMessage(int roomId, int from) {
		List<ChatMessage> message = new ArrayList();
		
		for(ChatMessage chatMessage : chatMessageList) {
			if(chatMessage.getRoomId() == roomId && chatMessage.getId() >= from) {
				message.add(chatMessage);
			}
		}
		
		return message;
	}

	public List getAllMessage() {
		//Log.info("ChatDao.getAllMessage() 실행");
		return chatMessageList;
	}

	public void removeAllMessage() {
		chatMessageList.clear();
	}
}
