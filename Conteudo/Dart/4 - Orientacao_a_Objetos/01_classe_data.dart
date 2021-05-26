class Data {
  int? dia;
  int? mes;
  int? ano;

  // Em dart só pode existir um construtor (Alem dos nomeados)
  // Data(int dia, int mes, int ano){
  //   this.dia = dia;
  //   this.mes = mes;
  //   this.ano = ano;
  // }

  // Construtor de apenas uma linha
  // Data(this.dia, this.mes, this.ano);

  // Construtor com valores padrões
  Data([this.dia = 1, this.mes = 1, this.ano = 1970]);

  // Construtor nomeado
  Data.com({this.dia = 1, this.mes =1, this.ano = 1970});
  Data.ultimoDiaDoAno(this.ano){
    this.dia = 31;
    this.mes = 12;
  }

  String obterFormatada(){
    return "${dia}/${mes}/${ano}";
  }

  // Sobrescrevendo o metodo toString
  String toString(){
    return obterFormatada();
  }
}

main(List<String> args) {
  var dataAniversario = new Data(3, 10, 2020);

  // new não é obrigatorio
  Data dataCompra = Data(1,1,1070);
  dataCompra.dia = 23;
  dataCompra.mes = 12;
  dataCompra.ano = 2021;

  print("A data da compra é: ${dataCompra.obterFormatada()}");
  print(dataAniversario);
  print(new Data());
  print(Data(1));
  print(Data.com(ano: 2021));
  print(Data.ultimoDiaDoAno(2024));
}