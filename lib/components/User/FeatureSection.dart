import 'package:flutter/material.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.85,
          mainAxisSpacing: 12,
          crossAxisSpacing: 4,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          FeatureItem(
            icon: Icons.new_releases,
            label: '新品首发',
            badge: '新品',
            iconBgColor: Color(0xFFFFD700),
            badgeColor: Color(0xFFFFD700),
          ),
          FeatureItem(
            icon: Icons.flash_on,
            label: '百亿补贴',
            badge: '',
            iconBgColor: Color(0xFFFF4757),
          ),
          FeatureItem(
            icon: Icons.star,
            label: '大牌好价',
            badge: '爆款',
            iconBgColor: Color(0xFF9B59B6),
            badgeColor: Color(0xFF9B59B6),
          ),
          FeatureItem(
            icon: Icons.group,
            label: '严选拼团',
            badge: '',
            iconBgColor: Color(0xFFFF4757),
          ),
          FeatureItem(
            icon: Icons.card_giftcard,
            label: '任务中心',
            badge: '',
            iconBgColor: Color(0xFFFFA502),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String badge;
  final Color iconBgColor;
  final Color? badgeColor;

  const FeatureItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.badge,
    required this.iconBgColor,
    this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(icon, size: 24, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        if (badge.isNotEmpty)
          Positioned(
            top: 0,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}