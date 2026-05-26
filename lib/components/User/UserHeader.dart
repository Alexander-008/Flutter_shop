import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class UserHeader extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();

  UserHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFE4E1), Color(0xFFCD858C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Obx(() {
        final isLoggedIn = _userController.userInfo.value.id.isNotEmpty;
        final userInfo = _userController.userInfo.value;

        return Row(
          children: [
            // 头像区域
            GestureDetector(
              onTap: () => _handleAvatarTap(context, isLoggedIn),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: isLoggedIn && userInfo.avatar.isNotEmpty
                      ? Image.network(
                          userInfo.avatar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(),
                        )
                      : _buildDefaultAvatar(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 用户信息区域
            Expanded(
              child: GestureDetector(
                onTap: () => _handleAvatarTap(context, isLoggedIn),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLoggedIn ? userInfo.nickname : '立即登录',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (isLoggedIn)
                      GestureDetector(
                        onTap: () => _handleLogout(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '退出/切换账号',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      const Text(
                        '登录后享受更多服务',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                  ],
                ),
              ),
            ),
            // 右侧功能区
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIconButton(
                  icon: Icons.qr_code_scanner,
                  onTap: () {
                    // 扫码功能
                  },
                ),
                const SizedBox(height: 8),
                _buildProBadge(),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDefaultAvatar() {
    return const Icon(Icons.person, size: 35, color: Color(0xFFC12929));
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: Colors.black87),
      ),
    );
  }

  Widget _buildProBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB74D), Color(0xFFFFA726)],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB74D).withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        'Pro会员',
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleAvatarTap(BuildContext context, bool isLoggedIn) {
    if (isLoggedIn) {
      Navigator.pushNamed(context, '/user');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  void _handleLogout(BuildContext context) {
    // 处理退出/切换账号
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认退出'),
        content: const Text('确定要退出当前账号吗？'),
        //放置确认按钮和取消按钮
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              // _userController.logout();
              //清除token
              await tokenManager.removeToken();
              // GEX清除用户信息
              _userController.clearUserInfo();

              Navigator.pop(context);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
