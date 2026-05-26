import 'package:flutter/material.dart';
import 'package:hm_shop/components/User/UserHeader.dart';
import 'package:hm_shop/components/User/AssetsRow.dart';
import 'package:hm_shop/components/User/OrderRow.dart';
import 'package:hm_shop/components/User/ServiceSection.dart';
import 'package:hm_shop/components/User/FeatureSection.dart';
import 'package:hm_shop/components/User/RecommendSection.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UserHeader(),
          const AssetsRow(),
          const OrderRow(),
          const ServiceSection(),
          const FeatureSection(),
          const RecommendSection(),
        ],
      ),
    );
  }
}
