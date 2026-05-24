import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/models/home.dart';
import 'package:hm_shop/utils/ToastUtil.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 滚动控制器
  ScrollController _scrollController = ScrollController();
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
  int _page = 1; //当前页码，默认第一页
  bool _hasMore = true; //是否还有更多数据，默认有
  bool _isLoadingMore = false; //是否正在加载更多
  @override
  void initState() {
    super.initState();
    _registerScrollListener();
    // 初始化时调用下拉刷新动作 (initState -> build -> 下拉刷新组件 -> 才可以操作它)
    Future.microtask(() {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  //注册一个滚动监听器，用于监听滚动事件
  void _registerScrollListener() {
    _scrollController.addListener(() {
      // 滚动到最底部时，加载更多数据 上拉刷新
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 50)) {
        getRecommendList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 统一获取所有数据
  Future<void> _fetchData() async {
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
      // 上拉加载更多时的判断
      if (_isLoadingMore || !_hasMore) {
        return;
      }
      _isLoadingMore = true;
      int requestPage = _page * 10;
      final list = await getRecommendListAPI(params: {'limit': requestPage});
      _isLoadingMore = false;
      if (mounted) {
        setState(() {
          _recommendList = list;
        });
        if (_recommendList.length < requestPage) {
          _hasMore = false;
          return;
        }
      }
      _page++;
    } catch (e) {
      _isLoadingMore = false;
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

  //下拉刷新,是异步函数
  Future<void> _RefreshLoad() async {
    _page = 1;
    _hasMore = true;
    _errorMessage = null;
    // 等待数据获取完成
    await _fetchData();
    //刷新成功后提示
    ToastUtil.showSuccess(context, '刷新成功');
  }

  // 刷新指示器状态键
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _RefreshLoad,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                controller: _scrollController,
                slivers: _getSlivers(),
              ),
      ),
    );
  }
}
