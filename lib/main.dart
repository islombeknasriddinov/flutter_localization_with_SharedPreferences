import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/pages/detail_page.dart';
import 'package:flutter_localization/pages/home_page.dart';
import 'package:flutter_localization/pages/login_page.dart';
import 'package:flutter_localization/pages/signup_page.dart';
import 'package:flutter_localization/services/pref_service.dart';
import 'package:toast/toast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

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
  Widget _startPage(){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          Prefs.saveUSerId(snapshot.data!.uid);
          return HomePage();
        }else{
          Prefs.removeUserId();
          return LoginPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _startPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignUpPage.id: (context) => SignUpPage(),
        LoginPage.id: (context) => LoginPage(),
        DetailPage.id: (context) => DetailPage(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
