import 'dart:math';

main(List<String> args) {
  int a = 2;
  int b = 3;
  somaComPrint(a, b);

  int c = 4;
  int d = 5;
  somaComPrint(c, d);

  somarDoisNumerosAleatorios();
}

void somaComPrint(int a, int b){
  print(a + b);
}

void somarDoisNumerosAleatorios(){
  int n1 = Random().nextInt(11);
  int n2 = Random().nextInt(11);

  print(n1 + n2);
}