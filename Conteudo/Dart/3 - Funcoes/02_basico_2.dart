import 'dart:math';

main(List<String> args) {
  int resultado = somar(2, 3);

  print(resultado);

  print("Soma dos numeros aleatorios é ${somarNumerosAleatorios()}");
}

int somar(int a, int b){
  return a + b;
}

int somarNumerosAleatorios(){
  return Random().nextInt(11) + Random().nextInt(11);
}