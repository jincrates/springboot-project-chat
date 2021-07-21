package com.jincrates.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jincrates.chat.dao.ChatDao;
import com.jincrates.chat.dto.ChatMessage;

@Service
public class ChatService {
	
	@Autowired
	ChatDao dao;

	public void addMessage(int roomId, String writer, String content) {
		dao.addMessage(roomId, writer, content);
	}

	public List getMessage(int roomId, int from) {
		return dao.getMessage(roomId, from);
	}
	
	public List getAllMessage() {
		return dao.getAllMessage();
	}

	public void removeAllMessage() {
		dao.removeAllMessage();
	}
}
