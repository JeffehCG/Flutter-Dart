main(List<String> args) {
  var meuPrint = (String valor){
    print(valor);
    return valor;
  };

  int tamanho = executarPor(10, meuPrint, "Teste");
  print("O tamanho é $tamanho");
}

int executarPor(int qtde, String Function(String) fn, String valor){
  String textoCompleto = '';
  for(int i = 0; i < qtde; i++){
    textoCompleto += fn(valor);
  }

  return textoCompleto.length;
}