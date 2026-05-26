import 'package:flutter/material.dart';

class AssetsRow extends StatelessWidget {
  const AssetsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          AssetItem(icon: Icons.card_giftcard, label: '礼品卡', value: '0'),
          AssetItem(icon: Icons.account_balance_wallet, label: '余额', value: '¥0'),
          AssetItem(icon: Icons.card_membership, label: '红包', value: '0'),
          AssetItem(icon: Icons.percent, label: '优惠券', value: '1'),
          AssetItem(icon: Icons.local_offer, label: '津贴', value: '¥0'),
        ],
      ),
    );
  }
}

class AssetItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AssetItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF4757),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}