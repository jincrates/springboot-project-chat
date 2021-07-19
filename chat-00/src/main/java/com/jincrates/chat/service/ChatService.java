package com.jincrates.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jincrates.chat.dao.ChatDao;

@Service
public class ChatService {
	@Autowired
	ChatDao dao;

	public void addMessage(int roomId, String writer, String body) {
		dao.addMessage(roomId, writer, body);
	}

	public List getAllMessages() {
		return dao.getAllMessages();
	}

	public List getMessages(int roomId, int from) {
		return dao.getMessages(roomId, from);
	}

	public void clearAllMessages() {
		dao.clearAllMessages();
	}
	
}
