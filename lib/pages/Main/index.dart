import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/User/index.dart';
import 'package:hm_shop/pages/shop/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          setState(() {
            _currentIndex = index; //更新当前选中的索引
          });
        },
      ),
    );
  }
}
