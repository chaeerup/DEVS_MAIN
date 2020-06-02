package com.instagram.clone.common.socket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonObject;
import com.instagram.clone.model.biz.dm.MongoDmBiz;
import com.instagram.clone.model.vo.DmVo;
import com.instagram.clone.model.vo.MemberJoinProfileSimpleVo;
import com.instagram.clone.model.vo.MemberVo;

public class AlarmSocketHandler extends TextWebSocketHandler {

   @Autowired
   private MongoDmBiz mongoDmBiz;

   private Map<WebSocketSession, Integer> sessionMap = new HashMap<>(); // <세션, 채팅방번호>

   public AlarmSocketHandler() {

   }

   // 클라이언트와 연결 이후에 실행되는 메서드
   @Override
   public void afterConnectionEstablished(WebSocketSession session) throws Exception {
      sessionMap.put(session, -1);
      System.out.println("WebSocketSession.getId() : " + session.getId());
   }

   // 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
   @Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      String verify = message.getPayload().split(",")[0];

      if (verify.equals("chat")) { // session이 채팅을 쳤을때
         sendChatMessage(session, message);
      } else if (verify.equals("out")) { // 채팅방에서 나갓을 때
         sessionMap.put(session, -1);
      }
   }

   // 채팅 메시지 보내기
   private void sendChatMessage(WebSocketSession session, TextMessage message) throws IOException {

      int member_code = ((MemberVo) session.getAttributes().get("user")).getMember_code();
      int room_code = Integer.parseInt(message.getPayload().split(",")[1]);
      String chat_message = message.getPayload().split(",")[2];

      System.out.println((room_code + "방, " + session.getId() + ", " + member_code + "로 부터 " + chat_message + " 받음"));

      // 가장 최근 채팅 document를 통해 현재 채팅방에 참여중인 사람들의 정보를 추출
      DmVo recentChat = mongoDmBiz.findRecentChat(room_code);

      // 소켓통신 이용하여 채팅방에 전송
      for (WebSocketSession sess : sessionMap.keySet()) {
         for (MemberJoinProfileSimpleVo room_member : recentChat.getMember_list()) {

            // 채팅방에 참여중인 멤버코드리스트 와 접속중인 멤버코드들 중 일치하는 코드가 있다면 메시지 보냄
            if (room_member.getMember_code() == ((MemberVo) sess.getAttributes().get("user")).getMember_code()) {
               JsonObject json = new JsonObject();
               json.addProperty("chat", "chat");

               sess.sendMessage(new TextMessage(json.toString()));
            }
         }
      }

   }

   // 클라이언트와 연결을 끊었을 때 실행되는 메소드
   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      sessionMap.remove(session);
      System.out.println(("연결 끊김 : " + session.getId()));
   }

}