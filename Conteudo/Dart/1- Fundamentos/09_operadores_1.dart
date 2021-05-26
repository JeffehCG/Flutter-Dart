import 'dart:math';

main(List<String> args) {
  
  //Aritmeticos
  int a = 7;
  int b = 3;
  int resultado = a + b;

  print(resultado);
  print(a - b);
  print(a * b);
  print(a / b);
  print(a % b); // Resto da divisão
  print(a + (b * a) - (b/a));

  //Logicos
  bool isFragil = Random().nextBool();
  bool isCaro = Random().nextBool();

  print(isFragil && isCaro); // E
  print(isFragil || isCaro); // OU
  print(isFragil ^ isCaro); // OU Exclusivo (Apenas um dos dois tem que ser verdadeiro)
  print(!isFragil); // Negação
  
}