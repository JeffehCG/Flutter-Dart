main(List<String> args) {
  var alunos = [
    {'nome': 'Alfedro', 'nota' : 9.9},
    {'nome': 'Wilson', 'nota' : 9.3},
    {'nome': 'Mariana', 'nota' : 8.7},
    {'nome': 'Guilherme', 'nota' : 8.1},
    {'nome': 'Ana', 'nota' : 7.6},
    {'nome': 'Ricardo', 'nota' : 6.8},
  ];

  String Function(Map) pegarApenasONome = (aluno) => aluno['nome'];
  int Function(String) qtdeDeLetras = (texto) => texto.length;
  int Function(int) dobro = (texto) => texto * 2;

  var nomes = alunos.map(pegarApenasONome);
  // var quantidadeDeLetras = nomes.map(qtdeDeLetras);

  var quantidadeDeLetras = alunos
    .map(pegarApenasONome)
    .map(qtdeDeLetras)
    .map(dobro);

  print(nomes);
  print(quantidadeDeLetras);
}