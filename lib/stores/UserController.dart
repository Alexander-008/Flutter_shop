import 'package:get/get.dart';
import 'package:hm_shop/models/user.dart';

class UserController extends GetxController {
  var userInfo = UserInfo.fromJSON({}).obs; //用户信息模型
  var isLoading = false.obs; //是否加载中
  var error = ''.obs; //错误信息
  var redirectToShop = false.obs; //是否需要跳转到购物车

  // 更新用户信息
  updateUserInfo(UserInfo newUserInfo) {
    userInfo.value = newUserInfo;
  }

  // 清除用户信息
  void clearUserInfo() {
    userInfo.value = UserInfo.fromJSON({});
  }

  // 设置是否跳转到购物车
  void setRedirectToShop(bool value) {
    redirectToShop.value = value;
  }

  void logout() {}
}
