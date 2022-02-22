import 'package:customized_pager/views/home.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../views/onboarding/setup_onboarding_container_pages.dart';

class AppRoutes {
  static const home = '/home';
  static const dashboard = '/dashboard';
  static const setupOnboardingAccount = '/setup-onboarding';

}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // E.g Navigator.of(context).pushNamed(AppRoutes.home);
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MyHomePage(
            title: "",
          ),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.setupOnboardingAccount:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SetupOnboardingPagerContainer(settings.arguments),
          settings: settings,
          fullscreenDialog: true,
        );


      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ErrorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Path does not exist"),
      ),
    );
  }
}