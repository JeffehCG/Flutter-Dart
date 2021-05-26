main(List<String> args) {
    var alunos = [
    {'nome': 'Alfedro', 'nota' : 9.9},
    {'nome': 'Wilson', 'nota' : 9.3},
    {'nome': 'Mariana', 'nota' : 8.7},
    {'nome': 'Guilherme', 'nota' : 8.1},
    {'nome': 'Ana', 'nota' : 7.6},
    {'nome': 'Ricardo', 'nota' : 6.8},
  ];

  var melhoresNotas = alunos
    .map((aluno) => aluno['nota'])
    .map((nota) => (nota as double))
    .where((nota) => nota >= 8);

    print(melhoresNotas);

    var totalMelhoresNotas = melhoresNotas.reduce((value, element) => value + element);

    print(totalMelhoresNotas);
    print("O valor da media é: ${totalMelhoresNotas/ melhoresNotas.length}");
}