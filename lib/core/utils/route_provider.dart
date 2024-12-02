import 'package:flutter/material.dart';

import '../../views/home/pages/main_page.dart';
import '../../views/moment/pages/moment_entry_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case MomentEntryPage.routeName:
        final momentId = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => MomentEntryPage(momentId: momentId));
      default:
        return MaterialPageRoute(builder: (_) => const MainPage());
    }
  }
}
