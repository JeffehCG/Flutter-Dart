import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen_bottom.dart';
import 'package:meals/screens/tabs_screen_top.dart';
import 'package:meals/utils/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _avaibleMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  var settings = Settings();

  void _filterMeals(Settings settings) {
    setState(() {
      _avaibleMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();

      this.settings = settings;
    });
  }

  void _toogleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal){
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        // Thema da aplicação
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            fontFamily: 'Raleway',
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6:
                    TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'))),
        // Trabalhando com rotas nomeadas
        routes: {
          AppRoutes.HOME: (ctx) => settings.useTopTab
              ? TabScreenTop(_favoriteMeals)
              : TabScreenBottom(_favoriteMeals), // Rota inicial
          AppRoutes.CATEGORIES_MEALS: (ctx) =>
              CategoriesMealsScreen(_avaibleMeals),
          AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(_toogleFavorite, _isFavorite),
          AppRoutes.SETTINGS: (ctx) => SettingsScreen(_filterMeals, settings)
        },
        // Criação de rotas dinamicas
        onGenerateRoute: (settings) {
          if (settings.name == '/alguma-coisa') {
            return null;
          } else if (settings.name == '/outra-coisa') {
            return null;
          } else {
            return null;
          }
        },
        // Se foi procurado nas rota, uma que não existe, o metodo abaixo sera chamado
        // Dessa forma, se alguma rota acima for comentada, e tentar acessala, abaixo sera redirecionado para pagina 'CategoriesScreen'
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) {
            return TabScreenBottom(_favoriteMeals);
          });
        });
  }
}
