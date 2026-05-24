import 'package:flutter/material.dart';
import '../../utils/LocationService.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool _isAllSelected = true;
  bool _isItemSelected = true;

  void _toggleAllSelected(bool? value) {
    setState(() {
      _isAllSelected = value ?? false;
      _isItemSelected = value ?? false;
    });
  }

  void _toggleItemSelected(bool? value) {
    setState(() {
      _isItemSelected = value ?? false;
      _isAllSelected = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const ProBanner(),
          Expanded(
            child: ListView(
              children: [
                const LocationBar(),
                const ExchangeSection(),
                CartItem(
                  isSelected: _isItemSelected,
                  onSelectedChanged: _toggleItemSelected,
                ),
                const RecommendSection(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: BottomBar(
        isAllSelected: _isAllSelected,
        onAllSelectedChanged: _toggleAllSelected,
      ),
    );
  }
}

class ProBanner extends StatelessWidget {
  const ProBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA502)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: const [
          SizedBox(width: 16),
          Icon(Icons.star, size: 16, color: Colors.white),
          SizedBox(width: 8),
          Text(
            '开通Pro会员，预计可省¥54.95',
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
          Spacer(),
          Text(
            '立即开通',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class LocationBar extends StatefulWidget {
  const LocationBar({Key? key}) : super(key: key);

  @override
  State<LocationBar> createState() => _LocationBarState();
}

class _LocationBarState extends State<LocationBar> {
  String _address = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    setState(() => _isLoading = true);

    String address = await LocationService().getCurrentAddress();

    setState(() {
      _address = address;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.location_on, size: 16, color: Color(0xFFFF4757)),
          const SizedBox(width: 4),
          Expanded(
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFFFF4757),
                    ),
                  )
                : Text(
                    _address,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}

class ExchangeSection extends StatelessWidget {
  const ExchangeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                '全场换购',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Text(
                '已满99元，可选择9件商品换购',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Spacer(),
              Text(
                '去换购',
                style: TextStyle(fontSize: 12, color: Color(0xFFFF4757)),
              ),
              Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFFFF4757)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png',
                        width: 90,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 8),
                            Text(
                              '加大加厚 厨房除油污湿厕纸',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '[加大加厚] 3包/提',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '换购价¥21.9',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFF4757),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4757),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/xbsd.png',
                        width: 100,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '[指定]加换购',
                      style: TextStyle(fontSize: 10, color: Color(0xFFFF4757)),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool?> onSelectedChanged;

  const CartItem({
    Key? key,
    required this.isSelected,
    required this.onSelectedChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.check_circle, size: 18, color: Color(0xFFFF4757)),
              SizedBox(width: 8),
              Text(
                '单件包邮',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '以下商品已免邮',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: onSelectedChanged,
                  activeColor: const Color(0xFFFF4757),
                  checkColor: Colors.white,
                ),
                const SizedBox(width: 8),
                Image.network(
                  'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/xbsd.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4757),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Text(
                          '百亿补贴',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '[梓渝好物]营养还是...',
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '[免费试吃]全脂期1.5kg+赠50g*10袋...',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Text(
                            '¥139',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            '优惠后¥99',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFF4757),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text('x1'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE4E1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4757),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '限购1件',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
                const Spacer(),
                const Text(
                  '不可用券',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                const Text(
                  '不可用礼品卡',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendSection extends StatelessWidget {
  const RecommendSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Center(
            child: Text(
              '猜你喜欢',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: const Text(
                                '11',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '擦除99%细菌 厚实 洁净安心',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/nsny.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '网易严选 | 飞天茅台',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final bool isAllSelected;
  final ValueChanged<bool?> onAllSelectedChanged;

  const BottomBar({
    Key? key,
    required this.isAllSelected,
    required this.onAllSelectedChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isAllSelected,
            onChanged: onAllSelectedChanged,
            activeColor: const Color(0xFFFF4757),
            checkColor: Colors.white,
          ),
          const SizedBox(width: 4),
          const Text('全选'),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                '已优惠: ¥40, 查看详情',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Row(
                children: [
                  Text(
                    '合计:',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  Text(
                    '¥99',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFF4757),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFF4757),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                '结算(1)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
