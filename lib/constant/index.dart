// 全局常量
class GlobalConstants {
  static const String BASE_URL = 'https://meikou-api.itheima.net';
  static const int TIME_OUT = 10; //超时时间10秒
  static const String SUCCESS_CODE = '1'; //成功状态码
  static const String TOKEN_KEY = 'hs_shop_token'; //token键名
}

//请i去接口的常量
class HttpConstants {
  static const String BANNER_URL = '/home/banner'; //轮播图接口
  static const String CATEGORY_URL = '/home/category/head'; //分类接口
  static const String PRODUCT_URL = '/hot/preference'; //特惠推荐地址
  // static const String MORE_LIST_URL = '/home/moreList'; //更多列表接口
  // static const String SUGGESTION_URL = '/home/suggestion'; //建议接口
  // static const String USER_INFO = '/user/info'; //用户信息接口
  //推荐列表
  static const String RECOMMEND_LIST = '/home/recommend';
  //login
  static const String LOGIN_URL = '/login';

  ///member/profile
  ///用户信息接口
  static const String USER_INFO_URL = '/member/profile';

  ///member/logout
  ///退出登录接口
  static const String LOGOUT_URL = '/member/logout';
}
