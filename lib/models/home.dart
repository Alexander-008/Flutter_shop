// 轮播图模型
class HomeModelBanner {
  List<HomeModelBanner> data = [];
  String id;
  String imgUrl;
  // String? title;
  HomeModelBanner({required this.id, required this.imgUrl}); //构造函数

  //扩展一个工厂函数，一般用于 Factory 来声明，一般用于创建实例对象
  factory HomeModelBanner.fromJson(Map<String, dynamic> json) {
    //从json字符串中提取数据
    return HomeModelBanner(
      id: json['id'] ?? '',
      //如果id为空，就用空字符串代替
      imgUrl: json['imgUrl'] ?? '',
    );
  }
}

// 分类模型
class CategoryItem {
  final String id;
  final String name;
  final String picture;
  final List<CategoryItem>? children;
  final dynamic goods;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    List<CategoryItem>? childrenList;
    if (json['children'] != null) {
      childrenList = (json['children'] as List)
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return CategoryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: childrenList,
      goods: json['goods'],
    );
  }
}

// 特惠推荐模型
// 核心：推荐结果模型（对应原JSON的result字段）
class RecommendResult {
  final String id;
  final String title;
  final List<SubType> subTypes;

  RecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  // ✅ 直接从result的JSON Map创建对象（核心工厂方法）
  factory RecommendResult.fromJson(Map<String, dynamic> json) {
    return RecommendResult(
      id: json['id'] as String,
      title: json['title'] as String,
      subTypes: (json['subTypes'] as List<dynamic>)
          .map((item) => SubType.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // 转化回JSON（可选）
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTypes': subTypes.map((item) => item.toJson()).toList(),
    };
  }
}

// 子分类模型（抢先尝鲜/新品预告）
class SubType {
  final String id;
  final String title;
  final GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] as String,
      title: json['title'] as String,
      goodsItems: GoodsItems.fromJson(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'goodsItems': goodsItems.toJson()};
  }
}

// 商品分页信息模型
class GoodsItems {
  final int counts;
  final int pageSize;
  final int pages;
  final int page;
  final List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] as int,
      pageSize: json['pageSize'] as int,
      pages: json['pages'] as int,
      page: json['page'] as int,
      items: (json['items'] as List<dynamic>)
          .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counts': counts,
      'pageSize': pageSize,
      'pages': pages,
      'page': page,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  take(int i) {}
}

// 单个商品模型
class GoodsItem {
  final String id;
  final String name;
  final String? desc; // 空安全处理（珐琅锅desc为null）
  final String price;
  final String picture;
  final int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] as String,
      name: json['name'] as String,
      desc: json['desc'] as String?,
      price: json['price'] as String,
      picture: json['picture'] as String,
      orderNum: json['orderNum'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'picture': picture,
      'orderNum': orderNum,
    };
  }
}

// 推荐列表响应模型
class RecommendListResponse {
  final String code;
  final String msg;
  final List<RecommendItem> result;

  RecommendListResponse({
    required this.code,
    required this.msg,
    required this.result,
  });

  factory RecommendListResponse.fromJson(Map<String, dynamic> json) {
    return RecommendListResponse(
      code: json['code'] as String,
      msg: json['msg'] as String,
      result: (json['result'] as List<dynamic>)
          .map((item) => RecommendItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'result': result.map((item) => item.toJson()).toList(),
    };
  }
}

// 推荐商品项模型
class RecommendItem {
  final String id;
  final String name;
  final double price;
  final String picture;
  final int payCount;

  RecommendItem({
    required this.id,
    required this.name,
    required this.price,
    required this.picture,
    required this.payCount,
  });

  factory RecommendItem.fromJson(Map<String, dynamic> json) {
    // 兼容整数和浮点数类型的price
    dynamic priceValue = json['price'];
    double price;
    if (priceValue is int) {
      price = priceValue.toDouble();
    } else if (priceValue is double) {
      price = priceValue;
    } else {
      price = double.tryParse(priceValue.toString()) ?? 0.0;
    }
    
    return RecommendItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: price,
      picture: json['picture']?.toString() ?? '',
      payCount: json['payCount'] is int ? json['payCount'] : int.tryParse(json['payCount']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'picture': picture,
      'payCount': payCount,
    };
  }
}

// 商品详情项模型（继承自 GoodsItem）
class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");

  /// 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
