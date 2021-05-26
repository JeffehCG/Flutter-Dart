import '04_cliente.dart';
import '04_produto.dart';
import '04_venda.dart';
import '04_venda_item.dart';

main(List<String> args) {
  // Composição
  var venda = Venda(
    cliente: Cliente(
      nome: 'Jefferson Costa',
      cpf: '123.456.789-00'
    ),
    itens: <VendaItem>[
      VendaItem(
        quantidade: 2,
        produto: Produto(
          codigo: 1,
          nome: 'Mouse Razer',
          preco: 349.99,
          desconto: 0.5
        )
      ),
      VendaItem(
        quantidade: 3,
        produto: Produto(
          codigo: 2,
          nome: 'Teclado HyperX',
          preco: 299.99,
          desconto: 0.3
        )
      ),
      VendaItem(
        quantidade: 100,
        produto: Produto(
          codigo: 3,
          nome: 'Caneta Bic',
          preco: 2.99,
          desconto: 0.2
        )
      ),
    ]
  );

  venda.imprimirNotaFiscal();
}