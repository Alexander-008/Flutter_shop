import 'package:flutter/material.dart';
import 'package:hm_shop/components/User/UserHeader.dart';
import 'package:hm_shop/components/User/AssetsRow.dart';
import 'package:hm_shop/components/User/OrderRow.dart';
import 'package:hm_shop/components/User/ServiceSection.dart';
import 'package:hm_shop/components/User/FeatureSection.dart';
import 'package:hm_shop/components/User/RecommendSection.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          UserHeader(),
          AssetsRow(),
          OrderRow(),
          ServiceSection(),
          FeatureSection(),
          RecommendSection(),
        ],
      ),
    );
  }
}