import '03_carro.dart';

main(List<String> args) {
  var c1 = new Carro(320);

  while(!c1.estaNoLimite()){
    print("A velocidade atual é ${c1.acelerar()} Km/h.");
  }

  print("O carro chegou no maximo com velocidade ${c1.velocidadeAtual} Km/h.");

  while(!c1.estaParado()){
    print("A velocidade atual é ${c1.frear()} Km/h.");
  }
  
  c1.velocidadeAtual = 3;
  c1.velocidadeAtual = 500;
  print("O carro parrou com velocidade ${c1.velocidadeAtual} Km/h.");

}