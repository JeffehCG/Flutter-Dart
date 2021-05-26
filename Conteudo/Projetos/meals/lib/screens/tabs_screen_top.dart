import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

class TabScreenTop extends StatelessWidget {
  final List<Meal> favoriteMeals;
  TabScreenTop(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    // Trabalhando com tabs
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Vamos Cozinhar?'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categorias',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favoritos',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavoriteScreen(favoriteMeals),
          ],
        ),
      ),
    );
  }
}
