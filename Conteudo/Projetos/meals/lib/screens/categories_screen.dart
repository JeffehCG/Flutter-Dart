import 'package:flutter/material.dart';
import 'package:meals/components/category_item.dart';
import 'package:meals/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tela organizada por grades
    return GridView(
      padding: const EdgeInsets.all(15),
      // Area com scroll, é definindo como sera renderizado (MainAxi - vertical, CrossAxi - horizontal)
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            200, // Cada elemento tera no maximo 200px no CrossAxis
        childAspectRatio: 3 / 2, // Proporsão de cada elementeo
        crossAxisSpacing: 20,
        mainAxisSpacing: 16,
      ),
      children: DUMMY_CATEGORIES.map((cat) {
        return CategoryItem(cat);
      }).toList(),
    );
  }
}
