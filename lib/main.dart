import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_shop/controllers/auth_controller.dart';
import 'package:my_shop/controllers/categories_controller.dart';
import 'package:my_shop/controllers/products_controller.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'utils/routes.dart';
import 'views/screens/auth/sign_in_screen.dart';
import 'views/screens/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => CategoriesController()),
        ChangeNotifierProvider(create: (context) => ProductsController()),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          useInheritedMediaQuery: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final user = snapshot.data;

                  return user == null
                      ? const SignInScreen()
                      : const MainScreen();
                },
              ),
              routes: Routes.route,
            );
          },
        );
      },
    );
  }
}
