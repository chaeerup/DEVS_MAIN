package com.instagram.clone.model.dao.dm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.instagram.clone.model.vo.DmVo;
import com.mongodb.client.result.UpdateResult;

@Repository
public class MongoDmDaoImpl implements MongoDmDao {

   @Autowired
   private MongoTemplate mongo;

   @Autowired
   private SequenceGenerator seqGenerator;

   @Override
   public DmVo insertChatRoom(DmVo newRoom) {
      newRoom.setRoom_code((int) seqGenerator.getNextSequenceId(newRoom.ROOM_CODE_SEQ_NAME));
      return mongo.insert(newRoom, "INSTAGRAM");
   }

   @Override
   public List<DmVo> findMyChatRoomList(int my_member_code) {

      // 1. 어그리게이트, 같은 room_code에서 최대 chat_code를 가져오기
      Aggregation aggre = Aggregation.newAggregation(//
            Aggregation.sort(Sort.Direction.DESC, "chat_code"), //
            Aggregation.group("room_code").first("chat_code").as("chat_code")//
      );

      Map<String, Object> map = new HashMap<>();
      AggregationResults<? extends Map> result = mongo.aggregate(aggre, "INSTAGRAM", map.getClass());

      Iterator<? extends Map> iter = result.iterator();
      List<Integer> chat_code_list = new ArrayList<Integer>();
      while (iter.hasNext()) {
         Map<String, Object> resultMap = iter.next();
         chat_code_list.add((Integer) resultMap.get("chat_code"));

         System.out.println("------------------------" + resultMap);
//         System.out.println("------------------------" + (Integer) resultMap.get("chat_code"));
      }

      // 2. 최종, 해당 채널, 채팅방 별 최근 채팅 메시지 document list 추출 -> 채팅방리스트
      Criteria criteria = new Criteria();
      criteria.andOperator(Criteria.where("chat_code").in(chat_code_list), Criteria.where("chat_code").ne(0));

      Query finalQuery = new Query(criteria).addCriteria(Criteria.where("member_list.member_code").in(my_member_code))
            .with(Sort.by(Sort.Direction.DESC, "chat_code"));

      return mongo.find(finalQuery, DmVo.class, "INSTAGRAM");
   }

   @Override
   public DmVo findRecentChat(int room_code) {
      Query query = new Query(Criteria.where("room_code").is(room_code))
            .with(Sort.by(Sort.Direction.DESC, "chat_code")).limit(1);

      return mongo.findOne(query, DmVo.class, "INSTAGRAM");
   }

   @Override
   public DmVo insertChat(DmVo newChat) {
      newChat.setChat_code((int) seqGenerator.getNextSequenceId(newChat.CHAT_CODE_SEQ_NAME));
      return mongo.insert(newChat, "INSTAGRAM");
   }

   @Override
   public List<DmVo> selectChatList(int room_code) {

      Query query = new Query();

      Criteria criteria = new Criteria();
      criteria.andOperator(Criteria.where("room_code").is(room_code), Criteria.where("chat_code").ne(0));

      query.addCriteria(criteria).with(Sort.by(Sort.Direction.ASC, "chat_code"));

      return mongo.find(query, DmVo.class, "INSTAGRAM");
   }

   @Override
   public void removeUnreadMemberCodeList(int room_code, int member_code) {
      Query query = new Query(Criteria.where("room_code").is(room_code));
      Update update = new Update().pull("unread_member_code_list", member_code);

      UpdateResult result = mongo.updateMulti(query, update, DmVo.class, "INSTAGRAM");
   }

}