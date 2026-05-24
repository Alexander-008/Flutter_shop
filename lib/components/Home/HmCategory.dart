// 分类组件
import 'package:flutter/material.dart';
import 'package:hm_shop/models/home.dart';

class HmCategory extends StatefulWidget {
  // 分类数据
  final List<CategoryItem> categoryList;
  HmCategory({Key? key, required this.categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          itemCount: widget.categoryList.length,
          scrollDirection: Axis.horizontal, // 水平方向滚动
          itemBuilder: (context, index) {
            final item = widget.categoryList[index]; // 获取当前分类项
            return Container(
              height: 100,
              width: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 231, 232, 234),
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10), //左右间距
              alignment: Alignment.center, // 居中对齐
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, //垂直居中对齐
                children: [
                  Image.network(item.picture, width: 40, height: 40),
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            );
          },
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
