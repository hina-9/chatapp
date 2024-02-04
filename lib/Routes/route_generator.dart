import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Routes/screen_arguements.dart';
import 'package:chitchat/Screens/chat_screen.dart';
import 'package:chitchat/Screens/forgot_password_screen.dart';
import 'package:chitchat/Screens/home_screen.dart';
import 'package:chitchat/Screens/profile_screen.dart';
import 'package:chitchat/Screens/sign_in_screen.dart';
import 'package:chitchat/Screens/sign_up_screen.dart';
import 'package:chitchat/Screens/splash_screen.dart';
import 'package:chitchat/Services/auth.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppNavRoutes.initialRoute:
        return routeScreen(
            child: FutureBuilder(
          future: AuthMethods().getCurrentUser(),
          builder: ((context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return SplashScreen();
            }
          }),
        ));
      case AppNavRoutes.signinscreen:
        return routeScreen(child: const SignInScreen());
      case AppNavRoutes.signupscreen:
        return routeScreen(child: const SignUpScreen());
      case AppNavRoutes.chatscreen:
        ScreenArguments mydata = args as ScreenArguments;
        return routeScreen(
            child: ChatScreen(
          data: mydata,
        ));
      case AppNavRoutes.homescreen:
        return routeScreen(child: const HomeScreen());
      case AppNavRoutes.forgotpassscreen:
        return routeScreen(child: const ForgotPasswordScreen());
      case AppNavRoutes.profilescreen:
        return routeScreen(child: const ProfileScreen());

      // case AppNavRoutes.initialRoute:
      //   return routeScreen(child: const HomeScreen());

      // case AppNavRoutes.casesComplaintsDetails:
      //   CasesComplaintsModel casesComplaintsModel =
      //       args as CasesComplaintsModel;
      //   return routeScreen(
      //     child: CaseComplaintDetailsScreen(
      //       currentCaseComplaint: casesComplaintsModel,
      //     ),
      //   );

      //DEFAULT CASE
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Text('Error Page');
    });
  }

  static Route<dynamic> routeScreen(
      {Widget? child, bool fullscreenDialog = false}) {
    return MaterialPageRoute(
      builder: (context) => SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        ),
      ),
    );
  }
}
