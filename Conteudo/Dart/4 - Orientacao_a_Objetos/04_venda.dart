import '04_cliente.dart';
import '04_venda_item.dart';

class Venda {
  Cliente? cliente;
  List<VendaItem> itens;

  double get valorTotal{
    return itens
      .map((item) => item.preco * item.quantidade)
      .reduce((t, a) => t + a);
  }

  Venda({this.cliente, this.itens = const []});

  void imprimirNotaFiscal(){
    print("Nome do Cliente : ${cliente!.nome}");
    print("CPF do Cliente : ${cliente!.cpf}");
    print("Itens da Compra :");
    for (var item in itens) {
      print("Item :");
      print(" Nome: ${item.produto!.nome}");
      print(" Preço: R\$${item.preco}");
      print(" Quantidade: ${item.quantidade}");
    }
    print("Preço total: R\$${valorTotal}");
  }
}