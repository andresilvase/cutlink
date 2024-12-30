import 'package:app/core/routes/routes.dart';
import 'package:app/features/shorten/views/shorten.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateroute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return _defaultRouter(const Shorten());
    }

    return null;
  }
}

PageRoute _defaultRouter(Widget widget) {
  return MaterialPageRoute(builder: (_) => widget);
}
