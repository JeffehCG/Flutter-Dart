import 'dart:io';
main(List<String> args) {
  // Recebendo dados de entrada do usuario
  print("Informe seu nome: ");
  String? nome = stdin.readLineSync();

  // Calculo area da circunferencia

  const double PI = 3.1415; // const é uma constante

  print("Informe o raio: ");
  var entradaDoUsuario = stdin.readLineSync()!;
  final raio = double.parse(entradaDoUsuario); // final é uma constante

  var area = PI * raio * raio;

  print("Ola $nome \n O valor da area é: ${area}");
}

// final vs const 
// const é usado quando uma constante podera ser definida durante a compilação
// final é usado quando uma constante sera definite em tempo de execução (Por exemplo pela entrada de um usuario)

// Executando via terminal e não output dart 05_Constantes_1.dart 