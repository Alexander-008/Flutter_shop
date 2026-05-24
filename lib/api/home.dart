//api接口
import 'package:hm_shop/utils/DioRequset.dart';
import 'package:hm_shop/models/home.dart';
import 'package:hm_shop/constant/index.dart';

// 获取轮播图列表接口
Future<List<HomeModelBanner>> getBannerListAPI() async {
  try {
    // 发送GET请求并获取响应（dioRequest.get已返回解析后的data['result']）
    final data = await dioRequest.get(HttpConstants.BANNER_URL);

    print('轮播图数据: $data');

    // 将响应数据转换为List<HomeModelBanner>
    //将 response.data 改为直接使用 data
    return (data as List)
        .map((item) => HomeModelBanner.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    // 错误处理
    print('获取轮播图失败: $e');
    rethrow; // 抛出异常让上层处理
  }
}

// 获取分类列表接口
Future<List<CategoryItem>> getCategoryListAPI() async {
  try {
    // 发送GET请求并获取响应（dioRequest.get已返回解析后的data['result']）
    final data = await dioRequest.get(HttpConstants.CATEGORY_URL);
    print('分类数据: $data');
    // 将响应数据转换为List<CategoryItem>
    return (data as List)
        .map((item) => CategoryItem.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('获取分类列表失败: $e');
    rethrow; // 抛出异常让上层处理
  }
}

// 获取特惠推荐列表接口
Future<RecommendResult> getProductListAPI() async {
  try {
    // 发送GET请求并获取响应（dioRequest.get已返回解析后的data['result']）
    final data = await dioRequest.get(HttpConstants.PRODUCT_URL);
    print('特惠推荐数据: $data');
    // 将响应数据转换为RecommendResult
    return RecommendResult.fromJson(data); //返回的RecommendResult对象
  } catch (e) {
    print('获取特惠推荐列表失败: $e');
    rethrow; // 抛出异常让上层处理
  }
}

// 获取推荐列表接口
Future<List<RecommendItem>> getRecommendListAPI({
  Map<String, dynamic>? params,
}) async {
  try {
    // 发送GET请求并获取响应（dioRequest.get已返回解析后的data['result']）
    final data = await dioRequest.get(
      HttpConstants.RECOMMEND_LIST,
      params: params,
    );
    print('推荐列表数据: $data');
    // 将响应数据转换为List<RecommendItem>
    return (data as List)
        .map((item) => RecommendItem.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('获取推荐列表失败: $e');
    rethrow; // 抛出异常让上层处理
  }
}
