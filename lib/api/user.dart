import 'package:hm_shop/constant/index.dart';
import 'package:hm_shop/utils/DioRequset.dart';
// import 'package:flutter/cupertino.dart';
import 'package:hm_shop/models/user.dart';

Future<UserInfo> loginAPI(String url, {Map<String, dynamic>? data}) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN_URL, data: data),
  );
}

//获取用户信息
Future<UserInfo> getUserInfoAPI() async {
  return UserInfo.fromJSON(await dioRequest.get(HttpConstants.USER_INFO_URL));
}
