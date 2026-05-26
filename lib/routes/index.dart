// 路由配置
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';
import 'package:hm_shop/pages/User/index.dart';
import 'package:hm_shop/pages/shop/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';

// 返回App根组件
Widget getRootWidget() {
  return MaterialApp(
    initialRoute: "/",
    routes: getRootRoutes(),
    onGenerateRoute: (settings) {
      return _generateRoute(settings);
    },
  );
}

// 路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) => MainPage(),
    "/login": (context) => LoginPage(),
    "/user": (context) => UserPage(),
    "/shop": (context) => ShopPage(),
  };
}

/// 路由生成器（路由守卫）
Route<dynamic>? _generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/shop':
      // 购物车页面需要登录
      return MaterialPageRoute(
        builder: (context) => const ShopPage(),
        settings: settings,
      );
    default:
      // 其他路由直接跳转
      final widgetBuilder = getRootRoutes()[settings.name];
      if (widgetBuilder != null) {
        return MaterialPageRoute(
          builder: widgetBuilder,
          settings: settings,
        );
      }
      return null;
  }
}

/// 检查登录状态并跳转
Future<bool> checkLoginAndNavigate(BuildContext context, String targetRoute) async {
  await tokenManager.init();
  String token = tokenManager.getToken();
  
  if (token.isEmpty) {
    // 未登录，跳转到登录页面
    Navigator.pushReplacementNamed(context, '/login');
    return false;
  }
  return true;
}
