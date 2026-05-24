// 轮播图组件
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/models/home.dart';

class HmSlider extends StatefulWidget {
  // 轮播图数据
  final List<HomeModelBanner> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  //控制器
  CarouselSliderController _sliderController = CarouselSliderController();
  // 轮播图当前索引
  int _currentIndex = 0;
  //轮播图组件
  Widget _buildSlider() {
    //动态获取轮播图宽度
    double _width = MediaQuery.of(context).size.width; //获取当前屏幕宽度
    //插件：carousel_slider
    return CarouselSlider(
      carouselController: _sliderController, //控制器
      items: widget.bannerList
          .map(
            (item) => Container(
              height: 200,
              width: _width, //动态获取宽度
              child: Image(image: NetworkImage(item.imgUrl), fit: BoxFit.cover),
            ),
          )
          .toList(),
      // 轮播图选项
      options: CarouselOptions(
        autoPlayInterval: Duration(seconds: 5), // 自动播放间隔
        height: 200,
        autoPlay: true, //自动播放
        aspectRatio: 2.0, // 轮播图宽高比
        viewportFraction: 1.0, // 轮播图占满全屏
        // 轮播图切换时调用
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  //搜索栏
  Widget _buildSearch() {
    return Padding(
      padding: EdgeInsets.all(10), //上下左右间距
      child: Container(
        height: 50,
        // color: Colors.pink,
        alignment: Alignment.centerLeft, //左对齐
        padding: EdgeInsets.symmetric(horizontal: 40), //内容左右间距
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.3), //透明背景
          border: Border.all(color: Colors.white, width: 0.1), //边框
          // 边框圆角
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          '搜索.....',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  //底部控制器圆点
  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.bannerList.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _sliderController.animateToPage(index);
            });
          },
          child: Container(
            width: 20,
            height: 5,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: index == _currentIndex
                  ? Color(0xFFBF9C9C)
                  : Colors.white.withValues(
                      alpha: 0.6,
                    ), //当前索引为index时，颜色为粉色，否则为透明白色
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //轮播图
        _buildSlider(),
        //搜索框
        Positioned(top: 10, left: 0, right: 0, child: _buildSearch()),
        //导航条是固定在底部的，高度为50，宽度为全屏
        Positioned(bottom: 10, left: 0, right: 0, child: _buildDots()),
      ],
    );
  }
}
