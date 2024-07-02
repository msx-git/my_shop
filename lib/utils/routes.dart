import 'package:my_shop/views/screens/main/main_screen.dart';

import '../views/screens/auth/sign_in_screen.dart';
import '../views/screens/auth/sign_up_screen.dart';
import '../views/screens/home/home_screen.dart';

class Routes {
  static final route = {
    RouteNames.signIn: (context) => const SignInScreen(),
    RouteNames.signUp: (context) => const SignUpScreen(),
    RouteNames.main: (context) => const MainScreen(),
    RouteNames.home: (context) => const HomeScreen(),
  };
}

class RouteNames {
  static const signIn = "/signin";
  static const signUp = "/signup";
  static const main = "/main";
  static const home = "/home";
  static const cart = "/cart";
  static const orders = "/orders";
  static const settings = "/settings";
}
