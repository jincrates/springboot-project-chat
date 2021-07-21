<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>
var roomId = parseInt('${param.roomId}');
var lastLoadedMessageId = 0;
</script>
<script>
// 폼이 발송되기 전에 한 번씩 실행
// 즉 엔터 한 번 칠때마다 실행
function addMessage(writer, content) {
	$.post(
		'/chat/addMessage',
		{
			roomId: roomId,
			writer: writer,
			content: content
		},
		function(data) {
			//console.log(data.msg);
		},
		'json'
	);
}

function submitChatMessageForm(form) {
	form.writer.value = form.writer.value.trim();
	
	if(form.writer.value.length == 0 ){
		alter("작성자를 입력해주세요.");
		form.writer.focus();
		
		return false;
	}
	
	if(form.content.value.length == 0 ){
		alter("내용을 입력해주세요.");
		form.content.focus();
		
		return false;
	}
	
	var writer = form.writer.value;
	var content = form.content.value;
	
	form.content.value = "";
	form.content.focus();
	
	addMessage(writer, content);
}

function appendMessage(chatMessage) {
	var html = chatMessage.writer + " : " + chatMessage.content;
	
	$(".chat-message").append("<div>" + html + "</div>");
}

function getMessage() {
	$.get(
		'/chat/getMessage',
		{
			roomId: roomId,
			from: lastLoadedMessageId + 1
		},
		function(data){
			for(var i = 0, max = data.messages.length; i < max; i++){
				appendMessage(data.messages[i]);
				
				lastLoadedMessageId = data.messages[i].id;
			}
		},
		'json'
	);
}

// 1초마다 실행
setInterval(getMessage, 1000);

</script>
</head>
<body>
	<h1>${param.roomId}번방</h1>
	<form onsubmit="submitChatMessageForm(this); return false;">
		<div>
			<input type="text" name="writer" placeholder="작성자" autocomplete="off" />
		</div>
		<div>
			<input type="text" name="content" placeholder="내용" autocomplete="off" />
		</div>
		<div>
			<input type="submit" value="작성" />
		</div>
	</form>
	
	<div class="chat-message"></div>
</body>
</html>