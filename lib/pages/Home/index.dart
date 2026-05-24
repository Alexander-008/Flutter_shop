import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/models/home.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图数据
  List<HomeModelBanner> _bannerList = [];
  // 分类数据
  List<CategoryItem> _categoryList = [];
  // 特惠推荐数据
  RecommendResult _productList = RecommendResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 推荐列表数据
  List<RecommendItem> _recommendList = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // 统一获取所有数据
  void _fetchData() async {
    await Future.wait([
      getBannerList(),
      getCategoryList(),
      getProductList(),
      getRecommendList(params: {'limit': 10}),
    ]);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 获取轮播图数据
  Future<void> getBannerList() async {
    try {
      final list = await getBannerListAPI();
      if (mounted) {
        setState(() {
          _bannerList = list;
        });
      }
    } catch (e) {
      print('获取轮播图失败: $e');
      _handleError(e.toString());
    }
  }

  // 获取分类数据
  Future<void> getCategoryList() async {
    try {
      final list = await getCategoryListAPI();
      if (mounted) {
        setState(() {
          _categoryList = list;
        });
      }
    } catch (e) {
      print('获取分类列表失败: $e');
      _handleError(e.toString());
    }
  }

  // 获取特惠推荐数据
  Future<void> getProductList() async {
    try {
      final list = await getProductListAPI();
      if (mounted) {
        setState(() {
          _productList = list;
        });
      }
    } catch (e) {
      print('获取特惠推荐列表失败: $e');
      _handleError(e.toString());
    }
  }

  // 获取推荐列表数据
  Future<void> getRecommendList({Map<String, dynamic>? params}) async {
    try {
      // 默认获取20条数据，如果没有传参数的话
      final requestParams = params ?? {'limit': 20};
      print('请求推荐列表参数: $requestParams');
      final list = await getRecommendListAPI(params: requestParams);
      print('推荐列表返回数据长度: ${list.length}');
      if (mounted) {
        setState(() {
          _recommendList = list;
        });
      }
    } catch (e) {
      print('获取推荐列表失败: $e');
      _handleError(e.toString());
    }
  }

  // 统一错误处理
  void _handleError(String error) {
    if (mounted) {
      setState(() {
        _errorMessage = error;
      });
    }
  }

  List<Widget> _getSlivers() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), // 轮播图
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)), // 分类
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(productList: _productList),
      ), // 特惠推荐
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(child: const HmHot()), // 热门
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 更多列表
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomScrollView(slivers: _getSlivers()));
  }
}
