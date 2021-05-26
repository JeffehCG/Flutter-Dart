// - Numeros (int e double)
// - String (String)
// - Booleano (bool)
// - Dinamica (dynamic)

main(List<String> args) {
  // Numericos 
  int n1 = 3;
  double n2 = (-5.67).abs(); // abs pega o valor absoluto
  double n3 = double.parse("12.765");
  num n4 =6;

  print(n1.abs() + n2 + n3 + n4);

  // Texto
  String s1 = "Bom";
  String s2 = " dia";

  print(s1 + s2.toUpperCase() + "!!!");

  // Booleano
  bool estaChovendo = true;
  bool muitoFrio = false;

  print(estaChovendo && muitoFrio);

  // Dinamica - pode receber qualquer valor
  dynamic x = "Um texto bem legal!!";
  print(x);

  x = 123;
  print(x);
  
  x = false;
  print(x);
}