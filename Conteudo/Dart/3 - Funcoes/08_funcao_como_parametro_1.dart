import 'dart:math';

main(List<String> args) {
  var minhaFnPar = () => print('O valor é par!');
  var minhaFnImpar = () => print('O valor é impar!');

  executar(minhaFnPar, minhaFnImpar);
}

void executar(Function fnPar, Function fnImpar){
  var sorteado = Random().nextInt(1000);
  print("O valor sorteado foi: $sorteado");
   sorteado % 2 == 0 ? fnPar() : fnImpar();
}