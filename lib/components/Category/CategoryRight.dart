import 'package:flutter/material.dart';
import 'package:hm_shop/models/home.dart';

class CategoryRight extends StatelessWidget {
  final CategoryItem category;

  const CategoryRight({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryItem>? children = category.children;
    
    return Expanded(
      child: Container(
        color: Colors.white,
        child: children != null && children.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: children.length,
                itemBuilder: (context, index) {
                  final child = children[index];
                  return Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          child.picture,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color.fromARGB(255, 240, 240, 240),
                              child: const Icon(Icons.image, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        child.name,
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              )
            : const Center(
                child: Text('暂无子分类'),
              ),
      ),
    );
  }
}