main(List<String> args) {
  // Função anonima
  var adicao = (int a, int b){
    return a + b;
  };
  print(adicao(4, 19));

  // Função anonima - Arrow Funcion
  var subtracao = (int a, int b) => a - b;
  var multiplicacao = (int a, int b) => a * b;
  var divisao = (int a, int b) => a / b;

  print(subtracao(9, 13));
  print(multiplicacao(9, 13));
  print(divisao(9, 13));
}