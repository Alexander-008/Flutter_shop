import 'package:flutter/material.dart';

class RecommendSection extends StatelessWidget {
  const RecommendSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.favorite, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text(
                '猜你喜欢',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.favorite, size: 16, color: Colors.red),
            ],
          ),
          const SizedBox(height: 16),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 10,
              mainAxisSpacing: 16,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              RecommendProduct(
                imageUrl:
                    'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png',
                title: '加大加厚可冲散湿厕纸 擦除99%细菌',
                price: '24.9',
                originalPrice: '49',
                tag: '百亿补贴',
                sales: '纸品清洁热销榜第1名',
              ),
              RecommendProduct(
                imageUrl:
                    'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/nsny.png',
                title: '可水洗低敏A类凉感仙茶果冻被8.0',
                price: '79',
                originalPrice: '199',
                tag: '到手价',
                sales: '被子热销榜第1名',
              ),
              RecommendProduct(
                imageUrl:
                    'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/xbsd.png',
                title: '爆品鲜升级！网易天成全价冻干双拼猫粮3.0',
                price: '93',
                originalPrice: '149',
                tag: '补贴价',
                sales: '猫粮热销榜第1名',
              ),
              RecommendProduct(
                imageUrl:
                    'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/sssp.png',
                title: '网易严选 | 一起躺夏 仙茶果冻被7.0',
                price: '69',
                originalPrice: '199',
                tag: '到手价',
                sales: '被子热销榜第2名',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecommendProduct extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String originalPrice;
  final String tag;
  final String sales;

  const RecommendProduct({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.tag,
    required this.sales,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                color: tag == '到手价' ? Colors.red : const Color(0xFFFF4757),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          sales,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              '¥$price',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF4757),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '¥$originalPrice',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }
}