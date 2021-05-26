main(List<String> args) {

  // Unarios
  int a = 3;
  int b = 4;

  a++;
  a--;

  print(a);

  // A comparação abaixo sera verdadeira, por causa da localização do operador Unario
  // Como o ++ esta depois da variavel, ele sera acrescentado depois da comparação
  print(a++ == --b);
  print(a == b);

  // Unarios Logicos
  print(!true);
  print(!false);

  bool x = false;
  print(!x);
}