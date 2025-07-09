import 'package:get/get.dart';
import 'package:invoice_app/ui/screens/login_screen.dart';
import 'package:invoice_app/ui/screens/splash_screen.dart';

class AppRoutes {
  static String splash = '/';
  static String login = '/login';

  static List<GetPage<dynamic>>? getPages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
    )
  ];
}
