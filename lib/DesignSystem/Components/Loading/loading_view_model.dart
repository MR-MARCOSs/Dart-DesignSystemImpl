import 'package:flutter/material.dart';

class LoadingViewModel {
  final bool isLoading;
  final String? message; // Mensagem opcional para exibir durante o carregamento

  LoadingViewModel({required this.isLoading, this.message});
}
