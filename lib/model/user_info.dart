class UserInfo{
  UserInfoEntity user_info;
  UserInfo.fromJson(Map<String, dynamic> json){
    user_info = new UserInfoEntity.fromJson(json["user_info"]);
  }
}

class UserInfoEntity{
   String user_name;
   String user_address;
   int is_zy;
   String created_at;
   String source;
   String user_state;
   String user_latitude;
   String user_sex;
   String user_type;
   int create_id;
   String updated_at;
   String im_uuid;
   String im_password;
   String user_phone;
   String register_channel;
   String user_business;
   String user_photo;
   String user_email;
   int display;
   String user_longitude;
   String user_birthday;
   String user_id;
   String user_area;
   String invite_code;
   String signature;
   int is_unlock_face;


   UserInfoEntity.fromJson(Map<String, dynamic> userMap) {
     user_name = userMap["user_name"];
     user_address = userMap["user_address"];
     is_zy = userMap["is_zy"];
     created_at = userMap["created_at"];
     source = userMap["source"];
     user_state = userMap["user_state"];
     user_latitude = userMap["user_latitude"];
     user_sex = userMap["user_sex"];
     user_type = userMap["user_type"];
     im_uuid = userMap["im_uuid"];
     im_password = userMap["im_password"];
     user_phone = userMap["user_phone"];
     register_channel = userMap["register_channel"];
     user_business = userMap["user_business"];
     user_photo = userMap["user_photo"];
     user_email = userMap["user_email"];
     user_longitude = userMap["user_longitude"];
     user_birthday = userMap["user_birthday"];
     user_id = userMap["user_id"].toString();
     user_area = userMap["user_area"];
     invite_code = userMap["invite_code"];
     signature = userMap["signature"];
   }
}


class UserStatistic{

}