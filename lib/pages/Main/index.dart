import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/User/index.dart';
import 'package:hm_shop/pages/shop/index.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/stores/TokenManager.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final UserController _userController = Get.put(UserController());
  //首页的tabBar
  final List<Map<String, String>> _tab = [
    {
      'icon': 'lib/assets/tabBar/home.png',
      'selectedIcon': 'lib/assets/tabBar/home_selected.png',
      'title': '首页',
    },
    {
      'icon': 'lib/assets/tabBar/category.png',
      'selectedIcon': 'lib/assets/tabBar/category_selected.png',
      'title': '分类',
    },
    {
      'icon': 'lib/assets/tabBar/shop.png',
      'selectedIcon': 'lib/assets/tabBar/shop_selected.png',
      'title': '购物车',
    },
    {
      'icon': 'lib/assets/tabBar/user.png',
      'selectedIcon': 'lib/assets/tabBar/user_selected.png',
      'title': '我的',
    },
  ];
  //定义变量currentIndex
  int _currentIndex = 0;
  //定义方法bottomNavigattionBar使用
  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    return List.generate(_tab.length, (index) {
      final item = _tab[index];
      return BottomNavigationBarItem(
        icon: Image.asset(item['icon']!, width: 28, height: 28),
        activeIcon: Image.asset(item['selectedIcon']!, width: 28, height: 28),
        label: item['title'],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // 初始化用户信息
    _initUser();
    // 监听是否需要跳转到购物车
    ever(_userController.redirectToShop, (redirect) {
      if (redirect) {
        // 跳转到购物车页面
        setState(() {
          _currentIndex = 2;
        });
        // 重置标志位
        _userController.setRedirectToShop(false);
      }
    });
  }

  /// 初始化用户信息（持久化登录）
  Future<void> _initUser() async {
    // 初始化 tokenManager
    await tokenManager.init();
    // 检查 token 是否有值
    if (tokenManager.getToken().isNotEmpty) {
      // 如果 token 有值，就获取用户信息
      try {
        var userInfo = await getUserInfoAPI();
        _userController.updateUserInfo(userInfo);
      } catch (e) {
        // 获取用户信息失败，清除 token
        await tokenManager.removeToken();
      }
    }
  }

  /// 处理购物车点击
  Future<void> _handleShopTap() async {
    // 检查 token 是否存在
    String token = tokenManager.getToken();
    if (token.isEmpty) {
      // 未登录，标记需要跳转到购物车，然后跳转到登录页面
      _userController.setRedirectToShop(true);
      Navigator.pushNamed(context, '/login');
    } else {
      // 已登录，切换到购物车页面
      setState(() {
        _currentIndex = 2;
      });
    }
  }

  //定义方法childrenPages使用
  List<Widget> _getChildrenPages() {
    return [HomePage(), CategoryPage(), ShopPage(), UserPage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _getChildrenPages(),
        ),
      ), //需要安全区
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, //当前选中的索引
        //选中的颜色
        showSelectedLabels: true, //显示选中的标题
        showUnselectedLabels: true, //显示未选中项的标题
        selectedItemColor: const Color.fromARGB(255, 183, 152, 141),
        unselectedItemColor: Colors.grey,
        items: _getBottomNavigationBarItems(),
        onTap: (index) {
          // 购物车索引为2（首页0, 分类1, 购物车2, 我的3）
          if (index == 2) {
            _handleShopTap();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
