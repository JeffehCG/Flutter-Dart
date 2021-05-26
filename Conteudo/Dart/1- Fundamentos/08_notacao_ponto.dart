main(List<String> args) {
  double nota1 = 6.99.roundToDouble(); // Aredonda o valor
  double nota2 = 6.99.truncateToDouble();  // Desconcidera as casas decimais

  print(nota1);
  print(nota2);

  String s1 = "jefferson costa";
  String s2 = s1.substring(0,9);
  String s3 = s2.toUpperCase();
  String s4 = s3.padRight(15, "!");

  String s5 = "jefferson costa"
    .substring(0,9)
    .toUpperCase()
    .padRight(15, "!");

  print(s4);
  print(s5);
}