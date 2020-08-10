class CodeLoginModel {
  String token;
  int is_new_user;
  String user_id;
  String im_password;

  CodeLoginModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> loginMap = json["data"];
    token = loginMap["token"];
    is_new_user = loginMap["is_new_user"];
    user_id = loginMap["user_id"];
    im_password = loginMap["im_password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['is_new_user'] = this.is_new_user;
    data['user_id'] = this.user_id;
    data['im_password'] = this.im_password;
    return data;
  }

}
