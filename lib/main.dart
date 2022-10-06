import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/pages/home_page.dart';
import 'package:flutter_localization/pages/login_page.dart';
import 'package:flutter_localization/pages/sharePfr_page.dart';
import 'package:flutter_localization/pages/signUp_page.dart';
import 'package:toast/toast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
          Locale('uz', 'UZ')
        ],
        path: 'assets/translation', // <-- change patch to your
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SharedPrfr.id: (context) => SharedPrfr(),
        SignUpPage.id: (context) => SignUpPage(),
        LoginPage.id: (context) => LoginPage(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
