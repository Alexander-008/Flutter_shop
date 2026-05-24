import 'package:flutter/material.dart';

class OrderRow extends StatelessWidget {
  const OrderRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  '我的订单',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text('查看全部', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              OrderItem(icon: Icons.shopping_bag, label: '全部订单'),
              OrderItem(icon: Icons.payment, label: '待付款'),
              OrderItem(icon: Icons.local_shipping, label: '待发货'),
              OrderItem(icon: Icons.delivery_dining, label: '已发货'),
              OrderItem(icon: Icons.rate_review, label: '待评价'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF4757), Color(0xFFFF6B7A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                const Text(
                  '点击此处，开启贴心物流通知，月度账单提醒',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'GO',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF4757),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const OrderItem({Key? key, required this.icon, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(icon, size: 24, color: const Color(0xFFFF4757)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}
