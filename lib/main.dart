import 'package:chitchat/Providers/login_providers.dart';
import 'package:chitchat/Providers/registration_provider.dart';
import 'package:chitchat/Providers/search_provider.dart';
import 'package:chitchat/Providers/shared_preference_provider.dart';
import 'package:chitchat/Providers/theme_provider.dart';
import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Routes/route_generator.dart';
import 'package:chitchat/Utils/app_theme.dart';

import 'package:chitchat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(
      create: (BuildContext context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<RegistrationProvider>(
      create: (BuildContext context) => RegistrationProvider(),
    ),
    ChangeNotifierProvider<LoginProvider>(
      create: (BuildContext context) => LoginProvider(),
    ),
    ChangeNotifierProvider<SearchProvider>(
      create: (BuildContext context) => SearchProvider(),
    ),
    ChangeNotifierProvider<SharedPrefProvider>(
      create: (BuildContext context) => SharedPrefProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Network App',
        navigatorKey: AppNavigation.navigationKey,
        initialRoute: AppNavRoutes.initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
        //Theme
        theme: Provider.of<ThemeProvider>(context).themeData,
      );
    });
  }
}
