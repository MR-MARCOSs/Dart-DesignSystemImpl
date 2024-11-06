import 'package:flutter/material.dart';
// Importe a sua tela de login
import 'package:develop_design_system/Scenes/Login/login_view.dart'; // Substitua pelo caminho correto

class SignupPageRouter {
  static void login(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const LoginPage()), // Use o nome correto da sua tela de login
    );
  }
}
