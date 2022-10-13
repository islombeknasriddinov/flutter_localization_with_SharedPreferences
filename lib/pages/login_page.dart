import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/pages/signup_page.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:toast/toast.dart';
import '../model/user_model.dart';
import '../services/auth_service.dart';
import '../services/pref_service.dart';
import '../utils/utils.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static final String id = "login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool language = true;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    Prefs.loadUser("user").then((user) => {
      if(user!.email!.isNotEmpty
          && user.password!.isNotEmpty){
        emailController.text = user.email.toString(),
        passwordController.text = user.password.toString()
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: (){
              if(language){
                language = false;
                context.locale = Locale('en', 'US');
              }else{
                language = true;
                context.locale = Locale('ru', 'RU');
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Ionicons.language, color: Colors.black,),
                SizedBox(width: 10,),
                Text('language', style: TextStyle(color: Colors.black),).tr(),
                SizedBox(width: 20,)
              ],
            ),
          )

        ],
      ),
      backgroundColor: Colors.grey[90],
      body: Stack(
        children: [
          Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      //#image
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 80, right: 80),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/im_welcome.png"),
                        ),
                      ),

                      //#text welcome
                      Text('welcome', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),).tr(),
                      SizedBox(height: 5,),

                      //#text
                      Text('text', style: TextStyle(color: Colors.grey, fontSize: 14,), textAlign: TextAlign.center,).tr(),
                      SizedBox(height: 40,),

                      //#Email editer
                      Center(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: emailController,
                            style:  TextStyle(
                                fontSize: 16,
                                color: Colors.blue
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.person_outline, size: 22, color: Colors.blue,),
                                contentPadding: EdgeInsets.all(20),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.blue)),
                                hintText: 'email'.tr(),
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),

                      //#password editer
                      Center(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: passwordController,
                            style:  TextStyle(
                                fontSize: 16,
                                color: Colors.blue
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.lock_open, size: 22, color: Colors.blue,),
                                contentPadding: EdgeInsets.all(20),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.blue)),
                                hintText: 'password'.tr(),
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),

                      //#forgot password text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('forgot', style: TextStyle(color: Colors.black, fontSize: 12),).tr(),
                          SizedBox(width: 20,)
                        ],
                      ),

                      //#login button
                      Container(
                        margin: EdgeInsets.only(right: 90, left: 90, top: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.indigo,
                        ),
                        child: TextButton(
                          onPressed: _doLogin,
                          child: Text('login', style: TextStyle(color: Colors.white, fontSize: 14),).tr(),
                        ),
                      ),
                      SizedBox(height: 40,),

                      Text('text1', style: TextStyle(color: Colors.grey[400], fontSize: 12),).tr(),

                      //#facebook and google button
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center ,
                          children: [
                            //#facebook
                            Expanded(child: Container(
                              margin: EdgeInsets.only(right: 8, left: 45),
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo[500],
                              ),
                              child: TextButton(
                                onPressed: (){},
                                child: Text("Facebook", style: TextStyle(color: Colors.white),),
                              ),
                            ),),

                            //#google
                            Expanded(child: Container(
                              width: 100,
                              margin: EdgeInsets.only(left: 8, right: 45),
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              child: TextButton(
                                onPressed: (){},
                                child: Text("Google", style: TextStyle(color: Colors.white),),
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: 60,),

                      //#signup button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('dont', style: TextStyle(fontSize: 13),).tr(),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, SignUpPage.id);
                            },
                            child: Text('signup', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),).tr(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
          ),

          isloading?
          Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      )
    );
  }

  void _doLogin(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    Users users = Users.from(email, password);


    setState(() {
      isloading = true;
    });

    AuthService.signInUser(context, email, password).then((user) => {
      _getFirebaseUser(user!, users)
    });

    Prefs.loadUser("user").then((user) => {
      if(user!.email!.isNotEmpty
          && user.password!.isNotEmpty){
        Utils.showToast("Your $email, $password saved")
      }
    });
  }


  _getFirebaseUser(User user, Users users) async{
    setState(() {
      isloading = false;
    });
    if(user != null){
      await Prefs.saveUSerId(user.uid);
      Prefs.storeUser(users, "user");
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.showToast("Check your email or password");
    }
  }
}
