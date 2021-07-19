<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>  -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script>
var roomId = parseInt('${param.roomId}');
</script>

<script>
// 폼이 발송되기 전에 한 번씩 실행
// 즉 엔터 한 번 칠 때마다 실행
function Chat__addMessage(writer, body) {
	$.post(
		'/chat/doAddMessage',
		{
			roomId:roomId,
			writer: writer,
			body: body
		},
		function(data) {
			//console.log(data.msg);
		},
		'json'
	);
}

var Chat__lastLoadedMessageId = 0;

function Chat__drawMessage(chatMessage) {
	var html = chatMessage.writer + ' : ' + chatMessage.body;
	
	$(".chat-messages").append("<div>" + html + "</div>");
}

function Chat__loadNewMessages() {
	$.get(
		'/chat/getMessages',
		{
			roomId: roomId,
			from: Chat__lastLoadedMessageId + 1
		},
		function(data){
			for ( var i = 0; i < data.messages.length; i++ ){
				Chat__drawMessage(data.messages[i]);
				
				Chat__lastLoadedMessageId = data.messages[i].id;
			}
		},
		'json'
	);
}

setInterval(Chat__loadNewMessages, 1000);

function submitChatMessageForm(form) {
	form.writer.value = form.writer.value.trim();
	
	if( form.writer.value.length == 0 ) {
		alter("작성자를 입력해주세요.");
		form.writer.focus();
		
		return false;
	}
	
	if( form.body.value.length == 0 ) {
		alter("내용을 입력해주세요.");
		form.body.focus();
		
		return false;
	}
	
	var writer = form.writer.value;
	var body = form.body.value;
	
	form.body.value = '';
	form.body.focus();
	
	Chat__addMessage(writer, body);
}
</script>
</head>
<body>
	<h1>${roomId}번방</h1>
	<!-- 
	<h1>${param.roomId}번방</h1>
	 -->
	<form onsubmit="submitChatMessageForm(this); return false;">
		<div>
			<input type="text" name="writer" placeholder="작성자" autocomplete="off" />
		</div>
		<div>
			<input type="text" name="body" placeholder="내용" autocomplete="off" />
		</div>
		<div>
			<input type="submit" value="작성" />
		</div>
	</form>
	
	<div class="chat-messages"></div>
</body>
</html>