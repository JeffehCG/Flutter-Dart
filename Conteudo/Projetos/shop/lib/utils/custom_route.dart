import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

// Rota customizada para utilizar animação
class CustomRoute extends MaterialPageRoute {
  CustomRoute({@required WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Com tratativas, é possivel definir animações diferentes para cada rota
    if (settings.name == AppRoutes.AUTH_HOME) {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

// Rota customizada para utilizar animação (Global)
class CustomPageTransitionsBuilder extends PageTransitionsBuilder {

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Com tratativas, é possivel definir animações diferentes para cada rota
    if (route.settings.name == AppRoutes.AUTH_HOME) {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

