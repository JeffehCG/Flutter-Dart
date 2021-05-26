main(List<String> args) {
  // var listaCoisas = ['banana', true, 123, 4.56, [1,2,3]];

  List<String> frutas = ['banana', 'maça', 'laranja'];
  frutas.add('melão');

  print(frutas);

  Map<String,double> salarios = {
    'gerente' : 10549.59,
    'vendedor': 3589.98,
    'estagiario': 600.00
  };

  print(salarios);
}