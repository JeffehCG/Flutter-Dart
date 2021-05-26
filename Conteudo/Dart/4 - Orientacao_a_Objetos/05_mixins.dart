class Carro{
  int _velocidade = 0;

  int acelerar(){
    _velocidade += 5;
    return _velocidade;
  }

  int frear(){
    _velocidade -= 5;
    return _velocidade;
  }
}

// mixin - Mistura
mixin Luxo{
  bool _arLigado = false;

  ligarAr(){
    _arLigado = true;
  }

  desligarAr(){
    _arLigado = false;
  }
}

mixin Esportivo{
  bool _turboLigado = false;

  ligarTurbo(){
    _turboLigado = true;
  }

  desligarTurbo(){
    _turboLigado = false;
  }
}

// Herança - subclasse (Dart não aceita multiplas heranças - Dessa forma precisa utilizar o mixin)
class Gol extends Carro{}

// Mixin - atraves do mixin, a classe ferrari tera tambem os metodos e atributos de (Esportivo e Luxo)
class Ferrari extends Carro with Esportivo, Luxo{

  // Sobrescrevendo metodo da classe Carro
  @override
  acelerar(){
    if(_turboLigado){
      super.acelerar();
    }
    if(_arLigado){}
    return super.acelerar();
  }
}

void main(List<String> args) {
  Carro c1 = Gol();
  print(c1.acelerar());
  print(c1.acelerar());
  print(c1.frear());

  Ferrari c2 = Ferrari();
  c2.ligarTurbo();
  c2.ligarAr();
  print(c2.acelerar());
  print(c2.acelerar());
  print(c2.frear());

}