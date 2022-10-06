import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/services/pref_service.dart';
import '../model/user_model.dart';

class SharedPrfr extends StatefulWidget {
  static final String id = "shared_prfr_page";

  @override
  State<SharedPrfr> createState() => _SharedPrfrState();
}

class _SharedPrfrState extends State<SharedPrfr> {
  String myName = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: false,
                child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Name : " + myName,
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 100)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Prefs.storeName("Islombek");
                        },
                        child: Text("Store Name")),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Prefs.loadName().then((name) => {showName(name)});
                        },
                        child: Text("Load Name")),
                  ],
                )
              ],
            )
            ),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 50,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: InputBorder.none,
                  icon: Icon(Icons.email, color: Colors.lightBlue,)
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 50,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    icon: Icon(Icons.lock, color: Colors.lightBlue,)
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
              ),
              child: ElevatedButton(
                onPressed: _doLogin,
                child: Text("Log in", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _doLogin(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    User user = User.from(email, password);
    Prefs.storeUser(user, "key");

    Prefs.loadUser("key").then((user) => {
      print(user!.email)
    });
  }

  void showName(String name) {
    setState(() {
      myName = name;
    });
  }
}
