import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/pages/login_page.dart';
import 'package:flutter_localization/utils/utils.dart';
import 'package:toast/toast.dart';
import '../model/account_model.dart';
import '../services/auth_service.dart';
import '../services/pref_service.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, LoginPage.id);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        )
      ),
      backgroundColor: Colors.grey[90],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //#text welcome
                  Text('lets', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),).tr(),
                  SizedBox(height: 5,),

                  //#text
                  Text('text2', style: TextStyle(color: Colors.grey, fontSize: 13,), textAlign: TextAlign.center,).tr(),
                  SizedBox(height: 40,),

                  //#Name editer
                  Center(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: nameController,
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
                            hintText: 'name'.tr(),
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),

                  //#Email editer
                  Center(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 15,),
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
                            prefixIcon: Icon(Icons.email_outlined, size: 22, color: Colors.blue,),
                            contentPadding: EdgeInsets.all(20),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: 'email'.tr(),
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),

                  //#Phone editer
                  Center(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: phoneController,
                        style:  TextStyle(
                            fontSize: 16,
                            color: Colors.blue
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.phone_iphone_outlined, size: 22, color: Colors.blue,),
                            contentPadding: EdgeInsets.all(20),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: 'phone'.tr(),
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),

                  //#Password editer
                  Center(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 15,),
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

                  //#Confirm password editer
                  Center(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
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
                            hintText: 'confirm'.tr(),
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),

                  //#Create button
                  Container(
                    margin: EdgeInsets.only(right: 90, left: 90, top: 30),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.indigo,
                    ),
                    child: TextButton(
                      onPressed: _doLogin,
                      child: Text('create', style: TextStyle(color: Colors.white, fontSize: 14),).tr(),
                    ),
                  ),
                  SizedBox(height: 60,),

                  //#signup button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('text3', style: TextStyle(fontSize: 13),).tr(),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, LoginPage.id);
                        },
                        child: Text('loginhere', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),).tr(),
                      )
                    ],
                  )
                ],
              ),
            ),
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
    String name = nameController.text.toString().trim();
    String phone = phoneController.text.toString().trim();
    Account account = Account.from(email, password, name, phone);
    if(email.isEmpty || name.isEmpty || password.isEmpty) return;

    setState(() {
      isloading = true;
    });

    AuthService.signUpUser(context, name, email, password).then((user) => {
      _getFirebaseUser(user!, account)
    });



    Prefs.loadAccount("account").then((account) => {
        if(account!.email!.isNotEmpty
            && account.phone!.isNotEmpty
              && account.name!.isNotEmpty
                && account.password!.isNotEmpty){
           Utils.showToast("Your Email: $email, Password: $password,Name: $name,Phone: $phone saved")
        }
    });
  }

  _getFirebaseUser(User user, Account account) async{
    setState(() {
      isloading = false;
    });
    if(user != null){
      await Prefs.saveUSerId(user.uid);
      Prefs.storeUser(account, "account");
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.showToast("Check your information");
    }
  }
}
