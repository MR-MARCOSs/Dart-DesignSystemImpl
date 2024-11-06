import 'package:develop_design_system/DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import 'package:develop_design_system/DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import 'package:develop_design_system/DesignSystem/Components/InputField/input_text.dart';
import 'package:develop_design_system/DesignSystem/Components/InputField/input_text_view_model.dart';
import 'package:develop_design_system/DesignSystem/Components/LinkedLabel/linked_label.dart';
import 'package:develop_design_system/DesignSystem/Components/LinkedLabel/linked_label_view_model.dart';
import 'package:develop_design_system/Scenes/Login/login_router.dart';
import 'package:develop_design_system/Scenes/Login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:develop_design_system/DesignSystem/Components/Loading/loading.dart'; // Importe o caminho correto
import 'package:develop_design_system/DesignSystem/Components/Loading/loading_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            // Conteúdo principal
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/148x148.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                StyledInputField.instantiate(
                  viewModel: InputTextViewModel(
                      controller: emailController,
                      placeholder: 'E-mail',
                      password: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Esse campo é obrigatório';
                        } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Somente letras são permitidas!';
                        }
                        return null;
                      }),
                ),
                const SizedBox(height: 16),
                StyledInputField.instantiate(
                  viewModel: InputTextViewModel(
                      controller: passwordController,
                      placeholder: 'Password',
                      password: true,
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Esse campo é obrigatório';
                        }
                        return null;
                      }),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LinkedLabel.instantiate(
                      viewModel: LinkedLabelViewModel(
                        fullText: 'Forgot Password',
                        linkedText: 'Forgot Password',
                        onLinkTap: () {
                          print('Esqueceu a senha?');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ActionButton.instantiate(
                  viewModel: ActionButtonViewModel(
                    style: ActionButtonStyle.primary,
                    size: ActionButtonSize.large,
                    text: 'Login',
                    isLoading: false,
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        Map<String, dynamic> userData =
                            await LoginService.fetchLogin(
                          emailController.text,
                          passwordController.text,
                        );

                        // ignore: use_build_context_synchronously
                        LoginPageRouter.goToProfilePage(context, userData);
                      } catch (e) {
                        // Lógica de tratamento de erro
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao fazer login')),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 96),
                const Text(
                  'Don\'t Have An Account?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 73,
                  child: ActionButton.instantiate(
                    viewModel: ActionButtonViewModel(
                      style: ActionButtonStyle.primary,
                      size: ActionButtonSize.small,
                      text: 'Sign Up',
                      isLoading: false,
                      onPressed: () {
                        LoginPageRouter.goToSignupPage(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Renderização condicional do Loading apenas quando _isLoading for true
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Loading(
                      viewModel: LoadingViewModel(isLoading: _isLoading)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
