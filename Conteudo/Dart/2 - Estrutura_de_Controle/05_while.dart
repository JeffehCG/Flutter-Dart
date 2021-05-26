import 'dart:io';

main(List<String> args) {
  var digitado = '';

  // While
  while(digitado != 'sair'){
    print('Digite algo ou sair: ');
    digitado = stdin.readLineSync()!;
  }

  // Do While

  do{
    print('Digite algo ou sair: ');
    digitado = stdin.readLineSync()!;
  }while(digitado != 'sair');

  print("Fim!");
}