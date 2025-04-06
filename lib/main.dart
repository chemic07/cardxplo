import 'package:cardxplo/common/error_page.dart';
import 'package:cardxplo/common/loading_page.dart';
import 'package:cardxplo/features/auth/controller/auth_controller.dart';
import 'package:cardxplo/features/auth/pages/signup_page.dart';
import 'package:cardxplo/features/home/view/home_page.dart';
import 'package:cardxplo/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card X',
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      home: ref
          .watch(currentUserAccountProvider)
          .when(
            data: (user) {
              if (user != null) {
                return const HomePage();
              }
              return const SignupPage();
            },
            error:
                (error, stackTrace) =>
                    ErrorPage(errorText: error.toString()),
            loading: () => LoadingPage(),
          ),
    );
  }
}
