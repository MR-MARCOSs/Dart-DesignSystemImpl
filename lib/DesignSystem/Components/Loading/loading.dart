import 'package:flutter/material.dart';
import 'loading_view_model.dart';

class Loading extends StatelessWidget {
  final LoadingViewModel viewModel;

  const Loading({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoading) {
      return const SizedBox
          .shrink(); // Não exibe nada se não estiver carregando
    }

    return Center(
      // Centraliza o indicador de carregamento
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(), // Widget de carregamento circular
          if (viewModel.message != null) ...[
            // Exibe a mensagem se fornecida
            const SizedBox(height: 16),
            Text(viewModel.message!),
          ],
        ],
      ),
    );
  }
}

// Como usar:

// Em algum Widget Stateful:

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _isLoading = false;
  String? _loadingMessage;

  _fetchData() async {
    setState(() {
      _isLoading = true;
      _loadingMessage = "Carregando dados..."; // Mensagem opcional
    });

    // Simula uma operação assíncrona (requisição de rede, etc.)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _loadingMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Minha Tela")),
      body: Stack(
        children: [
          // Seu conteúdo principal aqui
          Center(
              child: TextButton(
                  onPressed: _fetchData, child: Text('Carregar Dados'))),

          Loading(
            viewModel: LoadingViewModel(
              isLoading: _isLoading,
              message: _loadingMessage,
            ),
          ),
        ],
      ),
    );
  }
}
