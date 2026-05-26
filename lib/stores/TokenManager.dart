import 'package:hm_shop/constant/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  //返回持久化对象实列对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String token = '';
  Future<void> init() async {
    final prefs = await _getInstance();
    token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? '';
  } //初始化token

  Future<void> setToken(String token) async {
    // this.token = token;
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, token);
  }

  //获取token
  String getToken() {
    return token;
  }

  //移除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);
    token = ''; //清空token变量
  }
}

// 全局实例
final tokenManager = TokenManager();
