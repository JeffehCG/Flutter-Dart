import '02_import_pessoa.dart';

main(List<String> args) {
  var p1 = Pessoa();
  p1.nome = 'João';

  print("O nome da pessoa é ${p1.nome}");
}