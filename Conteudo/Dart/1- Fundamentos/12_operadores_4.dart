import 'dart:io';

main(List<String> args) {

  // Ternario
  print("Esta chovendo? (S/N)");
  final bool isChovendo = stdin.readLineSync() == "S";

  print("Esta frio? (S/N)");
  final bool isFrio = stdin.readLineSync() == "S";

  String resultado = isChovendo && isFrio ? "Ficar em casa" : "Sair!!!";
  print(resultado);
  print(isChovendo && isFrio ? "Azarado" : "Sortudo");
}