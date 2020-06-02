
  function openDmSocket(){
       ws = new WebSocket("wss://www.devsmain.ml/echo");
  }
  $(function(){
       if(ws !== undefined && ws.readyState !== WebSocket.CLOSED){
           /* writeResponse("WebSocket is already opened.") */
           return
       }
       // 웹소켓 객체 생성
       openDmSocket();
       
       // 웹소켓 열림
       ws.onopen=function(event){    
    	   console.log("소켓 연결!!")
           if(event.data === undefined) {
              return
           } else {                  
              console.log("소켓 연결");
           }               
       };
       
       // 소켓으로부터 메시지 도착 시 (메시지의 attribute 이름에 따라 이벤트를 구분)
       ws.onmessage=function(event){
          
           var data = JSON.parse(event.data);
           
           if (data.enter != undefined) { // 다른 접속자가 채팅창에 접속했음을 알림   
              notifyUnreadChange(data.enter);          
           } else if (data.chat != undefined){ // 접속자의 메시지가 도착함 
              writeResponse(event.data)   
           findMyChatRoomList() // 채팅방 리스트도 최신화
           }
           
       };
       
       // 소켓 통신 종료 시
       ws.onclose=function(event){
           /* alert("소켓 연결종료") */
           console.log("소켓 연결종료");
       }
  })