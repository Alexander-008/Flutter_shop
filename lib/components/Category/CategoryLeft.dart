import 'package:flutter/material.dart';
import 'package:hm_shop/models/home.dart';

class CategoryLeft extends StatelessWidget {
  final List<CategoryItem> categoryList;
  final int selectedIndex;
  final Function(int) onTap;

  const CategoryLeft({
    Key? key,
    required this.categoryList,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: const Color.fromARGB(255, 245, 245, 245),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final item = categoryList[index];
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: isSelected
                        ? const Color(0xFFFF4757)
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? const Color(0xFFFF4757) : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
