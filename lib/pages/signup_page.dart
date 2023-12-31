import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/pages/home_page.dart';
import 'package:instaclone/pages/signin_page.dart';
import 'package:instaclone/services/auth_service.dart';

import '../services/utils_service.dart';

class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  _callSignInPage() {
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  bool validatePassword(String password) {
    if (password.length < 8) {
      return false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    return true;
  }

  bool validateEmail(String email) {
    if (email.indexOf('@') != email.lastIndexOf('@')) {
      return false;
    }
    if (!email.contains('.')) {
      return false;
    }
    if (email.startsWith('.') ||
        email.endsWith('.') ||
        email.startsWith('@') ||
        email.endsWith('@')) {
      return false;
    }
    if (email.contains('..')) {
      return false;
    }
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~@]+$").hasMatch(email)) {
      return false;
    }
    return true;
  }

  _doSignUp() {
    String fullname = fullnameController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();
    if (email.isEmpty || password.isEmpty || fullname.isEmpty) return;
    if (cpassword != password) {
      Utils.fireToast("Password and confirm password do not match");
      return;
    }
    if (validateEmail(email) || validatePassword(password)) {
      AuthService.signUpUser(fullname, email, password).then((value) => {
            _responseSignUp(value!),
          });
    } else {
      return;
    }
  }

  _responseSignUp(User firebaseUser) {
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(252, 175, 69, 1),
              Color.fromRGBO(245, 96, 64, 1),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Instagram",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontFamily: "Billabong",
                  ),
                ),
                //#fullname
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: fullnameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Fullname',
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),
                //#email
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),
                //#password
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),
                //#cpassword
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: cpasswordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),
                //signup
                GestureDetector(
                  onTap: () {
                    _doSignUp();
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      )),
                )
              ],
            )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have have an account?",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _callSignInPage();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
