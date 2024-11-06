import 'package:develop_design_system/Scenes/Profile/profile_factory.dart';
import 'package:develop_design_system/Scenes/Signup/signup_factory.dart';
import 'package:flutter/material.dart';
import 'package:develop_design_system/Scenes/Profile/profile_view.dart';

class LoginPageRouter {
  static void goToProfilePage(
      BuildContext context, Map<String, dynamic> userData) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfilePage(
                userData: userData,
                userEmail: 'Amanda',
              )),
    );
  }

  static void goToSignupPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignupPageFactory.create()));
  }
}
