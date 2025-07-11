import 'package:get/get.dart';
import 'package:invoice_app/ui/screens/home_screen.dart';
import 'package:invoice_app/ui/screens/login_screen.dart';
import 'package:invoice_app/ui/screens/splash_screen.dart';

class AppRoutes {
  static String splash = '/';
  static String login = '/login';
  static String home = '/home';

  static List<GetPage<dynamic>>? getPages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
    )
  ];
}
