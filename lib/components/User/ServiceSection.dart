import 'package:flutter/material.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({Key? key}) : super(key: key);

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
              Text(
                '我的服务',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1,
              mainAxisSpacing: 16,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              ServiceItem(icon: Icons.headphones, label: '帮助与客服'),
              ServiceItem(icon: Icons.refresh, label: '退换/售后'),
              ServiceItem(icon: Icons.group, label: '我的拼团'),
              ServiceItem(icon: Icons.location_on, label: '地址管理'),
              ServiceItem(icon: Icons.lock, label: '账号安全'),
              ServiceItem(icon: Icons.link, label: '账号关联'),
              ServiceItem(icon: Icons.phone, label: '我的手机号'),
              ServiceItem(icon: Icons.card_giftcard, label: '加群领红包'),
              ServiceItem(icon: Icons.list, label: '订单中心'),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceItem({Key? key, required this.icon, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Icon(icon, size: 22, color: const Color(0xFFFF4757)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
