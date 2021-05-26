main(List<String> args) {
  juntar(1, 9);
  juntar('Bom', ' dia!');
  String resultado = juntar("O valor de PI é ", 3.1415);
  print(resultado.toUpperCase());
}

dynamic juntar(dynamic a, b){
  var value = a.toString() + b.toString();
  print(value);
  return value;
}