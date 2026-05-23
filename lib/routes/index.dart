// 路由配置
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';
import 'package:hm_shop/pages/User/index.dart';

//返回App根及组件
Widget getRootWidget() {
  return MaterialApp(initialRoute: "/", routes: getRootRoutes());
}

// 路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {"/": (context) => MainPage(), "/login": (context) => LoginPage()};
}
