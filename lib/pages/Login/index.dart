import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/constant/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/LoadingDialog.dart';
import 'package:hm_shop/utils/ToastUtil.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 登录表单校验
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // 通过控制器获取手机号和密码输入值
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // 从Get实例中获取UserController
  final UserController _userController = Get.find();
  // 登录
  Future<void> _login() async {
    // 显示加载弹窗
    LoadingDialog.show(context);
    // 校验表单
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // 校验通过，登录
    try {
      final userInfo = await loginAPI(
        HttpConstants.LOGIN_URL,
        data: {
          'account': _phoneController.text,
          'password': _passwordController.text,
        },
      );
      _userController.updateUserInfo(userInfo); // 更新用户信息到UserController
      //持久化
      tokenManager.setToken(userInfo.token);
      // 登录成功，隐藏加载弹窗
      LoadingDialog.hide(context);
      ToastUtil.showSuccess(context, '登录成功');
      // 延迟1秒后跳转到购物车页面（替换登录页面）
      Future.delayed(const Duration(seconds: 1), () {
        // 返回前先隐藏 SnackBar
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // 直接跳转到购物车页面
        Navigator.pushReplacementNamed(context, '/');
      });
    } catch (e) {
      // 登录失败，提示用户
      String errorMessage = '登录失败';
      if (e is DioException) {
        // 隐藏加载弹窗
        LoadingDialog.hide(context);
        errorMessage = e.message ?? '登录失败';
      }
      // ignore: use_build_context_synchronously
      ToastUtil.showError(context, errorMessage);
    }
  }

  Widget _buildPhoneTextFiled() {
    return TextFormField(
      //校验
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入手机号';
        }
        //校验手机号格式
        if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
          return '请输入正确的手机号';
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: '请输入手机号',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // 密码输入框
  bool _isPasswordVisible = true;
  // 记住密码勾选状态
  bool _rememberPassword = false;

  Widget _buildPasswordTextFiled() {
    return Stack(
      children: [
        Expanded(
          child: TextFormField(
            //校验
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              //校验密码长度，不能大于16位,字母数字组合
              if (!RegExp(r'^[a-zA-Z0-9]{6,16}$').hasMatch(value)) {
                return '密码长度必须在6-16位之间，只能包含字母和数字';
              }
              return null;
            },
            controller: _passwordController,
            obscureText: _isPasswordVisible, // 密码输入框是否隐藏
            keyboardType: TextInputType.visiblePassword, // 密码输入框键盘类型
            obscuringCharacter: '*', // 密码输入框隐藏字符
            decoration: InputDecoration(
              hintText: '请输入密码',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Positioned(
          //右对齐
          right: 12,
          //上对齐
          top: 6,
          child: IconButton(
            icon: const Icon(Icons.visibility, size: 24, color: Colors.black87),
            onPressed: () {
              setState(() {
                // 切换密码显示状态
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            // 勾选框是否选中
            if (_rememberPassword) {
              // 处理登录逻辑
              _login();
            } else {
              // 弹出错误提示
              ToastUtil.showError(context, '请先勾选记住密码');
            }
          }
        },
        child: const Text('登录'),
      ),
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _rememberPassword,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (value) {
            setState(() {
              _rememberPassword = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.black),
        ),
        const Text.rich(
          TextSpan(
            text: '记住密码',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('优乐美登录'), centerTitle: true),
      body: Form(
        key: _formKey, // 登录表单校验
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // 登录表单校验
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: const Text(
                  '账号密码登录',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildPhoneTextFiled(),
              const SizedBox(height: 12),
              _buildPasswordTextFiled(),
              const SizedBox(height: 12),
              _buildCheckbox(),
              const SizedBox(height: 12),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
