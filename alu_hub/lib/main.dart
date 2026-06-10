import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        import 'package:flutter/material.dart';

        import 'sign_up_identity_screen.dart';
        import 'theme/app_theme.dart';

        void main() {
          runApp(const MyApp());
        }

        class MyApp extends StatelessWidget {
          const MyApp({super.key});

          @override
          Widget build(BuildContext context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ALU Hub',
              theme: AppTheme.theme,
              home: const SignUpIdentityScreen(),
            );
          }
        }
class MyHomePage extends StatefulWidget {
