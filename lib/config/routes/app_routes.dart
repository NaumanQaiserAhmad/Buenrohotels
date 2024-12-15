import 'package:flutter/material.dart';
import '../../features/hotels/presentation/screens/hotels_screen.dart';

class AppRoutes {
  static const String hotels = '/';

  static final Map<String, WidgetBuilder> routes = {
    hotels: (context) => const HotelsScreen(),
  };
}
