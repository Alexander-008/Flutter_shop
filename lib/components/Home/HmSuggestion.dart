import 'package:flutter/material.dart';
import 'package:hm_shop/models/home.dart';

class HmSuggestion extends StatelessWidget {
  // 特惠推荐数据（从后端获取）
  final RecommendResult productList;

  const HmSuggestion({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 245, 246),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 15),
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Text(
          "特惠推荐",
          style: TextStyle(
            color: Color.fromARGB(255, 230, 46, 46),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 230, 230),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "精选省攻略",
            style: TextStyle(
              color: Color.fromARGB(255, 230, 46, 46),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  // 获取商品列表数据
  List<GoodsItem> _getGoodsList() {
    if (productList.subTypes.isNotEmpty) {
      final goodsItems = productList.subTypes.first.goodsItems;
      if (goodsItems != null && goodsItems.items.isNotEmpty) {
        return goodsItems.items.take(3).toList();
      }
    }
    return [];
  }

  Widget _buildProductList() {
    final goodsList = _getGoodsList();
    final List<Widget> children = [];

    // 添加促销卡片
    children.add(_buildPromotionCard());

    // 添加商品卡片和间距
    for (int i = 0; i < goodsList.length; i++) {
      children.add(const SizedBox(width: 8));
      children.add(
        _buildProductCard(
          imageUrl: goodsList[i].picture,
          price: '¥${goodsList[i].price}',
        ),
      );
    }

    return Row(children: children);
  }

  Widget _buildPromotionCard() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 106, 106),
              Color.fromARGB(255, 255, 182, 182),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "年终大促",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text("限时买就返", style: TextStyle(color: Colors.white, fontSize: 14)),
            SizedBox(height: 8),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard({required String imageUrl, required String price}) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            price,
            style: const TextStyle(
              color: Color.fromARGB(255, 230, 46, 46),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
