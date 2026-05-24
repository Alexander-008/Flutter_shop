// 热门组件
import 'dart:math';

import 'package:flutter/material.dart';

class HmHot extends StatelessWidget {
  const HmHot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // 左侧：爆款推荐
          Expanded(
            child: _buildHotCard(
              title: '爆款推荐',
              subtitle: '爆款必买',
              bgColor: const Color.fromARGB(255, 255, 230, 230),
              titleColor: const Color.fromARGB(255, 230, 46, 46),
              items: [
                _buildHotPromotion(),
                const SizedBox(width: 8),
                _buildHotProduct(
                  imageUrl:
                      'https://picsum.photos/id/${Random().nextInt(1000)}/400/600', //改成随机的图片
                  price: '¥142.00',
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // 右侧：一站买全
          Expanded(
            child: _buildHotCard(
              title: '一站买全',
              subtitle: '精心优选',
              bgColor: const Color.fromARGB(255, 255, 246, 220),
              titleColor: const Color.fromARGB(255, 255, 183, 77),
              items: [
                _buildHotProduct(
                  imageUrl:
                      'https://picsum.photos/id/${Random().nextInt(1000)}/400/400', //改成随机的图片
                  price: '¥142.00',
                ),
                const SizedBox(width: 8),
                _buildHotProduct(
                  imageUrl:
                      'https://picsum.photos/id/${Random().nextInt(1000)}/400/400', //改成随机的图片
                  price: '¥132.00',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 热卖卡片容器
  Widget _buildHotCard({
    required String title,
    required String subtitle,
    required Color bgColor,
    required Color titleColor,
    required List<Widget> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildCardHeader(title, subtitle, titleColor),
          const SizedBox(height: 10),
          Row(children: items),
        ],
      ),
    );
  }

  // 卡片标题
  Widget _buildCardHeader(String title, String subtitle, Color color) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(subtitle, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }

  // 促销区域
  Widget _buildHotPromotion() {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/id/${Random().nextInt(1000)}/400/400', //改成随机的图片
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '¥99.00',
            style: TextStyle(
              color: Color.fromARGB(255, 230, 46, 46),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 商品卡片
  Widget _buildHotProduct({required String imageUrl, required String price}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
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
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
