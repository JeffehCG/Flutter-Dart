import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questao.dart';
import 'package:projeto_perguntas/resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int pergundaSelecionada;
  final void Function(int) quandoResponder;
  final bool temPerguntaSelecionada;

  Questionario(this.perguntas, this.pergundaSelecionada, this.quandoResponder,
      this.temPerguntaSelecionada);

  @override
  Widget build(BuildContext context) { 
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[pergundaSelecionada]['respostas']
        : null;

    // Lista de Widgets, um componente para cada resposta
    List<Widget> widgeds;
    if (respostas != null)
      widgeds = respostas 
          .map((resp) =>
              Resposta(resp['texto'], () => quandoResponder(resp['pontuacao'])))
          .toList();

    return Column(
      // Flex Box
      children: [
        Questao(perguntas[pergundaSelecionada]['texto']),
        ...widgeds // ... operador que pega todos os itens da lista, e retorna
      ],
    );
  }
}
