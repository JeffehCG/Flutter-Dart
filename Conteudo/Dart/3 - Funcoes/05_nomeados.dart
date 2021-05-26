main(List<String> args) {
  saudarPessoa(nome: 'João', idade: 33);
  saudarPessoa(idade: 47, nome: "Maria");

  imprimirData('/');
  imprimirData('-', ano: 2020);
  imprimirData('/', mes: 10, dia: 25);
}

saudarPessoa({String? nome, int? idade}){
  print("Olá $nome nem parece que você tem $idade anos.");
}

void imprimirData(String separacao, {int dia =1,int mes = 1, int ano = 1970}){
  print('$dia$separacao$mes$separacao$ano');
}