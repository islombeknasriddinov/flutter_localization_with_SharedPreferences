import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text('welcome',style: TextStyle(fontSize: 20),).tr(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.locale = Locale('en', 'US');
                    },
                    child: Text("English",style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.locale = Locale('ru', 'RU');
                    },
                    child: Text("Russian",style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.locale = Locale('uz', 'UZ');
                    },
                    child: Text("Uzbek",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
