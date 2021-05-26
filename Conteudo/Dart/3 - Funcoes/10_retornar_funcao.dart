main(List<String> args) {
  print(somaParcial(2)(10));

  // Esse recurso é muito interessando, pois uma parte do processamento ja foi feita na função
  // Assim quando você executa a função de retorno, a uma economia de processamento
  var somaCom10 = somaParcial(10);
  print(somaCom10(3));
  print(somaCom10(7));
  print(somaCom10(19));
}

int Function(int) somaParcial(int a){
  int c = 0;

  return(int b){
    return a + b + c;
  };
}