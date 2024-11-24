import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/views/common/pages/main_page.dart';
import 'package:myapp/core/resources/colors.dart';
import 'package:myapp/core/resources/strings.dart';

import 'views/moment/pages/moment_page.dart';
import 'views/moment/bloc/moment_bloc.dart';
import 'views/moment/pages/moment_entry_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MomentBloc(),
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case MomentEntryPage.routeName:
              final args = settings.arguments as Map<String, dynamic>?;
              final momentId = args?['momentId'] as String?;
              return MaterialPageRoute(
                builder: (context) => MomentEntryPage(momentId: momentId),
              );
            case MomentPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const MomentPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const MainPage(),
              );
          }
        },
      ),
    );
  }
}
